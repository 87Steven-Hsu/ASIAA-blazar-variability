%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A code to do calculate cloest WHAM intensity sources of blazar sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear; close all;

%%% Read "Table_2_published_mean with z.csv"
% filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published_mean with z.csv'); 
% fid = fopen(filename);  % openfile
% 
% for i=1:1
%     line = fgetl(fid);  % skip header of first line
% end
% 
% table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f','delimiter',','); 
% fclose(fid);    % close file
% 
% sourcename = string(table{1}); 
% size_1 = table{2}';
% size_2 = table{3}'; 
% size_3 = table{4}'; 
% size_4 = table{5}'; 
% size_5 = table{6}'; 
% size_6 = table{7}';
% size_7 = table{8}'; 
% size_8 = table{9}'; 
% table_b = table{10}'; 
% table_l = table{11}';
% z = table{12};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% source size table AFTER publication 
Table2 = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published with z.csv');
fid = fopen(Table2);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %s %f %f %f','delimiter',','); 
fclose(fid); 

sourcename = string( Table{1} );  
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
table_b = Table{13}; 
table_l = Table{14}; 
z = Table{15}; 

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
WHAM = readtable('/Users/87steven/Documents/ASIAA/Radio variability Code/wham2.txt',opts);

WHAM_l = WHAM.LON'; %[deg]
WHAM_b = WHAM.LAT'; %[deg]
Inten = WHAM.Inten'; 
err = WHAM.error';

%% WHAM coordinates plot
% figure(1);
%     set(gcf,'pos',[100,100,1200,800]);
%     
%     plot(WHAM_l,WHAM_b,'r.','MarkerSize',6,'MarkerFaceColor','k') 
%     xlabel('Galactic Longitude','FontSize', 15)
%     ylabel('Galactic Latitude','FontSize', 15)   
%     xlim([0 360])   
%     ylim([-90 90])   
%     set(gca,'FontSize',15,'LineWidth',2); 

%% distance calculation between Sources and WHAM coordinates
for i = 1:length(sourcename) % length = 1148
    
    for j = 1:length(WHAM_l)
        % disp('i = '+ string(i))
        d(i,j) = sqrt((table_l(i)-WHAM_l(j))^2+(table_b(i)-WHAM_b(j))^2);
        
    end
    
end

%% Find the cloest distance and distance lower than 0.5 deg
Xresult = zeros(length(sourcename),2);

for i = 1:length(sourcename)
    
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
    
    plot(Xresult(:,1),Xresult(:,2),'ro','MarkerSize',6,'MarkerFaceColor','r') 
    hold on 
    plot(table_l(matchsucc),table_b(matchsucc),'go','MarkerSize',6,'MarkerFaceColor','g')
    hold off
    xlabel('Galactic Longitude','FontSize', 20)
    ylabel('Galactic Latitude','FontSize', 20)   
    xlim([0 360])   
    ylim([-90 90])   
    grid on
    legend('WHAM H-\alpha intensity','Blazar Sources','location','northeast')
    set(gca,'FontSize',20,'LineWidth',2); 

%% save cross match file
for i = 1: length(sourcename)
    save_table(i,:) = table(sourcename(i), Xresult(i,1), Xresult(i,2));

end

filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/WHAM_Xmatch_result_table2.csv'); 
fileID = fopen(filename,'w');

writetable(save_table, filename);

fclose(fileID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Result check
%%%% read saved file
% filename = strcat('WHAM_Xmatch_result.txt'); 
% fid = fopen(filename);  % openfile
% 
% for i=1:1
%     fgetl(fid);  % skip header of first line
% end
% 
% Result = textscan(fid,'%f64 %f64','delimiter',','); 
% 
% fclose(fid);
% 
% matres_l = Result{1}; % Xmatch result galactic longitude
% matres_b = Result{2}; % Xmatch result galactic latitude

filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/OVRO galactic coordinate.csv'); 
fid = fopen(filename);  % openfile

for i=1:1
    fgetl(fid);  % skip header of first line
end

Result = textscan(fid,'%s %f %f %f','delimiter',','); 

fclose(fid);

%%% matres = match result
table_b = Result{2}; % Xmatch result of WHAM galactic longitude (4963 coordinates, includes NaN) 
                      % => use numreSt2 index for finding corresponding tau_char, D(1000) parameters
table_l = Result{3}; % Xmatch result WHAM galactic latitude

%%%% plot saved WHAM l and b and blazars' scattering plot
matchsucc = find(~isnan(table_b));

figure(3);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(WHAM_l,WHAM_b,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(table_l(matchsucc),table_b(matchsucc),'g.','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlabel('Galactic Longitude','FontSize', 15)
    ylabel('Galactic Latitude','FontSize', 15)   
    xlim([0 360])   
    ylim([-90 90])   
    grid on
    legend('WHAM H-\alpha intensity','Blazar Sources','location','northeast')
    set(gca,'FontSize',15,'LineWidth',2); 




























