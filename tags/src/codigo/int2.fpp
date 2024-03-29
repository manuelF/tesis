c-------------------------------------------------------------------
c Integrals subroutine -Second part
c 2 e integrals, 2 index : density fitting functions
c All of them are calculated
c using the Obara-Saika recursive method.
c
c
c loop over all basis functions
c now the basis is supposed to be ordered according to the type,
c all s, then all p, then all d, .....
c inside each type, are ordered in shells
c px,py,pz , dx2,dxy,dyy,dzx,dzy,dzz, .....
c
c ns ... marker for end of s
c np ... marker for end of p
c nd ... marker for end of d
c
c r(Nuc(i),j) j component of position of nucleus i , j=1,3
c Input :  density basis 
c Output: G matrix  
c G matrix should be inverted, 
c later on, for evaluating  Coulomb terms
c-----------------------------------------------------------------
      subroutine intt2(NORM,natom,r,Nucd,M,Md,ncontd,nshelld,cd,ad,
     > RMM,XX)
c
      implicit real*8 (a-h,o-z)
      logical NORM,SVD
      integer iconst
      INCLUDE 'param'
      parameter(pi32=5.56832799683170698D0,pi=3.14159265358979312D0,
     >          rpi=1.77245385090551588D0,pi5=34.9868366552497108)
      dimension r(nt,3),nshelld(0:3)
      dimension cd(ngd,nl),ad(ngd,nl),Nucd(Md),ncontd(Md)
c
c aux . things
      dimension Q(3),d(ntq,ntq),aux(ngd),Det(2)
      dimension RMM(*),XX(Md,Md)
c
      common /Sys/ SVD,iconst
c     COMMON /TABLE/ STR(880,0:21)
      common /MMM/ Md2
c
      if (NORM) then
      sq3=sqrt(3.D0)
      else
      sq3=1.D0
      endif
c
      do 50 i=1,natom
      do 50 j=1,natom
       d(i,j)=(r(i,1)-r(j,1))**2+(r(i,2)-r(j,2))**2+
     >        (r(i,3)-r(j,3))**2
   50   continue
c
      nsd=nshelld(0)
      npd=nshelld(1)
      ndd=nshelld(2)
      Md2=2*Md
      M2=2*M
      MM=M*(M+1)/2
      MMd=Md*(Md+1)/2
c
c pointers
c
c first P
      M1=1
c now Pnew
      M3=M1+MM
c now S
      M5=M3+MM
c now G
      M7=M5+MM
c now Gm
      M9=M7+MMd
c now H
      M11=M9+MMd
c now F
      M13=M11+MM
c auxiliar things
      M15=M13+M
c
c
c end ------------------------------------------------
      do 1 k=1,MMd
    1      RMM(M7+k-1)=0.D0
c
c--- 2 index electron repulsion for density basis set
c
c first loop (s|s) case -------------------------------------------
c
      do 200 i=1,nsd
      do 200 j=1,i
c
      dd=d(Nucd(i),Nucd(j))
c
      do 200 ni=1,ncontd(i)
      do 200 nj=1,ncontd(j)
c
c (0|0) calculation
      zij=ad(i,ni)+ad(j,nj)
      t0=ad(i,ni)*ad(j,nj)
      alf=t0/zij
      t1=sqrt(zij)*t0
      
      u=alf*dd
      ccoef=cd(i,ni)*cd(j,nj)
c
      s0s=pi5/t1*FUNCT(0,u)
c
      k=i+((Md2-j)*(j-1))/2
      RMM(M7+k-1)=RMM(M7+k-1)+ccoef*s0s
c
  200  continue
c
c------------------------------------------------------------------
c
c second loop  (p|s) case
c
c
      do 300 i=nsd+1,nsd+npd,3
      do 300 j=1,nsd
c
      dd=d(Nucd(i),Nucd(j))
c
      do 300 ni=1,ncontd(i)
      do 300 nj=1,ncontd(j)
c
      zij=ad(i,ni)+ad(j,nj)
      t0=ad(i,ni)*ad(j,nj)
      alf=t0/zij
      t1=sqrt(zij)*t0
      t2=pi5/t1
c
      Q(1)=(ad(i,ni)*r(Nucd(i),1)+ad(j,nj)*r(Nucd(j),1))/zij
      Q(2)=(ad(i,ni)*r(Nucd(i),2)+ad(j,nj)*r(Nucd(j),2))/zij
      Q(3)=(ad(i,ni)*r(Nucd(i),3)+ad(j,nj)*r(Nucd(j),3))/zij
c
      u=alf*dd
      s1s=t2*FUNCT(1,u)
c
c
      ccoef=cd(i,ni)*cd(j,nj)
c
c l2: different p in the p shell ( x,y,z respectively)
c
      do 305 l1=1,3
        t1=Q(l1)-r(Nucd(i),l1)
        tn=t1*s1s
c
        ii=i+l1-1
c ii index , taking into account different components of the shell
c
        k=ii+((Md2-j)*(j-1))/2
        RMM(M7+k-1)=RMM(M7+k-1)+tn*ccoef
  305   continue
  300   continue
c
c------------------------------------------------------------
c
c (p|p) case
c
      do 400 i=nsd+1,nsd+npd,3
      do 400 j=nsd+1,i,3
c
      dd=d(Nucd(i),Nucd(j))
c
      do 400 ni=1,ncontd(i)
      do 400 nj=1,ncontd(j)
c
      zij=ad(i,ni)+ad(j,nj)
      z2=2.D0*zij
      t0=ad(i,ni)*ad(j,nj)
      alf=t0/zij
      t1=sqrt(zij)*t0
      t2=pi5/t1
c
      Q(1)=(ad(i,ni)*r(Nucd(i),1)+ad(j,nj)*r(Nucd(j),1))/zij
      Q(2)=(ad(i,ni)*r(Nucd(i),2)+ad(j,nj)*r(Nucd(j),2))/zij
      Q(3)=(ad(i,ni)*r(Nucd(i),3)+ad(j,nj)*r(Nucd(j),3))/zij
c
      u=alf*dd
      s1s=t2*FUNCT(1,u)
      s2s=t2*FUNCT(2,u)

      ccoef=cd(i,ni)*cd(j,nj)
c
      do 405 l1=1,3
       t1=Q(l1)-r(Nucd(i),l1)
       ps=t1*s2s
c
       do 405 l2=1,3
c
       t1=Q(l2)-r(Nucd(j),l2)
       tn=t1*ps
c
       if (l1.eq.l2) then
        tn=tn+s1s/z2
       endif
c
       ii=i+l1-1
       jj=j+l2-1
c
c      this to convert to 1 dimensional array, in diagonal case
c      we calculate more things than necessary . They should be
c      eliminated
       if(ii.ge.jj) then
       k=ii+((Md2-jj)*(jj-1))/2
       RMM(M7+k-1)=RMM(M7+k-1)+tn*ccoef
       endif
  405  continue
c
  400  continue
c-------------------------------------------------------------------
c (d|s) case
      do 500 i=nsd+npd+1,Md,6
      do 500 j=1,nsd
c
      dd=d(Nucd(i),Nucd(j))
c
      do 500 ni=1,ncontd(i)
      do 500 nj=1,ncontd(j)
c
      zij=ad(i,ni)+ad(j,nj)
      t0=ad(i,ni)*ad(j,nj)
      alf=t0/zij
      roz=ad(j,nj)/zij
      t1=sqrt(zij)*t0
      t2=pi5/t1
c
      Q(1)=(ad(i,ni)*r(Nucd(i),1)+ad(j,nj)*r(Nucd(j),1))/zij
      Q(2)=(ad(i,ni)*r(Nucd(i),2)+ad(j,nj)*r(Nucd(j),2))/zij
      Q(3)=(ad(i,ni)*r(Nucd(i),3)+ad(j,nj)*r(Nucd(j),3))/zij
c
      u=alf*dd
      s0s=t2*FUNCT(0,u)
      s1s=t2*FUNCT(1,u)
      s2s=t2*FUNCT(2,u)

      ccoef=cd(i,ni)*cd(j,nj)
c
      do 505 l1=1,3
       t1=Q(l1)-r(Nucd(i),l1)
       ps=t1*s2s
c
       do 505 l2=1,l1
c
       t1=Q(l2)-r(Nucd(i),l2)
       tn=t1*ps
c
       f1=1.
       if (l1.eq.l2) then
        tn=tn+(s0s-roz*s1s)/(2.D0*ad(i,ni))
        f1=sq3
       endif
c
       l12=l1*(l1-1)/2+l2
       ii=i+l12-1
c
       cc=ccoef/f1
       k=ii+((Md2-j)*(j-1))/2
       RMM(M7+k-1)=RMM(M7+k-1)+tn*cc
  505  continue
c
  500  continue
c-------------------------------------------------------------------
c (d|p) case
      do 600 i=nsd+npd+1,Md,6
      do 600 j=nsd+1,nsd+npd,3
c
      dd=d(Nucd(i),Nucd(j))
c
      do 600 ni=1,ncontd(i)
      do 600 nj=1,ncontd(j)
c
      zij=ad(i,ni)+ad(j,nj)
      z2=2.D0*zij
      t0=ad(i,ni)*ad(j,nj)
      alf=t0/zij
      t1=sqrt(zij)*t0
      t2=pi5/t1
c
      Q(1)=(ad(i,ni)*r(Nucd(i),1)+ad(j,nj)*r(Nucd(j),1))/zij
      Q(2)=(ad(i,ni)*r(Nucd(i),2)+ad(j,nj)*r(Nucd(j),2))/zij
      Q(3)=(ad(i,ni)*r(Nucd(i),3)+ad(j,nj)*r(Nucd(j),3))/zij
c
      u=alf*dd
      s1s=t2*FUNCT(1,u)
      s2s=t2*FUNCT(2,u)
      s3s=t2*FUNCT(3,u)
c
      ccoef=cd(i,ni)*cd(j,nj)
c
      do 605 l1=1,3
       t1=Q(l1)-r(Nucd(i),l1)
       pis=t1*s2s
       pi2s=t1*s3s
c
       do 605 l2=1,l1
c
       t1=Q(l2)-r(Nucd(i),l2)
       pjs=t1*s2s
c
       ds=t1*pi2s
c
       f1=1.D0
       if (l1.eq.l2) then
        f1=sq3
        ds=ds+(s1s-alf*s2s/ad(i,ni))/(2.D0*ad(i,ni))
       endif

c index of p
c
       do 605 l3=1,3
c
       t0=Q(l3)-r(Nucd(j),l3)
       tn=t0*ds
c
       if (l1.eq.l3) then
        tn=tn+pjs/z2
       endif
c
       if (l2.eq.l3) then
        tn=tn+pis/z2
       endif
c
c
       l12=l1*(l1-1)/2+l2
       ii=i+l12-1
       jj=j+l3-1
c
       cc=ccoef/f1
c
       k=ii+((Md2-jj)*(jj-1))/2
       RMM(M7+k-1)=RMM(M7+k-1)+tn*cc
  605  continue
c
  600  continue
c
c-------------------------------------------------------------------
c (d|d) case
      do 700 i=nsd+npd+1,Md,6
      do 700 j=nsd+npd+1,i,6
c
      dd=d(Nucd(i),Nucd(j))
c
      do 700 ni=1,ncontd(i)
      do 700 nj=1,ncontd(j)
c
      zij=ad(i,ni)+ad(j,nj)
      z2=2.D0*zij
      za=2.D0*ad(i,ni)
      zc=2.D0*ad(j,nj)
      t0=ad(i,ni)*ad(j,nj)
      alf=t0/zij
      t1=sqrt(zij)*t0
      t2=pi5/t1
c
      ti=ad(i,ni)/zij
      tj=ad(j,nj)/zij
      Q(1)=ti*r(Nucd(i),1)+tj*r(Nucd(j),1)
      Q(2)=ti*r(Nucd(i),2)+tj*r(Nucd(j),2)
      Q(3)=ti*r(Nucd(i),3)+tj*r(Nucd(j),3)
c
      u=alf*dd
      s0s=t2*FUNCT(0,u)
      s1s=t2*FUNCT(1,u)
      s2s=t2*FUNCT(2,u)
      s3s=t2*FUNCT(3,u)
      s4s=t2*FUNCT(4,u)
c
      t3=(s0s-tj*s1s)/za
      t4=(s1s-tj*s2s)/za
      t5=(s2s-tj*s3s)/za
      ccoef=cd(i,ni)*cd(j,nj)
c
      do 705 l1=1,3
       t1=Q(l1)-r(Nucd(i),l1)
       pis=t1*s2s
       pi2s=t1*s3s
       pi3s=t1*s4s
c
       do 705 l2=1,l1
c
       t1=Q(l2)-r(Nucd(i),l2)
       pjs=t1*s2s
       pj2s=t1*s3s
c
       ds=t1*pis
       d1s=t1*pi2s
       d2s=t1*pi3s
c
       f1=1.D0
       if (l1.eq.l2) then
        ds=ds+t3
        d1s=d1s+t4
        d2s=d2s+t5
        f1=sq3
       endif

c
       t6=(ds-ti*d1s)/zc
c
      lij=3
      if (i.eq.j) then
       lij=l1
      endif
       do 705 l3=1,lij
c
       t0=Q(l3)-r(Nucd(j),l3)
       dp=t0*d2s
       pip=t0*pi2s
       pjp=t0*pj2s
c
       if (l1.eq.l3) then
        dp=dp+pj2s/z2
        pip=pip+s2s/z2
       endif
c
       if (l2.eq.l3) then
        dp=dp+pi2s/z2
        pjp=pjp+s2s/z2
       endif
c
c
      lk=l3
      if (i.eq.j) then
       ll=l1*(l1-1)/2-l3*(l3-1)/2+l2
       lk=min(l3,ll)
      endif
       do 705 l4=1,lk
c
       t0=Q(l4)-r(Nucd(j),l4)
       tn=t0*dp
c
       if (l1.eq.l4) then
        tn=tn+pjp/z2
       endif
c
       if (l2.eq.l4) then
        tn=tn+pip/z2
       endif
c
       f2=1.D0
       if (l3.eq.l4) then
        tn=tn+t6
        f2=sq3
       endif
c
       l12=l1*(l1-1)/2+l2
       l34=l3*(l3-1)/2+l4
       ii=i+l12-1
       jj=j+l34-1
c
       cc=ccoef/(f1*f2)
c
c      this to convert to 1 dimensional array, in diagonal case
       k=ii+(Md2-jj)*(jj-1)/2
c
       RMM(M7+k-1)=RMM(M7+k-1)+tn*cc
  705  continue
c
  700  continue
c
c
c
       do 216 i=1,Md
       do 216 j=1,Md
c
        if(i.ge.j) then
         k=i+(Md*2-j)*(j-1)/2
         else
         k=j+(Md*2-i)*(i-1)/2
        endif
c
        XX(i,j)=RMM(M7+k-1)
  216   continue
c
c
       kk=0
      do 112 j=1,Md
      do 112 i=j,Md
       kk=kk+1
       tmp=XX(i,j)
       RMM(M7+kk-1)=tmp
  112  continue
c
      MMp=Md*(Md+1)/2
      do 199 k=1,MMp
  199   RMM(M9+k-1)=0.0D0
c
c     M10=M9+Md
      M10=M9+MMd+MM+1
      M12=M10+Md
      Md3=3*Md
c ESSL OPTION ------------------------------
#ifdef essl
      CALL DGESVF(10,XX,Md,RMM(M9),Md,1,RMM(M10),
     >             Md,Md,RMM(M12),Md3)
c
       ss=RMM(M10)/RMM(M10+Md-1)
c
#endif
c
c LAPACK OPTION ------------------------------
c
#ifdef pack
c
       do i=1,Md
        aux(i)=0.0D0
       enddo
       Md5=5*Md
      rcond=1.0D-07
      call dgelss(Md,Md,1,XX,Md,aux,Md,RMM(M9),rcond,irank,RMM(M10),
     >            Md5,info)
c
      ss=RMM(M9)/RMM(M9+Md-1)
c
#endif
       if (ss.gt.1.D14) then
        SVD=.true.
       endif
c
c------------------------------
c inversion of G matrix , kept in Gm
c
      if (SVD) then
       write(*,900) ss
       
      else
c
c
c
c  ESSL option     
#ifdef essl
      do 312 kk=1,MMp
       RMM(M9+kk-1)=RMM(M7+kk-1)
  312  continue
c
      call DPPICD(RMM(M9),Md,0,rcond,det,aux,Md)
#endif
c
c LINPACK OPTION
#ifdef pack
c
      kk=0
      do 313 j=1,Md
       do 313 i=1,j
       kk=kk+1
       kx=M7+j+(2*Md-i)*(i-1)/2-1
       RMM(M9+kk-1)=RMM(kx)
  313  continue
c
      call dppco(RMM(M9),Md,rcond,aux,info)
      call dppdi(RMM(M9),Md,det,1)
c
      kk=0
      do 314 j=1,Md
      do 314 i=1,j
      kk=kk+1
      kx=j+(2*Md-i)*(i-1)/2-1
       RMM(M15+kx)=RMM(M9+kk-1)
  314  continue
c
      do 315 kk=1,MMp
  315   RMM(M9+kk-1)=RMM(M15+kk-1)
c
#endif
c
      endif
  900  format('SWITCHING TO SVD rcond=',D8.2)
c
c-------------------------------------------------------------------
      return
      end
c
