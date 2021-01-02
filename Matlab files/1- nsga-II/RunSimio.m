
function F=RunSimio()
%% Part 1- Simio File Directory Information
    %1-1: The Directory that SIMIO file is located
        filePath='C:\Users\m.dehghani\Dropbox (NU College of Eng''g)\1- Research\25- Nihan-Mohammad papers\1- Multi-Objective Suplier Selection\2- Models\3- Integrated SO Model';   
    %1-2: The name of SIMIO file (*.spfx) 
        fileName='SCMmodel.spfx';
%% Part 2- Scenarios
        Scenarios=strcat('001;MD;1');
%% Part 3- Run Simio Experiment
      %Results='001;AvgInventory;333.233079370758;ServiceLevel;0.797444744180479;Inv_SL;418.196287098054;TotalCost;158731.386392568;JustANumbe;100|'
      Results = RunExperiment(filePath, fileName,Scenarios); 
      Results_string=strsplit(Results{1},';');
      
      f.label='';
      f.z=0;
      F=repmat(f,1,4); 
      for i=1:4
          j=2*i;
          F(i).label=Results_string{1,j};
          F(i).z=round(str2num(Results_string{1,j+1}),4);
      end
      
     
%% Part 4- Please do not change this part
    function Results=RunExperiment(filePath, fileName,Scenarios)
    % ? Please do not change or modify this section ?
    
    % 4-1: Add path
        addpath(filePath)
    % 4-1 Clear the txt file content
        TXTfilePathName=strcat(filePath ,'\SimioLink.txt');
        fid=fopen(TXTfilePathName,'wt');
    % 4-2: Store required info in txt file
        %info=[filePath;fileName;Scenarions];
        fprintf(fid, '%s\r\n', filePath,fileName, Scenarios);
        fclose(fid);
        
    % 4-3: Run EXE File to run Experiment
        EXEfilePathName=strcat(filePath ,'\RunExperimentDLLMD.exe');
        system(EXEfilePathName);                
        Results=textread(TXTfilePathName,'%s');        
    end
end