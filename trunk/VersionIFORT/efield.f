        SUBROUTINE EFIELD(ELFIELD,DISTPLAC,NUMBERQ,xq,yq,zq,dqi)
        IMPLICIT NONE
        real*16 D,Xq,Yq,zq,dqi,AREA,ELFIELD,DENS,EZERO,ELECQ,dq
        INTEGER NQ,I,J,K,atq
        DIMENSION Xq(50000),Yq(50000),Zq(50000),ATQ(50000),dqi(50000)

        AREA = 0.0
        DENS = 0.0
        EZERO = 8.854187817D-12
        ELECQ = 1.60217733D-19
        AREA = 0.2D0*D*NQ*0.2D0*D*NQ
        DENS = ELFIELD*EZERO*1.0D-10/ELECQ
        dq = AREA*DENS/(2*(NQ+1)*(NQ+1))

        DO I = 0,NQ
        ATQ(I) = 1
        Xq(I) = (-INT(NQ/2)+I)*0.2*d
        DO J = 0,NQ
        Yq(J) = (-INT(NQ/2)+J)*0.2*d
        DO K = 0,1
        Zq(K) = -0.5D0*d+d*K
        DQI(K) = -dq+dq*2.0D0*K
        ENDDO
        ENDDO
        ENDDO

        DO I=0,NQ
	DO J=0,NQ
	DO K=1,2
	WRITE(1,1) 'H',XQ(I),YQ(J),ZQ(K),DQI(K)
        ENDDO
        ENDDO
        ENDDO
1       FORMAT (A,4F4.9)
        END

