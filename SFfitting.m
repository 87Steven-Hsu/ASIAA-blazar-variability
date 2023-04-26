%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to fit structure function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Read file "'pushkarevkovalev_table2-3.txt'"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DataStartLine = 1;
NumVariables = 10;
VariableNames  = {'Source','RA','DEC','z','t2','t5','t8','t15','t24','t43'};
VariableWidths = [10,8,8,6,6,6,6,6,6,6] ;                                                 
DataType       = {'char','double','double','double','double','double','double','double','double','double'};
opts = fixedWidthImportOptions('NumVariables',NumVariables,...
                               'DataLines',DataStartLine,...
                               'VariableNames',VariableNames,...
                               'VariableWidths',VariableWidths,...
                               'VariableTypes',DataType);
push = readtable('pushkarevkovalev_table2-3.txt',opts);

Source = push.Source';  % source name
RA = push.RA';  % RA
DEC = push.DEC';    % DEC
z = push.z'; % redshift
t2 = push.t2'; % theta_2
t5 = push.t5'; % theta_5
t8 = push.t8'; % theta_8
t15 = push.t15'; % theta_15
t24 = push.t24'; % theta_24
t43 = push.t43'; % theta_43

%%% calculate apparent distance
for i = 1:max(size(z))
    Dist(i) = ad_dist(z(i),1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% read file of SF amplitude and characteristic timescale file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename = strcat('result_mod.csv'); 
fid = fopen(filename);  % openfile

for i=1:1
    line = fgetl(fid);  % skip header of first line
end

R = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',','); 
fclose(fid);    % close file

resultsn = R{1}'; % result's sourcename
foa = R{2}'; % a = 2m^2 without weight
fob = R{3}'; % b = tau_char without weight
Dnoise = R{4}'; % Dobise 
fowa = R{5}'; % aw = 2m^2 with weight
fowb = R{6}'; % bw = tau_char with weight
D100 = R{7}'; % D(tau=100) without weight
D1000 = R{8}'; % D(tau=1000) without weight  ----> calculate by Koay et al., 2011 function #5
D100w = R{9}'; % D(tau=100) with weight
D1000w = R{10}'; % D(tau=1000) with weight   ----> calculate by Koay et al., 2011 function #5
MF = R{11}'; % meanflux
D2000 = R{12}'; %D(tau=2000) without weight  ----> calculate by Koay et al., 2011 function #5
D2000w = R{13}'; % D(tau=2000) with weigh     ----> calculate by Koay et al., 2011 function #5
D1500 = R{14}'; %D(tau=1500) without weight  ----> calculate by Koay et al., 2011 function #5
D1500w = R{15}'; % D(tau=1500) with weigh     ----> calculate by Koay et al., 2011 function #5
SFerru = R{16}';
SFerrd = R{17}';
tau_char_uperr = R{18}';
tau_char_lowerr = R{19}';
D4w = R{20}';
D4w_uperr = R{21}';
D4w_lowerr = R{22}';

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% cross match source name from "table 2.cssv" and "result_mod.csv"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t2notnan = find(~isnan(t2)); 
St2 = Source(t2notnan); 
nt2 = t2(t2notnan);  
outputr = zeros(1,max(size(resultsn))); 
outputp = zeros(1,max(size(St2))); 
for n = 1:max(size(resultsn))
    for m = 1: max(size(St2))
        if strcmp(resultsn{1,n},St2{1,m}) == 1
            outputr(n) = n; 
            outputp(m) = m; 
        end
    end
end

numreSt2 = find(outputr ~=0); %JUST for OVRO use
numSt2 = find(outputp ~=0);    % for source size and redshift use

t5notnan = find(~isnan(t5));
St5 = Source(t5notnan);
nt5 = t5(t5notnan);  
outputr = zeros(1,max(size(resultsn))); 
outputp = zeros(1,max(size(St5)));   
for n = 1:max(size(resultsn))
    for m = 1: max(size(St5))
        if strcmp(resultsn{1,n},St5{1,m})==1
            outputr(n) = n;
            outputp(m) = m;
        end
    end
end
numreSt5 = find(outputr ~=0);    
numSt5 = find(outputp ~=0);    

t8notnan =find(~isnan(t8));
St8 = Source(t8notnan);
nt8 = t8(t8notnan);  
outputr = zeros(1,max(size(resultsn))); 
outputp = zeros(1,max(size(St8)));  
for n = 1:max(size(resultsn))
    for m = 1: max(size(St8))
        if strcmp(resultsn{1,n},St8{1,m})==1
            outputr(n) = n;
            outputp(m) = m;
        end
    end
end
numreSt8 = find(outputr ~=0);    
numSt8 = find(outputp ~=0);    

t15notnan =find(~isnan(t15));
St15 = Source(t15notnan);
nt15 = t15(t15notnan);  
outputr = zeros(1,max(size(resultsn))); 
outputp = zeros(1,max(size(St15)));   
for n = 1:max(size(resultsn))
    for m = 1: max(size(St15))
        if strcmp(resultsn{1,n},St15{1,m})==1
            outputr(n) = n;
            outputp(m) = m;
        end
    end
end
numreSt15 = find(outputr ~=0);    
numSt15 = find(outputp ~=0);    

t24notnan =find(~isnan(t24));
St24 = Source(t24notnan);
nt24 = t24(t24notnan);  
outputr = zeros(1,max(size(resultsn)));
outputp = zeros(1,max(size(St24))); 
for n = 1:max(size(resultsn))
    for m = 1: max(size(St24))
        if strcmp(resultsn{1,n},St24{1,m})==1
            outputr(n) = n;
            outputp(m) = m;
        end
    end
end
numreSt24 = find(outputr ~=0);
numSt24 = find(outputp ~=0);    

t43notnan =find(~isnan(t43)); 
St43 = Source(t43notnan);
nt43 = t43(t43notnan);  
outputr = zeros(1,max(size(resultsn))); 
outputp = zeros(1,max(size(St43)));  
for n = 1:max(size(resultsn))
    for m = 1: max(size(St43))
        if strcmp(resultsn{1,n},St43{1,m})==1
            outputr(n) = n;
            outputp(m) = m;
        end
    end
end
numreSt43 = find(outputr ~=0);    
numSt43 = find(outputp ~=0);    

rad = (1/3600)*1E-3*(pi/180);

realsize2 = nt2(numSt2).*Dist(numSt2)*rad;
realsize5 = nt5(numSt5).*Dist(numSt5)*rad;
realsize8 = nt8(numSt8).*Dist(numSt8)*rad;
realsize15 = nt15(numSt15).*Dist(numSt15)*rad;
realsize24 = nt24(numSt24).*Dist(numSt24)*rad;
realsize43 = nt43(numSt43).*Dist(numSt43)*rad; %[unit: pc]

%% Run "Sourcesizecomp.m" function
[tau_appsize_corr,tauw_appsz_corr,D100_appsz_corr,D100w_appsz_corr,D1000_appsz_corr,...
    D1000w_appsz_corr,MF_appsz_corr,fowb_actsz_corr,D1000w_actsz_corr,z_actsz_corr,MF_actsz_corr,...
    fowbsrc_actsz_corr,D2000w_MF_corr,D1500w_MF_corr]= Sourcesizecomp(fob,fowb,D100,D1000, ...
    D100w,D1000w,D2000w,D1500w,MF,nt2,nt5,nt8,nt15,nt24,nt43,numreSt2,numSt2,numreSt5,numSt5, ...
    numreSt8,numSt8,numreSt15,numSt15,numreSt24,numSt24,numreSt43,numSt43,realsize2,realsize5, ...
    realsize8,realsize15,realsize24,realsize43,z,SFerru,SFerrd,Dnoise);
%% Run "KStest2sample.m" function
[fowb_sz_KS,D1000w_actsz_KS,D1000w_appsz_KS,MF_actsz_KS,fowb_actsz_KS,fowb_z_KS,...
    fowb_MF_KS,fowbsrc_actsz_KS,z_dis_by_obstimesapn_KS,fowb_totMF_KS,D2000w_actsz_KS,...
    D1500w_actsz_KS] = KStest2sample(fob,fowb,numreSt2,numreSt5,numreSt8,numreSt15, ...
    numreSt24,numreSt43,nt2,nt5,nt8,nt15,nt24,nt43,numSt2,numSt5,numSt8,numSt15, ...
    numSt24,numSt43,D1000w,D2000w,D1500w,realsize2,realsize5,realsize8,realsize15, ...
    realsize24,realsize43,MF,z);

%% WHAM H-alpha intensity file
%%% test correlation with D(1000) against H-alpha intensity
DataStartLine = 49;
NumVariables = 4;
VariableNames  = {'LON','LAT','Inten','error'};
VariableWidths = [10,10,10,10] ;                                                 
DataType       = {'double','double','double','double'};
opts = fixedWidthImportOptions('NumVariables',NumVariables,...
                               'DataLines',DataStartLine,...
                               'VariableNames',VariableNames,...
                               'VariableWidths',VariableWidths,...
                               'VariableTypes',DataType);
WHAM = readtable('wham2.txt',opts);

WHAM_l = WHAM.LON'; %[deg]
WHAM_b = WHAM.LAT'; %[deg]
Inten = WHAM.Inten'; 
err = WHAM.error';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filename = strcat('WHAM_Xmatch_result.txt'); 
fid = fopen(filename);  % openfile

for i=1:1
    fgetl(fid);  % skip header of first line
end

Result = textscan(fid,'%f64 %f64','delimiter',','); 

fclose(fid);

%%% matres = match result
matres_l = Result{1}; % Xmatch result of WHAM galactic longitude (4963 coordinates, includes NaN) 
                      % => use numSt2 index for finding corresponding tau_char, D(1000) parameters
matres_b = Result{2}; % Xmatch result WHAM galactic latitude

%%
[Halp_D1000_corr ] = Halpha_blazarsources_func(fob,fowb,D1000w,D2000w,D1500w,MF,nt2,nt5,nt8,nt15,nt24,nt43,...
    numreSt2,numSt2,numreSt5,numSt5,numreSt8,numSt8,numreSt15,numSt15,numreSt24,numSt24,numreSt43,...
    numSt43,realsize2,realsize5,realsize8,realsize15,realsize24,realsize43,z,matres_l,matres_b);
