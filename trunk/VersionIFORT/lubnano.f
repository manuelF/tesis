


      SUBROUTINE LUBKSB(A,N,NP,INDX,B)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
C     include 'comm.f'
      DIMENSION A(NP,NP),INDX(NP),B(NP)
      II=0
      DO 12 I=1,N
	LL=INDX(I)
	SUM=B(LL)
	B(LL)=B(I)
	IF (II.NE.0)THEN
	  DO 11 J=II,I-1
	    SUM=SUM-A(I,J)*B(J)
11        CONTINUE
	ELSE IF (SUM.NE.0.) THEN
	  II=I
	ENDIF
	B(I)=SUM
12    CONTINUE
      DO 14 I=N,1,-1
	SUM=B(I)
c	IF(I.LT.N)THEN
	  DO 13 J=I+1,N
	    SUM=SUM-A(I,J)*B(J)
13        CONTINUE
c       ENDIF
	B(I)=SUM/A(I,I)
14    CONTINUE
      RETURN
      END

