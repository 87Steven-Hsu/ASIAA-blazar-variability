clc;clear;close all;

tic
% è®?data listä¸­ç?„è?‡è??
filename = strcat('OVROsourcelistJonly.csv'); % strcat = æ°´å¹³???Ž¥string
fid = fopen(filename);  % openfile

F = textscan(fid,'%s %s %s %s','delimiter',','); % å°‡è??…¥??„æ?”æ?ˆå?˜å…¥F?Ÿ©?™£

fclose(fid);    % close file

name = F{2}'; % data listä¸­æ?‰ç?„sourcename

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

fileFolder=fullfile('D:\³\\ASIAA\Code\lightcurvesflagged');    % è®?data base??„è?‡æ?™å¤¾ä¸­ç?„è?‡è??
dirOutput=dir(fullfile(fileFolder,'*'));
fileName={dirOutput.name};  % data base??„source name 

filename = strcat('result_2000.txt');
fileID = fopen(filename,'w');

for s = 1:max(size(name)) %all loop: max(size(name)) %11: J006-0623 ; 266: J0502+1338 % data listä¸­æ?‰ç?„sourcename (1270) "?‹¿?”¹"
    for k = 1:max(size(fileName)) %all loop: max(size(fileName)) %18: J006-0623 ; 252:  J0502+1338 % data base??„source name (1164) ""
        if strcmp([name{1,s},'.csv'],fileName{1,k}) == 1
            sourcename = char(name(s));
            dtlag = 4;
            makeplots = 1;
            [sourcename,tau,ipl,Dnoise,foa,fob,fowa,fowb] = OVROgetlightcurve_2000(sourcename,dtlag,makeplots);
            
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
