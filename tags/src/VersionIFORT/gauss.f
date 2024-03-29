      FUNCTION GAUSSN()
      IMPLICIT REAL*16  (A-H,O-Z)
      R1=RANF()
      R2=RANF()
      GAUSSN=DSQRT(-2.D0*DLOG(R1))*DCOS(6.2831853D0*R2)
      RETURN
      END


      FUNCTION RANF()
      IMPLICIT real*16 (A-H,O-Z)
      PARAMETER (M1=1048576,M2=324565)
      COMMON/YU/X,IDUM

      IF (IDUM.NE.-1)THEN
      X = 15.D0
      IDUM = -1
      ENDIF
      X=M2*X-M1*AINT(M2*X/M1)
      RANF= X/M1
      RETURN
      END
