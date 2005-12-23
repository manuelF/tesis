      SUBROUTINE TEPCHR(NATSOL)
      INCLUDE 'COMM'
      DIMENSION TI(3,3),OMG(3),INDX(3)
      
*-----------Velocid. al azar de 1 distr. gausseana--------------*
      TEMPAV = ZERO
      NOFSET=0
      DO  1 I= 1,NSPECQ+NATSOL
      IF(I.GT.1 ) NOFSET=NOFSET+NNAT(I-1)
      DO  1 J= 1+NOFSET,NNAT(I)+NOFSET
      IF(J.LE.NATOM)THEN
        VX(J)=ZERO
        VY(J)=ZERO
        VZ(J)=ZERO
      ENDIF
      VX(J)=VF(I)*GAUSSN()
      VY(J)=VF(I)*GAUSSN()
      VZ(J)=VF(I)*GAUSSN()
      TEMPAV = TEMPAV + WWM(I)*(VX(J)**2+VY(J)**2+VZ(J)**2)
1     CONTINUE
      TEMPAV1 = TEMPAV/GDF
*-----------------Velocidad del centro de masa------------------*
      SX1=ZERO
      SY1=ZERO
      SZ1=ZERO

      NOFSET=0
      DO 5 I=1,NSPECQ+NATSOL
      IF(I.GT.1) NOFSET=NOFSET+NNAT(I-1)
      DO 5 J=1+NOFSET,NNAT(I)+NOFSET
      SX1=SX1+ WWM(I)*VX(J)
      SY1=SY1+ WWM(I)*VY(J)
      SZ1=SZ1+ WWM(I)*VZ(J)
5     CONTINUE
      
      VXCM=SX1/TOTMAS
      VYCM=SY1/TOTMAS
      VZCM=SZ1/TOTMAS

*-------------A todas las parts. les resto la veloc.CM----------*
c      IF(NDFT.EQ.1)GOTO 89
      DO 9 I=1,NPART
      if(i.gt.natom)then
      VX0(I)=VX(I)-VXCM
      VY0(I)=VY(I)-VYCM
      VZ0(I)=VZ(I)-VZCM
      else
      VX0(I)=VX(I)
      VY0(I)=VY(I)
      VZ0(I)=VZ(I)
      endif
9     CONTINUE


*---------Calculo el momento angular total y se lo resto-------*
       if(one.ne.two)goto 990

       TI(1,1) = ZERO
       TI(1,2) = ZERO
       TI(1,3) = ZERO
       TI(2,2) = ZERO
       TI(3,3) = ZERO
       TI(2,3) = ZERO
       OMG(1) = ZERO
       OMG(2) = ZERO
       OMG(3) = ZERO


       NOFSET=0
       DO 8 I=1,NSPECQ+NATSOL
       IF(I.GT.1) NOFSET=NOFSET+NNAT(I-1)
       DO 8 J=1+NOFSET,NNAT(I)+NOFSET
       TI(1,1) = TI(1,1) + WWM(I)*(Y(J)**2 + Z(J)**2)
       TI(2,2) = TI(2,2) + WWM(I)*(X(J)**2 + Z(J)**2)
       TI(3,3) = TI(3,3) + WWM(I)*(Y(J)**2 + X(J)**2)
       TI(1,2) = TI(1,2) - WWM(I)*X(J)*Y(J)
       TI(1,3) = TI(1,3) - WWM(I)*X(J)*Z(J)
       TI(2,3) = TI(2,3) - WWM(I)*Z(J)*Y(J)
       OMG(1) = OMG(1) + WWM(I)*(Y(J)*VZ(J)-Z(J)*VY0(J))
       OMG(2) = OMG(2) + WWM(I)*(Z(J)*VX(J)-X(J)*VZ0(J))
       OMG(3) = OMG(3) + WWM(I)*(X(J)*VY(J)-Y(J)*VX0(J))
8      CONTINUE


       TI(3,2) = TI(2,3)
       TI(2,1) = TI(1,2)
       TI(3,1) = TI(1,3)

    
       CALL LUDCMP(TI,3,3,INDX,DTT)
       CALL LUBKSB(TI,3,3,INDX,OMG)

       DO  J = 1, NPART
       VX0(J) = VX0(J) - (OMG(2)*Z(J) - OMG(3)*Y(J))      
       VY0(J) = VY0(J) - (OMG(3)*X(J) - OMG(1)*Z(J))      
       VZ0(J) = VZ0(J) - (OMG(1)*Y(J) - OMG(2)*X(J))      
       ENDDO


990    continue
89    CONTINUE
*---------------------Corrijo las posiciones------------------*
      DO 20 I=1,NPART

*-----Un paso atras----*
      X(I) = X0(I)
      Y(I) = Y0(I)
      Z(I) = Z0(I)

*-----Posic. nuevas-----*      
       IF(I.LE.NATOM)THEN
       XX(I)=X(I)
       YY(I)=Y(I)
       ZZ(I)=Z(I)
       ELSE 
      XX(I)=X(I)+VX0(I)*DELTAT
      YY(I)=Y(I)+VY0(I)*DELTAT
      ZZ(I)=Z(I)+VZ0(I)*DELTAT
       ENDIF


20    CONTINUE

      TEMPAV = ZERO
      NOFSET=0
      DO 335 I=1,NSPECQ+NATSOL
      TEMPA(I)=ZERO
      IF(I.GT.1) NOFSET=NOFSET+NNAT(I-1)
      DO 45 J=1+NOFSET,NNAT(I)+NOFSET
      TEMPA(I)=WWM(I)*(VX0(J)**2+VY0(J)**2+VZ0(J)**2)
45    CONTINUE
      TEMPAV=TEMPAV+TEMPA(I)
335   CONTINUE
      
      TEMPAV2=TEMPAV/GDF

      CALL GAMMA(NATSOL)

     
      NOFSET = 0
      XCM = ZERO
      YCM = ZERO
      ZCM = ZERO

c      DO I = 1, NSPECQ+NATSOL
c      IF (I.GT.1) NOFSET = NOFSET + NNAT(I-1)
c      DO J = 1+ NOFSET , NNAT(I)+NOFSET

c      XCM = XCM + XX(J)*WWM(I)
c      YCM = YCM + YY(J)*WWM(I)
c      ZCM = ZCM + ZZ(J)*WWM(I)

c      ENDDO
c      ENDDO

c       IF(NDFT.EQ.1.)THEN

        DO I=1, NPART
        X(I)=XX(I)
        Y(I)=YY(I)
        Z(I)=ZZ(I)
        ENDDO

c       ELSE      
c        DO I=1, NPART
c        X(I)=XX(I)-XCM/TOTMAS 
c        Y(I)=YY(I)-YCM/TOTMAS 
c        Z(I)=ZZ(I)-ZCM/TOTMAS 
c        X(I)=XX(I)
c        Y(I)=YY(I)
c        Z(I)=ZZ(I)
c        ENDDO
c       ENDIF
*-------------------Temperatura media--------------------*

      TEMPAV=ZERO
      NOFSET = 0
      DO 135 I=1,NSPECQ+NATSOL
      TEMPA(I)=ZERO
      IF (I.GT.1) NOFSET=NOFSET+NNAT(I-1)
      DO 35 J=1+NOFSET,NNAT(I)+NOFSET
    
      VX0(J) = (X(J)-X0(J))/DELTAT
      VY0(J) = (Y(J)-Y0(J))/DELTAT
      VZ0(J) = (Z(J)-Z0(J))/DELTAT
c       if(j.le.natom)then
c       write(*,*)'tepchr',j,vx0(j),vy0(j),vz0(j)
c       endif

      VX(J) = VX0(J)
      VY(J) = VY0(J)
      VZ(J) = VZ0(J)

      VX2=VX0(J)*VX0(J)
      VY2=VY0(J)*VY0(J) 
      VZ2=VZ0(J)*VZ0(J)
      TEMPA(I)=TEMPA(I)+(VX2+VY2+VZ2)*WWM(I)

35    CONTINUE
      TEMPAV=TEMPAV+TEMPA(I)
135   CONTINUE


      TEMPP=TEMPAV/GDF

*--------TEMPAV1: despues de randomizar--------------*
*        TEMPAV2: despues de restar Vcm              *
*        TEMPP  : despues de llamar gamma y          *
*		  recalcular posiciones y velocids---*

      WRITE(6,19) TEMPRQ,TEMPAV1,TEMPAV2
19     FORMAT (/,2X, 'TERMOSTATO:, TEMP1, TEMP2',G14.6,2X,
     & G14.6,2X,G14.6)
      WRITE (6,*)itel, ' ENTRE A TEPCHR y TEMP ES:', TEMPP


c      NOFSET = 0
c      XCM = ZERO
c      YCM = ZERO
c      ZCM = ZERO

c      DO I = 1, NSPECQ+NATSOL
c      IF (I.GT.1) NOFSET = NOFSET + NNAT(I-1)
c      DO J = 1+ NOFSET , NNAT(I)+NOFSET

c      XCM = XCM + X(J)*WWM(I)
c      YCM = YCM + Y(J)*WWM(I)
c      ZCM = ZCM + Z(J)*WWM(I)
c      ENDDO
c      ENDDO

c      xcm=xcm/totmas
c      ycm=ycm/totmas
c      zcm=zcm/totmas


      RETURN
      END

