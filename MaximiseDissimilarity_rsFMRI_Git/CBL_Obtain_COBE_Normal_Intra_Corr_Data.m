

function [ CM_run_COBE_Data, Q_run,Corr_Common_cell_run, Corr_Indiv_run_COBE, Corr_Orig_run ] = Obtain_COBE_Normal_Intra_Corr_Data( Data,Component_remv )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

%Getting the Time-Courses of all the Subjects kept in a folder 

 Time_Course_run = Data;

%Getting the components to be removed and the applying COBE
rC =  Component_remv;
opts.c = rC;
[CM_run_COBE_Data, Q_run] = cobec(Time_Course_run, opts); % Please download COBE
% getting the common values
Common_cell_run= cell(1,1);
for i= 1: length(Q_run)
    M= CM_run_COBE_Data* Q_run{1,i};
    Common_cell_run{1,i}= M;
end
%getting the correlation values of common signal
Corr_Common_cell_run= cell(1,1);
for i= 1: length (Common_cell_run)
    M= corr(Common_cell_run{1,i}');
    Corr_Common_cell_run{i,1}= M;
end
%getting the Individual values
Indiv_cell_run= cell(1,1);
for i= 1: length (Common_cell_run)
    M= Time_Course_run{1,i}-Common_cell_run{1,i};
    Indiv_cell_run{i,1}= M;
end
% getting the Individual correlation matrices
Corr_Indiv_run_COBE= cell(1,1);
for i= 1: length(Indiv_cell_run)
    M= corr (Indiv_cell_run{i,1}');
    Corr_Indiv_run_COBE{i,1}= M;
end
%Getting the original matrices
Corr_Orig_run= cell(1,1);
for i= 1: length(Time_Course_run)
    M= corr (Time_Course_run{1,i}');
    Corr_Orig_run{i,1}= M;
end

end
