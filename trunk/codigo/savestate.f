      SUBROUTINE SAVESTATE(OPEN,NORM,natom,Iz,Nuc,ncont,nshell,a,c,r,
     1 			M,M18,NCOa,NCOb,RMM,Ex,NG2)
     
      IMPLICIT NONE
      logical NORM, OPEN
      integer NATOM, IZ, NUC, NCONT, NSHELL, M, M18, NCOA, NCOB, NG2
      real*8  a, c, r, RMM(NG2), EX
      
      open (unit=99,file='state.log')
      write(6, *) "Saving program state"
      
      write(99, *) "======================================="
      write(99, *) "          EXCHFOCK STATE               "
      write(99, *) "======================================="
      
      write(99, *) "OPEN=", OPEN
      write(99, *) "NORM=", NORM
      
      
      
      
      
      
      
      
      
      
      close(99)
      STOP
      return
      END