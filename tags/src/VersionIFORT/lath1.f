      SUBROUTINE LATHWD(NATSOL) 
      INCLUDE 'COMM'
      DIMENSION RX(40),RY(40),RZ(40)


*-------------------------Aguas en red FCC-------------------*
*                    X, Y, Z:  posic. con carga              *
*                                                            *  
*------------------------------------------------------------*


      IF (NWAT.EQ.0)  RETURN

      NOFSET=0
      DO 55 I=1,NATSOL
      IF (I.GT.1) NOFSET=NOFSET+NNAT(I)
      DO 55 J=NOFSET+1,NNAT(I)+NOFSET
      PC(J)=ZZZ(I)*EE
      PC0(J)=PC(J)
55    CONTINUE

      VB= (DBLE(NWAT)/FOUR)**THIRD  
      NVB=INT(VB)
      VVB=DBLE(NVB)
      write(*,*)vb,nvb,vvb       


      IF(VVB.NE.VB)THEN
	 IF(ICLSTR.NE.1)THEN
	 WRITE(6,*)'En fase condensada el nwat debe ser 4*N**3'  
	 STOP
	 ENDIF
	 NVB=NVB+1
      ENDIF

      CELL=BXLGTH/NVB
      CELL2=CELL/TWO
      write(*,*)'lath: cell,cell2  ',cell,cell2  


      IF ((DSQRT(TWO)*CELL/TWO).LT.SIGMA(1)) THEN
      WRITE(6,*) 'Densidad de oxigenos muy alta'
      STOP
      ENDIF

      RX(1)=0
      RY(1)=0
      RZ(1)=0
      
      RX(2)=CELL2
      RY(2)=CELL2
      RZ(2)=0
      
      RX(3)=CELL2
      RY(3)=0
      RZ(3)=CELL2
      
      RX(4)=0
      RY(4)=CELL2
      RZ(4)=CELL2

c      XH=0
c      YH=-DA(1)*0.7907964D0                                               
c      ZH=-DA(1)*0.6120792D0

      XH=0
      YH=-DA(1)*DSIN(52.26D0*PI/180.D0)
      ZH=-DA(1)*DCOS(52.26D0*PI/180.D0)



      JJ=0
      DO 99 IZ=1,NVB
      DO 99 IY=1,NVB
      DO 99 IX=1,NVB

         DO I=1,4 

         X(I+JJ)=(IX-1)*CELL+RX(I)
         Y(I+JJ)=(IY-1)*CELL+RY(I)
         Z(I+JJ)=(IZ-1)*CELL+RZ(I) 
         
         PHI=TWOPI*RANF()
         PSI=TWOPI*RANF()
         THE=PI*(ONE - TWO*RANF())

         SINPSI = DSIN(PSI)
         COSPSI = DCOS(PSI)

         COSPHI = DCOS(PHI)
         SINPHI = DSIN(PHI)

         COSTHE = DCOS(THE)
         SINTHE = DSIN(THE)


      X(I+JJ+NWAT)=  X(I+JJ) + YH * (-SINPSI*COSPHI-COSTHE*
     & SINPHI*COSPSI)+ZH * SINTHE * SINPHI
      Y(I+JJ+NWAT)=  Y(I+JJ) + YH * (-SINPSI*SINPHI+COSTHE*
     &  COSPHI*COSPSI) - ZH * SINTHE * COSPHI
      Z(I+JJ+NWAT)=  Z(I+JJ)+YH*SINTHE*COSPSI+ZH*COSTHE


      X(I++JJ+2*NWAT)=X(I+JJ)-YH*(-SINPSI*COSPHI-COSTHE*
     &  SINPHI*COSPSI)+ ZH*SINTHE*SINPHI 
      Y(I+JJ+2*NWAT)=Y(I+JJ)-YH*(-SINPSI*SINPHI+COSTHE*
     &  COSPHI*COSPSI)+ZH*(-SINTHE*COSPHI) 
      Z(I+JJ+2*NWAT)=Z(I+JJ)-YH*SINTHE*COSPSI+ZH*COSTHE


      IF (I+JJ.EQ.NWAT) GOTO 8100

      ENDDO
      JJ=JJ+4

99    CONTINUE



      IF (JJ.LT.NWAT) THEN
      WRITE(6,*) 'No alcanza la red para todos los oxigenos'
      STOP
      ENDIF
      
8100  CONTINUE

*-----------------Velocidades iniciales nulas-------------*
      DO I=1,NPART
         VX(I)=ZERO
         VY(I)=ZERO
         VZ(I)=ZERO

         VX0(I)=VX(I)
         VY0(I)=VY(I)
         VZ0(I)=VZ(I)
      ENDDO 

*---------------------Posicion del CM---------------------*
      XCM=ZERO
      YCM=ZERO
      ZCM=ZERO

      NOFSET=0
      DO 100 I=1,NATSOL
      IF(I.GT.1)  NOFSET=NOFSET+NNAT(I-1)
      DO  J=1+NOFSET,NNAT(I)+NOFSET
      
      XCM = XCM + WWM(I)*X(J)
      YCM = YCM + WWM(I)*Y(J)
      ZCM = ZCM + WWM(I)*Z(J)
      
      ENDDO

100   CONTINUE

      XCM=XCM/TOTMAS
      YCM=YCM/TOTMAS
      ZCM=ZCM/TOTMAS

*-------------A todas las parts. les resto la posic.CM----------*

      DO 20 I=1,NPART

      X(I)=X(I)-XCM
      Y(I)=Y(I)-YCM
      Z(I)=Z(I)-ZCM
      
20    CONTINUE

*--------------Distancias INTRAmoleculares iniciales-------------*
      

      DO 209 I=1,NWAT
      N1=I+NWAT
      N2=N1+NWAT

      D1=(X(I)-X(N1))**2+(Y(I)-Y(N1))**2+(Z(I)-Z(N1))**2
      D2=(X(I)-X(N2))**2+(Y(I)-Y(N2))**2+(Z(I)-Z(N2))**2
      D3=(X(N1)-X(N2))**2+(Y(N1)-Y(N2))**2+(Z(N1)-Z(N2))**2

c      WRITE(6,653)I,n1,(DSQRT(D1)/DA(1))
c      WRITE(6,653)I,n2,(DSQRT(D2)/DA(1))
c      WRITE(6,653)N1,N2,(DSQRT(D3)/DA(3))
653   FORMAT (1X,'dist.INTRAmole/DA(1o3)',I4,i4,3G15.7)

209   CONTINUE

*--------------Distancias INTERmoleculares iniciales-------------*

      DO 8999 J=1,NWAT-1
      DO 8999 I=J+1, NWAT
      D4=(X(J)-X(I))**2+(Y(J)-Y(I))**2+(Z(J)-Z(I))**2
 
      IF ((DSQRT(D4)).LT.SIGMA(1)) THEN
      WRITE (6,*) 'OJO CON DIST.INTERMOL:', I,J,D4,CELL
      STOP
      ENDIF

c      WRITE(6,9653)I,J,(DSQRT(D4)/CELL)
9653  FORMAT(1X,'dist.INTERmole/CELL',I4,I4,3G15.7)

8999  CONTINUE      
      

*-------------------Inicio : Reposo---------------------*

      DO I  = 1, NPART
       X0(I)  = X(I)
       Y0(I)  = Y(I)
       Z0(I)  = Z(I)


      ENDDO           
       
      RETURN
      END

