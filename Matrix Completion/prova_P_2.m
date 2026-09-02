n=3;
x=[0.6324,0.0975,0.2785];
Om=[1,2;3,2;2,3;3,1;3,3;1,3;2,2;1,1];
A=[0.3999,0.0617,0.1761;0.0617,0.0095,0.0272;0.1761,0.0272,0.0776];
B=P(A,Om,n);
cvx_begin sdp
    variable X(n,n)
    expression C(n,n)
    C=zeros(n);
    for i=1:n
        for j=1:n
            for k=Om.'
                if([i,j]==k.')
                    C(i,j)=X(i,j);
                end
            end
        end
    end
    minimize norm_nuc(X)
    subject to
            C==B
            X>=0
cvx_end