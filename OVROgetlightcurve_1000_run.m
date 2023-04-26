%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to fit structure function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

tic
filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/OVROsourcelistJonly.csv'); 
fid = fopen(filename);  % openfile

F = textscan(fid,'%s %s %s %s','delimiter',','); 

fclose(fid);    % close file

name = F{2}'; 

fileFolder = fullfile(['/Users/87steven/Documents/ASIAA/Radio variability Code/lightcurvesflagged']);    
dirOutput = dir(fullfile(fileFolder,'*'));
fileName = {dirOutput.name};  

filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/result_1000_0209.txt');
fileID = fopen(filename,'w');

for s = 1:max(size(name)) %all loop: max(size(name)) %11: J006-0623 ; 266: J0502+1338 
    for k = 1:max(size(fileName)) %all loop: max(size(fileName)) %18: J006-0623 ; 252:  J0502+1338 
        if strcmp([name{1,s},'.csv'],fileName{1,k}) == 1
            
            sourcename = char(name(s))
            dtlag = 4;
            makeplots = 0;
            [sourcename,tau,ipl,foa,fob,fowa,fowb,p22,tauchar_error_up,tauchar_error_down] = OVROgetlightcurve_1000(sourcename,dtlag,makeplots);
            
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

            fprintf(fileID,'%s\t %10.8f\t %10.8f\t %10.8f\t %10.8f\t %10.8f\t %10.8f\n ', ...
                sourcename,fowa,fowb,p22(250,2),p22(250,1), tauchar_error_up, tauchar_error_down); 
            
        end
    end 
end

fclose(fileID);

toc