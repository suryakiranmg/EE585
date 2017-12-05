clc; clear all;
%TF of plant
A=[0 0 1 0;0 0 0 1;0 -9.8 0 0;0 19.6 0 0];B=[0 ;0 ;1 ;-1];D=[0];
C=eye(4); % feeding back all states
Q=eye(4);R=eye(1);
K = lqr(A,B,Q,R) ; % K, gain of state feedback
%initial condition
IC = [0 (10*pi/180) 0 0];
%CASE 1--------------
plant1 = ss(A, B, C,0);
sys1 = feedback(plant1,K);
[y_sys1,t_sys1,x_sys1] = initial(sys1, IC);
%CASE 2--------------------
C=[1 0 0 0;0 1 0 0];% feeding back 1 and 2 states
R=eye(2);
plant2 = ss(A, B, C,0); 
K1 = lqr(A',C',Q,R); L = K1';
A_ob = (A-B*K-L*C);B_ob = L;C_ob = -K;D_ob = [0];
observer = ss(A_ob, B_ob, C_ob,0);
sys2 = feedback(plant2,-1*observer);
IC = [0 (10*pi/180) 0 0 0 0 0 0];
[y_sys2,t_sys2,x_sys2] = initial(sys2, IC);
%CASE3 3------------
C=[1 0 0 0];% feeding back 1 and 2 states
R=eye(1);
plant3 = ss(A, B, C,0); 
K1 = lqr(A',C',Q,R); L = K1';
A_ob = (A-B*K-L*C);B_ob = L;C_ob = -K;D_ob = [0];
observer = ss(A_ob, B_ob, C_ob,0);
sys3 = feedback(plant3,-1*observer);
IC = [0 (10*pi/180) 0 0 0 0 0 0];
[y_sys3,t_sys3,x_sys3] = initial(sys3, IC);

figure(1);hold on; grid on;xlabel('time');ylabel('position');
plot(t_sys1,x_sys1(:,1));plot(t_sys2,x_sys2(:,1));plot(t_sys3,x_sys3(:,1))
legend('state fdbk cont with K using LQR','Observer based cont with pos & angle','observer based cont with pos');

figure(2);hold on; grid on;xlabel('time');ylabel('angle');
plot(t_sys1,x_sys1(:,2));plot(t_sys2,x_sys2(:,2));plot(t_sys3,x_sys3(:,2));
legend('state fdbk cont with K using LQR','Observer based cont with pos & angle','observer based cont with pos');
