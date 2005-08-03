      SUBROUTINE FSPHER2(NATSOL)
      INCLUDE 'COMM'
      DOUBLE PRECISION ERFCb
      DIMENSION DX(NAT),DY(NAT),DZ(NAT),RIJSQ(NAT)
      DIMENSION DX1(NAT),DY1(NAT),DZ1(NAT),RIJSQ1(NAT)
      DIMENSION JNF(NAT),QIJ(NAT) ,fqp1(nat)
      SQRTPI=SQRT(PI)
    
c     write(*,*) 'Estoy en fspher2'
   
C-----PARAM LENN-JONES OXIGENOS CLASICOS
      EE12O=E12(NSPECQ+1)
      EE6O=E6(NSPECQ+1)
      FF12O=F12(NSPECQ+1)
      FF6O=F6(NSPECQ+1)

C-----PARAM LENN-JONES HIDOGENOS CLASICOS
      EE12H=E12(NSPECQ+2)
      EE6H=E6(NSPECQ+2)
      FF12H=F12(NSPECQ+2)
      FF6H=F6(NSPECQ+2)

C-----PARAM LENN-JONES HID-OX
        SIG3OH  = PTFIVE * (SIGMA(NSPECQ+2)+SIGMA(NSPECQ+1))
        EPSSOH  = DSQRT (EPS(NSPECQ+2)*EPS(NSPECQ+1))

        IF (SIGMA(NSPECQ+2).EQ.ZERO) THEN

        SIG3OH = ZERO
        EPSSOH = ZERO
        ENDIF
       
        EPSIOH  = EPSSOH * FOUR * BOLTZF
        SIG3OH  = SIG3OH * SIG3OH * SIG3OH
        SIG6OH  = SIG3OH * SIG3OH
        SIG12OH = SIG6OH * SIG6OH
        EE6OH   = EPSIOH * SIG6OH
        EE12OH  = EPSIOH * SIG12OH
        FF12OH  = 12.D0 * EE12OH
        FF6OH   = 6.D0  * EE6OH

c    write(*,*) 'LJ=',EE6OH,EE12OH,EE6H,EE12H,EE6O,EE12O

      DO 1554 ISITE= 1, 3
      IOFSET=(ISITE-1)*NWAT
      DO 1554 JSITE=1,3
      JOFSET=(JSITE-1)*NWAT

      IPRD=ISITE*JSITE

      IF (IPRD.EQ.1) THEN
      M=1
      ELSEIF (ISITE.EQ.1.OR.JSITE.EQ.1) THEN
      M=2
      ELSE
      M=3
      ENDIF

*----------------------------------------*
*               M=1  Corresponde a O-O   *
*               M=2  Corresponde a O-H   *
*               M=3  Corresponde a H-H   *
*----------------------------------------*



      DO 1554 I=NATOM+1,NATOM+NWAT-1
      DO 142 J=I+1,NWAT+NATOM


*-----DISTANCIAS ENTRE SITIOS CON CARGA: XYZ -----*
C      IF (ICLSTR.EQ.1)THEN
*----------- Cluster ==> NO min. dist ------------*

C      DX(J)=X(I+IOFSET)-X(J+JOFSET)
C      DY(J)=Y(I+IOFSET)-Y(J+JOFSET)
C      DZ(J)=Z(I+IOFSET)-Z(J+JOFSET)

C      ELSE
*----------- Bulk ==> minima distancia -----------*
C      DX(J)=XX(I+IOFSET)-XX(J+JOFSET)
C      DY(J)=YY(I+IOFSET)-YY(J+JOFSET)
C      DZ(J)=ZZ(I+IOFSET)-ZZ(J+JOFSET)
c      write(*,*) J, DX(J), DY(J), DZ(J)
C      DX(J) =(DX(J) - ANINT(DX(J)))*BXLGTH
C      DY(J) =(DY(J) - ANINT(DY(J)))*BXLGTH
C      DZ(J) =(DZ(J) - ANINT(DZ(J)))*BXLGTH

c      write(*,*) J, DX(J), DY(J), DZ(J)
C      ENDIF

C      RIJSQ(J)=DX(J)*DX(J)+DY(J)*DY(J)+DZ(J)*DZ(J)
      QIJ(J)=PC(I+IOFSET)*PC(J+JOFSET)

*-----DISTANCIAS ENTRE SITIOS CON MASA: X1Y1Z1------*
      IF(ICLSTR.EQ.1)THEN
*----------- Cluster ==> NO min. dist --------------*

      DX1(J)=X1(I+IOFSET)-X1(J+JOFSET)
      DY1(J)=Y1(I+IOFSET)-Y1(J+JOFSET)
      DZ1(J)=Z1(I+IOFSET)-Z1(J+JOFSET)
c      if(DX1(j).eq.0.) write(*,*) 'mierda!! DX1=0'
      ELSE
*----------- Bulk ==> minima distancia -------------*

      DX1(J)=XX1(I+IOFSET)-XX1(J+JOFSET)
      DY1(J)=YY1(I+IOFSET)-YY1(J+JOFSET)
      DZ1(J)=ZZ1(I+IOFSET)-ZZ1(J+JOFSET)

      DX1(J) =(DX1(J) - ANINT(DX1(J)))*BXLGTH
      DY1(J) =(DY1(J) - ANINT(DY1(J)))*BXLGTH
      DZ1(J) =(DZ1(J) - ANINT(DZ1(J)))*BXLGTH

      ENDIF

      RIJSQ1(J)=DX1(J)*DX1(J)+DY1(J)*DY1(J)+DZ1(J)*DZ1(J)
142   CONTINUE

        IF (ICLSTR.EQ.1) THEN
        NN = 0 

        DO 9133 J = I+1,NWAT+NATOM
        NN = NN +1
	JNF(NN)=J
9133    CONTINUE

        ELSE
c idem
        NN = 0
        DO 133 J = I+1,NWAT+NATOM
         IF (RIJSQ1(J).LT.RCTSQ) THEN
        NN = NN +1
        JNF(NN) = J
         ENDIF
133     CONTINUE

        ENDIF


C-------INTERACCION DE LENN-JONES ENTRE  CLASICOS              
        DO 1500 J = 1, NN
        RRSQK1=ONE/RIJSQ1(JNF(J))
        RRIJK1=DSQRT(RRSQK1)
        RR6=RRSQK1*RRSQK1*RRSQK1
        IF(M.EQ.1)THEN
        EGK=(EE12O*RR6-EE6O)*RR6
        FGK=(FF12O*RR6-FF6O)*RR6*RRSQK1	      
c       write(*,*) 'E LJ  M=',M,EGK
        ELSEIF(M.EQ.3)THEN
        EGK=(EE12H*RR6-EE6H)*RR6
        FGK=(FF12H*RR6-FF6H)*RR6*RRSQK1
c       write(*,*) 'E LJ M=',M,EGK
        ELSEIF(M.EQ.2)THEN
        EGK=(EE12OH*RR6-EE6OH)*RR6
        FGK=(FF12OH*RR6-FF6OH)*RR6*RRSQK1
c       write(*,*) 'E LJ M=',M,EGK
	
        VLJ=VLJ+EGK


*------------G(r) OO---------------*
	IRR = NINT(ONE/(RRIJK1*DELR))
	IRR = MIN(IGGRID,IRR)
	KG(1,IRR) = KG(1,IRR) + 2
*----------------------------------*

        AAX=DX1(JNF(J))*FGK
        AAY=DY1(JNF(J))*FGK
        AAZ=DZ1(JNF(J))*FGK
        
        FX(I+IOFSET)=FX(I+IOFSET)+AAX
        FY(I+IOFSET)=FY(I+IOFSET)+AAY
        FZ(I+IOFSET)=FZ(I+IOFSET)+AAZ

        FX(JNF(J)+JOFSET)=FX(JNF(J)+JOFSET)-AAX
        FY(JNF(J)+JOFSET)=FY(JNF(J)+JOFSET)-AAY
        FZ(JNF(J)+JOFSET)=FZ(JNF(J)+JOFSET)-AAZ

        ENDIF
1500    CONTINUE

           IF (ICLSTR.EQ.1) THEN

       NN = 0
       DO 6133 J = I+1,NWAT+NATOM
       NN = NN +1
       JNF(NN) = J
6133   CONTINUE

           ELSE

       NN = 0
       DO 2133 J = I+1,NWAT+NATOM
       IF (RIJSQ1(J).LT.RCTSQ) THEN
       NN = NN +1
       JNF(NN) = J
       ENDIF
2133   CONTINUE

           ENDIF
c agrgegado de damian:
c en la segunda oracion aca abajo agregue el 1
 
      DO 1490 J=1,NN
      RRSQK=ONE/RIJSQ1(JNF(J))
      RRIJK=DSQRT(RRSQK)

*     *-------G(r) HH--------------*
      IF (M.EQ.3) THEN 
      IRR = NINT(ONE/(RRIJK*DELR))
      IRR = MIN(IGGRID,IRR)
      KG(M,IRR) = KG(M,IRR) + 2
*     *----------------------------*

*     *------G(r) OH---------------*
      ELSEIF (M.EQ.2) THEN
      IRR = NINT(DSQRT( RIJSQ1(JNF(J)) )/DELR)
      IRR = MIN(IGGRID,IRR)
      KG(M,IRR) = KG(M,IRR) + 1
      ENDIF
*     *----------------------------*


CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C              CLUSTER     (COULOMB)                  C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

            IF (ICLSTR.EQ.1)THEN


       EGKC = QIJ(JNF(J))*RRIJK
       FGKC = EGKC*RRSQK

       VCT = VCT + EGKC

       FQI = -PC(JNF(J)+JOFSET)*RRIJK
       FQJ = -PC(I+IOFSET)*RRIJK
       FQ(I+IOFSET)=FQ(I+IOFSET)+FQI
       FQ(JNF(J)+JOFSET)=FQ(JNF(J)+JOFSET)+FQJ


CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C            BULK: SIST.PERIODICO     (COULOMB)              C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

             ELSEIF (ICLSTR.NE.1)THEN


c       write(*,*)'fspher',i+iofset,jnf(j)+jofset,
c     & pc(i+iofset)/ee,pc(jnf(j)+jofset)/ee,qij(jnf(j))/(ee**2)
*      ------------------------------
*      ----Coul: qq*erfc(Kr)/r + furim--------
*      ------------------------------

       IF (IEWLD.EQ.1) THEN

       EGKC = QIJ(JNF(J))*RRIJK*DERFC(RKAPPA/RRIJK)
       FGKC = EGKC +TWO*RKAPPA*DEXP(-RKAPPA2/RRSQK)
     &   /SQRTPI*QIJ(JNF(J))
       FGKC = FGKC*RRSQK

       FQI  = -EGKC/PC(I+IOFSET)
       FQJ  = -EGKC/PC(JNF(J)+JOFSET)
       FQ(I+IOFSET)=FQ(I+IOFSET)+FQI
       FQ(JNF(J)+JOFSET)=FQ(JNF(J)+JOFSET)+FQJ

        VCT = VCT + EGKC
        ELSE

*----------Coul:----------------------------------------------
*                qq(1/r + Eshift)          si r < rm2
*                qq(Cshift - (A+B*rr)rr)   si rm2 < r < rct
*                cero                      si r > rct
*-------------------------------------------------------------
        IF(RIJSQ1(JNF(J)).LT.RM2) THEN
        EGKC = QIJ(JNF(J))* RRIJK
        FGKC = EGKC*RRSQK
c        write(*,*) 'energia y fuerza',i+IOFSET
c     >  ,JNF(j) + JOFSET,EGKC,FGKC,QIJ(JNF(j))
        VCT = VCT + EGKC + QIJ(JNF(J))*ESHIFT
        Vcerca = Vcerca + EGKC +  QIJ(JNF(J))*ESHIFT   
c        pedo= EGKC  
c        pedo2= FGKC
c        RR = RIJSQ(JNF(J))

        ELSEIF((RIJSQ1(JNF(J)).GT.RM2).AND.
     &         (RIJSQ1(JNF(J)).LT.RCTSQ)) THEN
c        write(*,*) 'cacas2', JNF(j),RIJSQ(JNF(J)),RCTSQ


        RR = RIJSQ1(JNF(J))
        EGKC = QIJ(JNF(J))*(CSHIFT-(AB+B*RR)*RR)
        FGKC = QIJ(JNF(J))*(AF+BF*RR)
        VCT = VCT + EGKC
        Vlejos = Vlejos  + EGKC

c        pedo = EGKC
c        pedo2= FGKC
c     >  ,JNF(j) + JOFSET,EGKC,FGKC,QIJ(JNF(j)),AF,BF,RR


        ENDIF
c        write(99,*) rr ,pedo, pedo2 
   

      ENDIF
      ENDIF


c      write(98,*)  'ESHIFT  CSHIFT  AB b AF BF  RM2 RCTSQ QIJ'
c      write(98,*)  ESHIFT,  CSHIFT,  AB, B, AF, BF, RM2,
c     > RCTSQ, QIJ(JNF(J))
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC


      AAX=DX1(JNF(J))*FGKC
      AAY=DY1(JNF(J))*FGKC
      AAZ=DZ1(JNF(J))*FGKC
       
      IF (ISITE.EQ.1) THEN
      
      FX(I+IOFSET)=FX(I+IOFSET)+AAX*ALFA1
      FY(I+IOFSET)=FY(I+IOFSET)+AAY*ALFA1
      FZ(I+IOFSET)=FZ(I+IOFSET)+AAZ*ALFA1

      IIO=I+IOFSET+NWAT
      FX(IIO)=FX(IIO)+AAX*ALFA2
      FY(IIO)=FY(IIO)+AAY*ALFA2
      FZ(IIO)=FZ(IIO)+AAZ*ALFA2

      IIO=IIO+NWAT
      FX(IIO)=FX(IIO)+AAX*ALFA2
      FY(IIO)=FY(IIO)+AAY*ALFA2
      FZ(IIO)=FZ(IIO)+AAZ*ALFA2

      ELSE
      
      FX(I+IOFSET)=FX(I+IOFSET)+AAX
      FY(I+IOFSET)=FY(I+IOFSET)+AAY
      FZ(I+IOFSET)=FZ(I+IOFSET)+AAZ

      ENDIF

      IF (JSITE.EQ.1) THEN

      FX(JNF(J)+JOFSET)=FX(JNF(J)+JOFSET)-AAX*ALFA1
      FY(JNF(J)+JOFSET)=FY(JNF(J)+JOFSET)-AAY*ALFA1 
      FZ(JNF(J)+JOFSET)=FZ(JNF(J)+JOFSET)-AAZ*ALFA1 

      IIO=JNF(J)+JOFSET+NWAT
      FX(IIO)=FX(IIO)-AAX*ALFA2
      FY(IIO)=FY(IIO)-AAY*ALFA2
      FZ(IIO)=FZ(IIO)-AAZ*ALFA2

      IIO=IIO+NWAT
      FX(IIO)=FX(IIO)-AAX*ALFA2
      FY(IIO)=FY(IIO)-AAY*ALFA2
      FZ(IIO)=FZ(IIO)-AAZ*ALFA2

      ELSE
      FX(JNF(J)+JOFSET)=FX(JNF(J)+JOFSET)-AAX
      FY(JNF(J)+JOFSET)=FY(JNF(J)+JOFSET)-AAY 
      FZ(JNF(J)+JOFSET)=FZ(JNF(J)+JOFSET)-AAZ

      ENDIF

1490  CONTINUE
c===========================
         afx=zero
         afy=zero
         afz=zero
         do ll=1,npart
         afx=afx+fx(ll)
         afy=afy+fy(ll)
         afz=afz+fz(ll)
c         write(*,*) 'fspher 1, intermol' 
c         write(*,*) ll,fx(ll),fy(ll),fz(ll)
         enddo

      if(dsqrt(afx**2+afy**2+afz**2).gt.toll)then
c      write(*,*)'FZA TOTAL NE ZERO EN FSPHER (2)'
c      write(*,78)itel, afx,afy,afz
      endif
c============================         
1554  CONTINUE



C-----TERMINOS INTRAMOLECULARES (ENERGIA DE POLARIZACION)
C-----DEL SOLVENTE CLASICO
      DO 87 K=NATOM+1,NATOM+NWAT
      ECSELF=ENOH*PC(K)
      EPOL(K)=ECSELF
      VSELF=VSELF+ECSELF
      FQ(K)=FQ(K)-ENOH
      FQP(K)=FQP(K)-ENOH
      
 
      DO 87 ISITE=1,NATSOL
      DO 87 JSITE=ISITE,NATSOL
      
      IOFSET=(ISITE-1)*NWAT
      JOFSET=(JSITE-1)*NWAT
       
      IPRD=ISITE*JSITE

      IF(IPRD.EQ.1) M=1
      IF(IPRD.EQ.2.OR.IPRD.EQ.3) M=2
      IF(IPRD.EQ.4.OR.IPRD.EQ.9) M=3
      IF(IPRD.EQ.6) M=4
      

      
      IF(M.EQ.1.OR.M.EQ.3)THEN
      ECSELF=OV(M)*PTFIVE*PC(K+IOFSET)*PC(K+IOFSET)
      VSELF=VSELF+ECSELF
      FQ(K+IOFSET)=FQ(K+IOFSET)-OV(M)*PC(K+IOFSET)
      FQP(K+IOFSET)=FQP(K+IOFSET)-OV(M)*PC(K+IOFSET)
      ELSE
      ECSELF=OV(M)*PC(K+IOFSET)*PC(K+JOFSET)
      VSELF=VSELF+ECSELF

      FQ(K+IOFSET)=FQ(K+IOFSET)-OV(M)*PC(K+JOFSET)
      FQ(K+JOFSET)=FQ(K+JOFSET)-OV(M)*PC(K+IOFSET)

      FQP(K+IOFSET)=FQP(K+IOFSET)-OV(M)*PC(K+JOFSET)
      FQP(K+JOFSET)=FQP(K+JOFSET)-OV(M)*PC(K+IOFSET)

      ENDIF
      EPOL(K)=EPOL(K)+ECSELF
87    CONTINUE
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
     
c-----Control de fzas en fspher
      fxx=zero
      fyy=zero
      fzz=zero
      
c      write(*,*)'------------ fspher '
      do i=1+natom,npart
      fxx=fxx+fx(i)
      fyy=fyy+fy(i)
      fzz=fzz+fz(i)
c      write(*,*)i,fx(i),fy(i),fz(i)
      enddo

      if(dsqrt(fxx**2+fyy**2+fzz**2).gt.1.D-04)then
      write(*,*)'FZA TOTAL NE ZERO EN FSPHER'  
      write(*,78)itel, fxx,fyy,fzz
      endif
78    format(i9,3g15.7)


      RETURN
      END

      




      DOUBLE PRECISION FUNCTION ERFCb (X)
      DOUBLE PRECISION A1, A2, A3, A4, A5, P
      DOUBLE PRECISION T, X, XSQ, TP
       A1 = 0.254829592 
       A2 = -0.284496736 
       A3 = 1.421413741 
       A4 = -1.453152027 
       A5 = 1.061405429 
       P = 0.3275911 
       T = 1.0 / (1.0 + P*X )
       XSQ = X*X
       TP = T * (A1 + T * (A2 + T * (A3 + T * (A4 + T * A5 ) ) ) )
       ERFCb = TP * EXP ( -XSQ )
      END
      
      
