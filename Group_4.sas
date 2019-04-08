/* Group -4
Home work - 5 */

/* Reading Data*/
proc import datafile='E:\Users\dvi170030\Downloads\HW-5\Churn_telecom.csv' out = data dbms=csv replace;
run;
proc print data=data(obs=10);run;
proc means data=data;class churn;run;
proc means data=data NMISS N mean median;class asl_flag; run;

/*Feature Selection */
data dd;
set data(keep = avg3qty avgqty hnd_price mou_opkv_Mean months eqpdays change_mou change_rev blck_dat_Mean roam_Mean drop_dat_Mean mou_opkd_Mean threeway_Mean custcare_Mean callfwdv_Mean opk_dat_Mean asl_flag churn);
run;

proc means data=dd NMISS N mean median;class asl_flag; run;

/* Data Imputation */
data dd1;
set dd;
if asl_flag ='N' then asl_flag_N = 0;
if asl_flag ='Y' then asl_flag_N = 1;
if change_mou = . and asl_flag ='N' then change_mou = -5.75 ;
if change_mou = . and asl_flag = 'Y' then change_mou = -15.5;
if change_rev = . and asl_flag ='N' then change_rev = -0.27 ;
if change_rev = . and asl_flag = 'Y' then change_rev = -0.9037;
if hnd_price = . and asl_flag ='N' then hnd_price = 99.989 ;
if hnd_price = . and asl_flag = 'Y' then hnd_price = 129.989;
if roam_Mean = . then roam_Mean = 0;
if eqpdays = . then eqpdays = 415.1739;
run;

/* Correlation */

PROC corr data=dd1; var avg3qty avgqty hnd_price mou_opkv_Mean months eqpdays change_mou change_rev blck_dat_Mean roam_Mean drop_dat_Mean mou_opkd_Mean threeway_Mean custcare_Mean callfwdv_Mean opk_dat_Mean asl_flag churn;run;

/* Dropping Irrelavant Variables */

data dd2;
set dd1 (drop = asl_flag avg3qty);
run;

proc means data=dd2 NMISS N;run;

/*Logistic Model */
proc logistic data=dd2 OUTEST=betas COVOUT;
   model churn(event='1') =  avgqty hnd_price mou_opkv_Mean months eqpdays change_mou change_rev roam_Mean threeway_Mean asl_flag_N/ctable pprob=0.5 ;
OUTPUT OUT=pred p=phat lower=lcl upper=ucl
predprob=individual;
ODS OUTPUT Association=Association;
run;

PROC PRINT DATA = pred (OBS=10);RUN;
DATA pred;SET pred;
pred_dis=0;
IF phat>0.5 THEN pred_dis=1;
RUN;
PROC FREQ DATA=pred;
TABLES churn*pred_dis /
norow nocol nopercent;
RUN;
