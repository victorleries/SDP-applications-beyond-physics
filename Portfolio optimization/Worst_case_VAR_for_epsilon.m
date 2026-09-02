%define the parameters of the problem
n=5;
x_mean=[3.5712,84.9129,93.3993,67.8735];
x_mean=x_mean.';
var=[2.8559,3.5302,1.1592,1.3846];
var=diag(var);
c=0.5;
R=[1,c,c^2,c;c,1,c,c^2;c^2,c,1,c;c,c^2,c,1];
sig=var*R*var;
XOM=[];
E=[];
normOM=[];
for j=1:100 %run from epsilon 0.01 to 1 doing 99 steps
    e=0.01*j;
    E=[E,e];
    om=ones(1,4);
    om=om.';
    for i=1:n
        cvx_begin sdp %solve SDP with the algotirhm explained in section 3.3.1
            variable x(4)
            maximize(-om.'*x)
            subject to
                [sig,x-x_mean;(x-x_mean).',(1-e)/e]>=0
        cvx_end
        cvx_begin
            variable om(4)
            minimize(-om.'*x)
            subject to
                norm(om,1)<=1
                om>=0
        cvx_end
    end
    normOM=[normOM,norm(om,1)];
    XOM=[XOM,-x.'*om];%save data to plot
end
disp(XOM);
disp(normOM);
%plot calculated data
f=plot(E,XOM);
xlabel("ε");
ylabel("Worst-case VaR")
saveas(f,"Worst-case VaR en funció de epsilon","png")