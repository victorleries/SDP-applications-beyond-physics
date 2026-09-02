function [A] = P(X,om,n)
    B=zeros(n);
    for i=1:n
        for j=1:n
            for k=om.'
                if([i,j]==k.')
                    B(i,j)=X(i,j);
                end
            end
        end
    end
    A= B;
end