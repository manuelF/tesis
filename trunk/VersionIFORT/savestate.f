      SUBROUTINE SAVESTATE(OPEN,NORM,natom,Iz,Nuc,ncont,nshell,a,c,r,
     1 			M,M18,NCOa,NCOb,RMM,Ex,NG2)
     
      IMPLICIT NONE
      logical NORM, OPEN
      integer NATOM, IZ, NUC, NCONT, NSHELL, M, M18, NCOA, NCOB, NG2
      real*16  a, c, r, EX
      real*16 RMM(NG2)
C	Estas dos se usan para formate      
      integer i, j
      
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
      write(99, *) "--------------------------------------------------"      
      
      write(6, *) 'Starting RMM save'
      do 8 i=0,NG2/5-1
C      do 8 i=1,100
         write (99, 30) RMM(i*5+1), RMM(i*5+2), RMM(i*5+3),
     1    RMM(i*5+4), RMM(i*5+5)
         if (mod(i, 50000).eq.0) write(6, *) i," elements", (i*100)/NG2, 
     1	 	"%"
C     1    RMM(i*10+4), RMM(i*10+5), RMM(i*10+6), RMM(i*10+7), 
C     2    RMM(i*10+8), RMM(i*10+9), RMM(i*10+10)
8     continue
  
      do 9 i=1, mod(NG2, 5)
         write (99, 30) RMM(NG2/10+i)
9     continue



      close(99)
      STOP

      return
      
10    FORMAT(' EX=',E25.15)
15    FORMAT(' a=',E25.15)
20    FORMAT(' c=',E25.15)
25    FORMAT(' r=',E25.15)
30    FORMAT(5E25.15)
      END
