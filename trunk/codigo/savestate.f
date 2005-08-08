      SUBROUTINE SAVESTATE(OPEN,NORM,natom,Iz,Nuc,ncont,nshell,a,c,r,
     1 			M,M18,NCOa,NCOb,RMM,Ex,NG2)
     
      IMPLICIT NONE
      logical NORM, OPEN
      integer NATOM, IZ, NUC, NCONT, NSHELL, M, M18, NCOA, NCOB, NG2
      real*8  a, c, r, RMM(NG2), EX
      
      integer i
      
      open (unit=99, access='SEQUENTIAL', form='FORMATTED', 
     1     file='state.log')
      write(6, *) "Saving program state"
      
      write(99, *) "======================================="
      write(99, *) "          EXCHFOCK STATE               "
      write(99, *) "======================================="
      
      write(99, *) "OPEN=",OPEN
      write(99, *) "NORM=",NORM
      
      write(99, *) "NATOM=",NATOM
      write(99, *) "IZ=",IZ
      write(99, *) "NUC=",NUC
      write(99, *) "NCONT=",NCONT
      write(99, *) "NSHELL=",NSHELL

      write(99, *) "M=", M
      write(99, *) "M18=", M18
      write(99, *) "NCOa=", NCOA
      write(99, *) "NCOb=", NCOB

      write(99, 15) A
      write(99, 20) C
      write(99, 25) R
      write(99, 10) Ex      
      write(99, *) "---------------------------------------"      
      
      write(6, *) 'diego=', NG2, mod(NG2,10)
C      do 8 i=1,(NG2 mod 10)
C         write (6, *) 'diego=', i
C8     continue
      
      close(99)
      STOP

      return
      
10    FORMAT(' EX=',E25.15)
15    FORMAT(' a=',E25.15)
20    FORMAT(' c=',E25.15)
25    FORMAT(' r=',E25.15)
      END