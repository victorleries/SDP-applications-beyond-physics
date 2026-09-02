n=3;
x=[0.6324,0.0975,0.2785];
Om=[1,2;3,2;2,3;3,1;3,3;1,3;2,2;1,1];
A=[0.3999,0.0617,0.1761;0.0617,0.0095,0.0272;0.1761,0.0272,0.0776];
norm=trace(sqrtm(A.'*A));
disp(norm);
cvx_begin sdp
    variable X(n,n)
    expression P(n,n)
    minimize norm_nuc(X)
    subject to
            P(X,Om,n)==A
            X>=0
cvx_end