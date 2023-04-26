%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to fit structure function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Read file "'Table_2_arrange_.csv'"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% source size table BEFORE publication (source size error are not correct)
% Table2 = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/unpublished source size data/Table_2 with z.csv');

%%% source size table AFTER publication 
Table2 = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published with z.csv');
fid = fopen(Table2);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %s %f %f %f','delimiter',','); 
fclose(fid); 

Source_name = string( Table{1} );  
freq_1 = Table{2}; 
freq_2 = Table{3};   
freq_5 = Table{4}; 
freq_8 = Table{5}; 
freq_15 = Table{6}; 
freq_24 = Table{7}; 
freq_43 = Table{8}; 
freq_86 = Table{9}; 
size = Table{10}; 
size_err = Table{11}; 
epoch = string(Table{12}); 
b = Table{13}; 
l = Table{14}; 
z = Table{15}; 

t2 = size(~isnan(freq_2));
t5 = size(~isnan(freq_5));
t8 = size(~isnan(freq_8));
t15 = size(~isnan(freq_15));
t24 = size(~isnan(freq_24));
t43 = size(~isnan(freq_43));
 
t2_err = size_err(~isnan(freq_2));
t5_err = size_err(~isnan(freq_5));
t8_err = size_err(~isnan(freq_8));
t15_err = size_err(~isnan(freq_15));
t24_err = size_err(~isnan(freq_24));
t43_err = size_err(~isnan(freq_43));
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

ovro_name = R{1}'; % result's sourcename
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
D1000_uperr = R{16}';
D1000_lowerr = R{17}';
fowb_uperr = R{18}';
fowb_lowerr = R{19}';
D4w = R{20}';
D4w_uperr = R{21}';
D4w_lowerr = R{22}';

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% cross match source name from "table 2.cssv" and "result_mod.csv"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2 GHz
Source_name2_nonan = Source_name(~isnan(freq_2)); % length = 34619, unique source name = 3790
z_2 = z(~isnan(freq_2));
ovro_arr = zeros(1,length(ovro_name)); 
table2_arr = zeros(1,length(Source_name2_nonan)); 
for n = 1:length(ovro_name)
    for m = 1:length(Source_name2_nonan)
        if strcmp(ovro_name{1,n},Source_name2_nonan{m}) == 1
            ovro_arr(n) = n; 
            table2_arr(m) = m; 
        end
    end
end
numreSt2 = find(ovro_arr ~=0);      % for OVRO use
numSt2 = find(table2_arr ~=0);      % for source size and redshift use
 
name = Source_name2_nonan(numSt2);   % length = 20427, unique = 1079
size = t2(numSt2);   % length = 20427
size_err = t2_err(numSt2);   % length = 20427
z_2 = z_2(numSt2);   % length = 20427
unique_name = unique(name);   % length = 1079
for i = 1:length(unique(name))
    index = find(name == unique_name(i));
    err_lt50percent = find( (size(index)./size_err(index))>2 ); %% only take source size, whcih error is 1000 less than source size
    size2_median(i) = nanmean(size(index(err_lt50percent)));   % length = 1079, not nan length = 865
    %%% some sources have source sizes and source size uncertainties
    %%% measurement, and redshift, but did not match the selection criteria
    %%% => size2_median will be NaN, but still have z data
    %%% => not nan length of z ""can be greater than"" not nan length of size2_median
    %%% sources have nan mean value but with z, will still be in the
    %%% calculation of linear size, but not include in analysis
    z_2_array(i) = z_2(index(1));   % length = 1079, not nan length = 936
    Dist_2(i) = ad_dist(z_2_array(i),1);
end

%%% 5 GHz
Source_name5_nonan = Source_name(~isnan(freq_5));
z_5 = z(~isnan(freq_5));
ovro_arr = zeros(1,length(ovro_name)); 
table2_arr = zeros(1,length(Source_name5_nonan)); 
for n = 1:length(ovro_name)
    for m = 1:length(Source_name5_nonan)
        if strcmp(ovro_name{1,n},Source_name5_nonan{m})==1
            ovro_arr(n) = n;
            table2_arr(m) = m;
        end
    end
end
numreSt5 = find(ovro_arr ~=0);    
numSt5 = find(table2_arr ~=0);    

name = Source_name5_nonan(numSt5);
size = t5(numSt5);
size_err = t5_err(numSt5);
z_5 = z_5(numSt5);
unique_name = unique(name);
for i = 1:length(unique(name))
    index = find(name == unique_name(i));
    err_lt50percent = find((size(index)./size_err(index))>2); 
    size5_median(i) = nanmean(size(index(err_lt50percent)));
    z_5_array(i) = z_5(index(1));
    Dist_5(i) = ad_dist(z_5_array(i),1);
end

%%% 8 GHz
Source_name8_nonan = Source_name(~isnan(freq_8));
z_8 = z(~isnan(freq_8));
ovro_arr = zeros(1,length(ovro_name)); 
table2_arr = zeros(1,length(Source_name8_nonan)); 
for n = 1:length(ovro_name)
    for m = 1:length(Source_name8_nonan)
        if strcmp(ovro_name{1,n},Source_name8_nonan{m})==1
            ovro_arr(n) = n;
            table2_arr(m) = m;
        end
    end
end
numreSt8 = find(ovro_arr ~=0);    
numSt8 = find(table2_arr ~=0);   

name = Source_name8_nonan(numSt8);
size = t8(numSt8);
size_err = t8_err(numSt8);
z_8 = z_8(numSt8);
unique_name = unique(name);
for i = 1:length(unique(name))
    index = find(name == unique_name(i));
    err_lt50percent = find((size(index)./size_err(index))>2); 
    size8_median(i) = nanmean(size(index(err_lt50percent)));
    z_8_array(i) = z_8(index(1));
    Dist_8(i) = ad_dist(z_8_array(i),1);
end

%%% 15 GHz
Source_name15_nonan = Source_name(~isnan(freq_15));
z_15 = z(~isnan(freq_15));
ovro_arr = zeros(1,length(ovro_name)); 
table2_arr = zeros(1,length(Source_name15_nonan)); 
for n = 1:length(ovro_name)
    for m = 1:length(Source_name15_nonan)
        if strcmp(ovro_name{1,n},Source_name15_nonan{m})==1
            ovro_arr(n) = n;
            table2_arr(m) = m;
        end
    end
end
numreSt15 = find(ovro_arr ~=0);    
numSt15 = find(table2_arr ~=0);    

name = Source_name15_nonan(numSt15);
size = t15(numSt15);
size_err = t15_err(numSt15);
z_15 = z_15(numSt15);
unique_name = unique(name);
for i = 1:length(unique(name))
    index = find(name == unique_name(i));
    err_lt50percent = find((size(index)./size_err(index))>2); 
    size15_median(i) = nanmean(size(index(err_lt50percent)));
    z_15_array(i) = z_15(index(1));
    Dist_15(i) = ad_dist(z_15_array(i),1);
end

%%% 24 GHz
Source_name24_nonan = Source_name(~isnan(freq_24));
z_24 = z(~isnan(freq_24));
ovro_arr = zeros(1,length(ovro_name)); 
table2_arr = zeros(1,length(Source_name24_nonan)); 
for n = 1:length(ovro_name)
    for m = 1:length(Source_name24_nonan)
        if strcmp(ovro_name{1,n},Source_name24_nonan{m})==1
            ovro_arr(n) = n;
            table2_arr(m) = m;
        end
    end
end
numreSt24 = find(ovro_arr ~=0);
numSt24 = find(table2_arr ~=0);    

name = Source_name24_nonan(numSt24);
size = t24(numSt24);
size_err = t24_err(numSt24);
z_24 = z_24(numSt24);
unique_name = unique(name);
for i = 1:length(unique(name))
    index = find(name == unique_name(i));
    err_lt50percent = find((size(index)./size_err(index))>2); 
    size24_median(i) = nanmean(size(index(err_lt50percent)));
    z_24_array(i) = z_24(index(1));
    Dist_24(i) = ad_dist(z_24_array(i),1);
end

%%% 43 GHz
Source_name43_nonan = Source_name(~isnan(freq_43));
z_43 = z(~isnan(freq_43));
ovro_arr = zeros(1,length(ovro_name)); 
table2_arr = zeros(1,length(Source_name43_nonan)); 
for n = 1:length(ovro_name)
    for m = 1:length(Source_name43_nonan)
        if strcmp(ovro_name{1,n},Source_name43_nonan{m})==1
            ovro_arr(n) = n;
            table2_arr(m) = m;
        end
    end
end
numreSt43 = find(ovro_arr ~=0);    
numSt43 = find(table2_arr ~=0);    

name = Source_name43_nonan(numSt43);
size = t43(numSt43);
size_err = t43_err(numSt43);
z_43 = z_43(numSt43);
unique_name = unique(name);
for i = 1:length(unique(name))
    index = find(name == unique_name(i));
    err_lt50percent = find((size(index)./size_err(index))>2); 
    size43_median(i) = nanmean(size(index(err_lt50percent)));
    z_43_array(i) = z_43(index(1));
    Dist_43(i) = ad_dist(z_43_array(i),1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% transfer apparent source size to actual source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% calculate apparent distance
for i = 1:length(z)
    Dist(i) = ad_dist(z(i),1);
end
Dist = Dist';

rad = (1/3600)*1E-3*(pi/180);

realsize2 = size2_median.*Dist_2*rad;
realsize5 = size5_median.*Dist_5*rad;
realsize8 = size8_median.*Dist_8*rad;
realsize15 = size15_median.*Dist_15*rad;
realsize24 = size24_median.*Dist_24*rad;
realsize43 = size43_median.*Dist_43*rad; %[unit: pc]

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% angular diameter distance vs z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% close all;
% index = find(Dist == max(Dist));
% 
% figure;
%     set(gcf,'pos',[100,100,1200,800]);
%     
%     plot(z, Dist,'ro','MarkerSize',7,'MarkerFaceColor','r') 
%     hold on
%     plot([z(index), z(index)], [0,1E10],'b--','LineWidth',3) 
%     hold off
%     legend('', sprintf('z = %4.2f', z(index(1))),'location','northwest','FontSize', 25)
%     xlim([min(z)*0.5 max(z)*1.2]) 
%     ylim([min(Dist)*0.8 max(Dist)*1.2])  
%     xlabel('Redshift','FontSize', 20) 
%     ylabel('Angular Diameter Distance (D_{A})','FontSize', 20) 
%     set(gca, 'FontSize', 20, 'LineWidth', 2,'XScale', 'log', 'YScale', 'log');   % ,'XScale', 'log', 'YScale', 'log'

%% for paper use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Run "Sourcesizecomp_table2.m" function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_figure = 0;
[tauw_appsz_corr, fowbsrc_actsz_corr, D1000w_appsz_corr, D1000w_actsz_corr, D4w_actsz_corr,...
    D4w_appsz_corr   ]= Sourcesizecomp_table2(fob,fowb, ...
    D1000w,D1000_uperr,D1000_lowerr,D4w,D4w_uperr,D4w_lowerr,Dnoise,save_figure,...
    numreSt2,numreSt5,numreSt8,numreSt15,numreSt24,numreSt43, ...
    numSt2,numSt5,numSt8,numSt15,numSt24,numSt43, ...
    size2_median,size5_median,size8_median,size15_median,size24_median,size43_median,...
    realsize2,realsize5,realsize8,realsize15,realsize24,realsize43, ...
    z_2_array,z_5_array,z_8_array,z_15_array,z_24_array,z_43_array);

%% JUST for 2022 IAUS375 Conference use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Run "Sourcesizecomp_table2_report.m" function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_figure = 0;
[D1000w_appsz_corr, D1000w_actsz_corr, D4w_actsz_corr,...
    D4w_appsz_corr]= Sourcesizecomp_table2_report(fob,fowb, ...
    D1000w,D1000_uperr,D1000_lowerr,D4w,D4w_uperr,D4w_lowerr,Dnoise,save_figure,...
    numreSt2,numreSt5,numreSt8,numreSt15,numreSt24,numreSt43, ...
    numSt2,numSt5,numSt8,numSt15,numSt24,numSt43, ...
    size2_median,size5_median,size8_median,size15_median,size24_median,size43_median,...
    realsize2,realsize5,realsize8,realsize15,realsize24,realsize43, ...
    z_2_array,z_5_array,z_8_array,z_15_array,z_24_array,z_43_array);

%% for paper use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Run "KStest2sample_table2.m" function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_figure = 1;
[fowb_appsz_KS,fowbsrc_actsz_KS,D1000w_actsz_KS,D1000w_appsz_KS,D4w_actsz_KS, ...
    D4w_appsz_KS,fowb_lowz_appsz_KS, fowb_highz_appsz_KS, fowb_actsz_KS, ...
    fowbsrc_appsz_KS, fowbsrc_lowz_actsz_KS, fowbsrc_highz_actsz_KS] = KStest2sample_table2(fowb, ...
    D1000w, D4w,save_figure,...
    numreSt2,numreSt5,numreSt8,numreSt15,numreSt24,numreSt43, ...
    numSt2,numSt5,numSt8,numSt15, numSt24,numSt43, ...
    size2_median,size5_median,size8_median,size15_median,size24_median,size43_median, ...
    z_2_array,z_5_array,z_8_array,z_15_array,z_24_array,z_43_array, ...
    realsize2,realsize5,realsize8,realsize15,realsize24,realsize43);

%% JUST for 2022 IAUS375 Conference use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Run "KStest2sample_table2_report.m" function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_figure = 0;
[fowb_appsz_KS,fowbsrc_actsz_KS,D1000w_actsz_KS,D1000w_appsz_KS] = KStest2sample_table2_report(fowb,D1000w,D4w,save_figure,...
    numreSt2,numreSt5,numreSt8,numreSt15,numreSt24,numreSt43, ...
    numSt2,numSt5,numSt8,numSt15, numSt24,numSt43, ...
    size2_median,size5_median,size8_median,size15_median,size24_median,size43_median, ...
    z_2_array,z_5_array,z_8_array,z_15_array,z_24_array,z_43_array, ...
    realsize2,realsize5,realsize8,realsize15,realsize24,realsize43);

%% WHAM H-alpha intensity file
% DataStartLine = 49;
% NumVariables = 4;
% VariableNames  = {'LON','LAT','Inten','error'};
% VariableWidths = [10,10,10,10] ;                                                 
% DataType       = {'double','double','double','double'};
% opts = fixedWidthImportOptions('NumVariables',NumVariables,...
%                                'DataLines',DataStartLine,...
%                                'VariableNames',VariableNames,...
%                                'VariableWidths',VariableWidths,...
%                                'VariableTypes',DataType);
% WHAM = readtable('wham2.txt',opts);
% 
% WHAM_l = WHAM.LON'; %[deg]
% WHAM_b = WHAM.LAT'; %[deg]
% Inten = WHAM.Inten'; 
% err = WHAM.error';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/OVRO Xmatch WHAM.csv'); 
% fid = fopen(filename);  % openfile
% 
% for i=1:1
%     fgetl(fid);  % skip header of first line
% end
% 
% Result = textscan(fid,'%s %f %f %f %f %f %f %f %f','delimiter',','); 
% 
% fclose(fid);
% 
% %%% matres = match result
% OVRO_l = Result{2}; % Xmatch result of WHAM galactic longitude (4963 coordinates, includes NaN) 
%                       % => use numreSt2 index for finding corresponding tau_char, D(1000) parameters
% OVRO_b = Result{3}; % Xmatch result WHAM galactic latitude
% OVRO_z = Result{4};
% WHAM_l = Result{5}; 
% WHAM_b = Result{6}; 
% Halpha_int = Result{7}; 
% Halpha_int_err = Result{8}; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;

filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/OVRO_Table_2_published_mean_Xmatch_H-alpha.csv'); 
fid = fopen(filename);  % openfile

for i=1:1
    fgetl(fid);  % skip header of first line
end

Result = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',','); 

fclose(fid);

OVRO_name = string( Result{1} );
size1_median = Result{2}; 
size2_median = Result{3}; 
size5_median = Result{4}; 
size8_median = Result{5}; 
size15_median = Result{6}; 
size24_median = Result{7}; 
size43_median = Result{8}; 
size86_median = Result{9}; 
OVRO_b = Result{10}; 
OVRO_l = Result{11}; % Xmatch result WHAM galactic latitude
OVRO_z = Result{12};
WHAM_l = Result{13}; 
WHAM_b = Result{14}; 
Halpha_int = Result{15}; 
Halpha_int_err = Result{16}; 
separation = Result{17}; 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Run "Halpha_Table2,m" function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_figure = 0;
[ high_low_b_size_int_corr] = Halpha_Table2(save_figure,...
    size2_median,size5_median,size8_median,size15_median,size24_median,size43_median, ...
    OVRO_l, OVRO_b,Halpha_int,Halpha_int_err);

%%


%% D1000 v.s. physical core sizes outliers check
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Define figure parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SFerru = D1000_uperr;
SFerrd = D1000_lowerr;

D1000w2 = D1000w(numreSt2);
D1000w5 = D1000w(numreSt5); 
D1000w8 = D1000w(numreSt8); 
D1000w15 = D1000w(numreSt15); 
D1000w24 = D1000w(numreSt24); 
D1000w43 = D1000w(numreSt43); 

SFerru2 = SFerru(numreSt2); 
SFerru5 = SFerru(numreSt5); 
SFerru8 = SFerru(numreSt8); 
SFerru15 = SFerru(numreSt15); 
SFerru24 = SFerru(numreSt24); 
SFerru43 = SFerru(numreSt43); 

lt0u2 = find(SFerru2 < 0);
SFerru2(lt0u2) = Dnoise(numreSt2(lt0u2));
lt0u5 = find(SFerru5 < 0);
SFerru5(lt0u5) = Dnoise(numreSt5(lt0u5));
lt0u8 = find(SFerru8 < 0);
SFerru8(lt0u8) = Dnoise(numreSt8(lt0u8));
lt0u15 = find(SFerru15 < 0);
SFerru15(lt0u15) = Dnoise(numreSt15(lt0u15));
lt0u24 = find(SFerru24 < 0);
SFerru24(lt0u24) = Dnoise(numreSt24(lt0u24));
lt0u43 = find(SFerru43 < 0);
SFerru43(lt0u43) = Dnoise(numreSt43(lt0u43));

SFerrd2 = SFerrd(numreSt2); 
SFerrd5 = SFerrd(numreSt5); 
SFerrd8 = SFerrd(numreSt8); 
SFerrd15 = SFerrd(numreSt15); 
SFerrd24 = SFerrd(numreSt24); 
SFerrd43 = SFerrd(numreSt43); 

lt0d2 = find(SFerrd2 < 0);
SFerrd2(lt0d2) = Dnoise(numreSt2(lt0d2));
lt0d5 = find(SFerrd5 < 0);
SFerrd5(lt0d5) = Dnoise(numreSt5(lt0d5));
lt0d8 = find(SFerrd8 < 0);
SFerrd8(lt0d8) = Dnoise(numreSt8(lt0d8));
lt0d15 = find(SFerrd15 < 0);
SFerrd15(lt0d15) = Dnoise(numreSt15(lt0d15));
lt0d24 = find(SFerrd24 < 0);
SFerrd24(lt0d24) = Dnoise(numreSt24(lt0d24));
lt0d43 = find(SFerrd43 < 0);
SFerrd43(lt0d43) = Dnoise(numreSt43(lt0d43));

index2 = ~isnan(realsize2);
index5 = ~isnan(realsize5);
index8 = ~isnan(realsize8);
index15 = ~isnan(realsize15);
index24 = ~isnan(realsize24);
index43 = ~isnan(realsize43);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Find outliers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2 GHz 
index_out2 = find( realsize2 < 1);
outliers_realsize2 = realsize2(index_out2)';
outliers_z2 = z_2_array(index_out2)';

%%% 5 GHz 
index_out5 = find( realsize5 < 1);
outliers_realsize5 = realsize5(index_out5)';
outliers_z5 = z_5_array(index_out5)';

%%% 8 GHz 
index_out8 = find( realsize8 < 0.4);
outliers_realsize8 = realsize8(index_out8)';
outliers_z8 = z_8_array(index_out8)';

%%% 15 GHz 
index_out15 = find( realsize15 < 0.2);
outliers_realsize15 = realsize15(index_out15)';
outliers_z15 = z_15_array(index_out15)';

%%% 24 GHz 
index_out24 = find( realsize24 < 0.2);
outliers_realsize24 = realsize24(index_out24)';
outliers_z24 = z_24_array(index_out24)';

%%% 43 GHz 
index_out43 = find( realsize43 < 0.2);
outliers_realsize43 = realsize43(index_out43)';
outliers_z43 = z_43_array(index_out43)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.06,0.55,0.28,0.36])
    plot(realsize2(index2),D1000w2(index2),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize2,D1000w2,D1000w2-SFerrd2,SFerru2-D1000w2,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize2(D1000w2 < 0),Dnoise(numreSt2(D1000w2 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    plot(realsize2(index_out2), D1000w2(index_out2),'go','MarkerSize',5,'MarkerFaceColor','g')
    hold off
    xlim([min(realsize2(index2))*0.8 max(realsize2(index2))*1.2]) 
    ylim([min(D1000w2(index2))*0.5 max(D1000w2(index2))*3])  
    xlabel('l_{2 GHz} (pc)','FontSize', 20)
    ylabel('SF Amplitude D(1000d)','FontSize', 20)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 

    subplot('position',[0.38,0.55,0.28,0.36])
    plot(realsize5(index5),D1000w5(index5),'ro','MarkerSize',5,'MarkerFaceColor','r')
    hold on 
    errorbar(realsize5,D1000w5,D1000w5-SFerrd5,SFerru5-D1000w5,'r.','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize5(D1000w5 < 0),Dnoise(numreSt5(D1000w5 < 0)),'b.','MarkerSize',5,'MarkerFaceColor','k') 
    plot(realsize5(index_out5), D1000w5(index_out5),'go','MarkerSize',5,'MarkerFaceColor','g')
    hold off
    xlim([0.2 max(realsize5(index5))*1.2]) 
    ylim([min(D1000w5(index5))*0.5 max(D1000w5(index5))*3])  
    xlabel('l_{5 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.70,0.55,0.28,0.36])
    plot(realsize8(index8),D1000w8(index8),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize8,D1000w8,D1000w8-SFerrd8,SFerru8-D1000w8,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize8(D1000w8 < 0),Dnoise(numreSt8(D1000w8 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    plot(realsize8(index_out8), D1000w8(index_out8),'go','MarkerSize',5,'MarkerFaceColor','g')
    hold off
    xlim([min(realsize8(index8))*0.8 max(realsize8(index8))*1.2]) 
    ylim([min(D1000w8(index8))*0.5 max(D1000w8(index8))*3]) 
    xlabel('l_{8 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.06,0.09,0.28,0.36])
    plot(realsize15(index15),D1000w15(index15),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize15,D1000w15,D1000w15-SFerrd15,SFerru15-D1000w15,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize15(D1000w15 < 0),Dnoise(numreSt15(D1000w15 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b')
    plot(realsize15(index_out15), D1000w15(index_out15),'go','MarkerSize',5,'MarkerFaceColor','g')
    hold off
    xlim([min(realsize15(index15))*0.8 max(realsize15(index15))*1.2]) 
    ylim([min(D1000w15(index15))*0.5 max(D1000w15(index15))*3]) 
    xlabel('l_{15 GHz} (pc)','FontSize', 20)
    ylabel('SF Amplitude D(1000d)','FontSize', 20)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.38,0.09,0.28,0.36])
    plot(realsize24(index24),D1000w24(index24),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize24,D1000w24,D1000w24-SFerrd24,SFerru24-D1000w24,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize24(D1000w24 < 0),Dnoise(numreSt24(D1000w24 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    plot(realsize24(index_out24), D1000w24(index_out24),'go','MarkerSize',5,'MarkerFaceColor','g')
    hold off
    xlim([min(realsize24(index24))*0.8 max(realsize24(index24))*1.2]) 
    ylim([min(D1000w24(index24))*0.5 max(D1000w24(index24))*3]) 
    xlabel('l_{24 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.70,0.09,0.28,0.36])
    plot(realsize43(index43),D1000w43(index43),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize43,D1000w43,D1000w43-SFerrd43,SFerru43-D1000w43,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize43(D1000w43 < 0),Dnoise(numreSt43(D1000w43 < 0)),'b.','MarkerSize',5,'MarkerFaceColor','b') 
    plot(realsize43(index_out43), D1000w43(index_out43),'go','MarkerSize',5,'MarkerFaceColor','g')
    hold off
    xlim([min(realsize43(index43))*0.8 max(realsize43(index43))*1.2]) 
    ylim([min(D1000w43(index43))*0.5 max(D1000w43(index43))*3]) 
    xlabel('l_{43 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 

figure(5);   
set(gcf,'pos',[100,100,1200,800]);

    plot(outliers_realsize2,outliers_z2,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    plot(outliers_realsize5,outliers_z5,'go','MarkerSize',5,'MarkerFaceColor','g') 
    plot(outliers_realsize8,outliers_z8,'bo','MarkerSize',5,'MarkerFaceColor','b') 
    plot(outliers_realsize15,outliers_z15,'ko','MarkerSize',5,'MarkerFaceColor','k') 
    plot(outliers_realsize24,outliers_z24,'co','MarkerSize',5,'MarkerFaceColor','c') 
    plot(outliers_realsize43,outliers_z43,'mo','MarkerSize',5,'MarkerFaceColor','m') 
    hold off
    xlim([0 1]) 
    ylim([0 2])  
    xlabel('l (pc)','FontSize', 20)
    ylabel('z','FontSize', 20)  
    legend('2 GHz', '5 GHz', '8 GHz', '15 GHz', '24 GHz', '43 GHz', 'location','northeast','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
