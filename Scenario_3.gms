* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*
* DOWNLOADED FROM MINLP CYBER-INFRASTRUCTURE
* www.minlp.org
*
* PROBLEM : Production Planning with Contract Selection and Price Optimization: Constant-Elasticity and Logit DRMs
*
* EXAMPLE : Motivating
*
* AUTHOR(S) : Bruno Calfa, Ignacio Grossmann
*
* SUBMITTED BY : Bruno Calfa
*
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


$onecho > alphaecp.opt
MIPloglevel	1
$offecho

$onecho > dicopt.opt
stop	1
maxcycles	1000
$offecho

$onecho > sbb.opt
nodlim 100000
memnodes	100000
$offecho


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* 											Model v.1: Constant-Elasticity 												  *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

* * * * * * * * * * * * * * * * *  *
* Production Planning Declarations *
* * * * * * * * * * * * * * * * *  *
SETS
	I		Processes	/P1,P2,P3/
	J		Chemicals	/A,B,C,D/
	S		Sites	/S1/
	Ij(i,j)	Processes that consume chemical j
	Oj(i,j)	Processes that produce chemical j
	Ji(j,i)	Chemicals involved in process i
	JM(i,j)	Main products of process i
	IS(i,s)	Mapping of processes to sites
	JP(j)	Products
	JR(j)	Raw materials
	T		Time periods	/1*6/
	K		Scenarios	/1*10/
;
alias(j,jj);
alias(s,ss);
alias(t,tt);
alias(k,kk);
alias(t,tt);

Ij(i,j) = no;
Ij('P1','A') = yes;
Ij('P2','B') = yes;
Ij('P3','B') = yes;
Oj(i,j) = no;
Oj('P1','B') = yes;
Oj('P2','C') = yes;
Oj('P3','D') = yes;
Ji(j,i) = no;
Ji('A','P1') = yes;
Ji('B','P1') = yes;
Ji('B','P2') = yes;
Ji('C','P2') = yes;
Ji('B','P3') = yes;
Ji('D','P3') = yes;
JM(i,j) = no;
JM('P1','B') = yes;
JM('P2','C') = yes;
JM('P3','D') = yes;
IS(i,s) = yes;
JP(j) = no;
JP('C') = yes;
JP('D') = yes;
JR(j) = no;
JR('A') = yes;

TABLE	delta(i,s,t)	Operating cost
	1	2	3	4	5	6
P1.S1	0.26	0.26	0.26	0.14	0.14	0.14
P2.S1	0.16	0.16	0.16	0.13	0.13	0.13
P3.S1	0.32	0.32	0.32	0.32	0.32	0.32
;

PARAMETER	xi(j,s,t)	Inventory cost;
xi('D','S1',t) = 0.03;

PARAMETER	eta(j,s,ss,t)	Intersite transfer cost;
eta(j,s,ss,t) = 0;

TABLE	mu(i,j,s)	Mass factor
	S1
P1.A	0.83
P1.B	-1
P2.B	0.95
P2.C	-1
P3.B	1.11
P3.D	-1
;

PARAMETER	Q(i,s,t)	Process capacity;
Q('P1','S1',t) = 85;
Q('P2','S1',t) = 35;
Q('P3','S1',t) = 65;

PARAMETER	aL(j,s,t)	Raw material availability lower;
aL('A','S1',t) = 0;

PARAMETER	aU(j,s,t)	Raw material availability upper;
aU('A','S1',t) = 60;

PARAMETER	VU(j,s,t)	Inventory capacity;
VU('D','S1',t) = 6;

PARAMETER	FU(j,s,ss,t)	Intersite transfer limit;
FU(j,s,ss,t) = 0;

PARAMETER	HasDemand(j,t)	Flag to denote if material j has demand;
HasDemand('C',t) = 1;
HasDemand('D',t) = 1;

PARAMETER 	alphaspot(j,s,t,k)	Purchase spot price;
alphaspot('A','S1','1','1') = 1.37455;	alphaspot('A','S1','1','2') = 2.472633;	alphaspot('A','S1','1','3') = 4.976822;	alphaspot('A','S1','1','4') = 2.565652;	alphaspot('A','S1','1','5') = 3.356331;	alphaspot('A','S1','1','6') = 1.44013616;	alphaspot('A','S1','1','7') = 1.959312;	alphaspot('A','S1','1','8') = 2.5554035;	alphaspot('A','S1','1','9') = 6.121276;	alphaspot('A','S1','1','10') = 2.268122;	
alphaspot('A','S1','2','1') = 4.020626;	alphaspot('A','S1','2','2') = 2.964906;	alphaspot('A','S1','2','3') = 4.504642;	alphaspot('A','S1','2','4') = 3.200062;	alphaspot('A','S1','2','5') = 2.624108;	alphaspot('A','S1','2','6') = 0.04478201;	alphaspot('A','S1','2','7') = 3.275987;	alphaspot('A','S1','2','8') = 0.9265037;	alphaspot('A','S1','2','9') = 3.760758;	alphaspot('A','S1','2','10') = 3.826681;	
alphaspot('A','S1','3','1') = 5.974445;	alphaspot('A','S1','3','2') = 2.597016;	alphaspot('A','S1','3','3') = 4.248418;	alphaspot('A','S1','3','4') = 4.934691;	alphaspot('A','S1','3','5') = 5.99296;	alphaspot('A','S1','3','6') = 0.68209498;	alphaspot('A','S1','3','7') = 2.410622;	alphaspot('A','S1','3','8') = 2.4881944;	alphaspot('A','S1','3','9') = 7.781311;	alphaspot('A','S1','3','10') = 7.257567;	
alphaspot('A','S1','4','1') = 1.012926;	alphaspot('A','S1','4','2') = 2.996514;	alphaspot('A','S1','4','3') = 3.493567;	alphaspot('A','S1','4','4') = 3.433273;	alphaspot('A','S1','4','5') = 4.120419;	alphaspot('A','S1','4','6') = 1.90055992;	alphaspot('A','S1','4','7') = 2.112299;	alphaspot('A','S1','4','8') = 1.4857817;	alphaspot('A','S1','4','9') = 4.199485;	alphaspot('A','S1','4','10') = 3.512231;	
alphaspot('A','S1','5','1') = 5.547826;	alphaspot('A','S1','5','2') = 3.024617;	alphaspot('A','S1','5','3') = 4.285229;	alphaspot('A','S1','5','4') = 2.960692;	alphaspot('A','S1','5','5') = 4.627118;	alphaspot('A','S1','5','6') = 2.6051957;	alphaspot('A','S1','5','7') = 2.520239;	alphaspot('A','S1','5','8') = 2.207549;	alphaspot('A','S1','5','9') = 7.75634;	alphaspot('A','S1','5','10') = 8.229719;	
alphaspot('A','S1','6','1') = 5.486787;	alphaspot('A','S1','6','2') = 2.461346;	alphaspot('A','S1','6','3') = 8.845282;	alphaspot('A','S1','6','4') = 5.157271;	alphaspot('A','S1','6','5') = 4.191177;	alphaspot('A','S1','6','6') = 5.13465497;	alphaspot('A','S1','6','7') = 1.290353;	alphaspot('A','S1','6','8') = 2.683989;	alphaspot('A','S1','6','9') = 10.832325;	alphaspot('A','S1','6','10') = 8.466163;	

PARAMETER	prob(k)	Scenario probability;
prob('1') = 0.005;
prob('2') = 0.005;
prob('3') = 0.955;
prob('4') = 0.005;
prob('5') = 0.005;
prob('6') = 0.005;
prob('7') = 0.005;
prob('8') = 0.005;
prob('9') = 0.005;
prob('10') = 0.005;

PARAMETER	epsilon(j,k)	Regression residual;
epsilon('C','1') = -0.17779;	epsilon('C','2') = -0.1699941;	epsilon('C','3') = -1.3723019;	epsilon('C','4') = -0.1737872;	epsilon('C','5') = 0.8502323;	epsilon('C','6') = 0.6976087;	epsilon('C','7') = 0.5499974;	epsilon('C','8') = -0.402732;	epsilon('C','9') = -0.1915938;	epsilon('C','10') = -1.1945279;
epsilon('D','1') = -0.1063176;	epsilon('D','2') = 0.510392;	epsilon('D','3') = 3.411928;	epsilon('D','4') = 2.0030265;	epsilon('D','5') = -0.9911669;	epsilon('D','6') = 0.7111006;	epsilon('D','7') = -2.2692161;	epsilon('D','8') = 1.7564073;	epsilon('D','9') = 1.9458335;	epsilon('D','10') = 4.2422342;


* * * * * * * *  *
* Contracts Data *
* * * * * * * *  *
SETS
	C	Contract types	/d,b,l/
	CS	Contract scheme	/1*2/
	CL	Contract length	/1*3/
;
alias(cl,cll);

PARAMETER	phid(j,s,t,cs)	Purchase price for discount contract;
phid(j,'S1',t,'1') $ JR(j) = 1.85;
phid(j,'S1',t,'2') $ JR(j) = 1.45;
phid(j,s,t,cs) = 1.7*phid(j,s,t,cs);

PARAMETER	phib(j,s,t,cs)	Purchase price for bulk discount contract;
phib(j,'S1',t,'1') $ JR(j) = 1.8;
phib(j,'S1',t,'2') $ JR(j) = 1.4;
phib(j,s,t,cs) = 1.7*phib(j,s,t,cs);

PARAMETER	phil(j,s,t,cl)	Purchase price for fixed duration contract;
phil(j,'S1',t,'1') $ JR(j) = 2;
phil(j,'S1',t,'2') $ JR(j) = 1.2;
phil(j,'S1',t,'3') $ JR(j) = 1;
phil(j,s,t,cl) = 1.7*phil(j,s,t,cl);

PARAMETER	sigmad(j,s,t)	Purchase amount threshold for discount contract;
sigmad(j,'S1',t) $ JR(j) = 20;

PARAMETER	sigmab(j,s,t)	Purchase amount threshold for bulk discount contract;
sigmab('A','S1',t) = 40;

PARAMETER	sigmal(j,s,t,cl)	Purchase amount threshold for fixed duration contract;
sigmal(j,'S1',t,'1') $ JR(j) = 5;
sigmal(j,'S1',t,'2') $ JR(j) = 25;
sigmal(j,'S1',t,'3') $ JR(j) = 30;


* * * * * * * * * * * * * * * * *  * 
* Pricing Constant-Elasticity Data *
* * * * * * * * * * * * * * * * *  *

PARAMETER	beta2p(j)	Coefficient of constant-elasticity DRM;
beta2p('C') = 10;
beta2p('D') = 21;

PARAMETER	Ed(j)	Price elasticity in constant-elasticity DRM;
Ed('C') = 2;
Ed('D') = 1.5;


POSITIVE VARIABLES
	SF(j,s,t)		Sales from site s
    ST(j,t)			Total sales
	W(i,j,s,t,k)	Production rate
	P(j,s,t,k)		Total purchase amounts
    Pspot(j,s,t,k)	Purchase amounts from spot market
	COST(j,s,t,k)	Total purchase cost
    V(j,s,t,k)		Inventory level
    F(j,s,ss,t,k)	Intersite transfer flows
;

VARIABLES
	PROFIT
;

EQUATIONS
	SPProcessInputOutput(s,i,j,jj,t,k)	Process input and output relationships
	SPMaterialBalance(s,j,t,k)			Material and inventory balance
    TotalSales(j,t)						Aggregate sales from sites
;

SPProcessInputOutput(s,i,j,jj,t,k) $ [IS(i,s) and Ji(j,i) and JM(i,jj)]..
W(i,j,s,t,k) =E= abs(mu(i,j,s))*W(i,jj,s,t,k);

SPMaterialBalance(s,j,t,k)..
(V(j,s,t - 1,k) $ VU(j,s,t - 1)) + sum(i $ Oj(i,j), W(i,j,s,t,k)) + (P(j,s,t,k) $ alphaspot(j,s,t,k)) =E=
(V(j,s,t,k) $ VU(j,s,t)) + sum(i $ Ij(i,j), W(i,j,s,t,k)) + sum((ss) $ (ord(ss) <> ord(s)), F(j,s,ss,t,k)) + (SF(j,s,t) $ HasDemand(j,t));

TotalSales(j,t) $ HasDemand(j,t)..
ST(j,t) =E= sum(s, SF(j,s,t));


* * * * * * * * * *
* Contracts Model *
* * * * * * * * * *
POSITIVE VARIABLES
		COSTc(j,s,t,c)		Purchase cost for contracts
        Pd(j,s,t)			Purchase amount for discount contract
        Pddis1(j,s,t,cs)	Purchase amount for discount contract disjunction 1
        Pddis2(j,s,t,cs)	Purchase amount for discount contract disjunction 2
		Pb(j,s,t)			Purchase amount for bulk discount contract
        Pbdis(j,s,t,cs)		Purchase amount for bulk discount contract disjunction
        Pl(j,s,t)			Purchase amount for fixed duration contract
        Pldis(j,s,t,tt,cl)	Purchase amount for fixed duration contract disjunction
;

BINARY VARIABLES
	yd(j,s,t)		Binary variable for discount contract
	yddis(j,s,t,cs)	Binary variable for discount contract disjunction
    yb(j,s,t)		Binary variable for bulk discount contract
	ybdis(j,s,t,cs)	Binary variable for bulk discount contract disjunction
	yl(j,s,t)		Binary variable for fixed duration contract
	yldis(j,s,t,cl)	Binary variable for fixed duration contract disjunction
;

EQUATIONS
	SPTotalPurchaseCost(s,j,t,k)						Total purchase cost spot market and contracts
	SPTotalPurchaseAmount(s,j,t,k)						Total purchase amount spot market and contracts
	PurchaseCostBinLogical(s,j,t)						Logical constraint for purchase amount from contracts
	PurchaseCostDiscountContract(s,j,t)					Purchase cost from discount contract
	PurchaseAmountDis1DiscountContract(s,j,t)			Disaggregation of disjunction variables 1 for discount contract
	PurchaseAmountDis2DiscountContract(s,j,t)			Disaggregation of disjunction variables 2 for discount contract
	PurchaseAmountDiscountDis2UpperBound(s,j,t)			Upper bound in disjunction 2 for discount contract
	PurchaseAmountDiscountDis2Equality(s,j,t)			Equality constraint in disjunction 2 for discount contract
	PurchaseAmountDiscountDis1UpperBound(s,i,j,t)		Upper bound in disjunction 1 for discount contract
	PurchaseAmountDiscountBinLogical(s,j,t)				Logical constraint for discount contract
	PurchaseCostBulkContract(s,j,t)						Purchase cost from bulk discount contract
	PurchaseAmountDisBulkContract(s,j,t)				Disaggregation of disjunction variables for bulk discount contract
	PurchaseAmountBulkDis1UpperBound(s,j,t)				Upper bound in disjunction for bulk discount contract
	PurchaseAmountBulkDis2UpperBound(s,i,j,t)			Upper bound in disjunction for bulk discount contract
	PurchaseAmountBulkDis2LowerBound(s,j,t)				Lower bound in disjunction for bulk discount contract
	PurchaseAmountBulkBinLogical(s,j,t)					Logical constraint for bulk discount contract
	PurchaseCostLengthContract(s,j,t)					Purchase cost from fixed duration contract
	PurchaseAmountDisLengthContract(s,j,t)				Disaggregation of disjunction variables for fixed duration contract
	PurchaseAmountLengthDisUpperBound(s,i,j,t,tt,cl)	Upper bound in disjunction for fixed duration contract
	PurchaseAmountLengthDisLowerBound(s,j,t,tt,cl)		Lower bound in disjunction for fixed duration contract
	PurchaseAmountLengthBinLogical(s,j,t)				Logical constraint 1 for fixed duration contract
	PurchaseAmountLengthBinLogical2(s,j,t,tt,cl,cll)	Logical constraint 2 for fixed duration contract
;

SPTotalPurchaseCost(s,j,t,k) $ JR(j)..
COST(j,s,t,k) =E= alphaspot(j,s,t,k)*Pspot(j,s,t,k) + sum(c, COSTc(j,s,t,c));

SPTotalPurchaseAmount(s,j,t,k) $ JR(j)..
P(j,s,t,k) =E= Pspot(j,s,t,k) + Pd(j,s,t) + Pb(j,s,t) + Pl(j,s,t);

PurchaseCostBinLogical(s,j,t) $ JR(j)..
yd(j,s,t) + yb(j,s,t) + yl(j,s,t) =L= 1;

PurchaseCostDiscountContract(s,j,t) $ JR(j)..
COSTc(j,s,t,'d') =E= sum(cs, phid(j,s,t,cs)*Pddis1(j,s,t,cs));

PurchaseAmountDis1DiscountContract(s,j,t) $ JR(j)..
Pd(j,s,t) =E= sum(cs, Pddis1(j,s,t,cs));

PurchaseAmountDis2DiscountContract(s,j,t) $ JR(j)..
Pddis1(j,s,t,'1') =E= sum(cs, Pddis2(j,s,t,cs));

PurchaseAmountDiscountDis2UpperBound(s,j,t) $ JR(j)..
Pddis2(j,s,t,'1') =L= sigmad(j,s,t)*yddis(j,s,t,'1');

PurchaseAmountDiscountDis2Equality(s,j,t) $ JR(j)..
Pddis2(j,s,t,'2') =E= sigmad(j,s,t)*yddis(j,s,t,'2');

PurchaseAmountDiscountDis1UpperBound(s,i,j,t) $ [JR(j) and IS(i,s) and Ji(j,i)]..
Pddis1(j,s,t,'2') =L= Q(i,s,t)*yddis(j,s,t,'2');

PurchaseAmountDiscountBinLogical(s,j,t) $ JR(j)..
sum(cs, yddis(j,s,t,cs)) =E= yd(j,s,t);

PurchaseCostBulkContract(s,j,t) $ JR(j)..
COSTc(j,s,t,'b') =E= sum(cs, phib(j,s,t,cs)*Pbdis(j,s,t,cs));

PurchaseAmountDisBulkContract(s,j,t) $ JR(j)..
Pb(j,s,t) =E= sum(cs, Pbdis(j,s,t,cs));

PurchaseAmountBulkDis1UpperBound(s,j,t) $ JR(j)..
Pbdis(j,s,t,'1') =L= sigmab(j,s,t)*ybdis(j,s,t,'1');

PurchaseAmountBulkDis2UpperBound(s,i,j,t) $ [JR(j) and IS(i,s) and Ji(j,i)]..
Pbdis(j,s,t,'2') =L= Q(i,s,t)*ybdis(j,s,t,'2');

PurchaseAmountBulkDis2LowerBound(s,j,t) $ JR(j)..
Pbdis(j,s,t,'2') =G= sigmab(j,s,t)*ybdis(j,s,t,'2');

PurchaseAmountBulkBinLogical(s,j,t) $ JR(j)..
sum(cs, ybdis(j,s,t,cs)) =E= yb(j,s,t);

PurchaseCostLengthContract(s,j,t) $ JR(j)..
COSTc(j,s,t,'l') =E= phil(j,s,t,'1')*Pldis(j,s,t,t,'1') + sum((cl,tt) $ ((ord(cl) > 1) and (ord(tt) <= ord(t)) and ((ord(t) - ord(cl) + 1) > 0) and (ord(tt) >= (ord(t) - ord(cl) + 1))), phil(j,s,tt,cl)*Pldis(j,s,t,tt,cl));

PurchaseAmountDisLengthContract(s,j,t) $ JR(j)..
Pl(j,s,t) =E= Pldis(j,s,t,t,'1') + sum((cl,tt) $ ((ord(cl) > 1) and (ord(tt) <= ord(t)) and ((ord(t) - ord(cl) + 1) > 0) and (ord(tt) >= (ord(t) - ord(cl) + 1))), Pldis(j,s,t,tt,cl));

PurchaseAmountLengthDisUpperBound(s,i,j,t,tt,cl) $ [JR(j) and (ord(tt) <= ord(t)) and ((ord(t) - ord(cl) + 1) > 0) and (ord(tt) >= (ord(t) - ord(cl) + 1)) and IS(i,s) and Ji(j,i)]..
Pldis(j,s,t,tt,cl) =L= Q(i,s,t)*yldis(j,s,t,cl);

PurchaseAmountLengthDisLowerBound(s,j,t,tt,cl) $ [JR(j) and (ord(tt) <= ord(t)) and ((ord(t) - ord(cl) + 1) > 0) and (ord(tt) >= (ord(t) - ord(cl) + 1))]..
Pldis(j,s,t,tt,cl) =G= sigmal(j,s,tt,cl)*yldis(j,s,t,cl);

PurchaseAmountLengthBinLogical(s,j,t) $ JR(j)..
sum(cl, yldis(j,s,t,cl)) =E= yl(j,s,t);

PurchaseAmountLengthBinLogical2(s,j,t,tt,cl,cll) $ [JR(j) and (ord(tt) < ord(t)) and ((ord(t) - ord(cl) + 1) > 0) and (ord(tt) >= (ord(t) - ord(cl) + 1))]..
yldis(j,s,t,cl) =L= 1 - yldis(j,s,tt,cll);


* * * * * * * * * * * * * * * * * * *
* Pricing Constant-Elasticity Model *
* * * * * * * * * * * * * * * * * * *

POSITIVE VARIABLE
	STaux(j,t)	Auxiliary variable for total sales
;

EQUATION
	STauxcon(j,t)	Constraint to define auxiliary total sales variable
;

STauxcon(j,t) $ HasDemand(j,t)..
STaux(j,t)**(1/(1 - 1/Ed(j))) =L= ST(j,t);

EQUATIONS
	SPProfit_Purchase_Contracts_Pricing_ConstantElasticity	Objective function for stochastic contracts pricing constant-elasticity DRM
;

SPProfit_Purchase_Contracts_Pricing_ConstantElasticity..
PROFIT =E= 
sum(k, prob(k)*
	(
		sum((j,t) $ HasDemand(j,t), beta2p(j)*STaux(j,t) + epsilon(j,k)*ST(j,t)) -
		sum((s,j,t) $ alphaspot(j,s,t,k), COST(j,s,t,k)) -
		sum((s,i,j,t) $ (IS(i,s) and JM(i,j)), delta(i,s,t)*W(i,j,s,t,k)) -
		sum((s,j,t) $ xi(j,s,t), xi(j,s,t)*V(j,s,t,k)) -
		sum((s,ss,j,t) $ (eta(j,s,ss,t) and (ord(s) <> ord(ss))), eta(j,s,ss,t)*F(j,s,ss,t,k))
	)
);

model	SPConstEla	
/
	STauxcon,
	SPProcessInputOutput,
	SPMaterialBalance,
	TotalSales,
	SPTotalPurchaseCost,
	SPTotalPurchaseAmount,
	PurchaseCostBinLogical,
	PurchaseCostDiscountContract,
	PurchaseAmountDis1DiscountContract,
	PurchaseAmountDis2DiscountContract,
	PurchaseAmountDiscountDis2UpperBound,
	PurchaseAmountDiscountDis2Equality,
	PurchaseAmountDiscountDis1UpperBound,
	PurchaseAmountDiscountBinLogical,
	PurchaseCostBulkContract,
	PurchaseAmountDisBulkContract,
	PurchaseAmountBulkDis1UpperBound,
	PurchaseAmountBulkDis2UpperBound,
	PurchaseAmountBulkDis2LowerBound,
	PurchaseAmountBulkBinLogical,
	PurchaseCostLengthContract,
	PurchaseAmountDisLengthContract,
	PurchaseAmountLengthDisUpperBound,
	PurchaseAmountLengthDisLowerBound,
	PurchaseAmountLengthBinLogical,
	PurchaseAmountLengthBinLogical2,
	SPProfit_Purchase_Contracts_Pricing_ConstantElasticity
/;

SPConstEla.optFile = 1;

* Bounds and initializations
W.up(i,j,s,t,k) $ JM(i,j) = Q(i,s,t);
P.lo(j,s,t,k) $ JR(j) = aL(j,s,t);
P.up(j,s,t,k) $ JR(j) = aU(j,s,t);
V.up(j,s,t,k) = VU(j,s,t);
V.fx(j,s,t,k) $ (ord(t) = 1) = 0;
F.up(j,s,ss,t,k) $ [(not JR(j)) and (ord(s) <> ord(ss))] = FU(j,s,ss,t);
ST.l(j,t) $ HasDemand(j,t) = 1;
ST.lo(j,t) $ HasDemand(j,t) = 0.1;
STaux.l(j,t) $ HasDemand(j,t) = ST.l(j,t)**(1 - 1/Ed(j));
STaux.lo(j,t) $ HasDemand(j,t) = ST.lo(j,t)**(1/(1 - 1/Ed(j)));


OPTION MIP = GUROBI;
OPTION NLP = CONOPT;
OPTION MINLP = DICOPT;
*OPTION MINLP = SBB;
*OPTION MINLP = ALPHAECP;
*OPTION MINLP = BARON;
*OPTION MINLP = SCIP;

OPTION optcr = 0.001;
OPTION reslim = 21600;

OPTION solprint = off;
OPTION limrow = 0;
OPTION limcol = 0;
*OPTION sysout = on;
$OFFLISTING
$OFFSYMXREF

SOLVE SPConstEla MAXIMIZING PROFIT USING MINLP;



* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* 											 			Model v.1: Logit 												  *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

* * * * * * * * * *  *
* Pricing Logit Data *
* * * * * * * * * *  *

PARAMETER	beta3(j)	Coefficient of logit DRM;
beta3('C') = 40;
beta3('D') = 50;

PARAMETER	beta4(j)	Coefficient of logit DRM;
beta4('C') = -2;
beta4('D') = -3;

PARAMETER	beta5(j)	Coefficient of logit DRM;
beta5('C') = 0.7;
beta5('D') = 1;


* * * * * * * * * * * *
* Pricing Logit Model *
* * * * * * * * * * * *

EQUATIONS
	SPProfit_Purchase_Contracts_Pricing_Logit	Objective function for stochastic contracts pricing logit DRM
;

SPProfit_Purchase_Contracts_Pricing_Logit..
PROFIT =E= 
sum(k, prob(k)*
	(
		sum((j,t) $ HasDemand(j,t), ((log((beta3(j) - ST(j,t))/ST(j,t)) - beta4(j))/beta5(j))*ST(j,t) + epsilon(j,k)*ST(j,t)) -
		sum((s,j,t) $ alphaspot(j,s,t,k), COST(j,s,t,k)) -
		sum((s,i,j,t) $ (IS(i,s) and JM(i,j)), delta(i,s,t)*W(i,j,s,t,k)) -
		sum((s,j,t) $ xi(j,s,t), xi(j,s,t)*V(j,s,t,k)) -
		sum((s,ss,j,t) $ (eta(j,s,ss,t) and (ord(s) <> ord(ss))), eta(j,s,ss,t)*F(j,s,ss,t,k))
	)
);

model	SPLogit	
/
	SPProcessInputOutput,
	SPMaterialBalance,
	TotalSales,
	SPTotalPurchaseCost,
	SPTotalPurchaseAmount,
	PurchaseCostBinLogical,
	PurchaseCostDiscountContract,
	PurchaseAmountDis1DiscountContract,
	PurchaseAmountDis2DiscountContract,
	PurchaseAmountDiscountDis2UpperBound,
	PurchaseAmountDiscountDis2Equality,
	PurchaseAmountDiscountDis1UpperBound,
	PurchaseAmountDiscountBinLogical,
	PurchaseCostBulkContract,
	PurchaseAmountDisBulkContract,
	PurchaseAmountBulkDis1UpperBound,
	PurchaseAmountBulkDis2UpperBound,
	PurchaseAmountBulkDis2LowerBound,
	PurchaseAmountBulkBinLogical,
	PurchaseCostLengthContract,
	PurchaseAmountDisLengthContract,
	PurchaseAmountLengthDisUpperBound,
	PurchaseAmountLengthDisLowerBound,
	PurchaseAmountLengthBinLogical,
	PurchaseAmountLengthBinLogical2,
	SPProfit_Purchase_Contracts_Pricing_Logit
/;

SPLogit.optFile = 1;

* Bounds and initializations
W.up(i,j,s,t,k) $ JM(i,j) = Q(i,s,t);
P.lo(j,s,t,k) $ JR(j) = aL(j,s,t);
P.up(j,s,t,k) $ JR(j) = aU(j,s,t);
V.up(j,s,t,k) = VU(j,s,t);
V.fx(j,s,t,k) $ (ord(t) = 1) = 0;
F.up(j,s,ss,t,k) $ [(not JR(j)) and (ord(s) <> ord(ss))] = FU(j,s,ss,t);
ST.l(j,t) = 1;
ST.lo(j,t) = 0.1;
ST.up(j,t) = 0.99*beta3(j);


OPTION MIP = GUROBI;
OPTION NLP = CONOPT;
OPTION MINLP = DICOPT;
*OPTION MINLP = SBB;
*OPTION MINLP = ALPHAECP;
*OPTION MINLP = BARON;
*OPTION MINLP = SCIP;

OPTION optcr = 0.001;
OPTION reslim = 21600;

OPTION solprint = off;
OPTION limrow = 0;
OPTION limcol = 0;
*OPTION sysout = on;
$OFFLISTING
$OFFSYMXREF

SOLVE SPLogit MAXIMIZING PROFIT USING MINLP;