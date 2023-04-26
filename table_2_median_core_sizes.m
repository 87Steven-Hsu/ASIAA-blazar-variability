%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calculate medain core size of each band of every sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% read Table 2 file arranged and with z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Table2 = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published with z.csv'); 
fid = fopen(Table2);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %s %f %f %f','delimiter',','); 
fclose(fid); 

name = string( Table{1} );  %% size( Source{1} ) = 105357
freq1 = Table{2} ;
freq2 = Table{3} ;
freq3 = Table{4} ;
freq4 = Table{5} ;
freq5 = Table{6} ;
freq6 = Table{7} ;
freq7 = Table{8} ;
freq8 = Table{9} ;
size = Table{10} ;
size_err = Table{11} ;
gala_b = Table{13} ;
gala_l = Table{14} ; 
z = Table{15} ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% find core size whcih err is less than 50% of core size, and extract MEDIAN  value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
unique_name = unique(name);   % length = 5086

for i = 1:5086   % 5086

    index = find(name == unique_name(i));
    disp(string(i)+ ', source name = '+string(unique_name(i)))

    if any(freq2(index))

        not_nan = find(~isnan(freq1(index)));

        size_1 = size(index(not_nan));
        size_err_1 = size_err(index(not_nan));

        select_index = find( (size_1./size_err_1)>2 );

        chose_size_1 = size_1(select_index);
        chose_size_err_1 = size_err_1(select_index);
        
        median_size_1(i) = nanmedian(chose_size_1);
        median_size_err_1(i) = nanmedian(chose_size_err_1);

    else
        median_size_1(i) = NaN;
        median_size_err_1(i) = NaN;
    end

    if any(freq2(index))

        not_nan = find(~isnan(freq2(index)));

        size_2 = size(index(not_nan));
        size_err_2 = size_err(index(not_nan));

        select_index = find( (size_2./size_err_2)>2 );

        chose_size_2 = size_2(select_index);
        chose_size_err_2 = size_err_2(select_index);
        
        median_size_2(i) = nanmedian(chose_size_2);
        median_size_err_2(i) = nanmedian(chose_size_err_2);

    else
        median_size_2(i) = NaN;
        median_size_err_2(i) = NaN;
    end
    
    if any(freq3(index)) 

        not_nan = find(~isnan(freq3(index)));

        size_3 = size(index(not_nan));
        size_err_3 = size_err(index(not_nan));

        select_index = find( (size_3./size_err_3)>2 );

        chose_size_3 = size_3(select_index);
        chose_size_err_3 = size_err_3(select_index);
        
        median_size_3(i) = nanmedian(chose_size_3);
        median_size_err_3(i) = nanmedian(chose_size_err_3);

    else
        median_size_3(i) = NaN;
        median_size_err_3(i) = NaN;
    end

    if any(freq4(index)) 

        not_nan = find(~isnan(freq4(index)));

        size_4 = size(index(not_nan));
        size_err_4 = size_err(index(not_nan));

        select_index = find( (size_4./size_err_4)>2 );

        chose_size_4 = size_4(select_index);
        chose_size_err_4 = size_err_4(select_index);
        
        median_size_4(i) = nanmedian(chose_size_4);
        median_size_err_4(i) = nanmedian(chose_size_err_4);

    else
        median_size_4(i) = NaN;
        median_size_err_4(i) = NaN;
    end

    if any(freq5(index)) 

        not_nan = find(~isnan(freq5(index)));

        size_5 = size(index(not_nan));
        size_err_5 = size_err(index(not_nan));

        select_index = find( (size_5./size_err_5)>2 );

        chose_size_5 = size_5(select_index);
        chose_size_err_5 = size_err_5(select_index);
        
        median_size_5(i) = nanmedian(chose_size_5);
        median_size_err_5(i) = nanmedian(chose_size_err_5);

    else
        median_size_5(i) = NaN;
        median_size_err_5(i) = NaN;
    end

    if any(freq6(index)) 

        not_nan = find(~isnan(freq6(index)));

        size_6 = size(index(not_nan));
        size_err_6 = size_err(index(not_nan));

        select_index = find( (size_6./size_err_6)>2 );

        chose_size_6 = size_6(select_index);
        chose_size_err_6 = size_err_6(select_index);
        
        median_size_6(i) = nanmedian(chose_size_6);
        median_size_err_6(i) = nanmedian(chose_size_err_6);

    else
        median_size_6(i) = NaN;
        median_size_err_6(i) = NaN;
    end

    if any(freq7(index)) 

        not_nan = find(~isnan(freq7(index)));

        size_7 = size(index(not_nan));
        size_err_7 = size_err(index(not_nan));

        select_index = find( (size_7./size_err_7)>2 );

        chose_size_7 = size_7(select_index);
        chose_size_err_7 = size_err_7(select_index);
        
        median_size_7(i) = nanmedian(chose_size_7);
        median_size_err_7(i) = nanmedian(chose_size_err_7);

    else
        median_size_7(i) = NaN;
        median_size_err_7(i) = NaN;
    end

    if any(freq8(index)) 

        not_nan = find(~isnan(freq8(index)));

        size_8 = size(index(not_nan));
        size_err_8 = size_err(index(not_nan));

        select_index = find( (size_8./size_err_8)>2 );

        chose_size_8 = size_8(select_index);
        chose_size_err_8 = size_err_8(select_index);
        
        median_size_8(i) = nanmedian(chose_size_8);
        median_size_err_8(i) = nanmedian(chose_size_err_8);

    else
        median_size_8(i) = NaN;
        median_size_err_8(i) = NaN;
    end

    save_table(i,:) = table(string(unique_name(i)), median_size_1(i), median_size_err_1(i), ...
        median_size_2(i), median_size_err_2(i), median_size_3(i), median_size_err_3(i), ...
        median_size_4(i), median_size_err_4(i), median_size_5(i), median_size_err_5(i), ...
        median_size_6(i), median_size_err_6(i), median_size_7(i), median_size_err_7(i), ...
        median_size_8(i), median_size_err_8(i), gala_b(index(1)), gala_l(index(1)), ...
        z(index(1)));

end

%% save MEDIAN core size file 
filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published_median.csv'); 
fileID = fopen(filename,'w');

writetable(save_table, filename);

fclose(fileID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% find core size whcih err is less than 50% of core size, and extract MEAN value 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
unique_name = unique(name);   % length = 5086

for i = 1:5086   % 5086

    index = find(name == unique_name(i));
    disp(string(i)+ ', source name = '+string(unique_name(i)))

    if any(freq2(index))

        not_nan = find(~isnan(freq1(index)));

        size_1 = size(index(not_nan));
        size_err_1 = size_err(index(not_nan));

        select_index = find( (size_1./size_err_1)>2 );

        chose_size_1 = size_1(select_index);
        chose_size_err_1 = size_err_1(select_index);
        
        mean_size_1(i) = nanmean(chose_size_1);
        %median_size_err_1(i) = nanmean(chose_size_err_1);

    else
        mean_size_1(i) = NaN;
        %median_size_err_1(i) = NaN;
    end

    if any(freq2(index))

        not_nan = find(~isnan(freq2(index)));

        size_2 = size(index(not_nan));
        size_err_2 = size_err(index(not_nan));

        select_index = find( (size_2./size_err_2)>2 );

        chose_size_2 = size_2(select_index);
        chose_size_err_2 = size_err_2(select_index);
        
        mean_size_2(i) = nanmean(chose_size_2);
        %median_size_err_2(i) = nanmedian(chose_size_err_2);

    else
        mean_size_2(i) = NaN;
        %median_size_err_2(i) = NaN;
    end
    
    if any(freq3(index)) 

        not_nan = find(~isnan(freq3(index)));

        size_3 = size(index(not_nan));
        size_err_3 = size_err(index(not_nan));

        select_index = find( (size_3./size_err_3)>2 );

        chose_size_3 = size_3(select_index);
        chose_size_err_3 = size_err_3(select_index);
        
        mean_size_3(i) = nanmean(chose_size_3);
        %median_size_err_3(i) = nanmedian(chose_size_err_3);

    else
        mean_size_3(i) = NaN;
        %median_size_err_3(i) = NaN;
    end

    if any(freq4(index)) 

        not_nan = find(~isnan(freq4(index)));

        size_4 = size(index(not_nan));
        size_err_4 = size_err(index(not_nan));

        select_index = find( (size_4./size_err_4)>2 );

        chose_size_4 = size_4(select_index);
        chose_size_err_4 = size_err_4(select_index);
        
        mean_size_4(i) = nanmean(chose_size_4);
        %median_size_err_4(i) = nanmedian(chose_size_err_4);

    else
        mean_size_4(i) = NaN;
        %median_size_err_4(i) = NaN;
    end

    if any(freq5(index)) 

        not_nan = find(~isnan(freq5(index)));

        size_5 = size(index(not_nan));
        size_err_5 = size_err(index(not_nan));

        select_index = find( (size_5./size_err_5)>2 );

        chose_size_5 = size_5(select_index);
        chose_size_err_5 = size_err_5(select_index);
        
        mean_size_5(i) = nanmean(chose_size_5);
        %median_size_err_5(i) = nanmedian(chose_size_err_5);

    else
        mean_size_5(i) = NaN;
        %median_size_err_5(i) = NaN;
    end

    if any(freq6(index)) 

        not_nan = find(~isnan(freq6(index)));

        size_6 = size(index(not_nan));
        size_err_6 = size_err(index(not_nan));

        select_index = find( (size_6./size_err_6)>2 );

        chose_size_6 = size_6(select_index);
        chose_size_err_6 = size_err_6(select_index);
        
        mean_size_6(i) = nanmean(chose_size_6);
        %median_size_err_6(i) = nanmedian(chose_size_err_6);

    else
        mean_size_6(i) = NaN;
        %median_size_err_6(i) = NaN;
    end

    if any(freq7(index)) 

        not_nan = find(~isnan(freq7(index)));

        size_7 = size(index(not_nan));
        size_err_7 = size_err(index(not_nan));

        select_index = find( (size_7./size_err_7)>2 );

        chose_size_7 = size_7(select_index);
        chose_size_err_7 = size_err_7(select_index);
        
        mean_size_7(i) = nanmean(chose_size_7);
        %median_size_err_7(i) = nanmedian(chose_size_err_7);

    else
        mean_size_7(i) = NaN;
        %median_size_err_7(i) = NaN;
    end

    if any(freq8(index)) 

        not_nan = find(~isnan(freq8(index)));

        size_8 = size(index(not_nan));
        size_err_8 = size_err(index(not_nan));

        select_index = find( (size_8./size_err_8)>2 );

        chose_size_8 = size_8(select_index);
        chose_size_err_8 = size_err_8(select_index);
        
        mean_size_8(i) = nanmean(chose_size_8);
        %median_size_err_8(i) = nanmedian(chose_size_err_8);

    else
        mean_size_8(i) = NaN;
        %median_size_err_8(i) = NaN;
    end

    save_table(i,:) = table(string(unique_name(i)), mean_size_1(i),mean_size_2(i), ...
        mean_size_3(i), mean_size_4(i), mean_size_5(i), mean_size_6(i), ...
        mean_size_7(i), mean_size_8(i), gala_b(index(1)), gala_l(index(1)), ...
        z(index(1)));

end

%% save MEAN core size file 
filename = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published_mean.csv'); 
fileID = fopen(filename,'w');

writetable(save_table, filename);

fclose(fileID)