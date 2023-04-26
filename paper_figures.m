%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paper figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Read data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/OVRO timescale Xmatch Table 7 and Table 2 published 2GHz with z.csv'); 

fid = fopen(data);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',','); 
fclose(fid); 

name = string( Table{1} );  
tau_char_unweighted = Table{2};
Dnoise = Table{3}; 
tau_char = Table{4}; 
tau_char_uperr = Table{5};   
tau_char_loerr = Table{6}; 
D1000 = Table{7}; 
D1000_uperr = Table{8}; 
D1000_loerr = Table{9}; 
D4 = Table{10}; 
D4_uperr = Table{11}; 
D4_loerr = Table{12}; 
gla_b = Table{13}; 
int_size_1 = Table{14};    % [mas]
int_size_err_1 = Table{15}; 
sca_size_1 = Table{16};    % [mas]
sca_size_err_1 = Table{17}; 
obs_size_2 = Table{18};
obs_size_err_2 = Table{19};
z = Table{20};

obs_size_1 = sqrt( int_size_1.^2 + sca_size_1.^2);
obs_size_err_1 = sqrt( int_size_err_1.^2 + sca_size_err_1.^2);

index1 = find(sca_size_1 ~= 0.1);
index2 = find(sca_size_1 == 0.1);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% variability amplitude D(1000) against 1 GHz Intrinsic, scattering,
%%% observe source sizes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_figure = 0;

D1000_low_err = D1000-D1000_loerr;   
D1000_up_err = D1000_uperr-D1000;  

figure(1);
    set(gcf,'pos',[100,100,1800,600]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';
    
    subplot1a = subplot(1,3,1); 
    set(subplot1a,'pos',[0.06,0.15,0.3,0.8]);
    
        plot(int_size_1,D1000,'ro','MarkerSize',6,'MarkerFaceColor','r') 
        hold on 
        errorbar(int_size_1,D1000,int_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(int_size_1,D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',2)
        hold off
        set(gca,'FontSize',20,'LineWidth',2,'XScale','log','YScale','log')
        xlim([0.09 10])  
        ylim([0 max(D1000)*1.1]) 
        xlabel('\theta_{int, 1 GHz} [mas]','FontSize', 25) 
        ylabel('SF Amplitude D(1000)','FontSize', 25) 

    subplot1b = subplot(1,3,2); 
    set(subplot1b,'pos',[0.37,0.15,0.3,0.8]);

        plot(sca_size_1(index1),D1000(index1),'ro','MarkerSize',6,'MarkerFaceColor','r') 
        hold on 
        errorbar(sca_size_1(index1),D1000(index1),sca_size_err_1(index1),'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(sca_size_1(index1),D1000(index1),D1000_low_err(index1),D1000_up_err(index1),'ro','CapSize',0,'LineWidth',2)
        plot(sca_size_1(index2),D1000(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
        hold off
        set(gca,'FontSize',20,'LineWidth',2,'XScale','log','YScale','log','YTickLabel',[])
        xlim([0.09 100])  
        ylim([0 max(D1000)*1.1]) 
        xlabel('\theta_{sca, 1 GHz} [mas]','FontSize', 25) 

    subplot1c = subplot(1,3,3); 
    set(subplot1c,'pos',[0.68,0.15,0.3,0.8]);

        plot(obs_size_1,D1000,'ro','MarkerSize',6,'MarkerFaceColor','r') 
        hold on 
        errorbar(obs_size_1,D1000,obs_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(obs_size_1,D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',2)
        hold off
        set(gca,'FontSize',20,'LineWidth',2,'XScale','log','YScale','log','YTickLabel',[])
        xlim([0.2 100])  
        ylim([0 max(D1000)*1.1]) 
        xlabel('\theta_{obs, 1 GHz} [mas]','FontSize', 25) 

if save_figure == 1
    fig_name = 'D1000 vs 1 GHz core sizes';
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r600')
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% variability amplitude D(4) against 1 GHz Intrinsic, scattering, observe
%%% source sizes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_figure = 0;

D4_low_err = D4-D4_loerr;   %0.434*(D4-D4_loerr)./D4;
D4_up_err = D4_uperr-D4;   %0.434*(D4_uperr-D4)./D4;

figure(2);
    set(gcf,'pos',[100,100,1800,600]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    subplot1a = subplot(1,3,1); 
    set(subplot1a,'pos',[0.06,0.15,0.3,0.8]);

        plot(int_size_1,D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
        hold on 
        errorbar(int_size_1,D4,int_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(int_size_1,D4,D4_low_err,D4_up_err,'ro','CapSize',0,'LineWidth',2)
        hold off
        set(gca,'FontSize',20,'LineWidth',2,'XScale','log','YScale','log')
        xlim([0.08 10])
        ylim([0 max(D4)*1.1]) 
        xlabel('\theta_{int, 1 GHz} [mas]','FontSize', 25) 
        ylabel('SF Amplitude D(4)','FontSize', 25) 

    subplot1b = subplot(1,3,2); 
    set(subplot1b,'pos',[0.37,0.15,0.3,0.8]);

        plot(sca_size_1(index1),D4(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
        hold on 
        errorbar(sca_size_1(index1),D4(index1),sca_size_err_1(index1),'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(sca_size_1(index1),D4(index1),D4_low_err(index1),D4_up_err(index1),'ro','CapSize',0,'LineWidth',2)
        plot(sca_size_1(index2),D4(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
        hold off
        set(gca,'FontSize',20,'LineWidth',2,'XScale','log','YScale','log','YTickLabel',[])
        xlim([0.08 100])  
        ylim([0 max(D4)*1.1]) 
        xlabel('\theta_{sca, 1 GHz} [mas]','FontSize', 25) 

    subplot1c = subplot(1,3,3); 
    set(subplot1c,'pos',[0.68,0.15,0.3,0.8]);

        plot(obs_size_1,D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
        hold on 
        errorbar(obs_size_1,D4, obs_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(obs_size_1,D4, D4_low_err, D4_up_err,'ro','CapSize',0,'LineWidth',2)
        hold off
        set(gca,'FontSize',20,'LineWidth',2,'XScale','log','YScale','log','YTickLabel',[])
        xlim([0.2 100])  
        ylim([0 max(D4)*1.1]) 
        xlabel('\theta_{obs, 1 GHz} [mas]','FontSize', 25) 

if save_figure == 1
    fig_name = 'D4 vs 1 GHz core sizes';
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r600')
end


%% variability amplitude D(4) against intrinsic core sizes 

figure(3);
    set(gcf,'pos',[100,100,1200,900]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    plot(int_size_1,D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(int_size_1,D4,int_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',1.5)
    errorbar(int_size_1,D4,D4_low_err,D4_up_err,'ro','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.08 10])
    ylim([0 max(D4)*1.1]) 
    xlabel('\theta_{int, 1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
    set(gca,'FontSize',25,'LineWidth',3); 
    set(gca,'XScale','log','YScale','log');




%% 2023 TPS annua; meeting poster use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Intrinsic, scattering, observe source size against variability amplitude D(1000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_figure = 0;

D1000_low_err = D1000-D1000_loerr;   
D1000_up_err = D1000_uperr-D1000;  

figure(4);
    set(gcf,'pos',[100,100,1800,600]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';
    
    subplot1a = subplot(1,3,1); 
    set(subplot1a,'pos',[0.06,0.15,0.3,0.8]);
    
        plot(int_size_1,D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
        hold on 
        errorbar(int_size_1,D1000,int_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(int_size_1,D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',2)
        hold off
        xlim([0.09 9])  
        ylim([0 max(D1000)*1.1]) 
        xlabel('\theta_{int, 1 GHz} [mas]','FontSize', 25) 
        ylabel('SF Amplitude (D(\tau=1000))','FontSize', 25) 
        set(gca,'FontSize',25,'LineWidth',3,'XScale','log','YScale','log'); 

    subplot1b = subplot(1,3,2); 
    set(subplot1b,'pos',[0.37,0.15,0.3,0.8]);

        index1 = find(sca_size_1 ~= 0.1);
        index2 = find(sca_size_1 == 0.1);

        plot(sca_size_1(index1),D1000(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
        hold on 
        errorbar(sca_size_1(index1),D1000(index1),sca_size_err_1(index1),'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(sca_size_1(index1),D1000(index1),D1000_low_err(index1),D1000_up_err(index1),'ro','CapSize',0,'LineWidth',2)
        plot(sca_size_1(index2),D1000(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
        hold off
        xlim([0.09 100])  
        ylim([0 max(D1000)*1.1]) 
        xlabel('\theta_{sca, 1 GHz} [mas]','FontSize', 25) 
        %ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
        set(gca,'FontSize',25,'LineWidth',3,'YTickLabel',[],'XScale','log','YScale','log'); 

    subplot1c = subplot(1,3,3); 
    set(subplot1c,'pos',[0.68,0.15,0.3,0.8]);

        plot(obs_size_1,D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
        hold on 
        errorbar(obs_size_1,D1000,obs_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',2)
        errorbar(obs_size_1,D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',2)
        hold off
        xlim([0.2 100])  
        ylim([0 max(D1000)*1.1]) 
        xlabel('\theta_{obs, 1 GHz} [mas]','FontSize', 25) 
        %ylabel('SF Amplitude (D(\tau=1000))','FontSize', 25) 
        set(gca,'FontSize',25,'LineWidth',3,'YTickLabel',[],'XScale','log','YScale','log'); 

if save_figure == 1
    fig_name = 'D1000 vs 1 GHz core sizes';
    save_path = sprintf('/Users/87steven/Documents/天文所/碩二上/TPS/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r600')
end


