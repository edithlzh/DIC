.TITLE bulk_chain
.lib "./LAB1_LIB/BULK/models" ptm16hp_bulk

.option post
.global vdd gnd
.temp 25

.param supply = 0.7V
.param length = 16nm
.param n_width = 24nm
.param p_width = 36nm



.subckt inv in out l=16nm w1=24nm w2=36nm
xnmos out in gnd gnd nfet l=length w=w1
xpmos out in vdd vdd pfet l=length w=w2
.ends

x1 vin1 vout1 inv 
x2 vout1 vout2 inv w1='5*24n' w2='5*36n'
x3 vout2 vout3 inv w1='25*24n' w2='25*36n'
x4 vout3 vout4 inv w1='125*24n' w2='125*36n'
xload vout4 gnd inv w1='256*24n' w2='256*36n'

vs vin1 gnd pulse(0,0.7,1ns,50ps,50ps,1ns,2ns)
vdd vdd gnd supply



.TRAN 1ns 9ns 

.measure tran tpLH1
+trig V(vin1)='0.5*supply' fall=2
+targ V(vout1)='0.5*supply' rise=2
.measure tran tpHL1
+trig V(vin1)='0.5*supply' rise=2
+targ V(vout1)='0.5*supply' fall=2
.measure tp1 param='(tpLH1+tpHL2)/2'

.measure tran tpLH2
+trig V(vout1)='0.5*supply' fall=2
+targ V(vout2)='0.5*supply' rise=2
.measure tran tpHL2
+trig V(vout1)='0.5*supply' rise=2
+targ V(vout2)='0.5*supply' fall=2
.measure tp2 param='(tpLH2+tpHL2)/2'

.measure tran tpLH3
+trig V(vout2)='0.5*supply' fall=2
+targ V(vout3)='0.5*supply' rise=2
.measure tran tpHL3
+trig V(vout2)='0.5*supply' rise=2
+targ V(vout3)='0.5*supply' fall=2
.measure tp3 param='(tpLH3+tpHL3)/2'

.measure tran tpLH4
+trig V(vout3)='0.5*supply' fall=2
+targ V(vout4)='0.5*supply' rise=2
.measure tran tpHL4
+trig V(vout3)='0.5*supply' rise=2
+targ V(vout4)='0.5*supply' fall=2
.measure tp4 param='(tpLH4+tpHL4)/2'

.measure tp param = 'tp1+tp2+tp3+tp4'



.end