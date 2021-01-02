function model =ReadModel()
DM = xlsread('SupplierInfo.xlsx','SupplierData','B2:H11');

J = -1 * ones(1,size(DM,2));
J(end)=1;

m = size(DM,1); % Number of Alternatives 
n = size(DM,2); % Number of Criteria  

    model.m = m;
    model.n = n;
    model.DM = DM;
    model.J = J;   
end