%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to fit structure function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

tic
filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/OVROsourcelistJonly_csv.csv'); 
fid = fopen(filename);  % openfile

F = textscan(fid,'%s %s %s %s','delimiter',','); 

fclose(fid);    % close file

name = F{2}'; 

fileFolder = fullfile(['/Users/87steven/Documents/ASIAA/Radio variability Code/lightcurvesflagged']);    
dirOutput = dir(fullfile(fileFolder,'*'));
fileName = {dirOutput.name};  

filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/result_4_0706.txt');
fileID = fopen(filename,'w');

for s = 1:max(size(name)) %all loop: max(size(name)) %11: J006-0623 ; 266: J0502+1338 
    for k = 1:max(size(fileName)) %all loop: max(size(fileName)) %18: J006-0623 ; 252:  J0502+1338 
        if strcmp([name{1,s},'.csv'],fileName{1,k}) == 1
            
            s
            sourcename = char(name(s))
            dtlag = 4;
            makeplots = 0;
            [sourcename,tau,ipl,foa,fob,fowa,fowb,p22,D_4d_uperr,D_4d,D_4d_lowerr] = OVROgetlightcurve_4(sourcename,dtlag,makeplots);
            
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

            fprintf(fileID,'%s\t %10.8f\t %10.8f\t %10.8f\t \n ', ...  % %10.8f\t %10.8f\t %10.8f
                sourcename,D_4d_uperr,D_4d,D_4d_lowerr); 
            
        end
    end 
end

fclose(fileID);

toc