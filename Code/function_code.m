function [u, v] = function_code(xi,m,k,E,dt,wn)
wd=wn*sqrt(1-xi^2);

ep=exp(-xi*wn*dt);
sq=sqrt(1-xi^2);
si=sin(wd*dt);
co=cos(wd*dt);

A=ep*(xi/sq*si+co);
B=ep*(1/wd*si);
C=1/k*(2*xi/(wn*dt)+ep*(((1-2*xi^2)/(wd*dt)-xi/sq)*si-(1+2*xi/(wn*dt))*co));
D=1/k*(1-2*xi/(wn*dt)+ep*((2*xi^2-1)/(wd*dt)*si+2*xi/(wn*dt)*co));
Ap=-ep*(wn/sq*si);
Bp=ep*(co-xi/sq*si);
Cp=1/k*(-1/dt+ep*((wn/sq+xi/(dt*sq))*si+1/dt*co));
Dp=1/(k*dt)*(1-ep*(xi/sq*si+co));

u=zeros(length(E),1);
v=zeros(length(E),1);
u(1)=0;
v(1)=0;
for i=1:length(E)-1
    u(i+1)=A*u(i)+B*v(i)+C*(-m*E(i)*386.09)+D*(-m*E(i+1)*386.09);
    v(i+1)=Ap*u(i)+Bp*v(i)+Cp*(-m*E(i)*386.09)+Dp*(-m*E(i+1)*386.09);
end
end

    
