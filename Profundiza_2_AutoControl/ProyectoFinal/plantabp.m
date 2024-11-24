function dxdt = plantabp(t,x,flag,u1,du1,u2,du2) 
a=5/7; g=9.8;
dxdt(1,1) = x(2);
dxdt(2,1) = a*(x(1)*du1^2+x(3)*du1*du2-g*sin(u1));
dxdt(3,1) = x(4);
dxdt(4,1) = a*(x(3)*du2^2+x(1)*du2*du1-g*sin(u2));
end