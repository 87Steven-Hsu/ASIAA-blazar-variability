%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to do 2 sample K-S test of "Sourcesizecomp.m"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fowb_appsz_KS,fowbsrc_actsz_KS,D1000w_actsz_KS,D1000w_appsz_KS] = KStest2sample_table2(fowb,D1000w,D4w,save_figure,...
    numreSt2,numreSt5,numreSt8,numreSt15,numreSt24,numreSt43, ...
    numSt2,numSt5,numSt8,numSt15, numSt24,numSt43, ...
    size2_median,size5_median,size8_median,size15_median,size24_median,size43_median, ...
    z_2_array,z_5_array,z_8_array,z_15_array,z_24_array,z_43_array, ...
    realsize2,realsize5,realsize8,realsize15,realsize24,realsize43)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Set up parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size2 = size2_median;
size5 = size5_median;
size8 = size8_median;
size15 = size15_median;
size24 = size24_median;
size43 = size43_median;  

fowb2 = fowb(numreSt2); 
fowb5 = fowb(numreSt5); 
fowb8 = fowb(numreSt8); 
fowb15 = fowb(numreSt15); 
fowb24 = fowb(numreSt24); 
fowb43 = fowb(numreSt43); 

D1000w2 = D1000w(numreSt2);
D1000w5 = D1000w(numreSt5); 
D1000w8 = D1000w(numreSt8); 
D1000w15 = D1000w(numreSt15); 
D1000w24 = D1000w(numreSt24); 
D1000w43 = D1000w(numreSt43);

D4w2 = D4w(numreSt2);
D4w5 = D4w(numreSt5); 
D4w8 = D4w(numreSt8); 
D4w15 = D4w(numreSt15); 
D4w24 = D4w(numreSt24); 
D4w43 = D4w(numreSt43); 

%%% actual source size
fowbsrc2 = fowb(numreSt2)./(1 + z_2_array);
fowbsrc5 = fowb(numreSt5)./(1 + z_5_array);
fowbsrc8 = fowb(numreSt8)./(1 + z_8_array);
fowbsrc15 = fowb(numreSt15)./(1 + z_15_array);
fowbsrc24 = fowb(numreSt24)./(1 + z_24_array);
fowbsrc43 = fowb(numreSt43)./(1 + z_43_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Characteristic timescale (fowb) vs apparent source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(fowb2 > median(fowb2)); % find out index which is lt median
x2 = find(fowb2 < median(fowb2)); % find out index which is gt median
x3 = find(fowb5 > median(fowb5));
x4 = find(fowb5 < median(fowb5));
x5 = find(fowb8 > median(fowb8));
x6 = find(fowb8 < median(fowb8));
x7 = find(fowb15 > median(fowb15));
x8 = find(fowb15 < median(fowb15));
x9 = find(fowb24 > median(fowb24));
x10 = find(fowb24 < median(fowb24));
x11 = find(fowb43 > median(fowb43));
x12 = find(fowb43 < median(fowb43));

figure(51)
set(gcf,'pos',[100,100,1200,800]);

    subplot('position',[0.06,0.55,0.28,0.36])
    histogram(log10(size2(x1)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size2(x2)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size2(x1))),nanmedian(log10(size2(x1)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size2(x2))),nanmedian(log10(size2(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb2)), sprintf('\\tau_{char} < %4.fd', median(fowb2)),'location','northeast')
    xlabel('log(\theta_{2 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-0.5 0.5])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',3); 
    
    subplot('position',[0.38,0.55,0.28,0.36])
    histogram(log10(size5(x3)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size5(x4)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size5(x3))),nanmedian(log10(size5(x3)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size5(x4))),nanmedian(log10(size5(x4)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb5)), sprintf('\\tau_{char} < %4.fd', median(fowb5)),'location','northeast')
    xlabel('log(\theta_{5 GHz})','FontSize', 20)
    xlim([-1 0.5])
    ylim([0 0.2])
    set(gca,'FontSize',20,'LineWidth',3); 

    subplot('position',[0.70,0.55,0.28,0.36])
    histogram(log10(size8(x5)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size8(x6)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size8(x5))),nanmedian(log10(size8(x5)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size8(x6))),nanmedian(log10(size8(x6)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb8)), sprintf('\\tau_{char} < %4.fd', median(fowb8)),'location','northeast')
    xlabel('log(\theta_{8 GHz})','FontSize', 20)
    xlim([-1 0.])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',3); 
    
    subplot('position',[0.06,0.1,0.28,0.36])
    histogram(log10(size15(x7)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size15(x8)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size15(x7))),nanmedian(log10(size15(x7)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size15(x8))),nanmedian(log10(size15(x8)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb15)), sprintf('\\tau_{char} < %4.fd', median(fowb15)),'location','northeast')
    ylabel('Normalized Frequency','FontSize', 20)
    xlabel('log(\theta_{15 GHz})','FontSize', 20)
    xlim([-1.5 0.])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',3); 

    subplot('position',[0.38,0.1,0.28,0.36])
    histogram(log10(size24(x9)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size24(x10)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size24(x9))),nanmedian(log10(size24(x9)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size24(x10))),nanmedian(log10(size24(x10)))],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb24)), sprintf('\\tau_{char} < %4.fd', median(fowb24)),'location','northeast')
    xlabel('log(\theta_{24 GHz})','FontSize', 20)
    xlim([-1.5 -0.5])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',3); 
    
    subplot('position',[0.70,0.1,0.28,0.36])
    histogram(log10(size43(x11)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size43(x12)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size43(x11))),nanmedian(log10(size43(x11)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size43(x12))),nanmedian(log10(size43(x12)))],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb43)), sprintf('\\tau_{char} < %4.fd', median(fowb43)),'location','northeast')
    xlabel('log(\theta_{43 GHz})','FontSize', 20)
    xlim([-1.5 -0.5])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',3); 
    
%sgt = sgtitle('Characteristic timescale \tau_{char} Distributed by Median of Observe Source Size');
%sgt.FontSize = 20;
%sgt.LineWidth = 2;  

if save_figure == 1
    fig_name = 'tau_char distri. app source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[szr2,szp2] = kstest2(size2(x1),size2(x2));
[szr5,szp5] = kstest2(size5(x3),size5(x4));
[szr8,szp8] = kstest2(size8(x5),size8(x6));
[szr15,szp15] = kstest2(size15(x7),size15(x8));
[szr24,szp24] = kstest2(size24(x9),size24(x10));
[szr43,szp43] = kstest2(size43(x11),size43(x12));

fowb_appsz_KS = [[szr2,szp2];[szr5,szp5];[szr8,szp8];[szr15,szp15];[szr24,szp24];[szr43,szp43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Intrinsic timescale (fowb) vs actual source size KS-Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

figure(52) 
set(gcf,'pos',[100,100,1200,800]);
    
%     subplot('position',[0.06,0.55,0.28,0.36])
%     histogram(log10(realsize2(x1)),'binwidth',0.1,'Normalization','probability')
%     hold on
%     histogram(log10(realsize2(x2)),'binwidth',0.1,'Normalization','probability')
%     plot([nanmedian(log10(realsize2(x1))),nanmedian(log10(realsize2(x1)))],[0,1],'b--','LineWidth',3)
%     plot([nanmedian(log10(realsize2(x2))),nanmedian(log10(realsize2(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
%     hold off
%     legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc2)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc2)),'location','northeast')
%     xlabel('log(l_{2 GHz})','FontSize', 20) 
%     ylabel('Normalized Frequency','FontSize', 20)
%     xlim([0 1.5])
%     ylim([0 0.3])
%     set(gca,'FontSize',20,'LineWidth',3); 
    
%     subplot('position',[0.38,0.55,0.28,0.36])
%     histogram(log10(realsize5(x3)),'binwidth',0.1,'Normalization','probability')
%     hold on
%     histogram(log10(realsize5(x4)),'binwidth',0.1,'Normalization','probability')
%     plot([nanmedian(log10(realsize5(x3))),nanmedian(log10(realsize5(x3)))],[0,1],'b--','LineWidth',3)
%     plot([nanmedian(log10(realsize5(x4))),nanmedian(log10(realsize5(x4)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
%     hold off
%     legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc5)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc5)),'location','northeast')
%     xlabel('log(l_{5 GHz})','FontSize', 20) 
%     xlim([0 1])
%     ylim([0 0.2])
%     set(gca,'FontSize',20,'LineWidth',3); 

    subplot('position',[0.70,0.55,0.28,0.36])
    histogram(log10(realsize8(x5)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize8(x6)),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(realsize8(x5))),nanmedian(log10(realsize8(x5)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(realsize8(x6))),nanmedian(log10(realsize8(x6)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc8)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc8)),'location','northeast')
    xlabel('log(l_{8 GHz})','FontSize', 20) 
    xlim([-0.5 1])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',3); 
    
%     subplot('position',[0.06,0.1,0.28,0.36])
%     histogram(log10(realsize15(x7)),'binwidth',0.1,'Normalization','probability')
%     hold on
%     histogram(log10(realsize15(x8)),'binwidth',0.1,'Normalization','probability')
%     plot([nanmedian(log10(realsize15(x7))),nanmedian(log10(realsize15(x7)))],[0,1],'b--','LineWidth',3)
%     plot([nanmedian(log10(realsize15(x8))),nanmedian(log10(realsize15(x8)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
%     hold off
%     legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc15)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc15)),'location','northeast')
%     xlabel('log(l_{15 GHz})','FontSize', 20) 
%     ylabel('Normalized Frequency','FontSize', 20)
%     xlim([-1 0.5])
%     ylim([0 0.3])
%     set(gca,'FontSize',20,'LineWidth',3); 

%     subplot('position',[0.38,0.1,0.28,0.36])
%     histogram(log10(realsize24(x9)),'binwidth',0.1,'Normalization','probability')
%     hold on
%     histogram(log10(realsize24(x10)),'binwidth',0.1,'Normalization','probability')
%     plot([nanmedian(log10(realsize24(x9))),nanmedian(log10(realsize24(x9)))],[0,1],'b--','LineWidth',3)
%     plot([nanmedian(log10(realsize24(x10))),nanmedian(log10(realsize24(x10)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
%     hold off
%     legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc24)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc24)),'location','northeast')
%     xlabel('log(l_{24 GHz})','FontSize', 20) 
%     xlim([-1 0.5])
%     ylim([0 0.2])
%     set(gca,'FontSize',20,'LineWidth',3); 
    
    subplot('position',[0.70,0.1,0.28,0.36])
    histogram(log10(realsize43(x11)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize43(x12)),'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(realsize43(x11))),nanmedian(log10(realsize43(x11)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(realsize43(x12))),nanmedian(log10(realsize43(x12)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{src} > %4.fd', nanmedian(fowbsrc43)), sprintf('\\tau_{src} < %4.fd', nanmedian(fowbsrc43)),'location','northeast')
    xlabel('log(l_{43 GHz})','FontSize', 20) 
    xlim([-1 0.5])
    ylim([0 0.2])
    set(gca,'FontSize',20,'LineWidth',3); 
    
%sgt = sgtitle('Intrinsic timescale \tau_{src} Distributed by Median of Linear Source Size');
%sgt.FontSize = 20;
%sgt.LineWidth = 2;  

if save_figure == 1
    fig_name = 'tau_src distri. act source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[r2,p2] = kstest2(realsize2(x1),realsize2(x2));
[r5,p5] = kstest2(realsize5(x3),realsize5(x4));
[r8,p8] = kstest2(realsize8(x5),realsize8(x6));
[r15,p15] = kstest2(realsize15(x7),realsize15(x8));
[r24,p24] = kstest2(realsize24(x9),realsize24(x10));
[r43,p43] = kstest2(realsize43(x11),realsize43(x12));

fowbsrc_actsz_KS = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%% SF Amplitude D1000 vs Actual Source Size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(D1000w2 > median(D1000w2));
x2 = find(D1000w2 < median(D1000w2));
x3 = find(D1000w5 > median(D1000w5));
x4 = find(D1000w5 < median(D1000w5));
x5 = find(D1000w8 > median(D1000w8));
x6 = find(D1000w8 < median(D1000w8));
x7 = find(D1000w15 > median(D1000w15));
x8 = find(D1000w15 < median(D1000w15));
x9 = find(D1000w24 > median(D1000w24));
x10 = find(D1000w24 < median(D1000w24));
x11 = find(D1000w43 > median(D1000w43));
x12 = find(D1000w43 < median(D1000w43));

medx1 = nanmedian(log10(realsize2(x1)));
medx2 = nanmedian(log10(realsize2(x2)));
medx3 = nanmedian(log10(realsize5(x3)));
medx4 = nanmedian(log10(realsize5(x4)));
medx5 = nanmedian(log10(realsize8(x5)));
medx6 = nanmedian(log10(realsize8(x6)));
medx7 = nanmedian(log10(realsize15(x7)));
medx8 = nanmedian(log10(realsize15(x8)));
medx9 = nanmedian(log10(realsize24(x9)));
medx10 = nanmedian(log10(realsize24(x10)));
medx11 = nanmedian(log10(realsize43(x11)));
medx12 = nanmedian(log10(realsize43(x12)));

figure(53) 
set(gcf,'pos',[100,100,1200,800]);

%     subplot('position',[0.06,0.55,0.28,0.36])
%     histogram(log10(realsize2(x1)),'binwidth',0.1,'Normalization','probability')
%     hold on
%     histogram(log10(realsize2(x2)),'binwidth',0.1,'Normalization','probability')  
%     plot([medx1,medx1],[0,1],'b--','LineWidth',2.5)
%     plot([medx2,medx2],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
%     hold off
%     legend(sprintf('D(1000d) > %6.4f', median(D1000w2)),sprintf('D(1000d) < %6.4f', median(D1000w2)),'location','northeast')
%     xlabel('log(l_{2 GHz})','FontSize', 20) 
%     ylabel('Normalized Frequency','FontSize', 20)
%     xlim([0 1.5])
%     ylim([0 0.3])
%     set(gca,'FontSize',20,'LineWidth',2); 
    
%     subplot('position',[0.38,0.55,0.28,0.36])
%     histogram(log10(realsize5(x3)),'binwidth',0.1,'Normalization','probability')
%     hold on
%     histogram(log10(realsize5(x4)),'binwidth',0.1,'Normalization','probability')
%     plot([medx3,medx3],[0,1],'b--','LineWidth',2.5)
%     plot([medx4,medx4],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
%     hold off
%     legend(sprintf('D(1000d) > %6.4f', median(D1000w5)),sprintf('D(1000d) < %6.4f', median(D1000w5)),'location','northeast')
%     xlabel('log(l_{5 GHz})','FontSize', 20) 
%     xlim([-0.5 1.5])
%     ylim([0 0.2])
%     set(gca,'FontSize',20,'LineWidth',2); 

    subplot('position',[0.70,0.55,0.28,0.36])
    histogram(log10(realsize8(x5)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize8(x6)),'binwidth',0.1,'Normalization','probability')
    plot([medx5,medx5],[0,1],'b--','LineWidth',2.5)
    plot([medx6,medx6],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w8)),sprintf('D(1000d) < %6.4f', median(D1000w8)),'location','northeast')
    xlabel('log(l_{8 GHz})','FontSize', 20) 
    xlim([-0.5 0.8])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',2); 
    
%     subplot('position',[0.06,0.1,0.28,0.36])
%     histogram(log10(realsize15(x7)),'binwidth',0.1,'Normalization','probability')
%     hold on
%     histogram(log10(realsize15(x8)),'binwidth',0.1,'Normalization','probability')
%     plot([medx7,medx7],[0,1],'b--','LineWidth',2.5)
%     plot([medx8,medx8],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
%     hold off
%     legend(sprintf('D(1000d) > %6.4f', median(D1000w15)),sprintf('D(1000d) < %6.4f', median(D1000w15)),'location','northeast')
%     xlabel('log(l_{15 GHz})','FontSize', 20) 
%     ylabel('Normalized Frequency','FontSize', 20)
%     xlim([-0.8 0.6])
%     ylim([0 0.3])
%     set(gca,'FontSize',20,'LineWidth',2); 

%     subplot('position',[0.38,0.1,0.28,0.36])
%     histogram(log10(realsize24(x9)),'binwidth',0.1,'Normalization','probability')
%     hold on
%     histogram(log10(realsize24(x10)),'binwidth',0.1,'Normalization','probability')
%     plot([medx9,medx9],[0,1],'b--','LineWidth',2.5)
%     plot([medx10,medx10],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
%     hold off
%     legend(sprintf('D(1000d) > %6.4f', median(D1000w24)),sprintf('D(1000d) < %6.4f', median(D1000w24)),'location','northeast')
%     xlabel('log(l_{24 GHz})','FontSize', 20) 
%     xlim([-1. 0.4])
%     ylim([0 0.3])
%     set(gca,'FontSize',20,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.28,0.36])
    histogram(log10(realsize43(x11)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(realsize43(x12)),'binwidth',0.1,'Normalization','probability')
    plot([medx11,medx11],[0,1],'b--','LineWidth',2.5)
    plot([medx12,medx12],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w43)),sprintf('D(1000d) < %6.4f', median(D1000w43)),'location','northeast')
    xlabel('log(l_{43 GHz})','FontSize', 20)
    xlim([-1.2 0.3])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',2); 
    
%sgt = sgtitle('SF Amplitude D(1000d) Distributed by Median of Linear Source Size');
%sgt.FontSize = 20;
%sgt.LineWidth = 2;  

if save_figure == 1
    fig_name = 'linear source sizes distri D1000';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[realsizer2,realsizep2] = kstest2(realsize2(x1),realsize2(x2));
[realsizer5,realsizep5] = kstest2(realsize5(x3),realsize5(x4));
[realsizer8,realsizep8] = kstest2(realsize8(x5),realsize8(x6));
[realsizer15,realsizep15] = kstest2(realsize15(x7),realsize15(x8));
[realsizer24,realsizep24] = kstest2(realsize24(x9),realsize24(x10));
[realsizer43,realsizep43] = kstest2(realsize43(x11),realsize43(x12));

D1000w_actsz_KS = [[realsizer2,realsizep2];[realsizer5,realsizep5];[realsizer8,realsizep8];[realsizer15,realsizep15];[realsizer24,realsizep24];[realsizer43,realsizep43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% SF Amplitude D1000 vs Apparent Source Size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = find(D1000w2 > median(D1000w2));
x2 = find(D1000w2 < median(D1000w2));
x3 = find(D1000w5 > median(D1000w5));
x4 = find(D1000w5 < median(D1000w5));
x5 = find(D1000w8 > median(D1000w8));
x6 = find(D1000w8 < median(D1000w8));
x7 = find(D1000w15 > median(D1000w15));
x8 = find(D1000w15 < median(D1000w15));
x9 = find(D1000w24 > median(D1000w24));
x10 = find(D1000w24 < median(D1000w24));
x11 = find(D1000w43 > median(D1000w43));
x12 = find(D1000w43 < median(D1000w43));

medx1 = nanmedian(log10(size2(x1)));
medx2 = nanmedian(log10(size2(x2)));
medx3 = nanmedian(log10(size5(x3)));
medx4 = nanmedian(log10(size5(x4)));
medx5 = nanmedian(log10(size8(x5)));
medx6 = nanmedian(log10(size8(x6)));
medx7 = nanmedian(log10(size15(x7)));
medx8 = nanmedian(log10(size15(x8)));
medx9 = nanmedian(log10(size24(x9)));
medx10 = nanmedian(log10(size24(x10)));
medx11 = nanmedian(log10(size43(x11)));
medx12 = nanmedian(log10(size43(x12)));

figure(54) 
set(gcf,'pos',[100,100,1200,800]);

    subplot('position',[0.06,0.55,0.28,0.36])
    histogram(log10(size2(x1)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size2(x2)),'binwidth',0.1,'Normalization','probability')  
    plot([medx1,medx1],[0,1],'b--','LineWidth',2.5)
    plot([medx2,medx2],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w2)),sprintf('D(1000d) < %6.4f', median(D1000w2)),'location','northeast')
    xlabel('log(\theta_{2 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-0.5 0.5])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',2); 
    
    subplot('position',[0.38,0.55,0.28,0.36])
    histogram(log10(size5(x3)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size5(x4)),'binwidth',0.1,'Normalization','probability')
    plot([medx3,medx3],[0,1],'b--','LineWidth',2.5)
    plot([medx4,medx4],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w5)),sprintf('D(1000d) < %6.4f', median(D1000w5)),'location','northeast')
    xlabel('log(\theta_{5 GHz})','FontSize', 20) 
    xlim([-1. 0.5])
    ylim([0 0.2])
    set(gca,'FontSize',20,'LineWidth',2); 

    subplot('position',[0.70,0.55,0.28,0.36])
    histogram(log10(size8(x5)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size8(x6)),'binwidth',0.1,'Normalization','probability')
    plot([medx5,medx5],[0,1],'b--','LineWidth',2.5)
    plot([medx6,medx6],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w8)),sprintf('D(1000d) < %6.4f', median(D1000w8)),'location','northeast')
    xlabel('log(\theta_{8 GHz})','FontSize', 20) 
    xlim([-1.2 0.])
    ylim([0 0.35])
    set(gca,'FontSize',20,'LineWidth',2); 
    
    subplot('position',[0.06,0.1,0.28,0.36])
    histogram(log10(size15(x7)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size15(x8)),'binwidth',0.1,'Normalization','probability')
    plot([medx7,medx7],[0,1],'b--','LineWidth',2.5)
    plot([medx8,medx8],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w15)),sprintf('D(1000d) < %6.4f', median(D1000w15)),'location','northeast')
    xlabel('log(\theta_{15 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-1.5 0.])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',2); 

    subplot('position',[0.38,0.1,0.28,0.36])
    histogram(log10(size24(x9)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size24(x10)),'binwidth',0.1,'Normalization','probability')
    plot([medx9,medx9],[0,1],'b--','LineWidth',2.5)
    plot([medx10,medx10],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w24)),sprintf('D(1000d) < %6.4f', median(D1000w24)),'location','northeast')
    xlabel('log(\theta_{24 GHz})','FontSize', 20) 
    xlim([-1.5 -0.5])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',2); 
    
    subplot('position',[0.70,0.1,0.28,0.36])
    histogram(log10(size43(x11)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size43(x12)),'binwidth',0.1,'Normalization','probability')
    plot([medx11,medx11],[0,1],'b--','LineWidth',2.5)
    plot([medx12,medx12],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',2.5)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w43)),sprintf('D(1000d) < %6.4f', median(D1000w43)),'location','northeast')
    xlabel('log(\theta_{43 GHz})','FontSize', 20)
    xlim([-1.5 -0.6])
    ylim([0 0.3])
    set(gca,'FontSize',20,'LineWidth',2); 

%sgt = sgtitle('SF Amplitude D(1000d) Distributed by Median of Observe Source Size');
%sgt.FontSize = 20;
%sgt.LineWidth = 2;  

if save_figure == 1
    fig_name = 'D1000 distri. app source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[sizer2,sizep2] = kstest2(size2(x1),size2(x2));
[sizer5,sizep5] = kstest2(size5(x3),size5(x4));
[sizer8,sizep8] = kstest2(size8(x5),size8(x6));
[sizer15,sizep15] = kstest2(size15(x7),size15(x8));
[sizer24,sizep24] = kstest2(size24(x9),size24(x10));
[sizer43,sizep43] = kstest2(size43(x11),size43(x12));

D1000w_appsz_KS = [[sizer2,sizep2];[sizer5,sizep5];[sizer8,sizep8];[sizer15,sizep15];[sizer24,sizep24];[sizer43,sizep43]];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% SF Amplitude D1000 vs Apparent Source Size
%%% for conference proceedings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_figure = 0;

x1 = find(D1000w2 > median(D1000w2));
x2 = find(D1000w2 < median(D1000w2));
x3 = find(D1000w5 > median(D1000w5));
x4 = find(D1000w5 < median(D1000w5));
x5 = find(D1000w8 > median(D1000w8));
x6 = find(D1000w8 < median(D1000w8));
x7 = find(D1000w15 > median(D1000w15));
x8 = find(D1000w15 < median(D1000w15));
x9 = find(D1000w24 > median(D1000w24));
x10 = find(D1000w24 < median(D1000w24));
x11 = find(D1000w43 > median(D1000w43));
x12 = find(D1000w43 < median(D1000w43));

medx1 = nanmedian(log10(size2(x1)));
medx2 = nanmedian(log10(size2(x2)));
medx3 = nanmedian(log10(size5(x3)));
medx4 = nanmedian(log10(size5(x4)));
medx5 = nanmedian(log10(size8(x5)));
medx6 = nanmedian(log10(size8(x6)));
medx7 = nanmedian(log10(size15(x7)));
medx8 = nanmedian(log10(size15(x8)));
medx9 = nanmedian(log10(size24(x9)));
medx10 = nanmedian(log10(size24(x10)));
medx11 = nanmedian(log10(size43(x11)));
medx12 = nanmedian(log10(size43(x12)));

figure(55) 
set(gcf,'pos',[100,100,1350,900]);

    subplot('position',[0.06,0.55,0.28,0.36])
    histogram(log10(size2(x1)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size2(x2)),'binwidth',0.1,'Normalization','probability')  
    plot([medx1,medx1],[0,1],'b--','LineWidth',3)
    plot([medx2,medx2],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w2)),sprintf('D(1000d) < %6.4f', median(D1000w2)),'location','northeast')
    set(gca,'FontSize', 20,'LineWidth',3); 
    xlabel('log(\theta_{2 GHz})','FontSize', 25) 
    ylabel('Normalized count','FontSize', 25)
    xlim([-0.5 0.5])
    ylim([0 0.3])
    
    subplot('position',[0.38,0.55,0.28,0.36])
    histogram(log10(size5(x3)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size5(x4)),'binwidth',0.1,'Normalization','probability')
    plot([medx3,medx3],[0,1],'b--','LineWidth',3)
    plot([medx4,medx4],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w5)),sprintf('D(1000d) < %6.4f', median(D1000w5)),'location','northeast')
    set(gca,'FontSize', 20,'LineWidth',3); 
    xlabel('log(\theta_{5 GHz})','FontSize', 25) 
    xlim([-1. 0.5])
    ylim([0 0.2])

    subplot('position',[0.70,0.55,0.28,0.36])
    histogram(log10(size8(x5)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size8(x6)),'binwidth',0.1,'Normalization','probability')
    plot([medx5,medx5],[0,1],'b--','LineWidth',3)
    plot([medx6,medx6],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w8)),sprintf('D(1000d) < %6.4f', median(D1000w8)),'location','northeast')
    set(gca,'FontSize', 20,'LineWidth',3); 
    xlabel('log(\theta_{8 GHz})','FontSize', 25) 
    xlim([-1.2 0.])
    ylim([0 0.35])
    
    subplot('position',[0.06,0.1,0.28,0.36])
    histogram(log10(size15(x7)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size15(x8)),'binwidth',0.1,'Normalization','probability')
    plot([medx7,medx7],[0,1],'b--','LineWidth',3)
    plot([medx8,medx8],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w15)),sprintf('D(1000d) < %6.4f', median(D1000w15)),'location','northeast')
    set(gca,'FontSize', 20,'LineWidth',3); 
    xlabel('log(\theta_{15 GHz})','FontSize', 25) 
    ylabel('Normalized count','FontSize', 25)
    xlim([-1.5 0.])
    ylim([0 0.3])

    subplot('position',[0.38,0.1,0.28,0.36])
    histogram(log10(size24(x9)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size24(x10)),'binwidth',0.1,'Normalization','probability')
    plot([medx9,medx9],[0,1],'b--','LineWidth',2.5)
    plot([medx10,medx10],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w24)),sprintf('D(1000d) < %6.4f', median(D1000w24)),'location','northeast')
    set(gca,'FontSize', 20,'LineWidth',3); 
    xlabel('log(\theta_{24 GHz})','FontSize', 25) 
    xlim([-1.5 -0.5])
    ylim([0 0.3])
    
    subplot('position',[0.70,0.1,0.28,0.36])
    histogram(log10(size43(x11)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size43(x12)),'binwidth',0.1,'Normalization','probability')
    plot([medx11,medx11],[0,1],'b--','LineWidth',3)
    plot([medx12,medx12],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend(sprintf('D(1000d) > %6.4f', median(D1000w43)),sprintf('D(1000d) < %6.4f', median(D1000w43)),'location','northeast')
    set(gca,'FontSize', 20,'LineWidth',3); 
    xlabel('log(\theta_{43 GHz})','FontSize', 25)
    xlim([-1.5 -0.6])
    ylim([0 0.3])

if save_figure == 1
    fig_name = 'D1000 distri. app source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Characteristic timescale (fowb) vs apparent source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_figure = 1;

x1 = find(fowb2 > median(fowb2)); % find out index which is lt median
x2 = find(fowb2 < median(fowb2)); % find out index which is gt median
x3 = find(fowb5 > median(fowb5));
x4 = find(fowb5 < median(fowb5));
x5 = find(fowb8 > median(fowb8));
x6 = find(fowb8 < median(fowb8));
x7 = find(fowb15 > median(fowb15));
x8 = find(fowb15 < median(fowb15));
x9 = find(fowb24 > median(fowb24));
x10 = find(fowb24 < median(fowb24));
x11 = find(fowb43 > median(fowb43));
x12 = find(fowb43 < median(fowb43));

figure(56)
set(gcf,'pos',[100,100,1350,900]);

    subplot('position',[0.06,0.55,0.28,0.36])
    histogram(log10(size2(x1)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size2(x2)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size2(x1))),nanmedian(log10(size2(x1)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size2(x2))),nanmedian(log10(size2(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb2)), sprintf('\\tau_{char} < %4.fd', median(fowb2)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',3); 
    xlabel('log(\theta_{2 GHz})','FontSize', 25)
    ylabel('Normalized count','FontSize', 25)
    xlim([-0.5 0.5])
    ylim([0 0.3])
    
    subplot('position',[0.38,0.55,0.28,0.36])
    histogram(log10(size5(x3)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size5(x4)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size5(x3))),nanmedian(log10(size5(x3)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size5(x4))),nanmedian(log10(size5(x4)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb5)), sprintf('\\tau_{char} < %4.fd', median(fowb5)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',3); 
    xlabel('log(\theta_{5 GHz})','FontSize', 25)
    xlim([-1 0.5])
    ylim([0 0.2])

    subplot('position',[0.70,0.55,0.28,0.36])
    histogram(log10(size8(x5)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size8(x6)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size8(x5))),nanmedian(log10(size8(x5)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size8(x6))),nanmedian(log10(size8(x6)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb8)), sprintf('\\tau_{char} < %4.fd', median(fowb8)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',3); 
    xlabel('log(\theta_{8 GHz})','FontSize', 25)
    xlim([-1 0.])
    ylim([0 0.3])
    
    subplot('position',[0.06,0.1,0.28,0.36])
    histogram(log10(size15(x7)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size15(x8)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size15(x7))),nanmedian(log10(size15(x7)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size15(x8))),nanmedian(log10(size15(x8)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb15)), sprintf('\\tau_{char} < %4.fd', median(fowb15)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',3); 
    ylabel('Normalized count','FontSize', 25)
    xlabel('log(\theta_{15 GHz})','FontSize', 25)
    xlim([-1.5 0.])
    ylim([0 0.3])

    subplot('position',[0.38,0.1,0.28,0.36])
    histogram(log10(size24(x9)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size24(x10)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size24(x9))),nanmedian(log10(size24(x9)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size24(x10))),nanmedian(log10(size24(x10)))],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb24)), sprintf('\\tau_{char} < %4.fd', median(fowb24)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',3); 
    xlabel('log(\theta_{24 GHz})','FontSize', 25)
    xlim([-1.5 -0.5])
    ylim([0 0.3])
    
    subplot('position',[0.70,0.1,0.28,0.36])
    histogram(log10(size43(x11)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log10(size43(x12)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log10(size43(x11))),nanmedian(log10(size43(x11)))],[0,1],'b--','LineWidth',3)
    plot([nanmedian(log10(size43(x12))),nanmedian(log10(size43(x12)))],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',3)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(fowb43)), sprintf('\\tau_{char} < %4.fd', median(fowb43)),'location','northeast')
    set(gca,'FontSize',20,'LineWidth',3); 
    xlabel('log(\theta_{43 GHz})','FontSize', 25)
    xlim([-1.5 -0.5])
    ylim([0 0.3])
    
%sgt = sgtitle('Characteristic timescale \tau_{char} Distributed by Median of Observe Source Size');
%sgt.FontSize = 20;
%sgt.LineWidth = 2;  

if save_figure == 1
    fig_name = 'tau_char distri. app source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end


end