function dxdt = plantafcn(t,x,flag,kbb,u)
dxdt(1,1) = x(2,1);
dxdt(2,1) = kbb*sin(u);
end

