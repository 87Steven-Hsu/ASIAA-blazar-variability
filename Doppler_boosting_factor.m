%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to do correlation test between variability timescale and amplitude
% against Liodakis et al. (2018) Table2 Doppler Boosting factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;
save_figure = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tableead data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% source size table BEFOTableE publication (source size error are not correct)
%%% contains of Table 2 (observe source size) and Table 6 (intrinsic, and scattering sources size)
data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/result_mod_Xmatch_Liodakis_2018.csv'); 
fid = fopen(data);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,['%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f' ...
    ' %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f'],'delimiter',','); 
fclose(fid); 

source_name = Table{1}'; 
foa = Table{2}'; 
fob = Table{3}'; 
Dnoise = Table{4}'; % Dobise 
fowa = Table{5}'; % aw = 2m^2 with weight
fowb = Table{6}'; % bw = tau_char with weight
fowb_upper = Table{7}';
fowb_lower = Table{8}';
D1000w = Table{9}'; % D(tau=1000) with weight   ----> calculate by Koay et al., 2011 function #5
D1000_upper = Table{10}';
D1000_lower = Table{11}';
D4 = Table{12}';
D4_upper = Table{13}';
D4_lower = Table{14}';
z = Table{15}';
beta_max = Table{16}';
beta_max_err = Table{17}';
log_Tvar = Table{18}';
log_Tvar_lower = Table{19}';
log_Tvar_upper = Table{20}';
Delta_var = Table{21}';
Delta_var_lower = Table{22}';
Delta_var_upper = Table{23}';
Gamma_var = Table{24}';
Gamma_var_min = Table{25}';
Gamma_min_max = Table{26}';
theta_var = Table{27}';
theta_var_min = Table{28}';
theta_var_max = Table{29}';
size1 = Table{30}';
size2 = Table{31}';
size5 = Table{32}';
size8 = Table{33}';
size15 = Table{34}';
size24 = Table{35}';
size43 = Table{36}';

%%% transform from log to linear
Tvar = 10.^log_Tvar;
Tvar_lower = 10.^log_Tvar_lower;
Tvar_upper = 10.^log_Tvar_upper;

%%% intrinsic timescale
tau_src = fowb./(1+z);

%%% Doppler boosting correction intrinsic timescale
tau_src_doppler = Delta_var.*fowb./(1+z);

%%% find lower linit of timescale 
eq_obs_lim = find(fob == fowb);
neq_obs_lim = find(fob ~= fowb);

%%% flag lower limit of characteristic timescale and Delta
fowb_eq_obs_lim = fowb(eq_obs_lim);
tau_src_eq_obs_lim = tau_src(eq_obs_lim);
tau_src_doppler_eq_obs_lim = tau_src_doppler(eq_obs_lim);
Delta_var_eq_obs_lim = Delta_var(eq_obs_lim);

%%% flag normal characteristic timescale and Delta
fowb_neq_obs_lim = fowb(neq_obs_lim);
tau_src_neq_obs_lim = tau_src(neq_obs_lim);
tau_src_doppler_neq_obs_lim = tau_src_doppler(neq_obs_lim);
Delta_var_neq_obs_lim = Delta_var(neq_obs_lim);

%%% linear core size calculation
rad = (1/3600)*1E-3*(pi/180);
% angualr diameter distance 
for i = 1:length(z)
    ang_dis(i) = ad_dist(z(i) ,1);
end

realsize2 = size2.*ang_dis*rad;
realsize5 = size5.*ang_dis*rad;
realsize8 = size8.*ang_dis*rad;
realsize15 = size15.*ang_dis*rad;
realsize24 = size24.*ang_dis*rad;
realsize43 = size43.*ang_dis*rad;


%% Variability Doppler Boosting Factor vs D1000

[r,p] = corr(Delta_var',D1000w','type','Spearman','rows','complete');

figure(1);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(Delta_var,D1000w,'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    errorbar(Delta_var,D1000w, D1000w-D1000_lower,D1000_upper-D1000w,'ro','MarkerSize',7,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([min(Delta_var)*0.5 max(Delta_var)*3]) 
    ylim([min(D1000w)*0.8 max(D1000w)*1.2])  
    xlabel('\delta_{var}','FontSize', 20) 
    ylabel('SF Amplitude D(1000d)','FontSize', 20) 
    set(gca,'XScale', 'log', 'YScale', 'log', 'FontSize', 20, 'LineWidth', 2); 

    context = sprintf(['Sample number = %1.0f,\nSpearman correlation result:\n r = %4.2f,\n p = %6.4e'], length(Delta_var), r, p);
    text(0.1, 1, context,'FontSize', 25)

%% Variability Doppler Boosting Factor vs tau_char

[r,p] = corr(Delta_var_neq_obs_lim', fowb_neq_obs_lim','type','Spearman','rows','complete');

figure(2);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(Delta_var_neq_obs_lim, fowb_neq_obs_lim,'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    %errorbar(Delta_var, fowb, fowb-fowb_lower,fowb_upper-fowb,'ro','MarkerSize',7,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(Delta_var_eq_obs_lim, fowb_eq_obs_lim,'g^','MarkerSize',7,'MarkerFaceColor','g') 
    hold off
    xlim([min(Delta_var)*0.5 max(Delta_var)*1]) 
    ylim([min(fowb)*0.8 max(fowb)*2])  
    xlabel('\delta_{var}','FontSize', 20) 
    ylabel('Characteristic Timescale \tau_{char} (days)','FontSize', 20) 
    set(gca,'XScale', 'log', 'YScale', 'log', 'FontSize', 20, 'LineWidth', 2); 

    context = sprintf(['Sample number = %1.0f,\nSpearman correlation result:\n r = %4.2f,\n p = %6.4e'], length(Delta_var_neq_obs_lim), r, p);
    text(0.1, 3000, context,'FontSize', 25)

%% Variability Doppler Boosting Factor vs tau_src

[r,p] = corr(Delta_var_neq_obs_lim', tau_src_neq_obs_lim','type','Spearman','rows','complete');

figure(3);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(Delta_var_neq_obs_lim, tau_src_neq_obs_lim,'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    %errorbar(Delta_var, fowb, fowb-fowb_lower,fowb_upper-fowb,'ro','MarkerSize',7,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(Delta_var_eq_obs_lim, tau_src_eq_obs_lim,'g^','MarkerSize',7,'MarkerFaceColor','g') 
    hold off
    xlim([min(Delta_var)*0.5 max(Delta_var)*1]) 
    ylim([min(tau_src)*0.8 max(tau_src)*2])  
    xlabel('\delta_{var}','FontSize', 20) 
    ylabel('Intrinsic Timescale \tau_{src} (days)','FontSize', 20) 
    set(gca,'XScale', 'log', 'YScale', 'log', 'FontSize', 20, 'LineWidth', 2); 

    context = sprintf(['Sample number = %1.0f,\nSpearman correlation result:\n r = %4.2f,\n p = %6.4e'], length(Delta_var_neq_obs_lim), r, p);
    text(0.1, 3000, context,'FontSize', 25)

%% Variability Doppler Boosting Factor vs tau_src

[r,p] = corr(Delta_var_neq_obs_lim', tau_src_neq_obs_lim','type','Spearman','rows','complete');

figure(4);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(Delta_var_neq_obs_lim, tau_src_neq_obs_lim,'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    %errorbar(Delta_var, fowb, fowb-fowb_lower,fowb_upper-fowb,'ro','MarkerSize',7,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(Delta_var_eq_obs_lim, tau_src_eq_obs_lim,'g^','MarkerSize',7,'MarkerFaceColor','g') 
    hold off
    xlim([min(Delta_var)*0.8 max(Delta_var)*1.2]) 
    ylim([min(tau_src)*0.8 max(tau_src)*10])  
    xlabel('\delta_{var}','FontSize', 20) 
    ylabel('Intrinsic Timescale \tau_{src} [days]','FontSize', 20) 
    set(gca,'XScale', 'log', 'YScale', 'log', 'FontSize', 20, 'LineWidth', 2); 

    context = sprintf(['Sample number = %1.0f,\nSpearman correlation result:\n r = %4.2f,\n p = %6.4e'], length(Delta_var_neq_obs_lim), r, p);
    text(0.2, 9000, context,'FontSize', 25)
    
    
%% Variability Doppler Boosting Factor vs Doppler boosting correction tau_src

[r,p] = corr(Delta_var_neq_obs_lim', tau_src_doppler_neq_obs_lim','type','Spearman','rows','complete');

figure(4);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(Delta_var_neq_obs_lim, tau_src_doppler_neq_obs_lim,'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    %errorbar(Delta_var, fowb, fowb-fowb_lower,fowb_upper-fowb,'ro','MarkerSize',7,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(Delta_var_eq_obs_lim, tau_src_doppler_eq_obs_lim,'g^','MarkerSize',7,'MarkerFaceColor','g') 
    hold off
    xlim([min(Delta_var)*0.8 max(Delta_var)*1.2]) 
    ylim([min(tau_src_doppler)*0.8 max(tau_src_doppler)*2])  
    xlabel('\delta_{var}','FontSize', 20) 
    ylabel({'Doppler Boosting factor Corrected Intrinsic Timescale';'\tau_{src Doppler corrected} [days]'},'FontSize', 20) 
    set(gca,'XScale', 'log', 'YScale', 'log', 'FontSize', 20, 'LineWidth', 2); 

    context = sprintf(['Sample number = %1.0f,\nSpearman correlation result:\n r = %4.2f,\n p = %6.4e'], length(Delta_var_neq_obs_lim), r, p);
    text(0.2, 30000, context,'FontSize', 25)

%% Variability Doppler Boosting Factor vs angualr core sizes

figure(5);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(size2(~isnan(size2)), Delta_var(~isnan(size2)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(size2) 5])   
    ylim([0 max(Delta_var(~isnan(size2)))]) 
    xlabel('\theta_{2 GHz} (mas)','FontSize', 20)
    ylabel('\delta_{var}','FontSize', 20)   
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(size5(~isnan(size5)), Delta_var(~isnan(size5)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(size5) 1*max(size5)])
    ylim([0 max(Delta_var(~isnan(size5)))]) 
    xlabel('\theta_{5 GHz}  (mas)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(size8(~isnan(size8)), Delta_var(~isnan(size8)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(size8) 1*max(size8)])
    ylim([0 max(Delta_var(~isnan(size8)))]) 
    xlabel('\theta_{8 GHz}  (mas)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(size15(~isnan(size15)), Delta_var(~isnan(size15)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(size15) 1*max(size15)])
    ylim([0 max(Delta_var(~isnan(size15)))]) 
    xlabel('\theta_{15 GHz} (mas)','FontSize', 20)
    ylabel('\delta_{var}','FontSize', 20)   
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(size24(~isnan(size24)), Delta_var(~isnan(size24)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(size24) 1*max(size24)])
    ylim([0 max(Delta_var(~isnan(size24)))]) 
    xlabel('\theta_{24 GHz}  (mas)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(size43(~isnan(size43)), Delta_var(~isnan(size43)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(size43) 1*max(size43)])
    ylim([0 max(Delta_var(~isnan(size43)))]) 
    xlabel('\theta_{43 GHz}  (mas)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
% sgt = sgtitle('Compare Characteristic Timescale \tau_{char} Against Apparent Source Size in Multi-frequencies'); 
% sgt.FontSize = 20;
% sgt.LineWidth = 2;

%%% save figure in high resolution
if save_figure == 1
    fig_name = 'tau_char vs. app source size';
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[r2,p2] = corr(size2(~isnan(size2))', Delta_var(~isnan(size2))','type','Spearman','rows','complete');
[r5,p5] = corr(size5(~isnan(size5))', Delta_var(~isnan(size5))','type','Spearman','rows','complete');
[r8,p8] = corr(size8(~isnan(size8))', Delta_var(~isnan(size8))','type','Spearman','rows','complete');
[r15,p15] = corr(size15(~isnan(size15))', Delta_var(~isnan(size15))','type','Spearman','rows','complete');
[r24,p24] = corr(size24(~isnan(size24))', Delta_var(~isnan(size24))','type','Spearman','rows','complete');
[r43,p43] = corr(size43(~isnan(size43))', Delta_var(~isnan(size43))','type','Spearman','rows','complete');

deltavar_angsize_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

%% Variability Doppler Boosting Factor vs physical core sizes

figure(6);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(~isnan(realsize2)), Delta_var(~isnan(realsize2)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(realsize2) max(realsize2)*1.2])   
    ylim([0 max(Delta_var(~isnan(realsize2)))]) 
    xlabel('l_{2 GHz} (pc)','FontSize', 20)
    ylabel('\delta_{var}','FontSize', 20)   
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(~isnan(realsize5)), Delta_var(~isnan(realsize5)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(realsize5) 1*max(realsize5)])
    ylim([0 max(Delta_var(~isnan(realsize5)))]) 
    xlabel('l_{5 GHz}  (pc)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(~isnan(realsize8)), Delta_var(~isnan(realsize8)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(realsize8) 1*max(realsize8)])
    ylim([0 max(Delta_var(~isnan(realsize8)))]) 
    xlabel('l_{8 GHz}  (pc)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(~isnan(realsize15)), Delta_var(~isnan(realsize15)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(realsize15) 1*max(realsize15)])
    ylim([0 max(Delta_var(~isnan(realsize15)))]) 
    xlabel('l_{15 GHz} (pc)','FontSize', 20)
    ylabel('\delta_{var}','FontSize', 20)   
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(~isnan(realsize24)), Delta_var(~isnan(realsize24)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(realsize24) 1*max(realsize24)])
    ylim([0 max(Delta_var(~isnan(realsize24)))]) 
    xlabel('l_{24 GHz}  (pc)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(~isnan(realsize43)), Delta_var(~isnan(realsize43)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    hold off
    xlim([0.8*min(realsize43) 1*max(realsize43)])
    ylim([0 max(Delta_var(~isnan(realsize43)))]) 
    xlabel('l_{43 GHz}  (pc)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
% sgt = sgtitle('Compare Characteristic Timescale \tau_{char} Against Apparent Source Size in Multi-frequencies'); 
% sgt.FontSize = 20;
% sgt.LineWidth = 2;

%%% save figure in high resolution
if save_figure == 1
    fig_name = 'tau_char vs. app source size';
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[r2,p2] = corr(realsize2(~isnan(realsize2))', Delta_var(~isnan(realsize2))','type','Spearman','rows','complete');
[r5,p5] = corr(realsize5(~isnan(realsize5))', Delta_var(~isnan(realsize5))','type','Spearman','rows','complete');
[r8,p8] = corr(realsize8(~isnan(realsize8))', Delta_var(~isnan(realsize8))','type','Spearman','rows','complete');
[r15,p15] = corr(realsize15(~isnan(realsize15))', Delta_var(~isnan(realsize15))','type','Spearman','rows','complete');
[r24,p24] = corr(realsize24(~isnan(realsize24))', Delta_var(~isnan(realsize24))','type','Spearman','rows','complete');
[r43,p43] = corr(realsize43(~isnan(realsize43))', Delta_var(~isnan(realsize43))','type','Spearman','rows','complete');

deltavar_linearsize_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

%% Distribution of characteristic timescale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Characteristic timescale separated by the medin of Doppler boosting factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(Delta_var > nanmedian(Delta_var));
x2 = find(Delta_var < nanmedian(Delta_var));

[r,p] = kstest2(fowb(x1), fowb(x2))

figure(7) 
set(gcf,'pos',[100,100,1200,800]);
    
    histogram(log10(fowb(x1)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(fowb(x2)),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(fowb(x1))),nanmedian(log10(fowb(x1)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(fowb(x2))),nanmedian(log10(fowb(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf('\\delta_{var} > %4.f', nanmedian(Delta_var)), sprintf('\\delta_{var} < %4.f', nanmedian(Delta_var)),'location','northeast','FontSize', 20)
    xlabel('log(\tau_{char})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    %xlim([-0.4 0.5])
    ylim([0 0.25])
    set(gca,'FontSize',20,'LineWidth',3); 

    context = sprintf(['Sample number = %1.0f,\n Two sample K-S test p-value:\n p = %6.4e'], length(fowb), p);
    text(1.3, 0.2, context,'FontSize', 25)
    

if save_figure == 1
    fig_name = 'tau_char distri. linear source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%%  Doppler boosting factor separated by the medin of Characteristic timescale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(fowb > nanmedian(fowb));
x2 = find(fowb < nanmedian(fowb));

[r,p] = kstest2(Delta_var(x1), Delta_var(x2))


figure(8) 
set(gcf,'pos',[100,100,1200,800]);
    
    histogram(log10(Delta_var(x1)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(Delta_var(x2)),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(Delta_var(x1))),nanmedian(log10(Delta_var(x1)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(Delta_var(x2))),nanmedian(log10(Delta_var(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf('\\tau_{char} > %4.fd', nanmedian(fowb)), sprintf('\\tau_{char} < %4.fd', nanmedian(fowb)),'location','northeast','FontSize', 20)
    xlabel('log(\delta_{var})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    %xlim([-0.4 0.5])
    ylim([0 0.15])
    set(gca,'FontSize',20,'LineWidth',3); 

    context = sprintf(['Sample number = %1.0f,\n Two sample K-S test p-value:\n p = %6.4e'], length(fowb), p);
    text(-1, 0.13, context,'FontSize', 25)
    

if save_figure == 1
    fig_name = 'tau_char distri. linear source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end

%% Distribution of intrinsic timescale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Characteristic timescale separated by the medin of Doppler boosting factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(Delta_var > nanmedian(Delta_var));
x2 = find(Delta_var < nanmedian(Delta_var));

[r,p] = kstest2(tau_src(x1), tau_src(x2))

figure(9) 
set(gcf,'pos',[100,100,1200,800]);
    
    histogram(log10(tau_src(x1)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(tau_src(x2)),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(tau_src(x1))),nanmedian(log10(tau_src(x1)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(tau_src(x2))),nanmedian(log10(tau_src(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf('\\delta_{var} > %4.f', nanmedian(Delta_var)), sprintf('\\delta_{var} < %4.f', nanmedian(Delta_var)),'location','northeast','FontSize', 20)
    xlabel('log(\tau_{src})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    %xlim([-0.4 0.5])
    ylim([0 0.15])
    set(gca,'FontSize',20,'LineWidth',3); 

    context = sprintf(['Sample number = %1.0f,\n Two sample K-S test p-value:\n p = %6.4e'], length(fowb), p);
    text(1.2, 0.13, context,'FontSize', 25)
    

if save_figure == 1
    fig_name = 'tau_src distri. linear source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%%  Doppler boosting factor separated by the medin of Characteristic timescale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(tau_src > nanmedian(tau_src));
x2 = find(tau_src < nanmedian(tau_src));

[r,p] = kstest2(Delta_var(x1), Delta_var(x2))

figure(10) 
set(gcf,'pos',[100,100,1200,800]);
    
    histogram(log10(Delta_var(x1)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(Delta_var(x2)),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(Delta_var(x1))),nanmedian(log10(Delta_var(x1)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(Delta_var(x2))),nanmedian(log10(Delta_var(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf('\\tau_{src} > %4.fd', nanmedian(tau_src)), sprintf('\\tau_{src} < %4.fd', nanmedian(tau_src)),'location','northeast','FontSize', 20)
    xlabel('log(\delta_{var})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    %xlim([-0.4 0.5])
    ylim([0 0.15])
    set(gca,'FontSize',20,'LineWidth',3); 
    
    context = sprintf(['Sample number = %1.0f,\n Two sample K-S test p-value:\n p = %6.4e'], length(fowb), p);
    text(-0.9, 0.13, context,'FontSize', 25)
    

if save_figure == 1
    fig_name = 'tau_src distri. linear source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    

%% Distribution of Doppler boosting correction intrinsic timescale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Characteristic timescale separated by the medin of Doppler boosting factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(Delta_var > nanmedian(Delta_var));
x2 = find(Delta_var < nanmedian(Delta_var));

[r,p] = kstest2(tau_src_doppler(x1), tau_src_doppler(x2))

figure(11) 
set(gcf,'pos',[100,100,1200,800]);
    
    histogram(log10(tau_src_doppler(x1)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(tau_src_doppler(x2)),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(tau_src_doppler(x1))),nanmedian(log10(tau_src_doppler(x1)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(tau_src_doppler(x2))),nanmedian(log10(tau_src_doppler(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf('\\delta_{var} > %4.f', nanmedian(Delta_var)), sprintf('\\delta_{var} < %4.f', ...
        nanmedian(Delta_var)),'location','northeast','FontSize', 20)
    xlabel('log(\tau_{src Doppler corrected})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    %xlim([-0.4 0.5])
    ylim([0 0.15])
    set(gca,'FontSize',20,'LineWidth',3); 

    context = sprintf(['Sample number = %1.0f,\n Two sample K-S test p-value:\n p = %6.4e'], length(tau_src_doppler), p);
    text(1.7, 0.13, context,'FontSize', 25)
    

if save_figure == 1
    fig_name = 'tau_src_doppler distri. linear source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%%  Doppler boosting factor separated by the medin of Characteristic timescale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(tau_src_doppler > nanmedian(tau_src_doppler));
x2 = find(tau_src_doppler < nanmedian(tau_src_doppler));

[r,p] = kstest2(Delta_var(x1), Delta_var(x2))

figure(12) 
set(gcf,'pos',[100,100,1200,800]);
    
    histogram(log10(Delta_var(x1)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(Delta_var(x2)),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(Delta_var(x1))),nanmedian(log10(Delta_var(x1)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(Delta_var(x2))),nanmedian(log10(Delta_var(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf('\\tau_{src Doppler corrected} > %4.fd', nanmedian(tau_src_doppler)), sprintf('\\tau_{src Doppler corrected} < %4.fd', ...
        nanmedian(tau_src_doppler)),'location','northeast','FontSize', 20)
    xlabel('log(\delta_{var})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    %xlim([-0.4 0.5])
    ylim([0 0.15])
    set(gca,'FontSize',20,'LineWidth',3); 

    context = sprintf(['Sample number = %1.0f,\n Two sample K-S test p-value:\n p = %6.4e'], length(tau_src_doppler), p);
    text(-1, 0.13, context,'FontSize', 25)
    

if save_figure == 1
    fig_name = 'tau_src distri. linear source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% intrinsic timescale (fow src) vs linear size 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index2 = ~isnan(realsize2);
index5 = ~isnan(realsize5);
index8 = ~isnan(realsize8);
index15 = ~isnan(realsize15);
index24 = ~isnan(realsize24);
index43 = ~isnan(realsize43);

figure(14);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(index2),tau_src_doppler(index2),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    plot(realsize2(eq_obs_lim),tau_src_doppler(eq_obs_lim),'g^','MarkerSize',6,'MarkerFaceColor','g') 
    hold off
    xlim([min(realsize2(index2))*0.5 max(realsize2(index2))*2])
    ylim([min(tau_src_doppler(index2))*0.5 max(tau_src_doppler(index2))*5])   
    xlabel('l_{2 GHz}  (pc)','FontSize', 20)
    ylabel('\tau_{src} (days)','FontSize', 20)  
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(index5),tau_src_doppler(index5),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    plot(realsize5(eq_obs_lim),tau_src_doppler(eq_obs_lim),'g^','MarkerSize',6,'MarkerFaceColor','g') 
    hold off
    xlim([min(realsize5(index5))*0.5 max(realsize5(index5))*2])
    ylim([min(tau_src_doppler(index5))*0.5 max(tau_src_doppler(index5))*5])  
    xlabel('l_{5 GHz} (pc)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(index8),tau_src_doppler(index8),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    plot(realsize8(eq_obs_lim),tau_src_doppler(eq_obs_lim),'g^','MarkerSize',6,'MarkerFaceColor','g') 
    hold off
    xlim([min(realsize8(index8))*0.5 max(realsize8(index8))*2])
    ylim([min(tau_src_doppler(index8))*0.5 max(tau_src_doppler(index8))*5]) 
    xlabel('l_{8 GHz} (pc)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(index15),tau_src_doppler(index15),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    plot(realsize15(eq_obs_lim),tau_src_doppler(eq_obs_lim),'g^','MarkerSize',6,'MarkerFaceColor','g') 
    hold off
    xlim([min(realsize15(index15))*0.5 max(realsize15(index15))*2])
    ylim([min(tau_src_doppler(index15))*0.5 max(tau_src_doppler(index15))*5]) 
    xlabel('l_{15 GHz} (pc)','FontSize', 20)
    ylabel('\tau_{src} (days)','FontSize', 20)  
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(index24),tau_src_doppler(index24),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    plot(realsize24(eq_obs_lim),tau_src_doppler(eq_obs_lim),'g^','MarkerSize',6,'MarkerFaceColor','g') 
    hold off
    xlim([min(realsize24(index24))*0.5 max(realsize24(index24))*2])
    ylim([min(tau_src_doppler(index24))*0.5 max(tau_src_doppler(index24))*5]) 
    xlabel('l_{24 GHz} (pc)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(index43),tau_src_doppler(index43),'ro','MarkerSize',7,'MarkerFaceColor','r')  
    hold on 
    plot(realsize43(eq_obs_lim),tau_src_doppler(eq_obs_lim),'g^','MarkerSize',6,'MarkerFaceColor','g') 
    hold off
    xlim([min(realsize43(index43))*0.5 max(realsize43(index43))*2])
    ylim([min(tau_src_doppler(index43))*0.5 max(tau_src_doppler(index43))*5]) 
    xlabel('l_{43 GHz} (pc)','FontSize', 20)
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
% sgt = sgtitle('Compare Intrinsic Timescale \tau_{src} Against Actual Source Size in Multi-frequencies'); 
% sgt.FontSize = 20;
% sgt.LineWidth = 2;
% 
% if save_figure == 1
%     fig_name = 'tau_src vs linear core sizes';    
%     save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
%     print(gcf,save_path,'-dpng','-r400')
% end
times = 500;
[r2,p2]= corr(realsize2(index2)',tau_src_doppler(index2)','type','Spearman','rows','complete');
r2_err = Spearman_boostrap_error(realsize2(index2),tau_src_doppler(index2), times);
[r5,p5] = corr(realsize5(index5)',tau_src_doppler(index5)','type','Spearman','rows','complete');
r5_err = Spearman_boostrap_error(realsize5(index5),tau_src_doppler(index5), times);
[r8,p8] = corr(realsize8(index8)',tau_src_doppler(index8)','type','Spearman','rows','complete');
r8_err = Spearman_boostrap_error(realsize8(index8),tau_src_doppler(index8), times);
[r15,p15] = corr(realsize15(index15)',tau_src_doppler(index15)','type','Spearman','rows','complete');
r15_err = Spearman_boostrap_error(realsize15(index15),tau_src_doppler(index15), times);
[r24,p24] = corr(realsize24(index24)',tau_src_doppler(index24)','type','Spearman','rows','complete'); 
r24_err = Spearman_boostrap_error(realsize24(index24),tau_src_doppler(index24), times);
[r43,p43] = corr(realsize43(index43)',tau_src_doppler(index43)','type','Spearman','rows','complete');
r43_err = Spearman_boostrap_error(realsize43(index43),tau_src_doppler(index43), times);
    
fowbsrc_actsz_corr = [[r2,r2_err,p2];[r5,r5_err,p5];[r8,r8_err,p8];[r15,r15_err,p15];[r24,r24_err,p24];[r43,r43_err,p43]]; 

figure(15);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(neq_obs_lim),tau_src_doppler(neq_obs_lim),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlim([min(realsize2(index2))*0.5 max(realsize2(index2))*2])
    ylim([min(tau_src_doppler(index2))*0.5 max(tau_src_doppler(index2))*5])   
    xlabel('l_{2 GHz}  (pc)','FontSize', 20)
    ylabel('\tau_{src} (days)','FontSize', 20)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(neq_obs_lim),tau_src_doppler(neq_obs_lim),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlim([min(realsize5(index5))*0.5 max(realsize5(index5))*2])
    ylim([min(tau_src_doppler(index5))*0.5 max(tau_src_doppler(index5))*5])  
    xlabel('l_{5 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(neq_obs_lim),tau_src_doppler(neq_obs_lim),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlim([min(realsize8(index8))*0.5 max(realsize8(index8))*2])
    ylim([min(tau_src_doppler(index8))*0.5 max(tau_src_doppler(index8))*5]) 
    xlabel('l_{8 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 

    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(neq_obs_lim),tau_src_doppler(neq_obs_lim),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlim([min(realsize15(index15))*0.5 max(realsize15(index15))*2])
    ylim([min(tau_src_doppler(index15))*0.5 max(tau_src_doppler(index15))*5]) 
    xlabel('l_{15 GHz} (pc)','FontSize', 20)
    ylabel('\tau_{src} (days)','FontSize', 20)  
        set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(neq_obs_lim),tau_src_doppler(neq_obs_lim),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlim([min(realsize24(index24))*0.5 max(realsize24(index24))*2])
    ylim([min(tau_src_doppler(index24))*0.5 max(tau_src_doppler(index24))*5]) 
    xlabel('l_{24 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(neq_obs_lim),tau_src_doppler(neq_obs_lim),'ro','MarkerSize',7,'MarkerFaceColor','r')  
    xlim([min(realsize43(index43))*0.5 max(realsize43(index43))*2])
    ylim([min(tau_src_doppler(index43))*0.5 max(tau_src_doppler(index43))*5]) 
    xlabel('l_{43 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2,'TickLength',[0.03, 0.02]); 


times = 500;
[r2,p2]= corr(realsize2(neq_obs_lim)',tau_src_doppler(neq_obs_lim)','type','Spearman','rows','complete');
r2_err = Spearman_boostrap_error(realsize2(neq_obs_lim),tau_src_doppler(neq_obs_lim), times);
[r5,p5] = corr(realsize5(neq_obs_lim)',tau_src_doppler(neq_obs_lim)','type','Spearman','rows','complete');
r5_err = Spearman_boostrap_error(realsize5(neq_obs_lim),tau_src_doppler(neq_obs_lim), times);
[r8,p8] = corr(realsize8(neq_obs_lim)',tau_src_doppler(neq_obs_lim)','type','Spearman','rows','complete');
r8_err = Spearman_boostrap_error(realsize8(neq_obs_lim),tau_src_doppler(neq_obs_lim), times);
[r15,p15] = corr(realsize15(neq_obs_lim)',tau_src_doppler(neq_obs_lim)','type','Spearman','rows','complete');
r15_err = Spearman_boostrap_error(realsize15(neq_obs_lim),tau_src_doppler(neq_obs_lim), times);
[r24,p24] = corr(realsize24(neq_obs_lim)',tau_src_doppler(neq_obs_lim)','type','Spearman','rows','complete'); 
r24_err = Spearman_boostrap_error(realsize24(neq_obs_lim),tau_src_doppler(neq_obs_lim), times);
[r43,p43] = corr(realsize43(neq_obs_lim)',tau_src_doppler(neq_obs_lim)','type','Spearman','rows','complete');
r43_err = Spearman_boostrap_error(realsize43(neq_obs_lim),tau_src_doppler(neq_obs_lim), times);
    
fowbsrc_actsz_corr_redpoints = [[r2,r2_err,p2];[r5,r5_err,p5];[r8,r8_err,p8];[r15,r15_err,p15];[r24,r24_err,p24];[r43,r43_err,p43]]; 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Intrinsic timescale vs Linear core size KS-Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_figure = 1;

index2 = find(~isnan(realsize2) == 1);
fowbsrc2 = tau_src_doppler(index2);
index5 = find(~isnan(realsize5) == 1);
fowbsrc5 = tau_src_doppler(index5);
index8 = find(~isnan(realsize8) == 1);
fowbsrc8 = tau_src_doppler(index8);
index15 = find(~isnan(realsize15) == 1);
fowbsrc15 = tau_src_doppler(index15);
index24 = find(~isnan(realsize24) == 1);
fowbsrc24 = tau_src_doppler(index24);
index43 = find(~isnan(realsize43) == 1);
fowbsrc43 = tau_src_doppler(index43);

x1 = find(fowbsrc2 > nanmedian(fowbsrc2));
x2 = find(fowbsrc2 < nanmedian(fowbsrc2));
x3 = find(fowbsrc5 > nanmedian(fowbsrc5));
x4 = find(fowbsrc5 < nanmedian(fowbsrc5));
x5 = find(fowbsrc8 > nanmedian(fowbsrc8));
x6 = find(fowbsrc8 < nanmedian(fowbsrc8));
x7 = find(fowbsrc15 > nanmedian(fowbsrc15));
x8 = find(fowbsrc15 < nanmedian(fowbsrc15));
x9 = find(fowbsrc24 > nanmedian(fowbsrc24));
x10 = find(fowbsrc24 < nanmedian(fowbsrc24));
x11 = find(fowbsrc43 > nanmedian(fowbsrc43));
x12 = find(fowbsrc43 < nanmedian(fowbsrc43));

figure(16) 
set(gcf,'pos',[100,100,1350,900]);
    
    subplot('position',[0.06,0.55,0.28,0.36])
    histogram(log10(realsize2(index2(x1))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize2(index2(x2))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(realsize2(index2(x1)))),nanmedian(log10(realsize2(index2(x1))))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(realsize2(index2(x2)))),nanmedian(log10(realsize2(index2(x2))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc2)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc2)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',2)
    xlabel('log(l_{2 GHz})','FontSize', 25) 
    ylabel('Normalized Frequency','FontSize', 25)
    xlim([0 1.5])
    ylim([0 0.3])
    
    subplot('position',[0.38,0.55,0.28,0.36])
    histogram(log10(realsize5(index5(x3))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize5(index5(x4))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(realsize5(index5(x3)))),nanmedian(log10(realsize5(index5(x3))))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(realsize5(index5(x4)))),nanmedian(log10(realsize5(index5(x4))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc5)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc5)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',2)
    xlabel('log(l_{5 GHz})','FontSize', 25) 
    xlim([-0.1 1.2])
    ylim([0 0.3])

    subplot('position',[0.70,0.55,0.28,0.36])
    histogram(log10(realsize8(index8(x5))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize8(index8(x6))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(realsize8(index8(x5)))),nanmedian(log10(realsize8(index8(x5))))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(realsize8(index8(x6)))),nanmedian(log10(realsize8(index8(x6))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc8)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc8)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',2)
    xlabel('log(l_{8 GHz})','FontSize', 25) 
    xlim([-0.4 0.8])
    ylim([0 0.3])
    
    subplot('position',[0.06,0.1,0.28,0.36])
    histogram(log10(realsize15(index15(x7))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize15(index15(x8))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(realsize15(index15(x7)))),nanmedian(log10(realsize15(index15(x7))))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(realsize15(index15(x8)))),nanmedian(log10(realsize15(index15(x8))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc15)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc15)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',2)
    xlabel('log(l_{15 GHz})','FontSize', 25) 
    ylabel('Normalized Frequency','FontSize', 25)
    xlim([-0.6 0.6])
    ylim([0 0.3])

    subplot('position',[0.38,0.1,0.28,0.36])
    histogram(log10(realsize24(index24(x9))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize24(index24(x10))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(realsize24(index24(x9)))),nanmedian(log10(realsize24(index24(x9))))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(realsize24(index24(x10)))),nanmedian(log10(realsize24(index24(x10))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc24)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc24)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',2)
    xlabel('log(l_{24 GHz})','FontSize', 25) 
    xlim([-0.7 0.4])
    ylim([0 0.3])
    
    subplot('position',[0.70,0.1,0.28,0.36])
    histogram(log10(realsize43(index43(x11))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize43(index43(x12))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(realsize43(index43(x11)))),nanmedian(log10(realsize43(index43(x11))))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(realsize43(index43(x12)))),nanmedian(log10(realsize43(index43(x12))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc43)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc43)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',2)
    xlabel('log(l_{43 GHz})','FontSize', 25) 
    xlim([-1.2 0.3])
    ylim([0 0.3])
    
%sgt = sgtitle('Intrinsic timescale \tau_{src} Distributed by Median of Linear Source Size');
%sgt.FontSize = 20;
%sgt.LineWidth = 2;  

if save_figure == 1
    fig_name = 'tau_src doppler corrected distri. linear core size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[r2,p2] = kstest2(realsize2(index2(x1)), realsize2(index2(x2)));
[r5,p5] = kstest2(realsize5(index5(x3)), realsize5(index5(x4)));
[r8,p8] = kstest2(realsize8(index8(x5)), realsize8(index8(x6)));
[r15,p15] = kstest2(realsize15(index15(x7)), realsize15(index15(x8)));
[r24,p24] = kstest2(realsize24(index24(x9)), realsize24(index24(x10)));
[r43,p43] = kstest2(realsize43(index43(x11)), realsize43(index43(x12)));

fowbsrc_Doppler_actsz_KS = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Intrinsic timescale (redshift, Doppler factor corrected) vs angular core size KS-Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%save_figure = 1;

index2 = find(~isnan(size2) == 1);
fowbsrc2 = tau_src_doppler(index2);
index5 = find(~isnan(size5) == 1);
fowbsrc5 = tau_src_doppler(index5);
index8 = find(~isnan(size8) == 1);
fowbsrc8 = tau_src_doppler(index8);
index15 = find(~isnan(size15) == 1);
fowbsrc15 = tau_src_doppler(index15);
index24 = find(~isnan(size24) == 1);
fowbsrc24 = tau_src_doppler(index24);
index43 = find(~isnan(size43) == 1);
fowbsrc43 = tau_src_doppler(index43);

x1 = find(fowbsrc2 > nanmedian(fowbsrc2));
x2 = find(fowbsrc2 < nanmedian(fowbsrc2));
x3 = find(fowbsrc5 > nanmedian(fowbsrc5));
x4 = find(fowbsrc5 < nanmedian(fowbsrc5));
x5 = find(fowbsrc8 > nanmedian(fowbsrc8));
x6 = find(fowbsrc8 < nanmedian(fowbsrc8));
x7 = find(fowbsrc15 > nanmedian(fowbsrc15));
x8 = find(fowbsrc15 < nanmedian(fowbsrc15));
x9 = find(fowbsrc24 > nanmedian(fowbsrc24));
x10 = find(fowbsrc24 < nanmedian(fowbsrc24));
x11 = find(fowbsrc43 > nanmedian(fowbsrc43));
x12 = find(fowbsrc43 < nanmedian(fowbsrc43));

figure(17) 
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.06,0.55,0.28,0.36])
    histogram(log10(size2(index2(x1))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size2(index2(x2))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size2(index2(x1)))),nanmedian(log10(size2(index2(x1))))],[0,1],'b--','LineWidth',2.5)
    plot([nanmedian(log10(size2(index2(x2)))),nanmedian(log10(size2(index2(x2))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',2.5)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc2)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc2)),'location','northeast')
    xlabel('log(\theta_{2 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-0.4 0.5])
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.38,0.55,0.28,0.36])
    histogram(log10(size5(index5(x3))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size5(index5(x4))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size5(index5(x3)))),nanmedian(log10(size5(index5(x3))))],[0,1],'b--','LineWidth',2.5)
    plot([nanmedian(log10(size5(index5(x4)))),nanmedian(log10(size5(index5(x4))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',2.5)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc5)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc5)),'location','northeast')
    xlabel('log(\theta_{5 GHz})','FontSize', 20) 
    xlim([-0.9 0.2])
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.70,0.55,0.28,0.36])
    histogram(log10(size8(index8(x5))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size8(index8(x6))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size8(index8(x5)))),nanmedian(log10(size8(index8(x5))))],[0,1],'b--','LineWidth',2.5)
    plot([nanmedian(log10(size8(index8(x6)))),nanmedian(log10(size8(index8(x6))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',2.5)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc8)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc8)),'location','northeast')
    xlabel('log(\theta_{8 GHz})','FontSize', 20) 
    xlim([-1.0 0.0])
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.06,0.1,0.28,0.36])
    histogram(log10(size15(index15(x7))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size15(index15(x8))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size15(index15(x7)))),nanmedian(log10(size15(index15(x7))))],[0,1],'b--','LineWidth',2.5)
    plot([nanmedian(log10(size15(index15(x8)))),nanmedian(log10(size15(index15(x8))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',2.5)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc15)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc15)),'location','northeast')
    xlabel('log(\theta_{15 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-1.4 -0.2])
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.38,0.1,0.28,0.36])
    histogram(log10(size24(index24(x9))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size24(index24(x10))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size24(index24(x9)))),nanmedian(log10(size24(index24(x9))))],[0,1],'b--','LineWidth',2.5)
    plot([nanmedian(log10(size24(index24(x10)))),nanmedian(log10(size24(index24(x10))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',2.5)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc24)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc24)),'location','northeast')
    xlabel('log(l_{24 GHz})','FontSize', 20) 
    xlim([-1.4 -0.5])
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.70,0.1,0.28,0.36])
    histogram(log10(size43(index43(x11))),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size43(index43(x12))),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size43(index43(x11)))),nanmedian(log10(size43(index43(x11))))],[0,1],'b--','LineWidth',2.5)
    plot([nanmedian(log10(size43(index43(x12)))),nanmedian(log10(size43(index43(x12))))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',2.5)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc43)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc43)),'location','northeast')
    xlabel('log(\theta_{43 GHz})','FontSize', 20) 
    xlim([-1.5 -0.6])
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
%sgt = sgtitle('Intrinsic timescale \tau_{src} Distributed by Median of Linear Source Size');
%sgt.FontSize = 20;
%sgt.LineWidth = 2;  

if save_figure == 1
    fig_name = 'tau_src_Doppler distri observed core size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[r2,p2] = kstest2(realsize2(index2(x1)), realsize2(index2(x2)));
[r5,p5] = kstest2(realsize5(index5(x3)), realsize5(index5(x4)));
[r8,p8] = kstest2(realsize8(index8(x5)), realsize8(index8(x6)));
[r15,p15] = kstest2(realsize15(index15(x7)), realsize15(index15(x8)));
[r24,p24] = kstest2(realsize24(index24(x9)), realsize24(index24(x10)));
[r43,p43] = kstest2(realsize43(index43(x11)), realsize43(index43(x12)));

fowbsrc_Doppler_appsz_KS = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Intrinsic timescale (redshift, Doppler factor corrected) vs z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(18);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(z(neq_obs_lim), tau_src_doppler_neq_obs_lim,'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on 
    plot(z(eq_obs_lim), tau_src_doppler_eq_obs_lim,'g^','MarkerSize',7,'MarkerFaceColor','g') 
    hold off
    xlim([min(z)*0.5 max(z)*1]) 
    ylim([min(tau_src_doppler)*0.8 max(tau_src_doppler)*2])  
    xlabel('Redshift','FontSize', 20) 
    ylabel('Intrinsic Timescale (Doppler Corredted)','FontSize', 20) 
    set(gca,'XScale', 'log', 'YScale', 'log', 'FontSize', 20, 'LineWidth', 2); 
         
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Intrinsic timescale (redshift, Doppler factor corrected) vs z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index = find(ang_dis == max(ang_dis));

figure(19);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(z, ang_dis,'ro','MarkerSize',7,'MarkerFaceColor','r') 
    hold on
    plot([z(index), z(index)],[0,1E10],'b--','LineWidth',3) 
    hold off
    legend('' , sprintf('z = %4.2f', z(index)),'location','northeast','FontSize', 25)
    xlim([min(z)*0.5 max(z)*1.2]) 
    ylim([min(ang_dis)*0.8 max(ang_dis)*1.2])  
    xlabel('Redshift','FontSize', 20) 
    ylabel('Angular Diameter Distance (D_{A})','FontSize', 20) 
    set(gca, 'FontSize', 20, 'LineWidth', 2);   % ,'XScale', 'log', 'YScale', 'log'

%%

index2 = find(~isnan(size2) == 1);
fowbsrc2 = tau_src_doppler(index2);
index5 = find(~isnan(size5) == 1);
fowbsrc5 = tau_src_doppler(index5);
index8 = find(~isnan(size8) == 1);
fowbsrc8 = tau_src_doppler(index8);
index15 = find(~isnan(size15) == 1);
fowbsrc15 = tau_src_doppler(index15);
index24 = find(~isnan(size24) == 1);
fowbsrc24 = tau_src_doppler(index24);
index43 = find(~isnan(size43) == 1);
fowbsrc43 = tau_src_doppler(index43);

figure(20) 
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.06,0.55,0.26,0.36])
    plot(z(index2), log10(realsize2(index2)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlabel('Redshift (z)','FontSize', 20) 
    ylabel('log(l_{2 GHz})','FontSize', 20)
    xlim([-0.1 4])
%     ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.38,0.55,0.26,0.36])
    plot(z(index5), log10(realsize5(index5)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlabel('Redshift (z)','FontSize', 20) 
    ylabel('log(l_{5 GHz})','FontSize', 20)
    xlim([-0.1 4])
%     ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.70,0.55,0.26,0.36])
    plot(z(index8), log10(realsize8(index8)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlabel('Redshift (z)','FontSize', 20) 
    ylabel('log(l_{8 GHz})','FontSize', 20)
    xlim([-0.1 6])
%     ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.06,0.1,0.26,0.36])
    plot(z(index15), log10(realsize15(index15)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlabel('Redshift (z)','FontSize', 20) 
    ylabel('log(l_{15 GHz})','FontSize', 20)
    xlim([-0.1 4])
%     ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.38,0.1,0.26,0.36])
    plot(z(index24), log10(realsize24(index24)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlabel('Redshift (z)','FontSize', 20) 
    ylabel('log(l_{24 GHz})','FontSize', 20)
    xlim([-0.1 3.5])
%     ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.70,0.1,0.26,0.36])
    plot(z(index43), log10(realsize43(index43)),'ro','MarkerSize',7,'MarkerFaceColor','r') 
    xlabel('Redshift (z)','FontSize', 20) 
    ylabel('log(l_{43 GHz})','FontSize', 20)
    xlim([-0.1 3.5])
%     ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 

%%
clc; clear; close all;


data = strcat('/Users/87steven/Downloads/mew.csv'); 
fid = fopen(data);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,['%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f' ...
    ' %f %f %f %f %f %f %f %f %f'],'delimiter',','); 
fclose(fid); 

source_name = Table{1}'; 
fob = Table{2}'; 
Dnoise = Table{3}'; % Dobise 
fowb = Table{4}'; % bw = tau_char with weight
fowb_upper = Table{5}';
fowb_lower = Table{6}';
D1000w = Table{7}'; % D(tau=1000) with weight   ----> calculate by Koay et al., 2011 function #5
D1000_upper = Table{8}';
D1000_lower = Table{9}';
mean_flux = Table{10}';
D4 = Table{11}';
D4_upper = Table{12}';
D4_lower = Table{13}';
z = Table{14}';
log_Tvar = Table{15}';
log_Tvar_lower = Table{16}';
log_Tvar_upper = Table{17}';
Delta_var = Table{18}';
Delta_var_lower = Table{19}';
Delta_var_upper = Table{20}';
size1 = Table{21}';
size2 = Table{22}';
size5 = Table{23}';
size8 = Table{24}';
size15 = Table{25}';
size24 = Table{26}';
size43 = Table{27}';

Tvar = 10.^log_Tvar;
freq = [2E9,5E9,8E9,15E9,24E9,43E9];
c = 3E8;
k = 1.38*1.0E-23;
mean_flux_new = mean_flux*1.0E-26;

%%
size2 = sqrt( (c^2.*(1+z).*mean_flux_new)./(2*pi*k.*Delta_var.*Tvar*(2E9)^2) );
size5 = sqrt( (c^2.*(1+z).*mean_flux_new)./(2*pi*k.*Delta_var.*Tvar*(2E9)^2) );
size8 = sqrt( (c^2.*(1+z).*mean_flux_new)./(2*pi*k.*Delta_var.*Tvar*(2E9)^2) );
size15 = sqrt( (c^2.*(1+z).*mean_flux_new)./(2*pi*k.*Delta_var.*Tvar*(15E9)^2) );
size24 = sqrt( (c^2.*(1+z).*mean_flux_new)./(2*pi*k.*Delta_var.*Tvar*(2E9)^2) );
size43 = sqrt( (c^2.*(1+z).*mean_flux_new)./(2*pi*k.*Delta_var.*Tvar*(2E9)^2) );

%%% linear core size calculation
rad = (pi/180);   %  (1/3600)*1E-3*
% angualr diameter distance 
for i = 1:length(z)
    ang_dis(i) = ad_dist(z(i) ,1);
end

realsize15 = size15.*ang_dis*rad;




























