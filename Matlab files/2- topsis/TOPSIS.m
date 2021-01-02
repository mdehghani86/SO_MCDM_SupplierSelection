function sol=TOPSIS(model, q)
%% Problem definiton   
    DM = model.DM;      % Decision Matrix  
    J = model.J;        % J is the beneficial maxtrix to show the criteria property
    m = model.m;        % Number of Alternetives
    n = model.n;        % Number of Criteria
    %w = model.w;       % Weight of each criteria
    numCriteria=3;
    numSupplier=2;
 
%% TOPSIS initialization    
    
    %Step1: Select Criteria
    a=zeros(1,n);
    [Sa, So]=sort(q(1:end/2),'descend');
    
    a(So<=numCriteria)=1;

    Selection = find(a == 1);

    DM = DM(:,Selection);
    w=q(end/2+1:end);
    w=w(:,Selection);
    J = J(:,Selection);

    % Step2: Calculate a normalised decision matrix
    NDM = normc(DM);

    %Step3: Determine the weighted decision matrix

    V = repmat(w,m,1) .* NDM;
    V_Beneficial = repmat(J,m,1).* V;

    %Step4: Identify the Positive and Negatove and Negative Ideal Solution

    PIS = abs(max(V_Beneficial,[],1));
    NIS = abs(min(V_Beneficial,[],1));

    %Step5: Calculate the seperation distance of each competitive alternative
    %from the ideal and non-idealsolutiopn

    PIS_distance = repmat(PIS,m,1) - V;
    NIS_distance = V - repmat(NIS,m,1);

    for i = 1:m

    S_Plus(i) = rssq(PIS_distance(i,:));

    S_Minus(i) = rssq(NIS_distance(i,:));
    end

    %Step6: Measure the relative closeness of each supplier to the ideal
    %solution

    C = S_Minus./(S_Plus+S_Minus);

% Get the best 3 supllier and their value
       [Csorted, CsortedPosition] = sort(C,'descend');
       Suppliers = CsortedPosition(1:numSupplier);
       Value = Csorted(1:numSupplier);
       
       % define the propotion of suplliers
       portion =Value/sum(Value);
       
       % Make sure the portion of alternatives are round up to .xx
       portion(1,1:numSupplier) = roundn(portion(1,1:numSupplier),-2);
       portion(1,numSupplier) = 1 - sum(portion(1,1:numSupplier-1));

       % Store the Best Solution with selected best 3 alternetives with
       % portin and which criteria selected in this solution
       sol.Alternatives = Suppliers; 
       sol.Portion = portion; 
       sol.Criteria = find(a == 1);              
       %% Update Excel file as Simio Input
        Alternatives = sol.Alternatives'; 
        Portion =  sol.Portion';  
        d = [Alternatives, Portion];
        xlswrite('SupplierInfo.xlsx',d,'Simio','A2');
end