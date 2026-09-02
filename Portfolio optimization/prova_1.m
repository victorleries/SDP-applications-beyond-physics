%define the parameters of the problem
n=5;
x_mean=[3.5712,84.9129,93.3993,67.8735];
x_mean=x_mean.';
var=[2.8559,3.5302,1.1592,1.3846];
var=diag(var);
e=0.05;
OM=[];
X=[];
XOM=[];
C=[];
normOM=[];
for j=0:20 %take 20 steps from c=0 to c=1
    c=0.05*j;
    C=[C,c];
    R=[1,c,c^2,c;c,1,c,c^2;c^2,c,1,c;c,c^2,c,1];
    sig=var*R*var;
    om=ones(1,4);
    om=om.';
    for i=1:n %solve SDP with the algotirhm explained in section 3.3.1
        cvx_begin sdp
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
    X=[X,x];
    OM=[OM,om];
    XOM=[XOM,-x.'*om];%save data to plot
end
disp(OM);
disp(X);
disp(XOM);
disp(normOM);
%plot calculated data
f=plot(C,XOM);
xlabel("c");
ylabel("Worst-case VaR")
saveas(f,"Matrius cicliques","png")