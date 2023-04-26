%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% A code to check source number of each frequecny, which pass selection
%%% criteria (err < 50% of core sizes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

%%% read Table 2 file arranged and with z
Table2 = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/Table_2_published_arrange.csv'); 
fid = fopen(Table2);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %s %f %f','delimiter',','); 
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

%%
unique_name = unique(name);

input_freq = freq8;
notnan_index = find(~isnan(input_freq ) == 1);

notnan_name = name(notnan_index);
notnan_size = size(notnan_index);
notnan_size_err = size_err(notnan_index);

select_index = find( (notnan_size./notnan_size_err)>2 );

length(unique(notnan_name(select_index)))


aa = unique(notnan_name(select_index));



