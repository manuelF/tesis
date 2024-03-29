      BLOCK DATA
      implicit real*16 (a-h,o-z)
      common /masses/ xmass(216)
*     Atomic masses (u.m.a.) of most common isotopes
      data xmass /
*      H-1             H-2             H-3
     >  1.007825037D0,  2.014101787D0,  3.016049286D0,  0.0,
*      He-4            He-3
     >  4.00260325D0,   3.016029297D0,  0.0,            0.0,
*      Li-7            Li-6
     >  7.0160045D0,    6.0151232D0,    0.0,            0.0,
*      Be-9
     >  9.0121825D0,    0.0,            0.0,            0.0,
*       B-11            B-10
     > 11.0093053D0,   10.0129380D0,    0.0,            0.0,
*       C-12            C-13
     > 12.000000000D0, 13.003354839D0,  0.0,            0.0,
*       N-14            N-15
     > 14.003074008D0, 15.000108978D0,  0.0,            0.0,
*       O-16            O-18            O-17
     > 15.99491464D0,  17.99915939D0,  16.9991306D0,    0.0,
*       F-19
     > 18.99840325D0,   0.0,            0.0,            0.0,
*      Ne-20           Ne-22           Ne-21
     > 19.9924391D0,   21.9913837D0,   20.9938453D0,    0.0,
*      Na-23
     > 22.9897697D0,    0.0,            0.0,            0.0,
*      Mg-24           Mg-26           Mg-25
     > 23.9850450D0,   25.9825954D0,   24.9858392D0,    0.0,
*      AL-27
     > 26.9815413D0,    0.0,            0.0,            0.0,
*      Si-28           Si-29           Si-30
     > 27.9769284D0,   28.9764964D0,   29.9737717D0,    0.0,
*       P-31
     > 30.9737634D0,    0.0,            0.0,            0.0,
*       S-32            S-34            S-33            S-36
     > 31.9720718D0,   33.96786774D0,  32.9714591D0,   35.9670790D0,
*      Cl-35           Cl-37
     > 34.968852729D0, 36.965902624D0,  0.0,            0.0,
*      Ar-40           Ar-36           Ar-38
     > 39.9623831D0,   35.967545605D0, 37.9627322D0,    0.0,
*       K-39            K-41            K-40
     > 38.9637079D0,   40.9618254D0,   39.9639988D0,    0.0,
*      Ca-40           Ca-44           Ca-42           Ca-48
     > 39.9625907D0,   43.9554848D0,   41.9586218D0,   47.952532D0,
*      Sc-45
     > 44.9559136D0,    0.0,            0.0,            0.0,
*      Ti-48           Ti-46           Ti-47           Ti-49
     > 47.9479467D0,   45.9526327D0,   46.9517649D0,   48.9478705D0,
*       V-51            V-50
     > 50.9439625D0,   49.9471613D0,    0.0,            0.0,
*      Cr-52           Cr-53           Cr-50           Cr-54
     > 51.9405097D0,   52.9406510D0,   49.9460463D0,   53.9388822D0,
*      Mn-55
     > 54.9380463D0,    0.0,            0.0,            0.0,
*      Fe-56           Fe-54           Fe-57           Fe-58
     > 55.9349393D0,   53.9396121D0,   56.9353957D0,   57.9332778D0,
*      Co-59
     > 58.9331978D0,    0.0,            0.0,            0.0,
*      Ni-58           Ni-60           Ni-62           Ni-61
     > 57.9353471D0,   59.9307890D0,   61.9283464D0,   60.9310586D0,
*      Cu-63           Cu-65
     > 62.9295992D0,   64.9277924D0,    0.0,            0.0,
*      Zn-64           Zn-66           Zn-68           Zn-67
     > 63.9291454D0,   65.9260352D0,   67.9248458D0,   66.9271289D0,
*      Ga-69           Ga-71
     > 68.9255809D0,   70.9247006D0,    0.0,            0.0,
*      Ge-74           Ge-72           Ge-70           Ge-73
     > 73.9211788D0,   71.9220800D0,   69.9242498D0,   72.9234639D0,
*      As-75
     > 74.9215955D0,    0.0,            0.0,            0.0,
*      Se-80           Se-78           Se-82           Se-76
     > 79.9165205D0,   77.9173040D0,   81.916709D0,    75.9192066D0,
*      Br-79           Br-81
     > 78.9183361D0,   80.916290D0,     0.0,            0.0,
*      Kr-84           Kr-86           Kr-82           Kr-83
     > 83.9115064D0,   85.910614D0,    81.913483D0,    82.914134D0,
*      Rb-85
     > 84.9117D0,      0.0,             0.0,             0.0,
*      Sr-88           Sr-84           Sr-86           Sr-87
     > 87.9056D0,      83.9134d0,      85.9094d0,      86.9089d0,
*      Y-89
     > 88.9054D0,      0.0,             0.0,             0.0,
*      Zr-90           Zr-91           Zr-92           Zr-94
     > 89.9043D0,      90.9053D0,      91.9046D0,      93.9061D0,
*      Nb-93
     > 92.9060D0,      0.0,             0.0,             0.0,
*      Mo-98           Mo-92           Mo-95           Mo-96
     > 97.9055D0,      91.9063D0,      94.90584D0,     95.9046D0,
*      Tc
     > 98.0D0,         0.0,             0.0,             0.0,
*      Ru-102          Ru-99           Ru-100          Ru-104
     > 101.9037D0,     98.9061D0,      99.9030D0,      103.9055D0,
*      Rh-103
     > 102.9048D0,     0.0,             0.0,             0.0,
*      Pd-106          Pd-104           Pd-105         Pd-108
     > 105.9032D0,     103.9036D0,      104.9046D0,    107.90389D0,
*      Ag-107          Ag-109
     > 106.90509d0,    108.9047D0,      0.0,             0.0,
*      Cd-114          Cd-110           Cd-111         Cd-112
     > 113.9036D0,     109.9030D0,      110.9042D0,    111.9028D0,
*      In-115          In-113
     > 114.9041D0,     112.9043D0,      0.0,             0.0,
*      Sn-118          Sn-116           Sn-117         Sn-119
     > 117.9018D0,     115.9021D0,      116.9031D0,    118.9034D0,
*      Sb-121          Sb-123
     > 120.9038D0,     122.9041D0,      0.0,             0.0,
*      Te-130          Te-125           Te-126         Te-128
     > 129.9067D0,     124.9044D0,      125.9032D0,    127.9047D0,
*      I-127
     > 126.9004D0,     0.0,             0.0,             0.0,
*      Xe-132          Xe-129           Xe-131         Xe-134
     > 131.9042D0,     128.9048D0,      130.9051D0,    133.9054D0/
*
      end
*
c subroutine to generate and store angular grids points
c and weights
c Lebedev ( Becke's method)
c for 50 and 116 angular points
c 12-02-93 , D.E
c-------------------------------------------------------
      SUBROUTINE GRID
      implicit real*16 (a-h,o-z)
*      real*16 e,e2,e3,wang,wang2,wang3,pi,pi4
      parameter (pi=3.14159265358979312D0)
c
      common /intg1/ e(50,3),wang(50),Nr(0:54)
      common /intg2/ e2(116,3),wang2(116),Nr2(0:54),e3(194,3),wang3(194)
      common /radii/ Rm(0:54)
c Slater's radii
      data Rm /1.00,0.35,0.93,1.45,1.05,0.85,0.70,0.65,0.60,0.50,0.71,
c    >  1.80,1.50,1.25,1.10,1.00,1.00,1.00,0.50,
     >  3.60,1.50,1.25,1.10,1.00,1.00,1.00,2.00,
     >  2.20,1.80,1.60,1.40,1.35,1.40,1.40,1.40,1.35,1.35,1.35,
     >  1.35,1.30,
     >  1.25,1.15,1.15,1.15,1.15,
     >  2.35,2.00,1.80,1.55,1.45,1.45,1.35,1.30,1.35,1.40,
     >  1.60,1.55,1.55,1.45,1.45,1.40,1.40,1.31/
c elements not  included yet
c    >  2.60,2.15,1.95,1.85,1.85,1.85,
c    >  1.85,1.85,1.85,1.80,1.75,1.75,1.75,1.75,1.75,1.75,1.75,
c    >  1.55,1.45,1.35,1.35,1.30,1.35,1.35,1.35,1.50,1.90,
c    >  1.80,1.60,1.90/
c
c Number of shells for Least-Squares Fit
      data Nr /20,20,20,25,25,25,25,25,25,25,25,
     >  30,30,30,30,30,30,30,30,
c    >  60,30,30,30,30,30,30,60,
     >  35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,
     >  40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40/
c
      data Nr2 /30,30,30,35,35,35,35,35,35,35,35,
c    >  120,40,40,40,40,40,40,120,
     >  40,40,40,40,40,40,40,40,
     >  45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,
     >  50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50/
c
         do i=0,54
           Rm(i)=Rm(i)/(2.D0*0.529177D0)
         enddo
c
        pi4=4.D0*pi
c
c construction of angular grid #1 : 50 angular points per shell
c and weights
c
c Lebedev , Zh.Mat. Mat. Fiz. 15,1,48 (1975)
c
      do 101 i=1,50
      do 101 k=1,3
 101   e(i,k)=0.0D0
c
      do 102 i=1,6
 102    wang(i)=0.0126984126985D0
c
      do 103 i=7,18
 103    wang(i)=0.0225749559083D0
c
      do 104 i=19,26
 104    wang(i)=0.02109375D0
c
      do 105 i=27,50
 105    wang(i)=0.0201733355379D0
c
      do 106 i=1,50
 106    wang(i)=wang(i)*pi4
c
       e(1,3)=1.D0
       e(2,3)=-1.D0
       e(3,2)=1.D0
       e(4,2)=-1.D0
       e(5,1)=1.D0
       e(6,1)=-1.D0
c
      sq2=sqrt(0.5000000000000D0)
c
       e(7,1)=sq2
       e(7,2)=sq2
       e(8,1)=sq2
       e(8,2)=-sq2
       e(9,1)=-sq2
       e(9,2)=-sq2
       e(10,1)=-sq2
       e(10,2)=sq2
c
       e(11,1)=sq2
       e(11,3)=sq2
       e(12,1)=sq2
       e(12,3)=-sq2
       e(13,1)=-sq2
       e(13,3)=-sq2
       e(14,1)=-sq2
       e(14,3)=sq2
c
c
       e(15,2)=sq2
       e(15,3)=sq2
       e(16,2)=sq2
       e(16,3)=-sq2
       e(17,2)=-sq2
       e(17,3)=-sq2
       e(18,2)=-sq2
       e(18,3)=sq2
c
       ssq3=1.D0/sqrt(3.D0)
c
       e(19,1)=ssq3
       e(19,2)=ssq3
       e(19,3)=ssq3
       e(20,1)=-ssq3
       e(20,2)=ssq3
       e(20,3)=ssq3
       e(21,1)=-ssq3
       e(21,2)=-ssq3
       e(21,3)=ssq3
       e(22,1)=-ssq3
       e(22,2)=-ssq3
       e(22,3)=-ssq3
       e(23,1)=ssq3
       e(23,2)=-ssq3
       e(23,3)=-ssq3
       e(24,1)=ssq3
       e(24,2)=-ssq3
       e(24,3)=ssq3
       e(25,1)=ssq3
       e(25,2)=ssq3
       e(25,3)=-ssq3
       e(26,1)=-ssq3
       e(26,2)=ssq3
       e(26,3)=-ssq3
c
       em=0.904534033733D0
       el=0.301511344578D0
c
       e(27,1)=el
       e(27,2)=el
       e(27,3)=em
       e(28,1)=-el
       e(28,2)=el
       e(28,3)=em
       e(29,1)=-el
       e(29,2)=-el
       e(29,3)=em
       e(30,1)=-el
       e(30,2)=-el
       e(30,3)=-em
       e(31,1)=el
       e(31,2)=-el
       e(31,3)=-em
       e(32,1)=el
       e(32,2)=-el
       e(32,3)=em
       e(33,1)=el
       e(33,2)=el
       e(33,3)=-em
       e(34,1)=-el
       e(34,2)=el
       e(34,3)=-em
c
       e(35,1)=el
       e(35,2)=em
       e(35,3)=el
       e(36,1)=-el
       e(36,2)=em
       e(36,3)=el
       e(37,1)=-el
       e(37,2)=-em
       e(37,3)=el
       e(38,1)=-el
       e(38,2)=-em
       e(38,3)=-el
       e(39,1)=el
       e(39,2)=-em
       e(39,3)=-el
       e(40,1)=el
       e(40,2)=-em
       e(40,3)=el
       e(41,1)=el
       e(41,2)=em
       e(41,3)=-el
       e(42,1)=-el
       e(42,2)=em
       e(42,3)=-el
c
       e(43,1)=em
       e(43,2)=el
       e(43,3)=el
       e(44,1)=-em
       e(44,2)=el
       e(44,3)=el
       e(45,1)=-em
       e(45,2)=-el
       e(45,3)=el
       e(46,1)=-em
       e(46,2)=-el
       e(46,3)=-el
       e(47,1)=em
       e(47,2)=-el
       e(47,3)=-el
       e(48,1)=em
       e(48,2)=-el
       e(48,3)=el
       e(49,1)=em
       e(49,2)=el
       e(49,3)=-el
       e(50,1)=-em
       e(50,2)=el
       e(50,3)=-el
c
c ------------------------------------------------
c construction of angular grid #2 : 116 angular points per shell
c Lebedev , Zh.Mat. Mat. Fiz. 15,1,48 (1975)
c
c
      do 201 i=1,116
      do 201 k=1,3
 201   e2(i,k)=0.0D0
c
      sq2=sqrt(0.5000000000000D0)
      do 202 i=1,12
 202    wang2(i)=0.00200918797730D0
c
      do 203 i=13,20
 203    wang2(i)=0.00988550016044D0
c
      do 204 i=21,44
 204    wang2(i)=0.00844068048232D0
c
      do 205 i=45,68
 205    wang2(i)=0.00987390742389D0
c
      do 206 i=69,92
 206    wang2(i)=0.0093573216900D0
c
      do 207 i=93,116
 207    wang2(i)=0.00969499636166D0
c
      do 208 i=1,116
 208   wang2(i)=wang2(i)*pi4
c
       e2(1,1)=sq2
       e2(1,2)=sq2
       e2(2,1)=sq2
       e2(2,2)=-sq2
       e2(3,1)=-sq2
       e2(3,2)=-sq2
       e2(4,1)=-sq2
       e2(4,2)=sq2
c
       e2(5,1)=sq2
       e2(5,3)=sq2
       e2(6,1)=sq2
       e2(6,3)=-sq2
       e2(7,1)=-sq2
       e2(7,3)=-sq2
       e2(8,1)=-sq2
       e2(8,3)=sq2
c
       e2(9,2)=sq2
       e2(9,3)=sq2
       e2(10,2)=sq2
       e2(10,3)=-sq2
       e2(11,2)=-sq2
       e2(11,3)=-sq2
       e2(12,2)=-sq2
       e2(12,3)=sq2
c
       ssq3=1.D0/sqrt(3.D0)
       e2(13,1)=ssq3
       e2(13,2)=ssq3
       e2(13,3)=ssq3
       e2(14,1)=-ssq3
       e2(14,2)=ssq3
       e2(14,3)=ssq3
       e2(15,1)=-ssq3
       e2(15,2)=-ssq3
       e2(15,3)=ssq3
       e2(16,1)=-ssq3
       e2(16,2)=-ssq3
       e2(16,3)=-ssq3
       e2(17,1)=ssq3
       e2(17,2)=-ssq3
       e2(17,3)=-ssq3
       e2(18,1)=ssq3
       e2(18,2)=-ssq3
       e2(18,3)=ssq3
       e2(19,1)=ssq3
       e2(19,2)=ssq3
       e2(19,3)=-ssq3
       e2(20,1)=-ssq3
       e2(20,2)=ssq3
       e2(20,3)=-ssq3
c
       em=0.973314565209D0
       el=0.162263300152D0
c
       e2(21,1)=el
       e2(21,2)=el
       e2(21,3)=em
       e2(22,1)=-el
       e2(22,2)=el
       e2(22,3)=em
       e2(23,1)=-el
       e2(23,2)=-el
       e2(23,3)=em
       e2(24,1)=-el
       e2(24,2)=-el
       e2(24,3)=-em
       e2(25,1)=el
       e2(25,2)=-el
       e2(25,3)=-em
       e2(26,1)=el
       e2(26,2)=-el
       e2(26,3)=em
       e2(27,1)=el
       e2(27,2)=el
       e2(27,3)=-em
       e2(28,1)=-el
       e2(28,2)=el
       e2(28,3)=-em
c
       e2(29,1)=el
       e2(29,2)=em
       e2(29,3)=el
       e2(30,1)=-el
       e2(30,2)=em
       e2(30,3)=el
       e2(31,1)=-el
       e2(31,2)=-em
       e2(31,3)=el
       e2(32,1)=-el
       e2(32,2)=-em
       e2(32,3)=-el
       e2(33,1)=el
       e2(33,2)=-em
       e2(33,3)=-el
       e2(34,1)=el
       e2(34,2)=-em
       e2(34,3)=el
       e2(35,1)=el
       e2(35,2)=em
       e2(35,3)=-el
       e2(36,1)=-el
       e2(36,2)=em
       e2(36,3)=-el
c
       e2(37,1)=em
       e2(37,2)=el
       e2(37,3)=el
       e2(38,1)=-em
       e2(38,2)=el
       e2(38,3)=el
       e2(39,1)=-em
       e2(39,2)=-el
       e2(39,3)=el
       e2(40,1)=-em
       e2(40,2)=-el
       e2(40,3)=-el
       e2(41,1)=em
       e2(41,2)=-el
       e2(41,3)=-el
       e2(42,1)=em
       e2(42,2)=-el
       e2(42,3)=el
       e2(43,1)=em
       e2(43,2)=el
       e2(43,3)=-el
       e2(44,1)=-em
       e2(44,2)=el
       e2(44,3)=-el
c
       em=0.840255982384D0
       el=0.383386152638D0
c
       e2(45,1)=el
       e2(45,2)=el
       e2(45,3)=em
       e2(46,1)=-el
       e2(46,2)=el
       e2(46,3)=em
       e2(47,1)=-el
       e2(47,2)=-el
       e2(47,3)=em
       e2(48,1)=-el
       e2(48,2)=-el
       e2(48,3)=-em
       e2(49,1)=el
       e2(49,2)=-el
       e2(49,3)=-em
       e2(50,1)=el
       e2(50,2)=-el
       e2(50,3)=em
       e2(51,1)=el
       e2(51,2)=el
       e2(51,3)=-em
       e2(52,1)=-el
       e2(52,2)=el
       e2(52,3)=-em
c
       e2(53,1)=el
       e2(53,2)=em
       e2(53,3)=el
       e2(54,1)=-el
       e2(54,2)=em
       e2(54,3)=el
       e2(55,1)=-el
       e2(55,2)=-em
       e2(55,3)=el
       e2(56,1)=-el
       e2(56,2)=-em
       e2(56,3)=-el
       e2(57,1)=el
       e2(57,2)=-em
       e2(57,3)=-el
       e2(58,1)=el
       e2(58,2)=-em
       e2(58,3)=el
       e2(59,1)=el
       e2(59,2)=em
       e2(59,3)=-el
       e2(60,1)=-el
       e2(60,2)=em
       e2(60,3)=-el
c
       e2(61,1)=em
       e2(61,2)=el
       e2(61,3)=el
       e2(62,1)=-em
       e2(62,2)=el
       e2(62,3)=el
       e2(63,1)=-em
       e2(63,2)=-el
       e2(63,3)=el
       e2(64,1)=-em
       e2(64,2)=-el
       e2(64,3)=-el
       e2(65,1)=em
       e2(65,2)=-el
       e2(65,3)=-el
       e2(66,1)=em
       e2(66,2)=-el
       e2(66,3)=el
       e2(67,1)=em
       e2(67,2)=el
       e2(67,3)=-el
       e2(68,1)=-em
       e2(68,2)=el
       e2(68,3)=-el
c
       em=0.238807866929D0
       el=0.686647945709D0
c
       e2(69,1)=el
       e2(69,2)=el
       e2(69,3)=em
       e2(70,1)=-el
       e2(70,2)=el
       e2(70,3)=em
       e2(71,1)=-el
       e2(71,2)=-el
       e2(71,3)=em
       e2(72,1)=-el
       e2(72,2)=-el
       e2(72,3)=-em
       e2(73,1)=el
       e2(73,2)=-el
       e2(73,3)=-em
       e2(74,1)=el
       e2(74,2)=-el
       e2(74,3)=em
       e2(75,1)=el
       e2(75,2)=el
       e2(75,3)=-em
       e2(76,1)=-el
       e2(76,2)=el
       e2(76,3)=-em
c
       e2(77,1)=el
       e2(77,2)=em
       e2(77,3)=el
       e2(78,1)=-el
       e2(78,2)=em
       e2(78,3)=el
       e2(79,1)=-el
       e2(79,2)=-em
       e2(79,3)=el
       e2(80,1)=-el
       e2(80,2)=-em
       e2(80,3)=-el
       e2(81,1)=el
       e2(81,2)=-em
       e2(81,3)=-el
       e2(82,1)=el
       e2(82,2)=-em
       e2(82,3)=el
       e2(83,1)=el
       e2(83,2)=em
       e2(83,3)=-el
       e2(84,1)=-el
       e2(84,2)=em
       e2(84,3)=-el
c
       e2(85,1)=em
       e2(85,2)=el
       e2(85,3)=el
       e2(86,1)=-em
       e2(86,2)=el
       e2(86,3)=el
       e2(87,1)=-em
       e2(87,2)=-el
       e2(87,3)=el
       e2(88,1)=-em
       e2(88,2)=-el
       e2(88,3)=-el
       e2(89,1)=em
       e2(89,2)=-el
       e2(89,3)=-el
       e2(90,1)=em
       e2(90,2)=-el
       e2(90,3)=el
       e2(91,1)=em
       e2(91,2)=el
       e2(91,3)=-el
       e2(92,1)=-em
       e2(92,2)=el
       e2(92,3)=-el
c
       p1=0.878158910604D0
       q1=0.478369028812D0
c
       e2(93,1)=p1
       e2(93,2)=q1
       e2(94,1)=p1
       e2(94,2)=-q1
       e2(95,1)=-p1
       e2(95,2)=-q1
       e2(96,1)=-p1
       e2(96,2)=q1
c
       e2(97,1)=p1
       e2(97,3)=q1
       e2(98,1)=p1
       e2(98,3)=-q1
       e2(99,1)=-p1
       e2(99,3)=-q1
       e2(100,1)=-p1
       e2(100,3)=q1
c
       e2(101,2)=p1
       e2(101,3)=q1
       e2(102,2)=p1
       e2(102,3)=-q1
       e2(103,2)=-p1
       e2(103,3)=-q1
       e2(104,2)=-p1
       e2(104,3)=q1
c
       e2(105,1)=q1
       e2(105,2)=p1
       e2(106,1)=q1
       e2(106,2)=-p1
       e2(107,1)=-q1
       e2(107,2)=-p1
       e2(108,1)=-q1
       e2(108,2)=p1
c
       e2(109,1)=q1
       e2(109,3)=p1
       e2(110,1)=q1
       e2(110,3)=-p1
       e2(111,1)=-q1
       e2(111,3)=-p1
       e2(112,1)=-q1
       e2(112,3)=p1
c
       e2(113,2)=q1
       e2(113,3)=p1
       e2(114,2)=q1
       e2(114,3)=-p1
       e2(115,2)=-q1
       e2(115,3)=-p1
       e2(116,2)=-q1
       e2(116,3)=p1
c ------------------------------------------------
c
c ------------------------------------------------
c construction of angular grid #3 : 194 angular points per shell
c Lebedev , Zh.Mat. Mat. Fiz. 16,2,293 (1976)
c
c
      do 301 i=1,194
      do 301 k=1,3
 301   e3(i,k)=0.0D0
c
      do 302 i=1,6
 302    wang3(i)=0.00178234044724D0
c
      do 303 i=7,18
 303    wang3(i)=0.00571690594988D0
c
      do 304 i=19,26
 304    wang3(i)=0.00557338317884D0
c
      do 305 i=27,50
 305    wang3(i)=0.00551877146727D0
c
      do 306 i=51,74
 306    wang3(i)=0.00515823771181D0
c
      do 307 i=75,98
 307    wang3(i)=0.00560870408259D0
c
      do 308 i=99,122
 308    wang3(i)=0.00410677702817D0
c
      do 309 i=123,146 
 309    wang3(i)=0.00505184606462D0
c
      do 310 i=147,194
 310    wang3(i)=0.00553024891623D0
c
      do 311 i=1,194
 311    wang3(i)=wang3(i)*pi4
c
       e3(1,3)=1.D0
       e3(2,3)=-1.D0
       e3(3,2)=1.D0
       e3(4,2)=-1.D0
       e3(5,1)=1.D0
       e3(6,1)=-1.D0
c
      sq2=sqrt(0.5000000000000D0)
c
       e3(7,1)=sq2
       e3(7,2)=sq2
       e3(8,1)=sq2
       e3(8,2)=-sq2
       e3(9,1)=-sq2
       e3(9,2)=-sq2
       e3(10,1)=-sq2
       e3(10,2)=sq2
c
       e3(11,1)=sq2
       e3(11,3)=sq2
       e3(12,1)=sq2
       e3(12,3)=-sq2
       e3(13,1)=-sq2
       e3(13,3)=-sq2
       e3(14,1)=-sq2
       e3(14,3)=sq2
c
       e3(15,2)=sq2
       e3(15,3)=sq2
       e3(16,2)=sq2
       e3(16,3)=-sq2
       e3(17,2)=-sq2
       e3(17,3)=-sq2
       e3(18,2)=-sq2
       e3(18,3)=sq2
c
c
       ssq3=1.D0/sqrt(3.D0)
       e3(19,1)=ssq3
       e3(19,2)=ssq3
       e3(19,3)=ssq3
       e3(20,1)=-ssq3
       e3(20,2)=ssq3
       e3(20,3)=ssq3
       e3(21,1)=-ssq3
       e3(21,2)=-ssq3
       e3(21,3)=ssq3
       e3(22,1)=-ssq3
       e3(22,2)=-ssq3
       e3(22,3)=-ssq3
       e3(23,1)=ssq3
       e3(23,2)=-ssq3
       e3(23,3)=-ssq3
       e3(24,1)=ssq3
       e3(24,2)=-ssq3
       e3(24,3)=ssq3
       e3(25,1)=ssq3
       e3(25,2)=ssq3
       e3(25,3)=-ssq3
       e3(26,1)=-ssq3
       e3(26,2)=ssq3
       e3(26,3)=-ssq3
c
       em=0.777493219315D0
       el=0.444693317871D0
c
       e3(27,1)=el
       e3(27,2)=el
       e3(27,3)=em
       e3(28,1)=-el
       e3(28,2)=el
       e3(28,3)=em
       e3(29,1)=-el
       e3(29,2)=-el
       e3(29,3)=em
       e3(30,1)=-el
       e3(30,2)=-el
       e3(30,3)=-em
       e3(31,1)=el
       e3(31,2)=-el
       e3(31,3)=-em
       e3(32,1)=el
       e3(32,2)=-el
       e3(32,3)=em
       e3(33,1)=el
       e3(33,2)=el
       e3(33,3)=-em
       e3(34,1)=-el
       e3(34,2)=el
       e3(34,3)=-em
c
       e3(35,1)=el
       e3(35,2)=em
       e3(35,3)=el
       e3(36,1)=-el
       e3(36,2)=em
       e3(36,3)=el
       e3(37,1)=-el
       e3(37,2)=-em
       e3(37,3)=el
       e3(38,1)=-el
       e3(38,2)=-em
       e3(38,3)=-el
       e3(39,1)=el
       e3(39,2)=-em
       e3(39,3)=-el
       e3(40,1)=el
       e3(40,2)=-em
       e3(40,3)=el
       e3(41,1)=el
       e3(41,2)=em
       e3(41,3)=-el
       e3(42,1)=-el
       e3(42,2)=em
       e3(42,3)=-el
c
       e3(43,1)=em
       e3(43,2)=el
       e3(43,3)=el
       e3(44,1)=-em
       e3(44,2)=el
       e3(44,3)=el
       e3(45,1)=-em
       e3(45,2)=-el
       e3(45,3)=el
       e3(46,1)=-em
       e3(46,2)=-el
       e3(46,3)=-el
       e3(47,1)=em
       e3(47,2)=-el
       e3(47,3)=-el
       e3(48,1)=em
       e3(48,2)=-el
       e3(48,3)=el
       e3(49,1)=em
       e3(49,2)=el
       e3(49,3)=-el
       e3(50,1)=-em
       e3(50,2)=el
       e3(50,3)=-el
c
       em=0.912509096867D0
       el=0.289246562758D0
c
       e3(51,1)=el
       e3(51,2)=el
       e3(51,3)=em
       e3(52,1)=-el
       e3(52,2)=el
       e3(52,3)=em
       e3(53,1)=-el
       e3(53,2)=-el
       e3(53,3)=em
       e3(54,1)=-el
       e3(54,2)=-el
       e3(54,3)=-em
       e3(55,1)=el
       e3(55,2)=-el
       e3(55,3)=-em
       e3(56,1)=el
       e3(56,2)=-el
       e3(56,3)=em
       e3(57,1)=el
       e3(57,2)=el
       e3(57,3)=-em
       e3(58,1)=-el
       e3(58,2)=el
       e3(58,3)=-em
c
       e3(59,1)=el
       e3(59,2)=em
       e3(59,3)=el
       e3(60,1)=-el
       e3(60,2)=em
       e3(60,3)=el
       e3(61,1)=-el
       e3(61,2)=-em
       e3(61,3)=el
       e3(62,1)=-el
       e3(62,2)=-em
       e3(62,3)=-el
       e3(63,1)=el
       e3(63,2)=-em
       e3(63,3)=-el
       e3(64,1)=el
       e3(64,2)=-em
       e3(64,3)=el
       e3(65,1)=el
       e3(65,2)=em
       e3(65,3)=-el
       e3(66,1)=-el
       e3(66,2)=em
       e3(66,3)=-el
c
       e3(67,1)=em
       e3(67,2)=el
       e3(67,3)=el
       e3(68,1)=-em
       e3(68,2)=el
       e3(68,3)=el
       e3(69,1)=-em
       e3(69,2)=-el
       e3(69,3)=el
       e3(70,1)=-em
       e3(70,2)=-el
       e3(70,3)=-el
       e3(71,1)=em
       e3(71,2)=-el
       e3(71,3)=-el
       e3(72,1)=em
       e3(72,2)=-el
       e3(72,3)=el
       e3(73,1)=em
       e3(73,2)=el
       e3(73,3)=-el
       e3(74,1)=-em
       e3(74,2)=el
       e3(74,3)=-el
c
       em=0.314196994183D0
       el=0.671297344270D0
c
       e3(75,1)=el
       e3(75,2)=el
       e3(75,3)=em
       e3(76,1)=-el
       e3(76,2)=el
       e3(76,3)=em
       e3(77,1)=-el
       e3(77,2)=-el
       e3(77,3)=em
       e3(78,1)=-el
       e3(78,2)=-el
       e3(78,3)=-em
       e3(79,1)=el
       e3(79,2)=-el
       e3(79,3)=-em
       e3(80,1)=el
       e3(80,2)=-el
       e3(80,3)=em
       e3(81,1)=el
       e3(81,2)=el
       e3(81,3)=-em
       e3(82,1)=-el
       e3(82,2)=el
       e3(82,3)=-em
c
       e3(83,1)=el
       e3(83,2)=em
       e3(83,3)=el
       e3(84,1)=-el
       e3(84,2)=em
       e3(84,3)=el
       e3(85,1)=-el
       e3(85,2)=-em
       e3(85,3)=el
       e3(86,1)=-el
       e3(86,2)=-em
       e3(86,3)=-el
       e3(87,1)=el
       e3(87,2)=-em
       e3(87,3)=-el
       e3(88,1)=el
       e3(88,2)=-em
       e3(88,3)=el
       e3(89,1)=el
       e3(89,2)=em
       e3(89,3)=-el
       e3(90,1)=-el
       e3(90,2)=em
       e3(90,3)=-el
c
       e3(91,1)=em
       e3(91,2)=el
       e3(91,3)=el
       e3(92,1)=-em
       e3(92,2)=el
       e3(92,3)=el
       e3(93,1)=-em
       e3(93,2)=-el
       e3(93,3)=el
       e3(94,1)=-em
       e3(94,2)=-el
       e3(94,3)=-el
       e3(95,1)=em
       e3(95,2)=-el
       e3(95,3)=-el
       e3(96,1)=em
       e3(96,2)=-el
       e3(96,3)=el
       e3(97,1)=em
       e3(97,2)=el
       e3(97,3)=-el
       e3(98,1)=-em
       e3(98,2)=el
       e3(98,3)=-el
c
       em=0.982972302707D0
       el=0.129933544765D0
c
       e3(99,1)=el
       e3(99,2)=el
       e3(99,3)=em
       e3(100,1)=-el
       e3(100,2)=el
       e3(100,3)=em
       e3(101,1)=-el
       e3(101,2)=-el
       e3(101,3)=em
       e3(102,1)=-el
       e3(102,2)=-el
       e3(102,3)=-em
       e3(103,1)=el
       e3(103,2)=-el
       e3(103,3)=-em
       e3(104,1)=el
       e3(104,2)=-el
       e3(104,3)=em
       e3(105,1)=el
       e3(105,2)=el
       e3(105,3)=-em
       e3(106,1)=-el
       e3(106,2)=el
       e3(106,3)=-em
c
       e3(107,1)=el
       e3(107,2)=em
       e3(107,3)=el
       e3(108,1)=-el
       e3(108,2)=em
       e3(108,3)=el
       e3(109,1)=-el
       e3(109,2)=-em
       e3(109,3)=el
       e3(110,1)=-el
       e3(110,2)=-em
       e3(110,3)=-el
       e3(111,1)=el
       e3(111,2)=-em
       e3(111,3)=-el
       e3(112,1)=el
       e3(112,2)=-em
       e3(112,3)=el
       e3(113,1)=el
       e3(113,2)=em
       e3(113,3)=-el
       e3(114,1)=-el
       e3(114,2)=em
       e3(114,3)=-el
c
       e3(115,1)=em
       e3(115,2)=el
       e3(115,3)=el
       e3(116,1)=-em
       e3(116,2)=el
       e3(116,3)=el
       e3(117,1)=-em
       e3(117,2)=-el
       e3(117,3)=el
       e3(118,1)=-em
       e3(118,2)=-el
       e3(118,3)=-el
       e3(119,1)=em
       e3(119,2)=-el
       e3(119,3)=-el
       e3(120,1)=em
       e3(120,2)=-el
       e3(120,3)=el
       e3(121,1)=em
       e3(121,2)=el
       e3(121,3)=-el
       e3(122,1)=-em
       e3(122,2)=el
       e3(122,3)=-el
c
       p1=0.938319218138D0
       q1=0.345770219761D0
c
       e3(123,1)=p1
       e3(123,2)=q1
       e3(124,1)=p1
       e3(124,2)=-q1
       e3(125,1)=-p1
       e3(125,2)=-q1
       e3(126,1)=-p1
       e3(126,2)=q1
c
       e3(127,1)=p1
       e3(127,3)=q1
       e3(128,1)=p1
       e3(128,3)=-q1
       e3(129,1)=-p1
       e3(129,3)=-q1
       e3(130,1)=-p1
       e3(130,3)=q1
c
       e3(131,2)=p1
       e3(131,3)=q1
       e3(132,2)=p1
       e3(132,3)=-q1
       e3(133,2)=-p1
       e3(133,3)=-q1
       e3(134,2)=-p1
       e3(134,3)=q1
c
       e3(135,1)=q1
       e3(135,2)=p1
       e3(136,1)=q1
       e3(136,2)=-p1
       e3(137,1)=-q1
       e3(137,2)=-p1
       e3(138,1)=-q1
       e3(138,2)=p1
c
       e3(139,1)=q1
       e3(139,3)=p1
       e3(140,1)=q1
       e3(140,3)=-p1
       e3(141,1)=-q1
       e3(141,3)=-p1
       e3(142,1)=-q1
       e3(142,3)=p1
c
       e3(143,2)=q1
       e3(143,3)=p1
       e3(144,2)=q1
       e3(144,3)=-p1
       e3(145,2)=-q1
       e3(145,3)=-p1
       e3(146,2)=-q1
       e3(146,3)=p1
c
       r1=0.836036015482D0
       u1=0.159041710538D0
       w1=0.525118572443D0
c
       e3(147,1)=r1
       e3(147,2)=u1
       e3(147,3)=w1
       e3(148,1)=r1
       e3(148,2)=u1
       e3(148,3)=-w1
       e3(149,1)=r1
       e3(149,2)=-u1
       e3(149,3)=w1
       e3(150,1)=-r1
       e3(150,2)=u1
       e3(150,3)=w1
       e3(151,1)=r1
       e3(151,2)=-u1
       e3(151,3)=-w1
       e3(152,1)=-r1
       e3(152,2)=u1
       e3(152,3)=-w1
       e3(153,1)=-r1
       e3(153,2)=-u1
       e3(153,3)=w1
       e3(154,1)=-r1
       e3(154,2)=-u1
       e3(154,3)=-w1
c
       e3(155,1)=r1
       e3(155,2)=w1
       e3(155,3)=u1
       e3(156,1)=r1
       e3(156,2)=w1
       e3(156,3)=-u1
       e3(157,1)=r1
       e3(157,2)=-w1
       e3(157,3)=u1
       e3(158,1)=-r1
       e3(158,2)=w1
       e3(158,3)=u1
       e3(159,1)=r1
       e3(159,2)=-w1
       e3(159,3)=-u1
       e3(160,1)=-r1
       e3(160,2)=w1
       e3(160,3)=-u1
       e3(161,1)=-r1
       e3(161,2)=-w1
       e3(161,3)=u1
       e3(162,1)=-r1
       e3(162,2)=-w1
       e3(162,3)=-u1
c
       e3(163,1)=u1
       e3(163,2)=r1
       e3(163,3)=w1
       e3(164,1)=u1
       e3(164,2)=r1
       e3(164,3)=-w1
       e3(165,1)=u1
       e3(165,2)=-r1
       e3(165,3)=w1
       e3(166,1)=-u1
       e3(166,2)=r1
       e3(166,3)=w1
       e3(167,1)=u1
       e3(167,2)=-r1
       e3(167,3)=-w1
       e3(168,1)=-u1
       e3(168,2)=r1
       e3(168,3)=-w1
       e3(169,1)=-u1
       e3(169,2)=-r1
       e3(169,3)=w1
       e3(170,1)=-u1
       e3(170,2)=-r1
       e3(170,3)=-w1
c
       e3(171,1)=u1
       e3(171,2)=w1
       e3(171,3)=r1
       e3(172,1)=u1
       e3(172,2)=w1
       e3(172,3)=-r1
       e3(173,1)=u1
       e3(173,2)=-w1
       e3(173,3)=r1
       e3(174,1)=-u1
       e3(174,2)=w1
       e3(174,3)=r1
       e3(175,1)=u1
       e3(175,2)=-w1
       e3(175,3)=-r1
       e3(176,1)=-u1
       e3(176,2)=w1
       e3(176,3)=-r1
       e3(177,1)=-u1
       e3(177,2)=-w1
       e3(177,3)=r1
       e3(178,1)=-u1
       e3(178,2)=-w1
       e3(178,3)=-r1
c
       e3(179,1)=w1
       e3(179,2)=u1
       e3(179,3)=r1
       e3(180,1)=w1
       e3(180,2)=u1
       e3(180,3)=-r1
       e3(181,1)=w1
       e3(181,2)=-u1
       e3(181,3)=r1
       e3(182,1)=-w1
       e3(182,2)=u1
       e3(182,3)=r1
       e3(183,1)=w1
       e3(183,2)=-u1
       e3(183,3)=-r1
       e3(184,1)=-w1
       e3(184,2)=u1
       e3(184,3)=-r1
       e3(185,1)=-w1
       e3(185,2)=-u1
       e3(185,3)=r1
       e3(186,1)=-w1
       e3(186,2)=-u1
       e3(186,3)=-r1
c
       e3(187,1)=w1
       e3(187,2)=r1
       e3(187,3)=u1
       e3(188,1)=w1
       e3(188,2)=r1
       e3(188,3)=-u1
       e3(189,1)=w1
       e3(189,2)=-r1
       e3(189,3)=u1
       e3(190,1)=-w1
       e3(190,2)=r1
       e3(190,3)=u1
       e3(191,1)=w1
       e3(191,2)=-r1
       e3(191,3)=-u1
       e3(192,1)=-w1
       e3(192,2)=r1
       e3(192,3)=-u1
       e3(193,1)=-w1
       e3(193,2)=-r1
       e3(193,3)=u1
       e3(194,1)=-w1
       e3(194,2)=-r1
       e3(194,3)=-u1
c
         end
