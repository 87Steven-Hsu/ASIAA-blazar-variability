%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to cheack core size dependence with H-alpha intensity
% reference: Koryukova et al. (2022) Table 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Table2 = strcat('/Users/87steven/Downloads/Table_2_published_median_XMatch_WHAM2.csv');
% fid = fopen(Table2);  % openfile
% 
% for i = 1:1
%     fgetl(fid);  % skip header of first line
% end
% 
% Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',','); 
% fclose(fid); 
% 
% Source_name = string( Table{1} );  
% size_1 = Table{2}; 
% size_1_err = Table{3};   
% size_2 = Table{4}; 
% size_2_err = Table{5}; 
% size_5 = Table{6}; 
% size_5_err = Table{7}; 
% size_8 = Table{8}; 
% size_8_err = Table{9}; 
% size_15 = Table{10}; 
% size_15_err = Table{11};   
% size_24 = Table{12}; 
% size_24_err = Table{13}; 
% size_43 = Table{14}; 
% size_43_err = Table{15}; 
% size_86 = Table{16}; 
% size_86_err = Table{17};
% OVRO_b = Table{18}; 
% OVRO_l = Table{19};   
% z = Table{20}; 
% WHAM_l = Table{21}; 
% WHAM_b = Table{22}; 
% WHAM_int = Table{23}; 
% WHAM_inr_err = Table{24}; 
% separation = Table{25}; 


Table = strcat('/Users/87steven/Downloads/2GHz_core_size_XMatch_WHAM.csv');
fid = fopen(Table);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f','delimiter',','); 
fclose(fid); 

Source_name = string( Table{1} );  
size_2 = Table{2}; 
size_2_err = Table{3}; 
OVRO_b = Table{4}; 
OVRO_l = Table{5};   
z = Table{6}; 
WHAM_l = Table{7}; 
WHAM_b = Table{8}; 
WHAM_int = Table{9}; 
WHAM_inr_err = Table{10}; 
separation = Table{11}; 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b_interval = linspace(0, 90, 91);

for i = 1:90
    index = find( b_interval(i) <= abs(WHAM_b) & abs(WHAM_b) <= b_interval(i+1) );
    median_size2(i) = nanmedian(size_2(index)); 
    mean_size2(i) = nanmean(size_2(index)); 
    std_size2(i) = nanstd(size_2(index));

end

figure(1);
    set(gcf,'pos',[100,100,1200,800]);
    
        histogram(size_2(abs(WHAM_b) < 15),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
        hold on 
        histogram(size_2(abs(WHAM_b) > 15 ),'binwidth',0.2,'Normalization','probability') 
        hold off
        xlim([0 3])
        xlabel('\theta_{2 GHz} [mas]','FontSize', 15)
        ylabel('Count','FontSize', 15)   
        legend('0<|b|<15 deg','|b|>15 deg')
        set(gca,'FontSize',15,'LineWidth',2); 


figure(2);
    set(gcf,'pos',[100,100,1200,800]);

    plot(abs(WHAM_b),size_2,'ro','MarkerSize',6,'MarkerFaceColor','r') 
    hold on
    plot(b_interval(1:90), median_size2,'k-','LineWidth', 3) 
    plot(b_interval(1:90), mean_size2,'g-','LineWidth', 3) 
    plot([15, 15], [0.2, 999],'b--','LineWidth', 3)
    plot([10, 10], [0.2, 999],'b--','LineWidth', 3)
    hold off
    xlim([-0.1 90])   
    ylim([0.2 150])
    xlabel('|b| [deg]','FontSize', 15)   
    ylabel('\theta_{2 GHz} [mas]','FontSize', 15)   
    legend( ' ','Median', 'Mean','location','northeast','FontSize', 15)
    set(gca,'FontSize', 15,'LineWidth',2, 'Yscale', 'log'); 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lt10 = find(abs(OVRO_b) <= 10);
gt10 = find(abs(OVRO_b) > 10);

lt15 = find(abs(OVRO_b) <= 15);
gt15 = find(abs(OVRO_b) > 15);

%%% abs(b) <= 10
notnan_index_size = find( ~isnan( size_2(lt10) ));
notnan_index_int = find(~isnan( WHAM_int(lt10) ));

intersect_index = intersect(notnan_index_size, notnan_index_int);
new_size_lt10 = size_2(lt10(intersect_index))';
new_int_lt10 = WHAM_int(lt10(intersect_index));

%[low_r_lt10,low_p_lt10] = corr(new_size_lt10', new_int_lt10,'type','Kendall');

%%% abs(b) <= 15
notnan_index_size = find( ~isnan( size_2(lt15) ));  % length = 81
notnan_index_int = find(~isnan( WHAM_int(lt15) ));

intersect_index = intersect(notnan_index_size, notnan_index_int);
new_size_lt15 = size_2(lt15(intersect_index))';   % length = 71
new_int_lt15 = WHAM_int(lt15(intersect_index));

[low_r_lt15,low_p_lt15] = corr(new_size_lt15', new_int_lt15,'type','Kendall');

%%% full sample
notnan_index_size = find( ~isnan( size_2 ));  % length = 81
notnan_index_int = find(~isnan( WHAM_int ));

intersect_index = intersect(notnan_index_size, notnan_index_int);
new_size_all = size_2(intersect_index)';   % length = 71
new_int_all = WHAM_int(intersect_index);

[low_r_all,low_p_all] = corr(new_size_all', new_int_all,'type','Kendall');

figure(3);
    set(gcf,'pos',[100,100,1200,800]);

    plot(new_size_lt15, new_int_lt15, 'bo','MarkerSize',6,'MarkerFaceColor','b') 
    hold on
    plot(new_size_all, new_int_all, 'ro','MarkerSize',6,'MarkerFaceColor','r') 
    plot(new_size_lt15, new_int_lt15, 'bo','MarkerSize',6,'MarkerFaceColor','b') 
    hold off
    xlim([0.1 10])   
    ylim([0.1 300])
    xlabel('\theta_{2 GHz} [mas]','FontSize', 25)   
    ylabel('H-\alpha intensity','FontSize', 25)   
    legend( 'source |b| <= 15', 'source |b| <= 10','location','northeast','FontSize', 25)
    set(gca,'FontSize', 25,'LineWidth',2, 'Xscale', 'log', 'Yscale', 'log'); 


    %context = sprintf(['Kendall tau correlation result of |b| <= 10 with H-alpha int.:\n r = %4.2f,\n p = %6.4e'], low_r_lt10, low_p_lt10);
    %text(0.4, 200,context,'FontSize', 20)
    
    context = sprintf(['Kendall tau correlation result of |b| <= 15 with H-alpha int.:\n N = %3.f, \n r = %4.2f,\n p = %6.4e'], ...
        length(new_size_lt15), low_r_lt15, low_p_lt15);
    text(0.11, 110,context,'FontSize', 20)

    context = sprintf(['Kendall tau correlation result of full smaple with H-alpha int.:\n N = %3.f, \n r = %4.2f,\n p = %6.4e'], ...
        length(new_size_all), low_r_lt15, low_p_lt15);
    text(0.11, 30,context,'FontSize', 20)
    



























