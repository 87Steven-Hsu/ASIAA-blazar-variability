%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A code to do calculate cloest WHAM intensity sources of blazar sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear; close all;

%%% Read blazar infomation (pushkarev & kovalev) (# = 4963)
DataStartLine = 1;
NumVariables = 3;
VariableNames  = {'Source','latitude','longitude'};
VariableWidths = [10,8,8] ;                                                 
DataType       = {'char','double','double'};
opts = fixedWidthImportOptions('NumVariables',NumVariables,...
                               'DataLines',DataStartLine,...
                               'VariableNames',VariableNames,...
                               'VariableWidths',VariableWidths,...
                               'VariableTypes',DataType);
push = readtable('pushkarevkovalev_table2-3.txt',opts);

Source = push.Source';  % source name
Push_b = push.latitude';  
Push_l = push.longitude';    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Read WHAM data (# = 49640)
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

%% WHAM coordinates plot
figure(1);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(WHAM_l,WHAM_b,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlabel('Galactic Longitude','FontSize', 15)
    ylabel('Galactic Latitude','FontSize', 15)   
    xlim([0 360])   
    ylim([-90 90])   
    set(gca,'FontSize',15,'LineWidth',2); 

%% distance calculation between Sources and WHAM coordinates
for i = 1:max(size(Source))
    
    for j = 1:max(size(WHAM_l))
        
        d(i,j) = sqrt((Push_l(i)-WHAM_l(j))^2+(Push_b(i)-WHAM_b(j))^2);
        
    end
    
end

%% Find the cloest distance and distance lower than 0.5 deg
Xresult = zeros(4963,2);

for i = 1:max(size(Source))
    
    dismin = find(d(i,:) == min(d(i,:))); % find minimum distance of blazar sources and WHAM point
    
    if d(i,dismin) < 0.5 % if distance is less than 0.5 deg
        Xresult(i,1) = WHAM_l(dismin); %column 1 will assign galactic longitude
        Xresult(i,2) = WHAM_b(dismin); %column 2 will assign galactic latitude
    else % if distance is larger than 0.5 deg
        Xresult(i,1) = NaN; %column 1 will assign NaN
        Xresult(i,2) = NaN; %column 2 will assign NaN
    end
    
end
%% Xmatch result check
matchsucc = find(~isnan(Xresult(:,2))); % find match success sources' index
 
figure(2);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(Xresult(:,1),Xresult(:,2),'ro','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(Push_l(matchsucc),Push_b(matchsucc),'go','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlabel('Galactic Longitude','FontSize', 15)
    ylabel('Galactic Latitude','FontSize', 15)   
    xlim([0 360])   
    ylim([-90 90])   
    grid on
    legend('WHAM H-\alpha intensity','Blazar Sources','location','northeast')
    set(gca,'FontSize',15,'LineWidth',2); 

%% save cross match file
 filename = strcat('WHAM_Xmatch_result.txt');
 fileID = fopen(filename,'w');
 
 fprintf(fileID,'%7.3f\t %7.3f\n ',Xresult(:,1),Xresult(:,2));
 
 fclose(fileID);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Result check
%%%% read saved file
filename = strcat('WHAM_Xmatch_result.txt'); 
fid = fopen(filename);  % openfile

for i=1:1
    fgetl(fid);  % skip header of first line
end

Result = textscan(fid,'%f64 %f64','delimiter',','); 

fclose(fid);

matres_l = Result{1}; % Xmatch result galactic longitude
matres_b = Result{2}; % Xmatch result galactic latitude

%%%% plot saved WHAM l and b and blazars' scattering plot
matchsucc = find(~isnan(matres_b));

figure(3);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(matres_l,matres_b,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(Push_l(matchsucc),Push_b(matchsucc),'g.','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlabel('Galactic Longitude','FontSize', 15)
    ylabel('Galactic Latitude','FontSize', 15)   
    xlim([0 360])   
    ylim([-90 90])   
    grid on
    legend('WHAM H-\alpha intensity','Blazar Sources','location','northeast')
    set(gca,'FontSize',15,'LineWidth',2); 




























