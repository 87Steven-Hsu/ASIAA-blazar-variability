%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to fit structure function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

tic

filename = strcat('OVROsourcelistJonly.csv'); 
fid = fopen(filename);  % openfile

F = textscan(fid,'%s %s %s %s','delimiter',','); 

fclose(fid);    
size(F);    

SN = F{1}'; 
name = F{2}'; 
RA = F{3}'; 
DEC = F{4}'; 

% dtlag = time lag
dtlag = 4; % set to 0 to automatically determine dtlag from mean diff of succesive timestamps
           % set in days (e.g. 4) to fix value for minimum timescale
makeplots = 1; % set to 1 to make plots, 0 for no plotting

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get lightcurve data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sourcename = 'J0757+0956';
%sourcename = 'J0739+0137';
%sourcename = 'J0502+1338';
%sourcename = 'J0929+5013';
%sourcename = 'J0559-1817';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileFolder=fullfile('D:\ASIAA\Code\lightcurvesflagged');    
dirOutput=dir(fullfile(fileFolder,'*'));
fileName={dirOutput.name};  

%charname = char(name);

filename = strcat('result_1000.txt');
fileID = fopen(filename,'w');

for s = 1:max(size(name)) %all loop: max(size(name)) %11: J006-0623 ; 266: J0502+1338 %
    for k = 1:max(size(fileName)) %all loop: max(size(fileName)) %18: J006-0623 ; 252:  J0502+1338 
        if strcmp([name{1,s},'.csv'],fileName{1,k}) == 1
            sourcename = char(name(s));
            dtlag = 4;
            makeplots = 1;
            [sourcename Serrmean ipl errsf sf errsfbin tau Dnoise foa fob fowa fowb] = OVROgetlightcurve_1000(sourcename,dtlag,makeplots);
            
            if fob > max(tau(ipl))
                fob = max(tau(ipl));
            else 
                fob = fob;
            end
            
            if fowb > max(tau(ipl))
                fowb = max(tau(ipl));
            else 
                fowb = fowb;
            end

            fprintf(fileID,'%s\t%10.8f\t%10.8f\t%10.8f\t%10.8f\t%10.8f\n',sourcename,foa,fob,Dnoise,fowa,fowb); 
        end
    end 
end

fclose(fileID);

toc

%% Read file "'pushkarevkovalev_table2-3.txt'"

tic
clc; clear; close all;

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
t2 = push.t2'; % theta_2
t5 = push.t5'; % theta_5
t8 = push.t8'; % theta_8
t15 = push.t15'; % theta_15
t24 = push.t24'; % theta_24
t43 = push.t43'; % theta_43

%nan = find(isnum(t15));

toc

%% Read file of the result obtain above 
% 
tic
filename = strcat('result_1000.csv'); 
fid = fopen(filename);  % openfile

for i=1:1
    line = fgetl(fid);  % skip header of first line
end

R = textscan(fid,'%s %f64 %f64 %f64 %f64 %f64','delimiter',','); 

fclose(fid);    % close file
%size(R);    % check the size of the array

resultsn = R{1}'; % result's sourcename
foa = R{2}'; % a = D(tau = 1000)  without weight
fob = R{3}'; % b = tau_char without weight
Dnoise = R{4}'; % Dobise 
fowa = R{5}'; % aw = D(tau = 1000)  with weight
fowb = R{6}'; % bw = tau_char with weight

t2notnan =find(~isnan(t2)); 
St2 = Source(t2notnan); 
nt2 = t2(t2notnan); 
outputr = zeros(1,max(size(resultsn))); 
outputp = zeros(1,max(size(St2)));  
for n = 1:max(size(resultsn))
    for m = 1: max(size(St2))
        if strcmp(resultsn{1,n},St2{1,m})==1
            outputr(n) = [n];
            outputp(m) = [m];
        end
    end
end

numreSt2 = find(outputr ~=0);    
numSt2 = find(outputp ~=0);    

t5notnan =find(~isnan(t5));
St5 = Source(t5notnan);
nt5 = t5(t5notnan);  
outputr = zeros(1,max(size(resultsn))); 
outputp = zeros(1,max(size(St5)));   
for n = 1:max(size(resultsn))
    for m = 1: max(size(St5))
        if strcmp(resultsn{1,n},St5{1,m})==1
            outputr(n) = [n];
            outputp(m) = [m];
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
            outputr(n) = [n];
            outputp(m) = [m];
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
            outputr(n) = [n];
            outputp(m) = [m];
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
            outputr(n) = [n];
            outputp(m) = [m];
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
            outputr(n) = [n];
            outputp(m) = [m];
        end
    end
end

numreSt43 = find(outputr ~=0);    
numSt43 = find(outputp ~=0);    

size = [t2 t5 t8 t15 t24 t43];

%%
[foacorr,fowacorr,fobcorr,fowbcorr] = Sourcesizecomp_1000(foa,fob,fowa,fowb,nt2,nt5,nt8,nt15,nt24,nt43,...
   numreSt2,numSt2,numreSt5,numSt5,numreSt8,numSt8,numreSt15,numSt15,numreSt24,numSt24,numreSt43,numSt43);

[KStest2] = KStest2sample(fob,numreSt2,numreSt5,numreSt8,numreSt15,numreSt24,numreSt43,nt2,nt5,nt8,nt15,nt24,nt43,numSt2,numSt5,...
    numSt8,numSt15,numSt24,numSt43)

toc