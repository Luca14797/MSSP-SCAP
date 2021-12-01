/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Luca
 * Creation Date: 22 nov 2021 at 16:38:14
 *********************************************/

 {string} S = ...;
 {string} J = ...;
 {int} DAYS = ...;
 int N = ...;
 
 range surgery = 1..N;
 
 string I[S][surgery] = ...;
 
 int P[S][surgery] = ...;
 
 int R[S][surgery] = ...;
 
 int NOT = ...;
 int O_max = ...;
 int S_min[S] = ...;
 int S_max[S] = ...;
 int PS[S] = ...;
 {string} NA[S] = ...;
 int W = ...;
 
 int K[S][surgery];
 execute {
   for(var s in S) {
     for(var i in surgery) {
       if(I[s][i] != 0) {
         K[s][i] = P[s][i] * (W - R[s][i]);
       }       	
     }     
   }
 }
 
 dvar int+ x[surgery][S][J][DAYS];
 dvar int+ y[S][J][DAYS];
 
 maximize sum(s in S, i in surgery, r in J, w in DAYS) (K[s][i] * x[i][s][r][w]);
 
 subject to
 {
   forall(s in S, i in surgery)
     if(I[s][i] != "0")
       sum(r in J, w in DAYS)
         x[i][s][r][w] <= 1;
     
   forall(s in S, r in J, w in DAYS)
     sum(i in surgery : I[s][i] != "0")
       P[s][i] * x[i][s][r][w] <= O_max * y[s][r][w];
   
   forall(r in J, w in DAYS)
     sum(s in S)
       y[s][r][w] <= 1;
       
   forall(s in S)
     sum(w in DAYS, r in J)
       y[s][r][w] >= S_min[s];
       
   forall(s in S)
     sum(w in DAYS, r in J)
       y[s][r][w] <= S_max[s];
       
   forall(w in DAYS, s in S)
     sum(r in J)
       y[s][r][w] <= PS[s];
       
   forall(s in S)
     sum(w in DAYS, r in NA[s])
       y[s][r][w] == 0;
       
   forall(s in S, i in surgery, r in J, w in DAYS)
     if(I[s][i] != "0")
       x[i][s][r][w] == 1 || x[i][s][r][w] == 0;
     
   forall(s in S, r in J, w in DAYS)
     y[s][r][w] == 1 || y[s][r][w] == 0;
 }
 