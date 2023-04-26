clc;clear;close all;

tic
filename = strcat('OVROsourcelistJonly.csv'); 
fid = fopen(filename); 

F = textscan(fid,'%s %s %s %s','delimiter',','); 

fclose(fid);   

SN = F{1}'; % serial number
name = F{2}'; % data listä¸­æ?‰ç?„sourcename

dtlag = 4; % set to 0 to automatically determine dtlag from mean diff of succesive timestamps
           % set in days (e.g. 4) to fix value for minimum timescale
makeplots = 1; % set to 1 to make plots, 0 for no plotting

fileFolder=fullfile('D:\³\\ASIAA\Code\lightcurvesflagged');    
dirOutput=dir(fullfile(fileFolder,'*'));
fileName={dirOutput.name}; 

filename = strcat('result_0831.txt');
fileID = fopen(filename,'w');

for s = 1:max(size(name)) %max(size(name)) %11: J006-0623 ; 266: J0502+1338 % OVRO blazar monitering program
    for k = 1:max(size(fileName)) %max(size(fileName)) %18: J006-0623 ; 252: J0502+1338 % light curve data
        if strcmp([name{1,s},'.csv'],fileName{1,k}) == 1
            sourcename = char(name(s));
            [sourcename,tau,ipl,Dnoise,foa,fob,fowa,fowb,D100w,D1000w,SFAerru,SFAerrd] = OVROgetlightcurve(sourcename,...
                dtlag,makeplots);
            
            if fob > max(tau(ipl))
                fob = max(tau(ipl));
            end
            
            if fowb > max(tau(ipl))
                fowb = max(tau(ipl));
            end
            
            fprintf(fileID,'%s\t %10.8f\t %10.8f\t %10.8f\t %10.8f\t %10.8f\t %10.8f\t %10.8f\n ',...
                sourcename,Dnoise,fowa,fowb,D100w,D1000w,SFAerru(250),SFAerrd(250));
        end
    end 
end

fclose(fileID);

toc