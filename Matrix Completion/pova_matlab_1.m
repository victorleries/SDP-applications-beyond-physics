A=[-2,-1,3;-1,-0.5,1.5;-3,-1.5,4.5];
m=4;
om=randi([1,3],1,2);
while length(om)~=m
    b=randi([1,3],1,2);
    l=length(om);
    t=[];
    for k=om.'
        k=k.';
        disp(k);
        if b~=k
            t=[t,1];
        elseif b==k
            t=[t,0];
        end
        disp(t);
    end
    if t==ones(1,l)
        om=[om;b];
    end
    disp(length(om));
end
disp(om);