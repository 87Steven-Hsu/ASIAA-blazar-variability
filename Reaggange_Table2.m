%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to run re-arrange table 2 core sizes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

%%% read Table 2 file
% source size table BEFORE publication (source size error are not correct)
% Table2_filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/Table_2.csv'); 
% source size table AFTER publication 
Table2_filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published.csv'); 
fid = fopen(Table2_filename);  % openfile

for i = 1:2
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %s %f %f %f %f','delimiter',','); 
fclose(fid); 

name = string( Table{1} );  %% size( Source{1} ) = 105357
obs_freq = str2double(string( Table{2} ));
epoch = string( Table{3} );
size = str2double(string( Table{4} ));
size_err = str2double(string( Table{5} ));
b = str2double(string( Table{6} ));
l = str2double(string( Table{7} ));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
name_list = unique( name); %% unique source number = 17471
index = zeros(length( name_list), length(name));

for i = 1:length( name_list)
     
    for j = 1:length(name)  %length(name)
        aa = find( name_list(i) == name(j));
        if ~isempty(aa)
            index(i,j) = j;
        end
    end
end

%% take all core sizes and core sizes uncertainties
m = 1;
clear save_table

for i = 1:17474   %%% totol row = 17474
    aa = index(i,:);
    bb = find(index(i,:) > 0);
    
    source_name = name(aa(bb));
    source_freq = obs_freq(aa(bb));

    source_size = size(aa(bb));
    source_size_err = size_err(aa(bb));
    source_epoch = epoch(aa(bb));
    
    freq_1 = source_freq((1.4 <= source_freq) & (source_freq <= 1.58));
    freq_2 = source_freq((2.22 <= source_freq) & (source_freq <= 2.32));
    freq_3 = source_freq((4.16 <= source_freq) & (source_freq <= 5.1));
    freq_4 = source_freq((7.64 <= source_freq) & (source_freq <= 8.68));
    freq_5 = source_freq((13.87 <= source_freq) & (source_freq <= 15.56));
    freq_6 = source_freq((23.95 <= source_freq) & (source_freq <= 24.44));
    freq_7 = source_freq((43.12 <= source_freq) & (source_freq <= 43.85));
    freq_8 = source_freq((86.25 <= source_freq) & (source_freq <= 86.30));

    theta_1 = NaN(length(source_name), 1);
    theta_2 = NaN(length(source_name), 1);
    theta_3 = NaN(length(source_name), 1);
    theta_4 = NaN(length(source_name), 1);
    theta_5 = NaN(length(source_name), 1);
    theta_6 = NaN(length(source_name), 1);
    theta_7 = NaN(length(source_name), 1);
    theta_8 = NaN(length(source_name), 1);
    
    size_array =  NaN(length(source_name), 1);
    size_err_array = NaN(length(source_name), 1);

    if ~isnan(freq_1)
        start_num = 1;
        end_num = length(freq_1);
        theta_1(start_num:end_num) = freq_1;

        size_array(start_num:end_num) = source_size((1.4 <= source_freq) & (source_freq <= 1.58));
        size_err_array(start_num:end_num) = source_size_err((1.4 <= source_freq) & (source_freq <= 1.58));
        epoch_array(start_num:end_num) = source_epoch((1.4 <= source_freq) & (source_freq <= 1.58));
    end

    if ~isnan(freq_2)
        start_num = length(freq_1)+1;
        end_num = length([freq_1; freq_2]);
        theta_2(start_num:end_num) = freq_2;

        size_array(start_num:end_num) = source_size((2.22 <= source_freq) & (source_freq <= 2.32));
        size_err_array(start_num:end_num) = source_size_err((2.22 <= source_freq) & (source_freq <= 2.32));
        epoch_array(start_num:end_num) = source_epoch((2.22 <= source_freq) & (source_freq <= 2.32));
    end

    if ~isnan(freq_3)
        start_num = length([freq_1; freq_2])+1;
        end_num = length([freq_1; freq_2; freq_3]);
        theta_3(start_num:end_num) = freq_3;

        size_array(start_num:end_num) = source_size((4.16 <= source_freq) & (source_freq <= 5.1));
        size_err_array(start_num:end_num) = source_size_err((4.16 <= source_freq) & (source_freq <= 5.1));
        epoch_array(start_num:end_num) = source_epoch((4.16 <= source_freq) & (source_freq <= 5.1));
    end

    if ~isnan(freq_4)
        start_num = length([freq_1; freq_2; freq_3])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4]);
        theta_4(start_num:end_num) = freq_4;

        size_array(start_num:end_num) = source_size((7.64 <= source_freq) & (source_freq <= 8.68));
        size_err_array(start_num:end_num) = source_size_err((7.64 <= source_freq) & (source_freq <= 8.68));
        epoch_array(start_num:end_num) = source_epoch((7.64 <= source_freq) & (source_freq <= 8.68));
    end

    if ~isnan(freq_5)
        start_num = length([freq_1; freq_2; freq_3; freq_4])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4; freq_5]);
        theta_5(start_num:end_num) = freq_5;

        size_array(start_num:end_num) = source_size((13.87 <= source_freq) & (source_freq <= 15.56));
        size_err_array(start_num:end_num) = source_size_err((13.87 <= source_freq) & (source_freq <= 15.56));
        epoch_array(start_num:end_num) = source_epoch((13.87 <= source_freq) & (source_freq <= 15.56));
    end

    if ~isnan(freq_6)
        start_num = length([freq_1; freq_2; freq_3; freq_4; freq_5])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6]);
        theta_6(start_num:end_num) = freq_6;

        size_array(start_num:end_num) = source_size((23.95 <= source_freq) & (source_freq <= 24.44));
        size_err_array(start_num:end_num) = source_size_err((23.95 <= source_freq) & (source_freq <= 24.44));
        epoch_array(start_num:end_num) = source_epoch((23.95 <= source_freq) & (source_freq <= 24.44));
    end

    if ~isnan(freq_7)
        start_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6; freq_7]);
        theta_7(start_num:end_num) = freq_7;

        size_array(start_num:end_num) = source_size((43.12 <= source_freq) & (source_freq <= 43.85));
        size_err_array(start_num:end_num) = source_size_err((43.12 <= source_freq) & (source_freq <= 43.85));
        epoch_array(start_num:end_num) = source_epoch((43.12 <= source_freq) & (source_freq <= 43.85));
    end

    if ~isnan(freq_8)
        start_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6; freq_7])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6; freq_7; freq_8]);
        theta_8(start_num:end_num) = freq_8;
        
        size_array(start_num:end_num) = source_size((86.25 <= source_freq) & (source_freq <= 86.30));
        size_err_array(start_num:end_num) = source_size_err((86.25 <= source_freq) & (source_freq <= 86.30));
        epoch_array(start_num:end_num) = source_epoch((86.25 <= source_freq) & (source_freq <= 86.30));
    end

    source_b = b(aa(bb));
    source_l = l(aa(bb));

    for k = 1: length(source_name)
         save_table(m,:) = table(string(source_name(k)), theta_1(k), theta_2(k), theta_3(k), theta_4(k), ...
             theta_5(k), theta_6(k), theta_7(k), theta_8(k), size_array(k), size_err_array(k), ...
             epoch_array(k), source_b(k), source_l(k));

        m = m+1 
    end
    if ~isnan(freq_2)
        start_num = length(freq_1)+1;
        end_num = length([freq_1; freq_2]);
        theta_2(start_num:end_num) = freq_2;

        size_array(start_num:end_num) = source_size((2.22 <= source_freq) & (source_freq <= 2.32));
        size_err_array(start_num:end_num) = source_size_err((2.22 <= source_freq) & (source_freq <= 2.32));
        epoch_array(start_num:end_num) = source_epoch((2.22 <= source_freq) & (source_freq <= 2.32));
    end

    if ~isnan(freq_3)
        start_num = length([freq_1; freq_2])+1;
        end_num = length([freq_1; freq_2; freq_3]);
        theta_3(start_num:end_num) = freq_3;

        size_array(start_num:end_num) = source_size((4.16 <= source_freq) & (source_freq <= 5.1));
        size_err_array(start_num:end_num) = source_size_err((4.16 <= source_freq) & (source_freq <= 5.1));
        epoch_array(start_num:end_num) = source_epoch((4.16 <= source_freq) & (source_freq <= 5.1));
    end

    if ~isnan(freq_4)
        start_num = length([freq_1; freq_2; freq_3])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4]);
        theta_4(start_num:end_num) = freq_4;

        size_array(start_num:end_num) = source_size((7.64 <= source_freq) & (source_freq <= 8.68));
        size_err_array(start_num:end_num) = source_size_err((7.64 <= source_freq) & (source_freq <= 8.68));
        epoch_array(start_num:end_num) = source_epoch((7.64 <= source_freq) & (source_freq <= 8.68));
    end

    if ~isnan(freq_5)
        start_num = length([freq_1; freq_2; freq_3; freq_4])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4; freq_5]);
        theta_5(start_num:end_num) = freq_5;

        size_array(start_num:end_num) = source_size((13.87 <= source_freq) & (source_freq <= 15.56));
        size_err_array(start_num:end_num) = source_size_err((13.87 <= source_freq) & (source_freq <= 15.56));
        epoch_array(start_num:end_num) = source_epoch((13.87 <= source_freq) & (source_freq <= 15.56));
    end

    if ~isnan(freq_6)
        start_num = length([freq_1; freq_2; freq_3; freq_4; freq_5])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6]);
        theta_6(start_num:end_num) = freq_6;

        size_array(start_num:end_num) = source_size((23.95 <= source_freq) & (source_freq <= 24.44));
        size_err_array(start_num:end_num) = source_size_err((23.95 <= source_freq) & (source_freq <= 24.44));
        epoch_array(start_num:end_num) = source_epoch((23.95 <= source_freq) & (source_freq <= 24.44));
    end

    if ~isnan(freq_7)
        start_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6; freq_7]);
        theta_7(start_num:end_num) = freq_7;

        size_array(start_num:end_num) = source_size((43.12 <= source_freq) & (source_freq <= 43.85));
        size_err_array(start_num:end_num) = source_size_err((43.12 <= source_freq) & (source_freq <= 43.85));
        epoch_array(start_num:end_num) = source_epoch((43.12 <= source_freq) & (source_freq <= 43.85));
    end

    if ~isnan(freq_8)
        start_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6; freq_7])+1;
        end_num = length([freq_1; freq_2; freq_3; freq_4; freq_5; freq_6; freq_7; freq_8]);
        theta_8(start_num:end_num) = freq_8;
        
        size_array(start_num:end_num) = source_size((86.25 <= source_freq) & (source_freq <= 86.30));
        size_err_array(start_num:end_num) = source_size_err((86.25 <= source_freq) & (source_freq <= 86.30));
        epoch_array(start_num:end_num) = source_epoch((86.25 <= source_freq) & (source_freq <= 86.30));
    end

    source_b = b(aa(bb));
    source_l = l(aa(bb));

    for k = 1: length(source_name)
         save_table(m,:) = table(string(source_name(k)), theta_1(k), theta_2(k), theta_3(k), theta_4(k), ...
             theta_5(k), theta_6(k), theta_7(k), theta_8(k), size_array(k), size_err_array(k), ...
             epoch_array(k), source_b(k), source_l(k));

        m = m+1 
    end

end

%%
filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published_arrange.csv'); 
fileID = fopen(filename,'w');

writetable(save_table, filename);

fclose(fileID);



















