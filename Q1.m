clc;clear all;
A=[0 0 1 0;0 0 0 1;0 -9.8 0 0;0 19.6 0 0];
B=[0 ;0 ;1 ;-1];
contrlb_mat_rank=rank(ctrb(A,B))
C=[1 0 0 0]; %output is cart position
observ_mat_case1_rank=rank(obsv(A,C))
C=[0 1 0 0]; % output is angle, theta
observ_mat_case2_rank=rank(obsv(A,C))