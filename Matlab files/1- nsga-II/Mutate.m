function y=Mutate(x,mu,sigma,VarMin,VarMax)

    nVar=numel(x);
    
    nMu=ceil(mu*nVar);

    j=randsample(nVar,nMu);
    
    xnew=x+sigma.*randn(size(x));
    
    y=x;
    y(j)=xnew(j);
    
    y=max(y,VarMin);
    y=min(y,VarMax);

end