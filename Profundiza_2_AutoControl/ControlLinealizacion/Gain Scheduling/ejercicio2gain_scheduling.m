clear
clc
%% Funciones, variables y parámetros
% Parámetros:
m=0.1; k=0.001; g=9.81; a=0.05; L0=0.01; 
L1=0.02; r=1;
% Estados y entrada simbólicos
syms x1 x2 x3 u s k1s k2s k3s k4s
L=L1+L0/(1+x1/a);
f1=x2;
f2=g-k/m*x2-L0*a*x3^2/(2*m*(a+x1)^2);
f3=1/L*(u-r*x3+(L0*a*x2*x3)/((a+x1)^2));
f=[f1;f2;f3];   % Campo vectorial
x=[x1;x2;x3];   % Vector de estados
h=x1;           % Salida 
%% Linealización y Aumento de sistema
% Linealización
As=jacobian(f,x);
Bs=jacobian(f,u);
Cs=jacobian(h,x);
% Matrices aumentadas
Aa=[As zeros(3,1);...
    -Cs zeros(1,1)];
Ba=[Bs;zeros(1,1)];
ks=[k1s k2s k3s k4s]
Deter=det(s*eye(4)-(Aa-Ba*ks))
%% Ciclo para Gain Scheduling variando alfa
alfa=0:0.01:0.5;    % Rango de variable de Scheduling
for i=1:length(alfa)
    %Punto de equilibrio forzado por referencia;
    x1ss=alfa(i);
    x2ss=0;
    x3ss=sqrt(2*g*m/(L0*a))*(a+x1ss);
    uss=r*x3ss;
    %Evaluación de las matrices aumentadas en el equilibrio
    A=double(subs(Aa,{x1,x2,x3,u},{x1ss,x2ss,x3ss,uss}));
    B=double(subs(Ba,{x1,x2,x3,u},{x1ss,x2ss,x3ss,uss}));
    polos=[-5 -6 -10 -50];  % Polos deseados
    % Se calcula y almacena Ka para cada paso de alfa
    Ka(i,:)=place(A,B,polos);   
end
k1=Ka(:,1); k2=Ka(:,2); k3=Ka(:,3); k4=Ka(:,4);
%% Condiciones iniciales para modelo simulink
Kej2=[k1(10) k2(10) k3(10) k4(10)];
ref1=0.05;
x1ss=ref1;
x2ss=0;
x3ss=sqrt(2*g*m/(L0*a))*(a+x1ss);
% cix1=x1ss;
% cix2=x2ss;
% cix3=x3ss;
% ciint=(uss+(Kej2(1:3)*[cix1; cix2; cix3]))*1/Kej2(4);
cix1=0;
cix2=0;
cix3=0;
ciint=0;
%x3ss=vpa(x3ss,5);
uss=r*x3ss;
pert=0.04;
%pert=0.00;