clc;
clear;
close all;

%% Problem Definition

global NFE;
NFE=0;

model = ReadModel();          %Read Model from the excel
n=model.n;                      %Number of Criteria
m=model.m;                      %Number of Suppliers
CostFunction=@(x) MyCost(model, x);    % Cost Function

nVar=2*n;                       % Number of Decision Variables
VarSize=[1 nVar];               % Decision Variables Matrix Size
%% GA Parameters
MaxIt=5;                      % Maximum Number of Iterations
nPop=10;                        % Population Size
pc=0.8;                         % Crossover Percentage
nc=2*round(pc*nPop/2);          % Number of Offsprings (Parnets)
pm=0.3;                         % Mutation Percentage
nm=round(pm*nPop);              % Number of Mutants
mu=0.02;                        % Mutation Rate
gamma=0.1;                       %Crossover Gamma factor

ANSWER='Tournament';

UseRouletteWheelSelection=strcmp(ANSWER,'Roulette Wheel');
UseTournamentSelection=strcmp(ANSWER,'Tournament');
UseRandomSelection=strcmp(ANSWER,'Random');

if UseRouletteWheelSelection
    beta=8;                     % Selection Pressure
end

if UseTournamentSelection
    TournamentSize=3;           % Tournamnet Size
end

pause(0.1);

%% Initialization

empty_individual.Position=[];
empty_individual.Sol=[];
empty_individual.Cost=[];

pop=repmat(empty_individual,nPop,1);

for i=1:nPop 
    % Initialize Position
    pop(i).Position=rand(VarSize);
    
    % Evaluation based on Topsis
    [pop(i).Sol,pop(i).Cost]=CostFunction(pop(i).Position);
end

% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);

% Store Best Solution
BestSol=pop(1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Store Cost
WorstCost=pop(end).Cost;

% Array to Hold Number of Function Evaluations
nfe=zeros(MaxIt,1);
%% Main Loop

for it=1:MaxIt
    
%     % Calculate Selection Probabilities
%     P=exp(-beta*Costs/WorstCost);
%     P=P/sum(P);
%     
    % Crossover
    popc=repmat(empty_individual,nc/2,2);
    for k=1:nc/2
        
        % Select Parents Indices
%         if UseRouletteWheelSelection
%             i1=RouletteWheelSelection(P);
%             i2=RouletteWheelSelection(P);
%         end
        if UseTournamentSelection
            i1=TournamentSelection(pop,TournamentSize);
            i2=TournamentSelection(pop,TournamentSize);
        end
%         if UseRandomSelection
%             i1=randi([1 nPop]);
%             i2=randi([1 nPop]);
%         end

        % Select Parents
        p1=pop(i1);
        p2=pop(i2);
        
        % Apply Crossover
        [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position,p2.Position,gamma,0,1);
        
        % Evaluate Offsprings
           [popc(k,1).Sol, popc(k,1).Cost]=CostFunction(popc(k,1).Position);
           [popc(k,2).Sol, popc(k,2).Cost]=CostFunction(popc(k,2).Position);
    end
    popc=popc(:);
    
    
    % Mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        
        % Select Parent
        i=randi([1 nPop]);
        p=pop(i);
        
        % Apply Mutation
        popm(k).Position=Mutate(p.Position,mu,0,1);  
                
        % Evaluate Mutant
        [popm(k).Sol, popm(k).Cost]=CostFunction(popm(k).Position);

end
    
    % Create Merged Population
    pop=[pop
         popc
         popm];
     
    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    
    % Update Worst Cost
    WorstCost=max(WorstCost,pop(end).Cost);
    
    % Truncation
    pop=pop(1:nPop);
    Costs=Costs(1:nPop);
    
    % Store Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Store NFE
    nfe(it)=NFE;
end

%% Results

% figure;
% plot(nfe,BestCost,'LineWidth',2);
% xlabel('NFE');
% ylabel('Cost');
% [ BestSol.TOPSIS.Alternatives
%   BestSol.TOPSIS.Portion
%   BestSol.TOPSIS.Criteria]

