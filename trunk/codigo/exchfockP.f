c--------------------------------------------------------------
c sunroutine for evaluating, through numerical integration the
c exchange-correlation term of the Fock matrix elements
c (Alternative, more exact way to the approach used in the least-
c squares fit ).
c It is more expensive, in principle its cost goes as Ngrid*Nfunc**2/2
c compared to the Ngrid*Nfunc*Nocc in the least-squares approach
c 19-5-93
c
c--------------------------------------------------------------
c
      SUBROUTINE EXCHFOCK(OPEN,NORM,natom,Iz,Nuc,ncont,nshell,a,c,r,
     >               M,M18,NCOa,NCOb,RMM,Ex)

c
c      implicit real*8 (a-h,o-z)
      implicit none
      integer igrid,igrid2,nshell,nang
      logical NORM,integ,dens1,OPEN
      real*8 pi,pi2,a,c,r,rmm,w,rr,p
      real*8 ss0,fc,tmpjb,tmpja,tmpb,tmpa,tmp,pf,s,p3,p2,p1
      real*8 dz,dy,dx,dxib,dxia,bdxz,adxz,bdyz,adyz,bdxy,adxy,bdzz
      real*8 aij,x1,u,rnc,rnb,pp,tmp0,yi,dxz,dyz,dxy,dzz,dyy,dxx
      real*8 bdyy,adyy,bdxx,adxx,bdz,adz,bdy,ady,bdx,adx,dxi,dens,y2b
      real*8 y2a,yiec,yiex,densb,densa,wrad,r1,w1,x,t1,t0,rm,wang0
      real*8 wang3,e0,e3,wang2,e2,wang,e,xi,ds,f,ex,adzz,exp
      integer kk,nc,nb,i1,k,iang,n,na,m18b,m5,m3,m1,mm,m2,nd,np,ns
      integer i,j,l,nr2,nr,ndens,nr0,ll,nuc,ncont,ncoa,ncob,ngd0
      integer ngd,iexch,natom,m,m18,ntq,ntc,nss,ng,ng0,nl,nt,iz,nco
      
      INCLUDE 'param'
      INCLUDE 'mpif.h'
      parameter (pi=3.14159265358979312D0,pi2=6.28318530717958623D0)
      dimension c(ng,nl),a(ng,nl),Nuc(ng),ncont(ng)
      dimension r(nt,3),nshell(0:3),Xi(3)
      dimension ds(ntq),F(ng),W(ng),RMM(*),Iz(ntq)
      dimension RR(ntq,ntq),P(ntq)
c
      common /Ll/ Ll(3)
      common /Nc/ Ndens
      common /fit/ Nang,dens1,integ,Iexch,igrid,igrid2
      common /intg1/ e(50,3),wang(50),Nr(0:54)
      common /intg2/ e3(194,3),e2(116,3),wang3(194),wang2(116),Nr2(0:54)
      common /radii/ Rm(0:54)
c
      dimension wang0(194),e0(194,3),Nr0(0:54)

      
      real*8 pnt(M*(M+1)/2),send(M*(M+1)/2)

      INTEGER MYRANK, IPROC, ITAG,ITAG2, IERR,ISTAT
      INTEGER init, ifin, iaux,ih


      CALL MPI_COMM_RANK(MPI_COMM_WORLD, MYRANK, IERR)

      CALL MPI_COMM_SIZE(MPI_COMM_WORLD, IPROC, IERR)
      ITAG=730
      ITAG2=731
c now we should evaluate all same loops as the ones used for
c 1 electron matrix elements, but doing only products
c then, the particular density functional wanted is calculated
c
      NCO=NCOa
      Ex=0.0D0
      ExP=0.0D0
      ss0=0.0D0
c
      do 43 l=1,3
 43    Ll(l)=l*(l-1)/2
c
      do 44 i=1,natom
      do 44 j=1,natom
       t0=(r(i,1)-r(j,1))**2+(r(i,2)-r(j,2))**2+(r(i,3)-r(j,3))**2
       RR(i,j)=sqrt(t0)
 44    continue
c
      fc=1.D0
      if (NORM) then
       fc=1.D0/sqrt(3.D0)
      endif
c
      ns=nshell(0)
      np=nshell(1)
      nd=nshell(2)
      M2=2*M
      MM=M*(M+1)/2
c pointers
c
c first P
      M1=1
c now Fock beta
      M3=M1+MM
c now S, also F alpha later
      M5=M3+MM
      
      if ((IPROC.gt.1) .AND. (natom.ge.IPROC)) then
	 do ih=0,MM-1
	   pnt(ih+1)=RMM(M5+ih)
	   send(ih+1)=RMM(M3+ih)
	 enddo
      endif
c
c open shell case
      M18b=M18+M*NCOa
c
c --- chooses grid , according to igrid2 ---------------------
c
      do na=1,natom
       if (igrid2.eq.0) then
        Nr0(Iz(na))=Nr(Iz(na))
         else
        Nr0(Iz(na))=Nr2(Iz(na))
       endif
      enddo
c
      if (igrid2.eq.0) then
       Nang=50
      else if (igrid2.eq.1) then
       Nang=116
      else
       Nang=194
      endif
c
      do i=1,Nang
       if (igrid2.eq.0) then
        e0(i,1)=e(i,1)
        e0(i,2)=e(i,2)
        e0(i,3)=e(i,3)
        wang0(i)=wang(i)
        wang0(i)=wang(i)
        wang0(i)=wang(i)
       else if (igrid2.eq.1) then
        e0(i,1)=e2(i,1)
        e0(i,2)=e2(i,2)
        e0(i,3)=e2(i,3)
        wang0(i)=wang2(i)
        wang0(i)=wang2(i)
        wang0(i)=wang2(i)
       else
        e0(i,1)=e3(i,1)
        e0(i,2)=e3(i,2)
        e0(i,3)=e3(i,3)
        wang0(i)=wang3(i)
        wang0(i)=wang3(i)
        wang0(i)=wang3(i)
       endif
       enddo
c
c-------------------------------------------------------------
c loop 12 , over all grid  -----------------------------
c
      if ((IPROC.gt.1) .AND. (natom.ge.IPROC)) then
         init = ((natom*MYRANK)/IPROC)+1
         iaux = MYRANK+1
         if (IPROC.eq.iaux) then
          ifin=natom
         else
          ifin=init+(natom/IPROC)-1
         endif

      else
        init = 1
        ifin = natom

      endif
c
      DO 12 na=init,ifin
c       DO 12 na=1,natom
c
       do 16 n=1,Nr0(Iz(na))
c
       t0=pi/(Nr0(Iz(na))+1)
       t1=t0*n
       x=cos(t1)
c w: weight
       w1=t0*abs(sin(t1))
c multiply also by radial part
c
       r1=Rm(Iz(na))*(1.D0+x)/(1.D0-x)
       wrad=w1 * r1**2
c
       wrad=wrad*Rm(Iz(na)) * 2.D0 /(1.D0-x)**2

c Angular part now
c Grid 50 points, given by V.I.Lebedev's paper
c later 110, etc
c
      do 15 iang=1,Nang
c
c
c
       xi(1)=r(na,1)+r1*e0(iang,1)
       xi(2)=r(na,2)+r1*e0(iang,2)
       xi(3)=r(na,3)+r1*e0(iang,3)
c
        do 21 k=1,natom
         ds(k)=(xi(1)-r(k,1))**2+(xi(2)-r(k,2))**2+(xi(3)-r(k,3))**2
 21     continue
c
c call to density subroutines, vector F of basis functions will
c be also passed
c
        if (Iexch.le.3) then
c local density functionals, no gradients needed
           if (OPEN) then
             call DNSOP(DENSA,DENSB,F,Xi,ds,NORM,Nuc,ncont,nshell,
     >                   a,c,r,M,M18,NCOa,NCOb,RMM)
              call potop(Iexch,DENSA,DENSB,yiex,yiec,y2a,y2b)
              dens=DENSA+DENSB
           else
              call DNS(DENS,F,Xi,ds,NORM,Nuc,ncont,nshell,
     >                a,c,r,M,M18,NCO,RMM)
               dxi=DENS
               call pot(Iexch,dxi,yiex,yiec,y2a)
            endif
        else
c non local density functionals, gradients and 2nd derivatives needed
            if (OPEN) then
         call DNSGOP(DENSA,DENSB,F,aDx,bDx,aDy,bDy,aDz,bDz,aDxx,bDxx,
     >        aDyy,bDyy,aDzz,bDzz,aDxy,bDxy,aDyz,bDyz,aDxz,bDxz,
     >        Xi,ds,NORM,Nuc,ncont,nshell,a,c,r,M,M18,NCOa,NCOb,RMM)
         DENS=DENSA+DENSB
         dxia = DENSA
         dxib = DENSB
         call potgop(Iexch,dxia,dxib,adx,bdx,ady,bdy,adz,bdz,adxx,
     >        bdxx,adyy,bdyy,adzz,bdzz,adxy,bdxy,adyz,bdyz,adxz,bdxz,
     >        yiex,yiec,y2a,y2b)
            else
         call DNSG(DENS,F,Dx,Dy,Dz,Dxx,Dyy,Dzz,Dxy,Dyz,Dxz,
     >           Xi,ds,NORM,Nuc,ncont,nshell,a,c,r,M,M18,NCO,RMM)
         dxi=DENS
         call potg(Iexch,dxi,dx,dy,dz,dxx,dyy,dzz,dxy,dyz,dxz,yiex,yiec,
     >             y2a)
            endif
        endif
c
        yi = yiex + yiec
c
c
      do 1 i1=1,M
 1      W(i1)=0.D0
c
        tmp0=wrad*wang0(iang)
c NUMERICAL INTEGRATION PART  --------------------------------
c weight for the numerical integration is tmp0
c
        PP=0.0D0
        do 119 nb=1,natom
         P(nb)=1.D0
c
         rnb=(xi(1)-r(nb,1))**2+ (xi(2)-r(nb,2))**2+
     >       (xi(3)-r(nb,3))**2
         rnb=sqrt(rnb)
c
         do 120 nc=1,natom
         if (nc.eq.nb) goto 121
c
         rnc=(xi(1)-r(nc,1))**2+ (xi(2)-r(nc,2))**2+
     >       (xi(3)-r(nc,3))**2
         rnc=sqrt(rnc)
c
         u=(rnb-rnc)/RR(nb,nc)
c
c heteronuclear correction
c
         x=Rm(Iz(nb))/Rm(Iz(nc))
         x1=(x-1.D0)/(x+1.D0)
         aij=x1/(x1**2-1.0D0)
         u=u+aij*(1.D0-u**2)
c
c
         p1=1.5D0*u-0.5D0*u**3
         p2=1.5D0*p1-0.5D0*p1**3
         p3=1.5D0*p2-0.5D0*p2**3
c        p4=1.5D0*p3-0.5D0*p3**3
c        p5=1.5D0*p4-0.5D0*p4**3
         s=0.5D0*(1.D0-p3)
         P(nb)=P(nb)*s
c
c
 121   continue
 120   continue
        PP=PP+P(nb)
 119    continue
c
c
        PF=P(na)/PP
        tmp=tmp0*PF
c
        ExP=ExP+dens*yi*tmp
        ss0=ss0+dens*tmp
c
        if (dens.eq.0.0D0) then
         tmp=0.0D0
         yi=0.0D0
         y2a=0.0D0
         y2b=0.0D0
        endif
c
c     tmp = weight * potential
c
      
      if (OPEN) then
c
      tmpa=tmp*y2a
      tmpb=tmp*y2b
      kk=0
      do 101 j=1,M
c
c for the case in which basis function is 0
       if (F(j).eq.0.0D0) then
        kk=kk+M-j+1
        goto 101
       endif
c
       tmpja=tmpa*F(j)
       tmpjb=tmpb*F(j)
       
      do 102 i=j,M
c
        kk=kk+1
        
c Fock matrices, alpha and beta
c M5 pointer of alpha spin Fock matrix, M3 beta
        RMM(M5+kk-1)=RMM(M5+kk-1)+F(i)*tmpja
        RMM(M3+kk-1)=RMM(M3+kk-1)+F(i)*tmpjb
 102  continue
 101  continue
c
       else
      tmpa=tmp*y2a
      kk=0
      do 201 j=1,M
c
c for the case in which basis function is 0
       if (F(j).eq.0.0D0) then
        kk=kk+M-j+1
        goto 201
       endif
c
       tmpja=tmpa*F(j)
      do 202 i=j,M
c
        kk=kk+1
c Fock matrix
c M5 pointer
        RMM(M5+kk-1)=RMM(M5+kk-1)+F(i)*tmpja
 202  continue
 201  continue
      endif
c
 15    CONTINUE
c
 16   continue
 12   continue
c

      if ((IPROC.gt.1) .AND. (natom.ge.IPROC)) then
       CALL MPI_ALLReduce(ExP,Ex,1,27,102,MPI_COMM_WORLD,
     >                  IERR)

         if(MYRANK.eq.0) then
           do 203 i=1,IPROC-1
 	    CALL MPI_Recv(pnt,MM,27,i,ITAG,MPI_COMM_WORLD,
     >                   ISTAT,IERR)
	    do 204 ih=0,MM-1
              RMM(M5+ih)=RMM(M5+ih)+pnt(ih+1)
 204        continue
 203       continue
           do 205 i=1,IPROC-1
	    CALL MPI_Recv(send,MM,27,i,ITAG2,MPI_COMM_WORLD,
     >                   ISTAT,IERR)
	    do 206 ih=0,MM-1
             RMM(M3+ih)=RMM(M3+ih)+send(ih+1)
 206        continue
 205       continue

         else
           do ih=0,MM-1
            pnt(ih+1)=RMM(M5+ih)-pnt(ih+1)
           enddo
           do ih=0,MM-1
            send(ih+1)=RMM(M3+ih)-send(ih+1)
           enddo
	   CALL MPI_Send(pnt,MM,27,0,ITAG,MPI_COMM_WORLD,
     >                   IERR)

	   CALL MPI_Send(send,MM,27,0,ITAG2,MPI_COMM_WORLD,
     >                   IERR)
         endif

	 if(MYRANK.eq.0) then
	  do ih=0,MM-1
	    pnt(ih+1)=RMM(M5+ih)
	  enddo
	 endif
	 CALL MPI_Bcast(pnt,MM,27,0,MPI_COMM_WORLD,
     >	                 IERR)
	 do ih=0,MM-1
	   RMM(M5+ih)=pnt(ih+1)
	 enddo

	 if(MYRANK.eq.0) then
	  do ih=0,MM-1
	    pnt(ih+1)=RMM(M3+ih)
	  enddo
	 endif
	 CALL MPI_Bcast(pnt,MM,27,0,MPI_COMM_WORLD,
     >	                 IERR)
	 do ih=0,MM-1
	   RMM(M3+ih)=pnt(ih+1)
	 enddo
 
       else
        Ex=ExP
       endif


c hard-codea el tamano de RMM=23961645.cambiar a recibirlo por parámetro.
c      if(MYRANK.eq.0)then
c	CALL SAVESTATE(OPEN,NORM,natom,Iz,Nuc,ncont,nshell,a,c,r,
c     >               M,M18,NCOa,NCOb,RMM,Ex, 23961645)
c      else
c       stop
c      endif
      
      return
c
      end
