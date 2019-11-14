%CBL_Main_RunCOBE_MaximiseDissimilarity
%
%   Purpose: (1)The code will allo you to input your multi-session fMRI
%               data [No.of spatial areas X Time series ] and run COBE to obtain the COBE common Component per subject
%            (2) Common COBE component is the  component that is present in
%                all the session or in short it is shared by all the rs-fMRI sessions
%            (3) The common COBE component of each subject is correlated
%                with the common COBE component of all other subjects to obtain the "COBE Correlation matrix"
%            (4) The subjects that have maximally dissimilar pattern  are obtained from the COBE correlation matrix
%
%   Input:
%       (1) Preprocessed and Brain atlas-parcellated data (You can use any pipeline and parcellation scheme).
%            (Optional Suggestion- We used Thomas yeo's CBIG preprocessing
%             pipeline and Schaefer's atlas parcellation - please refer https://github.com/ThomasYeoLab/CBIG)
%       (2) Download Common and orthogonal Basis Extraction and add to matlab path- Please refer to paper (and cite as well)
%             Zhou, G., Cichocki, A., Zhang, Y., & Mandic, D. P. (2016a). Group Component Analysis for Multiblock Data: Common and Individual Feature 
%             Extraction. IEEE Transactions on Neural Networks and Learning Systems, 27(11), 2426–2439. https://doi.org/10.1109/TNNLS.2015.2487364 
%
%   Ouputs:
%       MCD and CS group - "Maximally dissimilar groups" and "COBE similar" groups 
%
%% Please refer to our paper for details (please cite it if you are using the code)  
%     Kashyap, R., Bhattacharjee, S., Yeo, B.T. and Chen, S.A., (2019). Maximizing Dissimilarity in Resting State detects Heterogeneous Subtypes in Healthy 
%     population associated with High Substance-Use and Problems in Antisocial Personality.Human Brain Mapping
%
%   For any queries please contact clinicalbrainlab@gmail.com

clear all;
% Import preprocessed and parcellated data
% Please specify the path of the folder- for example  /X/XX/XXk/YY/YYYY/ZZZZZ
files_loc1= dir('PLEASE_SPECIFY_THE_PATH'); % Run 1 or session 1
files_loc2= dir('PLEASE_SPECIFY_THE_PATH'); % Run 2 or session 2 and so on
path_location1 ='PLEASE_SPECIFY_THE_PATH';
path_location2 ='PLEASE_SPECIFY_THE_PATH';

All_Run_Locations=cell(1,1);

for i=3: length(files_loc1)
    
    U1.TC=[];
    U2.TC = [];
    j=i-2;
    U1 = load([path_location1 '/' files_loc1(i).name]);
    All_Run_Locations{1,j}= U1.TC;
    U2 = load([path_location2 '/' files_loc2(i).name]);
   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Run COBE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% WHen u want to have COBE Correlation matrices as well
Component_remv= 1;% You can specify the number of common components you want to extract
Number_of_Subjects = 788; % We used 
Number_Of_Sessions = 4; % We used 4 runs of rs-fMRI data from Human Connectome Project
for i= 1:Number_of_Subjects
Data= cell(1,4); % Since we used four runs of data in Human Connectome project
for j=1:4
Data{1,j}= All_Run_Locations{j,i};

end
%Getting the COBE and Normal correlation matrix for each run
    
    [ CM_run_COBE_Data, Q_run,Corr_Common_cell_run, Corr_Indiv_run_COBE, Corr_Orig_run ] = CBL_Obtain_COBE_Normal_Intra_Corr_Data( Data,Component_remv );
    CM_run_4runs{i}= CM_run_COBE_Data;
    Time_Ind_Subj_4runs{i}= Q_run;
    
end
% Please specify the path where you want to save your data
Output_dir ='/data/users/rajk/storage/Raphael/Megatrawl/Cross_valid/Intra_Cortical/Ruby_Data_Two_Components/All_Sessions/';
Output_Name1= 'COBE_Common_Data';
save (fullfile(Output_dir,[Output_Name1 '.mat']),'CM_run_4runs','Component_remv', 'Time_Ind_Subj_4runs' );

%%%%%%%%%%%%%%%%
% obtain COBE Correlation matrix
%% For Component 1 
Component_1 = [];
for i= 1 : Number_of_Subjects
    for j= 1 %% Component you want
        P= CM_run_4runs{1,i}(:,j);
        Component_1= [Component_1,P];
    end
end
COBE_Correlation_matrix = [];
% CM_run_4runs = CM_run_4runs_Sess_2;
for i= 1 : length (Component_1)
    correlation_values = [];
    for j= 1 : length (Component_1)
        correlation = corr(Component_1(:,i),Component_1(:,j));
        correlation_values = [correlation_values correlation];
    end
    COBE_Correlation_matrix = [matrix; correlation_values];
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Obtain the MCD group
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[subset, corr_coe, corr_coe_max] = find_subset_low_corr_behaviors(COBE_Correlation_matrix);
[M,Min_Index] =  min(corr_coe);
Subject= subset {Min_Index};

% For Visualisation of Data please download the CBIG groups visualisation
% commands and you can also obtain 7 and 17 network partition from there. 

