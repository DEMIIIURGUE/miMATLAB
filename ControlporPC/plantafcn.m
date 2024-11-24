function dxdt = plantafcn(t,x_sim,flag,u)
%Parámetros: era "kbb,u"
Ra=10;
Ki=10;
Kb=0.0706;
Jl=10;
Jm=0.005;
Ka=5;
n=1/100;
a=4.52;
Ks=5;
Kv=10;
Ko=50;
N=1;

dxdt(1,1) = x_sim(2,1); %Ecuaciones X punto en forma matricial.
dxdt(2,1) = (Ki*(-Kb*x_sim(2,1)+Ka*u))/(Ra*(Jm+(n^2*Jl)));
dxdt(3,1) = (N*Kv*n*x_sim(1,1)-(Ko*sqrt(x_sim(3,1))))/a;
end

