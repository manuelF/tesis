      SUBROUTINE NEWXYZ(NATSOL,F1,NT)
      INCLUDE 'COMM'
      DIMENSION F1(NT,3)
*------------------------------------------*
*         X Y Z : posiciones reales        *
*         Cambia X Y Z por X1 Y1 Z1        *
*------------------------------------------*

      DO 5 I =1,NPART
      X1(I)  = X(I)
      Y1(I)  = Y(I)
      Z1(I)  = Z(I)
5     CONTINUE
      


      DO I1 = 1, NWAT 
      I=I1+NATOM

      X(I)=ALFA1*X1(I)+ALFA2*(X1(I+NWAT)+X1(I+2*NWAT))
      Y(I)=ALFA1*Y1(I)+ALFA2*(Y1(I+NWAT)+Y1(I+2*NWAT))
      Z(I)=ALFA1*Z1(I)+ALFA2*(Z1(I+NWAT)+Z1(I+2*NWAT))

*---------Ahora X Y Z    = posiciones  con carga----------------*
*               X1 Y1 Z1 = posic. reales                        *
*---------------------------------------------------------------*

      ENDDO


*-------Si ICLSTR=1 es cluster,sino es bulk------*
C-------pone el centro de la caja en el CM de lo cuantico

C      goto 999


      IF(ICLSTR.NE.1)THEN     

      XCMC=0.       
      YCMC=0.       
      ZCMC=0.       
      MAS = 0.

      do I=1,NATOM 
      
      XCMC = XCMC + X(I)
      YCMC = YCMC + Y(I)
      ZCMC = ZCMC + Z(I)
      ENDDO

      XCMC=XCMC/NATOM
      YCMC=YCMC/NATOM
      ZCMC=ZCMC/NATOM
      do I=1,NPART

      X(I) = X(I) - XCMC
      Y(I) = Y(I) - YCMC
      Z(I) = Z(I) - ZCMC

      X1(I) = X1(I) - XCMC
      Y1(I) = Y1(I) - YCMC
      Z1(I) = Z1(I) - ZCMC

      X0(I) = X0(I) - XCMC
      Y0(I) = Y0(I) - YCMC
      Z0(I) = Z0(I) - ZCMC

      enddo
      DO 1 I = 1,NPART


      XX(I) = X(I) / BXLGTH
      YY(I) = Y(I) / BXLGTH
      ZZ(I) = Z(I) / BXLGTH

      XX1(I) = X1(I) / BXLGTH
      YY1(I) = Y1(I) / BXLGTH
      ZZ1(I) = Z1(I) / BXLGTH


      XX(I) = XX(I) - NINT(XX(I))
      YY(I) = YY(I) - NINT(YY(I))
      ZZ(I) = ZZ(I) - NINT(ZZ(I))

      XX1(I) = XX1(I) - NINT(XX1(I))
      YY1(I) = YY1(I) - NINT(YY1(I))
      ZZ1(I) = ZZ1(I) - NINT(ZZ1(I))
1     CONTINUE
      
c======COSAS QUE PUSO NANO===
C------mueve las aguas a la caja
      do i=1,NATOM

      XN = NINT(X(i)/BXLGTH) * BXLGTH
      YN = NINT(Y(i)/BXLGTH) * BXLGTH
      ZN = NINT(Z(i)/BXLGTH) * BXLGTH
      X(i) = X(i) - XN     
      X0(i) = X0(i) - XN     
      Y(i) = Y(i) - YN     
      Y0(i) = Y0(i) - YN     
      Z(i) = Z(i) - ZN     
      Z0(i) = Z0(i) - ZN     
      
      enddo 
      do 2 I=NATOM+1,NATOM+NWAT


      XN = NINT( X(I) / BXLGTH) * BXLGTH 

      X(I) = X(I) - XN       
      X(I+NWAT) = X(I+NWAT) - XN
      X(I+2*NWAT) = X(I+2*NWAT) - XN

      X0(I) = X0(I) - XN
      X0(I+NWAT) = X0(I+NWAT) - XN
      X0(I+2*NWAT) = X0(I+2*NWAT) - XN

      YN = NINT( Y(I) /  BXLGTH) * BXLGTH
      Y(I) = Y(I) - YN
      Y(I+NWAT) = Y(I+NWAT) - YN
      Y(I+2*NWAT) = Y(I+2*NWAT) - YN
      Y0(I) = Y0(I) - YN
      Y0(I+NWAT) = Y0(I+NWAT) - YN
      Y0(I+2*NWAT) = Y0(I+2*NWAT) - YN

      ZN = NINT( Z(I) /  BXLGTH) * BXLGTH
      Z(I) = Z(I) - ZN
      Z(I+NWAT) = Z(I+NWAT) - ZN
      Z(I+2*NWAT) = Z(I+2*NWAT) - ZN
      Z0(I) = Z0(I) - ZN
      Z0(I+NWAT) = Z0(I+NWAT) - ZN
      Z0(I+2*NWAT) = Z0(I+2*NWAT) - ZN

      X1(I) = X1(I) - XN
      X1(I+NWAT) = X1(I+NWAT) - XN
      X1(I+2*NWAT) = X1(I+2*NWAT) - XN
      
      Y1(I) = Y1(I) - YN
      Y1(I+NWAT) = Y1(I+NWAT) - YN
      Y1(I+2*NWAT) = Y1(I+2*NWAT) - YN

      Z1(I) = Z1(I) - ZN
      Z1(I+NWAT) = Z1(I+NWAT) - ZN
      Z1(I+2*NWAT) = Z1(I+2*NWAT) - ZN


C      write(*,*) 'newpos',I,X1(I),Y1(I),Z1(I)
2     continue

C========FIN NANO===
      
      ENDIF
C999   CONTINUE

      DO 3 I=1, NPART
      FX(I) = ZERO
      FY(I) = ZERO
      FZ(I) = ZERO
      F1(I,1)=ZERO
      F1(I,2)=ZERO
      F1(I,3)=ZERO
      FQ(I) = ZERO
      FQC(I)= ZERO
      FQP(I)= ZERO
      FQV(I)= ZERO
      EPOL(I)=ZERO
      EC(I) = ZERO
      VCSSO = ZERO
      VCSSH = ZERO
      VCSST = ZERO
3     CONTINUE

      RETURN
      END

        

