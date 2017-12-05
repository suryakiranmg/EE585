clc; clear all;
A=[0 0 1 0;0 0 0 1;0 -9.8 0 0;0 19.6 0 0];
B=[0 ;0 ;1 ;-1];
C1=[1 0 0 0];
C2=[1 0 0 0;0 1 0 0];
Q=eye(4);
R1=eye(1);
R2=eye(2);
% K, gain of state feedback
K = lqr(A,B,Q,R1) 
% L for the 1st case
K1 = lqr(A',C1',Q,R1); L1 = K1'
% L for the 2nd case
K2 = lqr(A',C2',Q,R2); L2 = K2'  
% Eigen values
Eig_Ab = eig([(A-B*K)])
Eig_Ac1 = eig([(A-L1*C1)])
Eig_Ac2 = eig([(A-L2*C2)])