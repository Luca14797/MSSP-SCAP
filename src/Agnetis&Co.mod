/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Luca
 * Creation Date: 22 nov 2021 at 16:38:14
 *********************************************/

 {string} S = ...;
 {string} J = ...;
 {int} DAYS = ...;
 
 {float} I_GYN = ...;
 {float} I_GS = ...;
 {float} I_ENT = ...;
 {float} I_URO = ...;
 {float} I_DS = ...;
 {float} I_ORTH = ...;
 
 {string} I[S] = ...;
 
 {int} P[S] = ...;
 
 {int} R[S] = ...;
 
 {int} K[S] = ...;
 
 int NOT = ...;
 int O_max = ...;
 int S_min[S] = ...;
 int S_max[S] = ...;
 int PS[S] = ...;
 {string} NA[S] = ...;
 int W = ...;
 
 dvar int+ x[I][S][J][DAYS];
 dvar int+ y[S][J][DAYS];
 
 maximize sum(s in S, i in I[s], r in J, w in DAYS) (K[s][i] * x[i][s][r][w]);
 
 subject to
 {
   forall(s in S, i in I[s])
     sum(r in J, w in DAYS)
       x[i][s][r][w] <= 1;
     
   forall(s in S, r in J, w in DAYS)
     sum(i in I[s])
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
       
   forall(s in S, i in I[s], r in J, w in DAYS)
     x[i][s][r][w] == 1 || x[i][s][r][w] == 0;
     
   forall(s in S, r in J, w in DAYS)
     y[s][r][w] == 1 || y[s][r][w] == 0;
 }
 