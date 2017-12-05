clc; clear all;
%TF of plant
A=[0 0 1 0;0 0 0 1;0 -9.8 0 0;0 19.6 0 0];
B=[0 ;0 ;1 ;-1];
C=[1 0 0 0];
D=[0];
[num,den]=ss2tf(A,B,C,D);
sys_tf_plant = tf(num,den)

% TF of observer
Q=eye(4);
R=eye(1);
% K, gain of state feedback
K = lqr(A,B,Q,R) ;
% L for the 1st case
K1 = lqr(A',C',Q,R); L = K1';
A_ob = (A-B*K-L*C);
B_ob = L;
C_ob = -K;
D_ob = [0];
[num,den]=ss2tf(A_ob,B_ob,C_ob,D_ob);
sys_tf_observer = tf(num,den)

%CL Transfer function
sys_CL = feedback(sys_tf_plant,-1*sys_tf_observer) 
%poles of CL TF
pole(sys_CL)
%Eigen values
Eig_Ab = eig([(A-B*K)])
Eig_Ac = eig([(A-L*C)])
