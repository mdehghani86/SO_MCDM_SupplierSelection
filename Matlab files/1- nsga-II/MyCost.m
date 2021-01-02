function [sol, z]=MyCost(model,q)

%% NFE
    global NFE;
    if isempty(NFE)
        NFE=0;
    end
    
    NFE=NFE+1;
%% Run Topsis
    sol=TOPSIS(model, q);
    pause(0.05);
%% Run Simio and get the results
    %z=[rand*1000 rand*20 rand]';
    F=RunSimio();
    z=[F(1).z ,F(2).z, F(4).z]';
end