c-----------------------------------------------------------------
c This subroutine deals with the exchange-correlation energy term
c Numerical integration , given by Becke's grid
c
c generates grid points
c calls to a function that at a certain space point gives density
c functional for the particular density functional chosen
c
c Output: Exchange-correlation energy
c 11-2-93
c-----------------------------------------------------------------
      subroutine exchnum2op(NORM,natom,r,Iz,Nuc,M,ncont,nshell,c,a,RMM,
     >                    M18,NCOa,NCOb,Exc,forza)
c      implicit real*8 (a-h,o-z)
      implicit none
      real*8 r,c,a,rmm,exc,excp,forza,densa,densb,yiex,yiec,y2a,y2b
      real*8 dens,adx,bdx,ady,bdy,adz,bdz,adxx,bdxx,adyy,bdyy,adzz
      real*8 bdzz,adxy,bdxy,adyz,bdyz,adxz,bdxz,yi,pp,rnb,rnc,u,x1,aij
      real*8 p1,p2,p3,s,pf,tmp1,tmpa,tmpb,e,wang,e3,wang3,rm,excha
      real*8 ecorr,ss0,t0,t1,x,w,r1,wrad,tmp0,radii,pi,pi2,xi,ds,rr
      real*8 p,ddx,ddy,ddz,aux

      integer natom,iz,nuc,m,ncont,nshell,m18,ncoa,ncob,k,nb,nc,ina,ih
      integer nang,iexch,nr,ndens,l,i,j,ns,npp,nd,npoint,na,n,ll,intg2
      integer ntq,ntc,nss,ng0,ng,nl,ngd0,ngd,nt
      
      
      integer igrid,igrid2
      logical NORM,integ,dens1
      INCLUDE 'param'
      parameter (pi=3.14159265358979312D0,pi2=6.28318530717958623D0)
c
c input
      dimension c(ng,nl),a(ng,nl),Nuc(ng),ncont(ng),Iz(natom)
      dimension r(nt,3),nshell(0:3)
      dimension xi(3)
      dimension RMM(*),ds(ntq)
c Rm: 1/2 Slater's radius, Nr : # shells
      dimension RR(ntq,ntq),P(ntq)
      dimension Ddx(ntq,2),Ddy(ntq,2),Ddz(ntq,2)
      dimension forza(nt,3),aux(ng)
c
c
c
      common /Ll/ Ll(3)
      common /fit/ Nang,dens1,integ,Iexch,igrid,igrid2
      common /intg2/ e(116,3),wang(116),Nr(0:54),e3(194,3),wang3(194)
      common /radii/ Rm(0:54)
      common /Nc/ Ndens

      INTEGER MYRANK,IPROC,IERR,ITAG,ITAG2,ITAG3,ISTAT
      INTEGER init,ifin, iauxa
      real*8 pnt(natom),send(natom)
      ITAG=730
      ITAG2=731
      ITAG3=732




      CALL MPI_COMM_RANK (91,MYRANK,IERR)

      CALL MPI_COMM_SIZE (91,IPROC,IERR)

c
      Ndens=2
c
      Exc=0.0D0
      ExcP=0.0D0
      excha = 0.D0
      ecorr = 0.D0
      ss0=0.0D0
c
*
*      do na=1,natom
*       forza(na,1)=0.D0
*       forza(na,2)=0.D0
*       forza(na,3)=0.D0
*      enddo
*
c ------------------------------------------------
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
      ns=nshell(0)
      npp=nshell(1)
      nd=nshell(2)
c
c
c-------------------------------------------------------------
c loop 12 , over all grid  -----------------------------
c loop 99, over all fitting functions
c everything goes here, the rest is the same
c xi vector of 3 dimensions
c yi density functional for xi ( all necessary data in common)
c
*
      if(igrid.eq.1) then
        npoint=116
      else
        npoint=194
      endif
*

      if ((IPROC.gt.1).AND.(natom.ge.IPROC)) then
        init = (natom/IPROC)*MYRANK+1
        iauxa = MYRANK+1
        if (IPROC.eq.iauxa) then
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
c

       do 16 n=1,Nr(Iz(na))
c
       t0=pi/(Nr(Iz(na))+1)
       t1=t0*n
       x=cos(t1)
c w: weight
       w=t0*abs(sin(t1))
c multiply also by radial part
c
       r1=Rm(Iz(na))*(1.D0+x)/(1.D0-x)
       wrad=w * r1**2
       wrad=wrad*Rm(Iz(na)) * 2.D0 /(1.D0-x)**2
c
c Angular part now
c Grid 50 points, given by V.I.Lebedev's paper
c later 110, etc
c
      do 15 i=1,npoint
c
      if(igrid.eq.1) then
         xi(1)=r(na,1)+r1*e(i,1)
         xi(2)=r(na,2)+r1*e(i,2)
         xi(3)=r(na,3)+r1*e(i,3)
         tmp0=wrad*wang(i)
       else
         xi(1)=r(na,1)+r1*e3(i,1)
         xi(2)=r(na,2)+r1*e3(i,2)
         xi(3)=r(na,3)+r1*e3(i,3)
         tmp0=wrad*wang3(i)
       endif
c
        do 21 k=1,natom
         ds(k)=(xi(1)-r(k,1))**2+(xi(2)-r(k,2))**2+(xi(3)-r(k,3))**2
 21     continue
c
c
        if (Iexch.le.3) then
c local density functionals, no gradients needed
         call DNSOP(DENSA,DENSB,aux,Xi,ds,NORM,Nuc,ncont,nshell,
     >     a,c,r,M,M18,NCOa,NCOb,RMM)
         call potop(Iexch,DENSA,DENSB,yiex,yiec,y2a,y2b)
         DENS=DENSA+DENSB
c
         call DENSGop(Ddx,Ddy,Ddz,Xi,ds,NORM,Nuc,ncont,nshell,
     >              a,c,r,M,M18,NCOa,NCOb,RMM,natom)
c
        else
c non local density functionals, gradients and 2nd derivatives needed
         call DNSGOP(DENSA,DENSB,aux,aDx,bDx,aDy,bDy,aDz,bDz,aDxx,bDxx,
     >        aDyy,bDyy,aDzz,bDzz,aDxy,bDxy,aDyz,bDyz,aDxz,bDxz,
     >        Xi,ds,NORM,Nuc,ncont,nshell,a,c,r,M,M18,NCOa,NCOb,RMM)
c
         DENS=DENSA+DENSB
c
         call potgop(Iexch,densa,densb,adx,bdx,ady,bdy,adz,bdz,adxx,
     >        bdxx,adyy,bdyy,adzz,bdzz,adxy,bdxy,adyz,bdyz,adxz,bdxz,
     >        yiex,yiec,y2a,y2b)
         call DENSGop(Ddx,Ddy,Ddz,Xi,ds,NORM,Nuc,ncont,nshell,
     >              a,c,r,M,M18,NCOa,NCOb,RMM,natom)
         endif
c----------------------
c
        yi = yiex + yiec
c
c----------------------

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
         p1=1.5D0*u-0.5D0*u**3
         p2=1.5D0*p1-0.5D0*p1**3
         p3=1.5D0*p2-0.5D0*p2**3
c        p4=1.5D0*p3-0.5D0*p3**3
c        p5=1.5D0*p4-0.5D0*p4**3
         s=0.5D0*(1.D0-p3)
         P(nb)=P(nb)*s
c
 121   continue
 120   continue
        PP=PP+P(nb)
 119    continue
c
c
        PF=P(na)/PP
c ss : integrated density, check
        dens=DENSA+DENSB
        yi=yiex+yiec
        ExcP=ExcP + PF*dens*yi*tmp0
        excha = excha + PF*dens*yiex*tmp0
        ecorr = ecorr + PF*dens*yiec*tmp0
        ss0=ss0 + PF*dens*tmp0
c
c
*
       tmp1=PF*tmp0
       tmpa=tmp1*y2a
       tmpb=tmp1*y2b
       do ina=1,natom
         forza(ina,1)=forza(ina,1) + DDx(ina,1)*tmpa + DDx(ina,2)*tmpb
         forza(ina,2)=forza(ina,2) + DDy(ina,1)*tmpa + DDy(ina,2)*tmpb
         forza(ina,3)=forza(ina,3) + DDz(ina,1)*tmpa + DDz(ina,2)*tmpb
       enddo
*
c
c---------------------------------------------------------
c
  15    CONTINUE
c
 161  continue
 16   continue
 12   continue
c-------------------------------------------------------




      if ((IPROC.gt.1) .AND. (natom.ge.IPROC)) then
      CALL MPI_ALLReduce(ExcP,Exc,1,27,102,91
     >                  ,IERR)
        if(MYRANK.eq.0) then
         do 203 i=1,IPROC-1
          CALL MPI_Recv(pnt,natom,27,i,ITAG,91,ISTAT,IERR)
	  do 204 ih=1,natom
           forza(ih,1)=forza(ih,1)+pnt(ih)
 204      continue
 203     continue

         do 205 i=1,IPROC-1
          CALL MPI_Recv(pnt,natom,27,i,ITAG2,91,ISTAT,IERR)
	  do 206 ih=1,natom
           forza(ih,2)=forza(ih,2)+pnt(ih)
 206      continue
 205     continue

         do 207 i=1,IPROC-1
	  CALL MPI_Recv(pnt,natom,27,i,ITAG3,91,ISTAT,IERR)
	  do 208 ih=1,natom
           forza(ih,3)=forza(ih,3)+pnt(ih)
 208      continue
 207     continue


        else

	 do ih=1,natom
          send(ih)=forza(ih,1)
         enddo
	 CALL MPI_Send(send,natom,27,0,ITAG,91,IERR)

         do ih=1,natom
          send(ih)=forza(ih,2)
         enddo
         CALL MPI_Send(send,natom,27,0,ITAG2,91,IERR)

	 do ih=1,natom
	  send(ih)=forza(ih,3)
         enddo
	 CALL MPI_Send(send,natom,27,0,ITAG3,91,IERR)
	endif

	if(MYRANK.eq.0) then
	 do ih=1,natom
	   pnt(ih)=forza(ih,1)
	 enddo
	endif
	CALL MPI_Bcast(pnt,natom,26,0,91,IERR)
	do ih=1,natom
	  forza(ih,1)=pnt(ih)
	enddo

	if(MYRANK.eq.0) then
	 do ih=1,natom
	   pnt(ih)=forza(ih,2)
	 enddo
	endif
	CALL MPI_Bcast(pnt,natom,26,0,91,IERR)
	do ih=1,natom
	  forza(ih,2)=pnt(ih)
	enddo

        if(MYRANK.eq.0) then
	 do ih=1,natom
	   pnt(ih)=forza(ih,3)
	 enddo
	endif
	CALL MPI_Bcast(pnt,natom,26,0,91,IERR)
	do ih=1,natom
	  forza(ih,3)=pnt(ih)
	enddo

      else
       Exc=ExcP
      endif

      return
      END
c-------------------------------------------------------------
