%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to do correlation test between variability timescale and amplitude
% against Table 6 intrinsic and scattering source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Read data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% source size table BEFORE publication (source size error are not correct)
%%% contains of Table 2 (observe source size) and Table 6 (intrinsic, and
%%% scattering sources size)
% data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/unpublished source size data/OVRO timescale Xmatch Table 6 and Table 2 2GHz with z.csv'); 
% fid = fopen(data);  % openfile
% 
% for i = 1:1
%     fgetl(fid);  % skip header of first line
% end
% 
% Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',','); 
% fclose(fid); 
% 
% name = string( Table{1} );  
% tau_char_unweighted = Table{2};
% Dnoise = Table{3}; 
% two_msq = Table{4};   
% tau_char = Table{5}; 
% tau_char_uperr = Table{6};   
% tau_char_loerr = Table{7}; 
% D1000 = Table{8}; 
% D1000_uperr = Table{9}; 
% D1000_loerr = Table{10}; 
% gla_b = Table{11}; 
% int_size_1 = Table{12};    % [mas]
% int_size_err_1 = Table{13}; 
% sca_size_1 = Table{14};    % [mas]
% sca_size_err_1 = Table{15}; 
% obs_size_2 = Table{16};
% obs_size_err_2 = Table{17};
% z = Table{18};
% D4 = Table{19}; 
% D4_uperr = Table{20}; 
% D4_loerr = Table{21}; 
% 
% obs_size_1 = sqrt( int_size_1.^2 + sca_size_1.^2);
% obs_size_err_1 = sqrt( int_size_err_1.^2 + sca_size_err_1.^2);

%%% source size table AFTER publication 
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

%%% boostrap times 
times = 500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Intrinsic source size against variability timescale 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(tau_char ~= tau_char_unweighted);
index2 = find(tau_char == tau_char_unweighted);

%hor_err = 0.434*int_size_err_1./int_size_1;

[r1,p1] = corr(int_size_1(index1),tau_char(index1),'type','Spearman','rows','complete');

figure(1);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(int_size_1(index1),tau_char(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(int_size_1(index1),tau_char(index1),int_size_err_1(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    plot(int_size_1(index2),tau_char(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([0.5 10])  
    ylim([min(tau_char)*0.5 max(tau_char)*1.1]) 
    xlabel('r_{1 GHz} [mas]','FontSize', 20) 
    ylabel('Characteristic Timescale (\tau_{char})','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r1, p1);
    text(3.5,2500,context,'FontSize', 25)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(tau_char >= nanmedian(tau_char)); 
x2 = find(tau_char < nanmedian(tau_char)); 

[r, p] = kstest2(int_size_1(x1),int_size_1(x2));

figure(51)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(int_size_1(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(int_size_1(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(int_size_1(x1))),nanmedian(log10(int_size_1(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(int_size_1(x2))),nanmedian(log10(int_size_1(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('\\tau_{char} > %4.fd', median(tau_char)), sprintf('\\tau_{char} < %4.fd', median(tau_char)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(r_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-1.5,0.45,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz Intrinsic source size distributed by characteristic timescale.png']);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Intrinsic source size against variability amplitude D(1000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D1000_low_err = D1000-D1000_loerr;   
D1000_up_err = D1000_uperr-D1000;  

%hor_err = 0.434*int_size_err_1./int_size_1;

[r2,p2] = corr(int_size_1,D1000,'type','Spearman','rows','complete');
r2_err = Spearman_boostrap_error(int_size_1',D1000', times);

figure(2);
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';
    
    plot(int_size_1,D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(int_size_1,D1000,int_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',1.5)
    errorbar(int_size_1,D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',1.5)
    %plot(int_size_1(index2),D1000(index2),'go','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([0.09 10])  
    ylim([0 max(D1000)*1.1]) 
    xlabel('r_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.1,0.6,context,'FontSize', 25)
    
    %saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz Intrinsic source size against variability amplitude.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(D1000 >= nanmedian(D1000)); 
x2 = find(D1000 < nanmedian(D1000)); 

[r, p] = kstest2(int_size_1(x1),int_size_1(x2));

figure(52)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(int_size_1(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(int_size_1(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(int_size_1(x1))),nanmedian(log10(int_size_1(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(int_size_1(x2))),nanmedian(log10(int_size_1(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(1000) > %6.4fd', nanmedian(D1000)), sprintf('D(1000) < %6.4fd', nanmedian(D1000)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(r_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-1.5,0.45,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz Intrinsic source size distributed by characteristic timescale.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Scattering source size against variability timescale 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(tau_char ~= tau_char_unweighted & sca_size_1 ~= 0.1);
index2 = find(tau_char == tau_char_unweighted | sca_size_1 == 0.1);

%hor_err = 0.434*sca_size_err_1./sca_size_1;

[r1,p1] = corr(sca_size_1(index1),tau_char(index1),'type','Spearman','rows','complete');

figure(3);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(sca_size_1(index1),tau_char(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(sca_size_1(index1),tau_char(index1),sca_size_err_1(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    plot(sca_size_1(index2),tau_char(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([0.09 100])  
    ylim([min(tau_char)*0.5 max(tau_char)*1.1]) 
    xlabel('s_{1 GHz sca} [mas]','FontSize', 20) 
    ylabel('Characteristic Timescale (\tau_{char})','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r1, p1);
    text(0.1,3000,context,'FontSize', 20)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
%%% exclude sources with lower limit of variability timescale and
%%% insignificant scattering effect
index1 = find(tau_char ~= tau_char_unweighted & sca_size_1 ~= 0.1);

tau_char_real  = tau_char(index1);
sca_size_1_real = sca_size_1(index1);
x1 = find(tau_char_real >= nanmedian(tau_char_real)); 
x2 = find(tau_char_real < nanmedian(tau_char_real)); 

[r, p] = kstest2(sca_size_1(x1),sca_size_1(x2));

figure(53)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(sca_size_1_real(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(sca_size_1_real(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(sca_size_1_real(x1))),nanmedian(log10(sca_size_1_real(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(sca_size_1_real(x2))),nanmedian(log10(sca_size_1_real(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(tau_char_real)), sprintf('\\tau_{char} < %4.fd', median(tau_char_real)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(s_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-0.75,0.45,context,'FontSize', 25)

    %saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz scattering source size against variability timescale.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
%%% only exclude sources with insignificant scattering effect
index1 = find(sca_size_1 ~= 0.1);

tau_char_real  = tau_char(index1);
sca_size_1_real = sca_size_1(index1);

x1 = find(tau_char_real >= nanmedian(tau_char_real)); 
x2 = find(tau_char_real < nanmedian(tau_char_real)); 

[r, p] = kstest2(sca_size_1(x1),sca_size_1(x2));

figure(53)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(sca_size_1_real(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(sca_size_1_real(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(sca_size_1_real(x1))),nanmedian(log10(sca_size_1_real(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(sca_size_1_real(x2))),nanmedian(log10(sca_size_1_real(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(tau_char_real)), sprintf('\\tau_{char} < %4.fd', median(tau_char_real)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(s_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-0.75,0.45,context,'FontSize', 25)


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Scattering source size against variability amplitude D(1000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D1000_low_err = D1000-D1000_loerr;   
D1000_up_err = D1000_uperr-D1000;  

index1 = find(sca_size_1 ~= 0.1);
index2 = find(sca_size_1 == 0.1);

[r2,p2] = corr(sca_size_1(index1),D1000(index1),'type','Spearman','rows','complete');
r2_err = Spearman_boostrap_error(sca_size_1(index1)',D1000(index1)', times);

figure(4);
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';
    
    plot(sca_size_1(index1),D1000(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(sca_size_1(index1),D1000(index1),sca_size_err_1(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    errorbar(sca_size_1(index1),D1000(index1),D1000_low_err(index1),D1000_up_err(index1),'ro','CapSize',0,'LineWidth',1.5)
    plot(sca_size_1(index2),D1000(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    
    %%% upper limit in intrinsic core sizes (r = 0.1 mas)
    %plot(sca_size_1(index),D1000(index),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    %errorbar(sca_size_1(index),D1000(index),D1000_low_err(index),D1000_up_err(index),'bo','CapSize',0,'LineWidth',1.5)

    hold off
    xlim([0.09 100])  
    ylim([0 max(D1000)*1.1]) 
    xlabel('s_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.15,0.6,context,'FontSize', 20)

    %saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz scattering source size against variability amplitude.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(D1000(index1) >= nanmedian(D1000(index1))); 
x2 = find(D1000(index1) < nanmedian(D1000(index1))); 
sca_size_1_real = sca_size_1(index1);

[r, p] = kstest2(sca_size_1_real(x1),sca_size_1_real(x2));

figure(54)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(sca_size_1_real(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(sca_size_1_real(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(sca_size_1_real(x1))),nanmedian(log10(sca_size_1_real(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(sca_size_1_real(x2))),nanmedian(log10(sca_size_1_real(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(1000) > %6.4fd', nanmedian(D1000)), sprintf('D(1000) < %6.4fd', nanmedian(D1000)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(s_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(0,0.45,context,'FontSize', 25)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Observe source size against variability timescale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(tau_char ~= tau_char_unweighted);
index2 = find(tau_char == tau_char_unweighted);

hor_err = obs_size_err_1;

[r1,p1] = corr(obs_size_1(index1), tau_char(index1),'type','Spearman','rows','complete');

figure(5)
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(obs_size_1(index1),tau_char(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(obs_size_1(index1),tau_char(index1),hor_err(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    plot(obs_size_1(index2),tau_char(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([0.2 100])  
    ylim([min(tau_char)*0.5 4E3]) 
    xlabel('\theta_{1 GHz} [mas]','FontSize', 20) 
    ylabel('Characteristic Timescale (\tau_{char})','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r1, p1);
    text(0.3, 2.5E3, context,'FontSize', 25)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(tau_char >= nanmedian(tau_char)); 
x2 = find(tau_char < nanmedian(tau_char)); 

[r, p] = kstest2(obs_size_1(x1),obs_size_1(x2));

figure(55)
set(gcf,'pos',[100,100,1200,800]);
%ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
%ax2.PositionConstraint = 'innerposition';

    histogram(log10(obs_size_1(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(obs_size_1(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(obs_size_1(x1))),nanmedian(log10(obs_size_1(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(obs_size_1(x2))),nanmedian(log10(obs_size_1(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('\\tau_{char} > %4.fd', nanmedian(tau_char)), sprintf('\\tau_{char} < %4.fd', nanmedian(tau_char)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(\theta_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-0.75,0.45,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz observe linear source size against variability amplitude.png']);



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Observe source size against variability amplitude D(1000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D1000_low_err = D1000-D1000_loerr;   
D1000_up_err = D1000_uperr-D1000;

[r2,p2] = corr(obs_size_1,D1000,'type','Spearman','rows','complete');
r2_err = Spearman_boostrap_error(obs_size_1',D1000', times);

figure(6);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(obs_size_1,D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(obs_size_1,D1000, obs_size_err_1,obs_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',1.5)
    errorbar(obs_size_1,D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.2 100])  
    ylim([0 max(D1000)*1.1]) 
    xlabel('\theta_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.25,0.6,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz observe source size against variability amplitude.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(D1000 >= nanmedian(D1000)); 
x2 = find(D1000 < nanmedian(D1000)); 

[r, p] = kstest2(obs_size_1(x1),obs_size_1(x2));

figure(56)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(obs_size_1(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(obs_size_1(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(obs_size_1(x1))),nanmedian(log10(obs_size_1(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(obs_size_1(x2))),nanmedian(log10(obs_size_1(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(1000) > %6.4fd', nanmedian(D1000)), sprintf('D(1000) < %6.4fd', nanmedian(D1000)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(\theta_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(0.,0.45,context,'FontSize', 25)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Separate 1 GHz Observe source by scattering and non-scattering sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(sca_size_1 ~= 0.1);
index2 = find(sca_size_1 == 0.1);

obs_sca_size_1 = sqrt( int_size_1(index1).^2 + sca_size_1(index1).^2);
obs_nonsca_size_1 = sqrt( int_size_1(index2).^2 + sca_size_1(index2).^2);

[r,p] = corr(obs_sca_size_1,D1000(index1),'type','Spearman','rows','complete');
[r1,p1] = corr(obs_nonsca_size_1,D1000(index2),'type','Spearman','rows','complete');

figure(7);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(obs_sca_size_1,D1000(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    plot(obs_nonsca_size_1,D1000(index2),'g^','MarkerSize',5,'MarkerFaceColor','g')
    hold off
    xlim([0.2 100])  
    ylim([0 max(D1000)*1.1]) 
    xlabel('\theta_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
    legend('Core size with scattering' , 'Core size with out scattering','location','northeast','FontSize', 20)
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Scattering observed core size Spearman correlation result:\n r = %4.2f,\n p = %6.4e \n' ...
        'Non-scattering observed core size Spearman correlation result:\n r = %4.2f,\n p = %6.4e' ], r, p, r1, p1);
    text(0.25,0.4,context,'FontSize', 25)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(D1000 >= nanmedian(D1000)); 
x2 = find(D1000 < nanmedian(D1000)); 

[r, p] = kstest2(obs_size_1(x1),obs_size_1(x2));

figure(57)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(obs_size_1(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(obs_size_1(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(obs_size_1(x1))),nanmedian(log10(obs_size_1(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(obs_size_1(x2))),nanmedian(log10(obs_size_1(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(1000) > %6.4fd', nanmedian(D1000)), sprintf('D(1000) < %6.4fd', nanmedian(D1000)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(\theta_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(0.,0.45,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz Intrinsic source size distributed by characteristic timescale.png']);

%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% 1 GHz Linear source size against variability timescale 
% %%% convert from intrinsic source size
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% index1 = find(tau_char ~= tau_char_unweighted);
% index2 = find(tau_char == tau_char_unweighted);
% 
% hor_err = int_size_err_1.*(1+z);
% 
% [r1,p1] = corr(int_size_1(index1).*(1+z(index1)), tau_char(index1).*(1+z(index1)),'type','Spearman','rows','complete');
% 
% figure(8);
%     set(gcf,'pos',[100,100,1200,800]);
%     
%     plot(int_size_1(index1).*(1+z(index1)),tau_char(index1).*(1+z(index1)),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     errorbar(int_size_1(index1).*(1+z(index1)),tau_char(index1).*(1+z(index1)),hor_err(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
%     plot(int_size_1(index2).*(1+z(index2)),tau_char(index2).*(1+z(index2)),'g^','MarkerSize',5,'MarkerFaceColor','g') 
%     hold off
%     xlim([0.05 40])  
%     ylim([min(tau_char)*0.5 2E4]) 
%     xlabel('\theta_{1 GHz Actual} [pc]','FontSize', 20) 
%     ylabel('Actual Variabiluty Timescale (\tau_{src})','FontSize', 20) 
%     set(gca,'FontSize',20,'LineWidth',2); 
%     set(gca,'XScale','log','YScale','log');
% 
%     context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r1, p1);
%     text(0.06, 1E4,context,'FontSize', 25)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% Two smaple K-S test
% tau_src_real = tau_char(index1).*(1+z(index1));
% act_size_1_real = int_size_1(index1).*(1+z(index1));
% x1 = find(tau_src_real >= nanmedian(tau_src_real)); 
% x2 = find(tau_src_real < nanmedian(tau_src_real)); 
% 
% [r, p] = kstest2(act_size_1_real(x1),act_size_1_real(x2));
% 
% figure(58)
% set(gcf,'pos',[100,100,1200,800]);
% ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
% ax2.PositionConstraint = 'innerposition';
% 
%     histogram(log10(act_size_1_real(x1)),15,'binwidth',0.25,'Normalization','probability')
%     hold on
%     histogram(log10(act_size_1_real(x2)),15,'binwidth',0.25,'Normalization','probability')
%     plot([nanmedian(log10(act_size_1_real(x1))),nanmedian(log10(act_size_1_real(x1)))],[0,1],'b--','LineWidth',4)
%     plot([nanmedian(log10(act_size_1_real(x2))),nanmedian(log10(act_size_1_real(x2)))],[0,1],'--', ...
%         'color',[0.8500 0.3250 0.0980],'LineWidth',4)
%     hold off
%     legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(tau_src_real)), sprintf('\\tau_{src} < %4.fd', nanmedian(tau_src_real)), ...
%         'location','northeast','FontSize', 20)
%     xlabel('log(\theta_{1 GHz Actual})','FontSize', 20)
%     ylabel('Normalized Frequency','FontSize', 20)
%     ylim([0 0.5])
%     set(gca,'FontSize',20,'LineWidth',2);
% 
%     context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
%     text(-1,0.45,context,'FontSize', 25)
% 
% saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz actual source size against variability timescale.png']);
% 
% %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% 1 GHz Actaul source size against variability amplitude D(1000)
% %%% convert from intrinsic source size
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D1000_low_err = D1000-D1000_loerr;   
% D1000_up_err = D1000_uperr-D1000;
% 
% [r2,p2] = corr(int_size_1.*(1+z),D1000,'type','Spearman','rows','complete');
% 
% figure(9);
% set(gcf,'pos',[100,100,1200,800]);
% ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
% ax2.PositionConstraint = 'innerposition';
%     
%     plot(int_size_1.*(1+z),D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     errorbar(int_size_1.*(1+z),D1000,hor_err,hor_err,'ro','horizontal','CapSize',0,'LineWidth',1.5)
%     errorbar(int_size_1.*(1+z),D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',1.5)
%     hold off
%     xlim([0.1 100])  
%     ylim([0 max(D1000)*1.1]) 
%     xlabel('\theta_{1 GHz Actual} [pc]','FontSize', 20) 
%     ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
%     set(gca,'FontSize',20,'LineWidth',2); 
%     set(gca,'XScale','log','YScale','log');
% 
%     context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
%     text(0.15,0.6,context,'FontSize', 25)
% 
% saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz actual source size against variability amplitude.png']);
   
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Linear source size against variability timescale 
%%% convert from observe source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(tau_char ~= tau_char_unweighted);
index2 = find(tau_char == tau_char_unweighted);

hor_err = obs_size_err_1.*(1+z);

[r1,p1] = corr(obs_size_1(index1).*(1+z(index1)), tau_char(index1).*(1+z(index1)),'type','Spearman','rows','complete');

figure(10)
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(obs_size_1(index1).*(1+z(index1)),tau_char(index1).*(1+z(index1)),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(obs_size_1(index1).*(1+z(index1)),tau_char(index1).*(1+z(index1)),hor_err(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    plot(obs_size_1(index2).*(1+z(index2)),tau_char(index2).*(1+z(index2)),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([0.8 100])  
    ylim([min(tau_char)*0.5 2E4]) 
    xlabel('l_{1 GHz} [pc]','FontSize', 20) 
    ylabel('Actual Variabiluty Timescale (\tau_{src})','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r1, p1);
    text(1, 1E4,context,'FontSize', 25)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
tau_src_real = tau_char(index1).*(1+z(index1));
act_size_1_real = obs_size_1(index1).*(1+z(index1));
x1 = find(tau_src_real >= nanmedian(tau_src_real)); 
x2 = find(tau_src_real < nanmedian(tau_src_real)); 

[r, p] = kstest2(act_size_1_real(x1),act_size_1_real(x2));

figure(55)
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';

    histogram(log10(act_size_1_real(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(act_size_1_real(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(act_size_1_real(x1))),nanmedian(log10(act_size_1_real(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(act_size_1_real(x2))),nanmedian(log10(act_size_1_real(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('\\tau_{src} > %4.fd', nanmedian(tau_src_real)), sprintf('\\tau_{src} < %4.fd', nanmedian(tau_src_real)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(l_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-0.5,0.45,context,'FontSize', 25)

saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz observe linear source size against variability amplitude.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Linear source size against variability amplitude D(1000)
%%% convert from observe source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D1000_low_err = D1000-D1000_loerr;   
% D1000_up_err = D1000_uperr-D1000;
% 
% [r2,p2] = corr(obs_size_1.*(1+z),D1000,'type','Spearman','rows','complete');
% 
% figure(11);
% set(gcf,'pos',[100,100,1200,800]);
% ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
% ax2.PositionConstraint = 'innerposition';
%     
%     plot(obs_size_1.*(1+z),D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     errorbar(obs_size_1.*(1+z),D1000,hor_err,hor_err,'ro','horizontal','CapSize',0,'LineWidth',1.5)
%     errorbar(obs_size_1.*(1+z),D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',1.5)
%     hold off
%     xlim([0.1 100])  
%     ylim([0 max(D1000)*1.1]) 
%     xlabel('l_{1 GHz} [pc]','FontSize', 20) 
%     ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
%     set(gca,'FontSize',20,'LineWidth',2); 
%     set(gca,'XScale','log','YScale','log');
% 
%     context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
%     text(0.15,0.6,context,'FontSize', 25)
% 
% saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz observe linear source size against variability amplitude.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2 GHz Observe source size against variability timescale 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(tau_char ~= tau_char_unweighted);
index2 = find(tau_char == tau_char_unweighted);

[r1,p1] = corr(obs_size_2(index1),tau_char(index1),'type','Spearman','rows','complete');

figure(12);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(obs_size_2(index1),tau_char(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    %errorbar(int_size_2(index1),tau_char(index1),int_size_err_2(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    plot(obs_size_2(index2),tau_char(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([0.01 10])  
    ylim([min(tau_char)*0.5 max(tau_char)*1.1]) 
    xlabel('\theta_{2 GHz} [mas]','FontSize', 20) 
    ylabel('Characteristic Timescale (\tau_{char})','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r1, p1);
    text(0.015,2500,context,'FontSize', 25)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
tau_char_real  = tau_char(index1);
obs_size_2_real = obs_size_2(index1);
x1 = find(tau_char_real >= nanmedian(tau_char_real)); 
x2 = find(tau_char_real < nanmedian(tau_char_real)); 

[r, p] = kstest2(obs_size_2(x1),obs_size_2(x2));

figure(56)
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';

    histogram(log10(obs_size_2_real(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(obs_size_2_real(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(obs_size_2_real(x1))),nanmedian(log10(obs_size_2_real(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(obs_size_2_real(x2))),nanmedian(log10(obs_size_2_real(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', nanmedian(tau_char_real)), sprintf('\\tau_{char} < %4.fd', nanmedian(tau_char_real)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(\theta_{2 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-2,0.45,context,'FontSize', 25)

saveas(gcf,['/Users/87steven/Downloads/paper figures/2 GHz observe source size against variability timescale.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2 GHz Observe source size against variability amplitude D(1000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D1000_low_err = D1000-D1000_loerr;   
D1000_up_err = D1000_uperr-D1000;

[r2,p2] = corr(obs_size_2,D1000,'type','Spearman','rows','complete');

figure(13);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(obs_size_2,D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(obs_size_2,D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.01 10])  
    ylim([0 max(D1000)*1.1]) 
    xlabel('\theta_{2 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.015,0.6,context,'FontSize', 25)

saveas(gcf,['/Users/87steven/Downloads/paper figures/2 GHz observe source size against variability amplitude.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2 GHz Linear source size against actual variability timescale 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(tau_char ~= tau_char_unweighted);
index2 = find(tau_char == tau_char_unweighted);

%hor_err = 0.434*(int_size_err_2.*(1+z))./(int_size_2.*(1+z));

[r1,p1] = corr(obs_size_2(index1).*(1+z(index1)), tau_char(index1).*(1+z(index1)),'type','Spearman','rows','complete');

figure(14);
set(gcf,'pos',[100,100,1200,800]);
    
    plot(obs_size_2(index1).*(1+z(index1)),tau_char(index1).*(1+z(index1)),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    %errorbar(int_size_1(index1).*(1+z(index1)),tau_char(index1),hor_err(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    plot(obs_size_2(index2).*(1+z(index2)),tau_char(index2).*(1+z(index2)),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([0.01 20])  
    ylim([0 2E4]) 
    xlabel('l_{2 GHz} [pc]','FontSize', 20) 
    ylabel('Actual Variability Timescale (\tau_{src})','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r1, p1);
    text(0.015,1E4,context,'FontSize', 25)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
tau_src_real = tau_char(index1).*(1+z(index1));
act_size_2_real = obs_size_2(index1).*(1+z(index1));
x1 = find(tau_src_real >= nanmedian(tau_src_real)); 
x2 = find(tau_src_real < nanmedian(tau_src_real)); 

[r, p] = kstest2(act_size_2_real(x1), act_size_2_real(x2));

figure(64)
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';

    histogram(log10(act_size_2_real(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(act_size_2_real(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(act_size_2_real(x1))),nanmedian(log10(act_size_2_real(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(act_size_2_real(x2))),nanmedian(log10(act_size_2_real(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend(sprintf('\\tau_{src} > %4.fd', nanmedian(tau_src_real)), sprintf('\\tau_{src} < %4.fd', nanmedian(tau_src_real)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(l_{2 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-1.5 1.])
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-1.4,0.45,context,'FontSize', 25)

saveas(gcf,['/Users/87steven/Downloads/paper figures/2 GHz actual source size against variability timescale.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2 GHz Linear source size against variability amplitude D(1000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D1000_low_err = D1000-D1000_loerr;   
D1000_up_err = D1000_uperr-D1000;

[r2,p2] = corr(obs_size_2.*(1+z),D1000,'type','Spearman','rows','complete');

figure(15);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(obs_size_2.*(1+z),D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(obs_size_2.*(1+z),D1000,D1000_low_err,D1000_up_err,'ro','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.01 100])  
    ylim([0 max(D1000)*1.1]) 
    xlabel('l_{2 GHz} [pc]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.015,0.6,context,'FontSize', 25)

saveas(gcf,['/Users/87steven/Downloads/paper figures/2 GHz actual source size against variability amplitude.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Intrinsic source size against variability amplitude D(4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D4_low_err = D4-D4_loerr;   %0.434*(D4-D4_loerr)./D4;
D4_up_err = D4_uperr-D4;   %0.434*(D4_uperr-D4)./D4;

%hor_err = 0.434*int_size_err_1./int_size_1;

[r2,p2] = corr(int_size_1,D4,'type','Spearman','rows','complete');
r2_err = Spearman_boostrap_error(int_size_1',D4', times);

figure(16);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(int_size_1,D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(int_size_1,D4,int_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',1.5)
    errorbar(int_size_1,D4,D4_low_err,D4_up_err,'ro','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.08 10])
    ylim([0 max(D4)*1.1]) 
    xlabel('r_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.1,0.03,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz intrinsic source size against short variability amplitude.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(D4 >= nanmedian(D4)); 
x2 = find(D4 < nanmedian(D4)); 

[r, p] = kstest2(int_size_1(x1),int_size_1(x2));

figure(66)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(int_size_1(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(int_size_1(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(int_size_1(x1))),nanmedian(log10(int_size_1(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(int_size_1(x2))),nanmedian(log10(int_size_1(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(4d) > %6.4fd', nanmedian(D4)), sprintf('D(4d) < %6.4fd', nanmedian(D4)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(r_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-1.5,0.45,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz Intrinsic source size distributed by characteristic timescale.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Scattering source size against variability amplitude D(4)
%%% exclude source with upper limit of the scattering core size 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D4_low_err = D4-D4_loerr;   
D4_up_err = D4_uperr-D4;   

index1 = find(sca_size_1 ~= 0.1);
index2 = find(sca_size_1 == 0.1);

%hor_err = 0.434*sca_size_err_1./sca_size_1;

[r2,p2] = corr(sca_size_1(index1),D4(index1),'type','Spearman','rows','complete');
r2_err = Spearman_boostrap_error(sca_size_1(index1)',D4(index1)', times);

figure(17);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(sca_size_1(index1),D4(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(sca_size_1(index1),D4(index1),sca_size_err_1(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    errorbar(sca_size_1(index1),D4(index1),D4_low_err(index1),D4_up_err(index1),'ro','CapSize',0,'LineWidth',1.5)
    plot(sca_size_1(index2),D4(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([0.08 100])  
    ylim([0 max(D4)*1.1]) 
    xlabel('s_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.1,0.03,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz scattering source size against short variability amplitude.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(D4(index1) >= nanmedian(D4(index1))); 
x2 = find(D4(index1) < nanmedian(D4(index1))); 
sca_size_1_real = sca_size_1(index1);

[r, p] = kstest2(sca_size_1_real(x1),sca_size_1_real(x2));

figure(67)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(sca_size_1_real(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(sca_size_1_real(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(sca_size_1_real(x1))),nanmedian(log10(sca_size_1_real(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(sca_size_1_real(x2))),nanmedian(log10(sca_size_1_real(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(4 d) > %6.4fd', nanmedian(D4)), sprintf('D(4 d) < %6.4fd', nanmedian(D4)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(r_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(0,0.45,context,'FontSize', 25)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Linear source size against variability amplitude D(4)
%%% convert from intrinsic source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D4_low_err = D4-D4_loerr;   
% D4_up_err = D4_uperr-D4;
% 
% %hor_err = 0.434*int_size_err_1./int_size_1;
% 
% [r2,p2] = corr(int_size_1.*(1+z),D4,'type','Spearman','rows','complete');
% 
% figure(18);
% set(gcf,'pos',[100,100,1200,800]);
% ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
% ax2.PositionConstraint = 'innerposition';
%     
%     plot(int_size_1.*(1+z),D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     errorbar(int_size_1.*(1+z),D4,int_size_err_1.*(1+z),'ro','horizontal','CapSize',0,'LineWidth',1.5)
%     errorbar(int_size_1.*(1+z),D4, D4_low_err, D4_up_err,'ro','CapSize',0,'LineWidth',1.5)
%     hold off
%     xlim([0.09 100])  
%     ylim([0 max(D4)*1.1]) 
%     xlabel('l_{1 GHz} [pc]','FontSize', 20) 
%     ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
%     set(gca,'FontSize',20,'LineWidth',2); 
%     set(gca,'XScale','log','YScale','log');
% 
%     context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
%     text(0.1,0.03,context,'FontSize', 25)
% 
% saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz actual source size against short variability amplitude.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Observe source size against variability amplitude D(4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D4_low_err = D4-D4_loerr;   
D4_up_err = D4_uperr-D4;

%hor_err = 0.434*int_size_err_1./int_size_1;

[r2,p2] = corr(obs_size_1,D4,'type','Spearman','rows','complete');
r2_err = Spearman_boostrap_error(obs_size_1',D4', times);

figure(19);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(obs_size_1,D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(obs_size_1,D4, obs_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',1.5)
    errorbar(obs_size_1,D4, D4_low_err, D4_up_err,'ro','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.2 100])  
    ylim([0 max(D4)*1.1]) 
    xlabel('\theta_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.3, 0.04,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz observe source size against short variability amplitude.png']);

%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Separate 1 GHz Observe source by scattering and non-scattering sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(sca_size_1 ~= 0.1);
index2 = find(sca_size_1 == 0.1);

obs_sca_size_1 = sqrt( int_size_1(index1).^2 + sca_size_1(index1).^2);
obs_nonsca_size_1 = sqrt( int_size_1(index2).^2 + sca_size_1(index2).^2);

[r,p] = corr(obs_sca_size_1,D4(index1),'type','Spearman','rows','complete');
[r1,p1] = corr(obs_nonsca_size_1,D4(index2),'type','Spearman','rows','complete');

figure(20);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(obs_sca_size_1,D4(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    plot(obs_nonsca_size_1,D4(index2),'g^','MarkerSize',5,'MarkerFaceColor','g')
    %plot(obs_size_1,D4,'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([0.2 100])  
    ylim([0 max(D4)*1.1]) 
    xlabel('\theta_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
    legend('Core size with scattering' , 'Core size without scattering','location','northeast','FontSize', 20)
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Scattering observed core size Spearman correlation result:\n r = %4.2f,\n p = %6.4e \n' ...
        'Non-scattering observed core size Spearman correlation result:\n r = %4.2f,\n p = %6.4e' ], r, p, r1, p1);
    text(0.25,0.03,context,'FontSize', 25)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2 GHz Observe source size against variability amplitude D(4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D4_low_err = D4-D4_loerr;   
D4_up_err = D4_uperr-D4;

[r2,p2] = corr(obs_size_1,D4,'type','Spearman','rows','complete');

figure(21);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(obs_size_1,D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(obs_size_1,D4,D4_low_err,D4_up_err,'ro','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.01 10])  
    ylim([0 max(D4)*1.1]) 
    xlabel('\theta_{2 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.015,0.03,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/2 GHz observe source size against short variability amplitude.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(D4 >= nanmedian(D4)); 
x2 = find(D4 < nanmedian(D4)); 

[r, p] = kstest2(obs_size_1(x1),obs_size_1(x2));

figure(71)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(obs_size_1(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(obs_size_1(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(obs_size_1(x1))),nanmedian(log10(obs_size_1(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(obs_size_1(x2))),nanmedian(log10(obs_size_1(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(4 d) > %6.4fd', nanmedian(D4)), sprintf('D(4 d) < %6.4fd', nanmedian(D4)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(\theta_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(0.,0.45,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz Intrinsic source size distributed by characteristic timescale.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2 GHz Linear source size against variability amplitude D(1000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D4_low_err = D4-D4_loerr;   
D4_up_err = D4_uperr-D4;

[r2,p2] = corr(obs_size_2.*(1+z),D4,'type','Spearman','rows','complete');

figure(22);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(obs_size_2.*(1+z),D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(obs_size_2.*(1+z),D4,D4_low_err,D4_up_err,'ro','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.01 100])  
    ylim([0 max(D4)*1.1]) 
    xlabel('l_{2 GHz} [pc]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r2, p2);
    text(0.015,0.03,context,'FontSize', 25)

saveas(gcf,['/Users/87steven/Downloads/paper figures/2 GHz actual source size against short variability amplitude.png']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Scattering source size against variability amplitude D(1000)
%%% seperate core sizes by the median of D(1000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = find(D1000 >= nanmedian(D1000));
index2 = find(D1000 < nanmedian(D1000));

D1000_low_err = D1000-D1000_loerr;   
D1000_up_err = D1000_uperr-D1000;   

figure(23);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(sca_size_1(index1),D1000(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    plot(sca_size_1(index2),D1000(index2),'go','MarkerSize',5,'MarkerFaceColor','g') 
    errorbar(sca_size_1(index1),D1000(index1),sca_size_err_1(index1),'ro','horizontal','CapSize',0,'LineWidth',1.5)
    errorbar(sca_size_1(index2),D1000(index2),sca_size_err_1(index2),'go','horizontal','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.08 100])  
    ylim([0 max(D1000)*1.1]) 
    xlabel('s_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(0.1,0.6,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz scattering source size against short variability amplitude.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
%%% seperate core sizes by the median of D(1000)

[r, p] = kstest2(sca_size_1(index1), sca_size_1(index2));

figure(73)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(sca_size_1(index1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(sca_size_1(index2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(sca_size_1(index1))),nanmedian(log10(sca_size_1(index1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(sca_size_1(index2))),nanmedian(log10(sca_size_1(index2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(1000 d) > %6.4fd', nanmedian(D1000)), sprintf('D(1000 d) < %6.4fd', nanmedian(D1000)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(r_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.65])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(1.1,0.55,context,'FontSize', 25)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
%%% seperate core sizes by s = 0.1 (classifed into scattered and non-scattered)
D1000_new = D1000;
D1000_new(D1000_new < 0) = nan;

index1 = find(sca_size_1 ~= 0.1); % length(index1) = 230
index2 = find(sca_size_1 == 0.1); % length(index2) = 308

[r, p] = kstest2(D1000_new(index1), D1000_new(index2));

figure(74)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(D1000_new(index1)),15,'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log10(D1000_new(index2)),15,'binwidth',0.2,'Normalization','probability')
    plot([nanmedian(log10(D1000_new(index1))),nanmedian(log10(D1000_new(index1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(D1000_new(index2))),nanmedian(log10(D1000_new(index2)))],[0,1],'--', 'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend('s > 0.1 mas', 's = 0.1 mas', 'location','northeast','FontSize', 25)
    xlabel('log(D(1000 d))','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-3 0.])
    ylim([0 0.2])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-2.8,0.18,context,'FontSize', 25)
    
    %fig_name = 'D(1000 d) separate by s = 0.1';    
    %save_path = sprintf('/Users/87steven/Downloads/%s.png', fig_name);
    %print(gcf,save_path,'-dpng','-r400')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1 GHz Scattering source size against variability amplitude D(4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D4_low_err = D4-D4_loerr;   
D4_up_err = D4_uperr-D4;   

[r,p] = corr(sca_size_1,D4,'type','Spearman','rows','complete');

figure(24);
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';
    
    plot(sca_size_1,D4,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(sca_size_1,D4,sca_size_err_1,'ro','horizontal','CapSize',0,'LineWidth',1.5)
    hold off
    xlim([0.08 100])  
    ylim([0 max(D4)*1.1]) 
    xlabel('s_{1 GHz} [mas]','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=4))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(0.1,0.03,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/1 GHz scattering source size against short variability amplitude.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
x1 = find(D4 >= nanmedian(D4)); 
x2 = find(D4 < nanmedian(D4)); 

[r, p] = kstest2(sca_size_1(x1),sca_size_1(x2));

figure(75)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(sca_size_1(x1)),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(log10(sca_size_1(x2)),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(log10(sca_size_1(x1))),nanmedian(log10(sca_size_1(x1)))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(log10(sca_size_1(x2))),nanmedian(log10(sca_size_1(x2)))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(4 d) > %6.4fd', nanmedian(D4)), sprintf('D(4 d) < %6.4fd', nanmedian(D4)), ...
        'location','northeast','FontSize', 20)
    xlabel('log(r_{1 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.7])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(1.1,0.58,context,'FontSize', 25)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
%%% seperate core sizes by s = 0.1 (classifed into scattered and non-scattered)
index1 = find(sca_size_1 ~= 0.1); % length(index1) = 230
index2 = find(sca_size_1 == 0.1); % length(index2) = 308

[r, p] = kstest2(D4(index1), D4(index2));

figure(76)
    set(gcf,'pos',[100,100,1200,800]);
    ax2 = axes('Position',[0.1 0.12 0.85 0.83]);
    ax2.PositionConstraint = 'innerposition';

    histogram(log10(D4(index1)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(D4(index2)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(D4(index1))),nanmedian(log10(D4(index1)))],[0,1],'b--','LineWidth',6)
    plot([nanmedian(log10(D4(index2))),nanmedian(log10(D4(index2)))],[0,1],'--', 'color',[0.8500 0.3250 0.0980],'LineWidth',6)
    hold off
    legend('s > 0.1 mas', 's = 0.1 mas', 'location','northeast','FontSize', 40)
    set(gca,'FontSize',30,'LineWidth',4);
    xlabel('log(D(4 d))','FontSize', 40)
    ylabel('Normalized Count','FontSize', 40)
    xlim([-3.5 -1.5])
    ylim([0 0.2])

    %context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    %text(-2.1,0.16,context,'FontSize', 25)

    fig_name = 'log D(4 d) separate by s=0.1';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png', fig_name);
    print(gcf,save_path,'-dpng','-r600')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Take median of source size and source size error of each source, and save
%them to "OVRO timescale Xmatch Table 6 with z.csv"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clc; clear; close all;
% %%% Read data
%
% %%% ource size table BEFORE publication (source size error are not correct)
%data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/unpublished source size data/OVRO timescale Xmatch Table 6 and Table 2 2GHz.csv'); 
%
%%%% ource size table AFTER publication 
% data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/published source size data/OVRO timescale Xmatch Table 7 and Table 2 published 2GHz.csv'); 
% fid = fopen(data);  % openfile
% 
% for i = 1:1
%     fgetl(fid);  % skip header of first line
% end
% 
% Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',','); 
% fclose(fid); 
% 
% name = string( Table{1} );  
% size_2 = Table{18};
% size_err_2 = Table{19};
% z = Table{20};
% 
% %%
% %%%% Table arrange
% unique_name = unique(name);
% 
% for i = 1:length(unique_name)
%    index = find(name == unique_name(i));
%    median_size(i) = nanmedian(size_2(index));
%    median_size_err(i) = nanmedian(size_err_2(index));
%    z_array(i) = z(index(1));
% 
% end
% 
% median_size = median_size';
% median_size_err = median_size_err';
% z_array = z_array';
% 
% %%% after getting results (median_size, median_size_err, and z_array),
% %%% duplicate "OVRO timescale Xmatch Table 7.csv", paste "median_size, 
% %%% median_size_err, and z_array" into the document, and save as a new file
% %%% ("OVRO timescale Xmatch Table 7 and Table 2 published 2GHz with z.csv")








