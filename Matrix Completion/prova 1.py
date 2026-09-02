import numpy as np
import scipy as sp
#import matplotlib.pyplot as plt
import cvxpy as cp

A=[[-2,-1,3],[-1,-0.5,1.5],[-3,-1.5,4.5]]
m=4

#generem el conjunt omicron d'entrades que coneixem de la matriu A
om=[]
om.append(np.random.randint(0,3,2))
print(om)
while (len(om)!=m):
    a=[]
    l=np.random.randint(0,3,2)
    for j in range(len(om)):
        if(l!=om[j]).any():
            a.append(True)
        elif(l==om[j]).all():
            a.append(False)
    a=np.array(a)
    if a.all():
        om.append(l)
print(om)
#definim la funció P
def P(X):
    A=[[0,0,0],[0,0,0],[0,0,0]]
    for i in range(3):
        for j in range(3):
            for k in om:
                if(np.array([i,j])==k).all():
                    A[i][j]=X[i][j]
    return A
B=P(A)
print(B)
#expresem el problema SDP
X=cp.Variable((3,3))
print(P(X))
obj=cp.norm(X,"nuc")
st=[P(X)==B]+[X>>0]
prob=cp.Problem(cp.Minimize(obj),st)
prob.solve()
print(X.value)
