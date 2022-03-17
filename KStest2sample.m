%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to do 2 sample K-S test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fobszKS,D1000wactszKS,D1000wappszKS,MFszKS,fowbszKS,fowbzKS,fowbMFKS,fowbactszKS,fowbactzKS,...
    fowbtotMFKS,D2000actszKS,D1500wactszKS] = KStest2sample(fob,fowb,numreSt2,numreSt5,...
    numreSt8,numreSt15,numreSt24,numreSt43,nt2,nt5,nt8,nt15,nt24,nt43,numSt2,numSt5,...
    numSt8,numSt15,numSt24,numSt43,D1000w,D2000w,D1500w,realsize2,realsize5,realsize8,...
    realsize15,realsize24,realsize43,MF,z)

fob2 = fob(numreSt2); 
fob5 = fob(numreSt5);
fob8 = fob(numreSt8);
fob15 = fob(numreSt15);
fob24 = fob(numreSt24);
fob43 = fob(numreSt43);

fowb2 = fowb(numreSt2); 
fowb5 = fowb(numreSt5); 
fowb8 = fowb(numreSt8); 
fowb15 = fowb(numreSt15); 
fowb24 = fowb(numreSt24); 
fowb43 = fowb(numreSt43); 

size2 = nt2(numSt2);
size5 = nt5(numSt5);
size8 = nt8(numSt8);
size15 = nt15(numSt15);
size24 = nt24(numSt24);
size43 = nt43(numSt43);

MF2 = MF(numreSt2); 
MF5 = MF(numreSt5); 
MF8 = MF(numreSt8); 
MF15 = MF(numreSt15); 
MF24 = MF(numreSt24); 
MF43 = MF(numreSt43);

D1000w2 = D1000w(numreSt2);
D1000w5 = D1000w(numreSt5); 
D1000w8 = D1000w(numreSt8); 
D1000w15 = D1000w(numreSt15); 
D1000w24 = D1000w(numreSt24); 
D1000w43 = D1000w(numreSt43);

z2 = z(numSt2);
z5 = z(numSt5);
z8 = z(numSt8);
z15 = z(numSt15);
z24 = z(numSt24);
z43 = z(numSt43);

D1500w2 = D1500w(numreSt2); 
D1500w5 = D1500w(numreSt5); 
D1500w8 = D1500w(numreSt8); 
D1500w15 = D1500w(numreSt15); 
D1500w24 = D1500w(numreSt24); 
D1500w43 = D1500w(numreSt43); 

D2000w2 = D2000w(numreSt2); 
D2000w5 = D2000w(numreSt5); 
D2000w8 = D2000w(numreSt8); 
D2000w15 = D2000w(numreSt15); 
D2000w24 = D2000w(numreSt24); 
D2000w43 = D2000w(numreSt43); 

%%% actual source size
fowbsrc2 = fowb(numreSt2).*(1 + z(numSt2));
fowbsrc5 = fowb(numreSt5).*(1 + z(numSt5));
fowbsrc8 = fowb(numreSt8).*(1 + z(numSt8));
fowbsrc15 = fowb(numreSt15).*(1 + z(numSt15));
fowbsrc24 = fowb(numreSt24).*(1 + z(numSt24));
fowbsrc43 = fowb(numreSt43).*(1 + z(numSt43));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%% Characteristic timescale (fowb) vs source size
figure(51)
set(gcf,'pos',[100,100,1200,800]);

    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(log(size2(x1)),15,'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log(size2(x2)),15,'binwidth',0.2,'Normalization','probability')
    plot([median(log(size2(x1))),median(log(size2(x1)))],[0,1],'b--','LineWidth',1.5)
    plot([median(log(size2(x2))),median(log(size2(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{char} > 636d','\tau_{char} < 636d','location','northeast')
    xlabel('log(\theta_{2 GHz})','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(log(size5(x3)),15,'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log(size5(x4)),15,'binwidth',0.2,'Normalization','probability')
    plot([nanmedian(log(size5(x3))),nanmedian(log(size5(x3)))],[0,1],'b--','LineWidth',1.5)
    plot([median(log(size5(x4))),median(log(size5(x4)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{char} > 726d','\tau_{char} < 726d','location','northeast')
    xlabel('log(\theta_{5 GHz})','FontSize', 20)
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(log(size8(x5)),15,'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log(size8(x6)),15,'binwidth',0.2,'Normalization','probability')
    plot([median(log(size8(x5))),median(log(size8(x5)))],[0,1],'b--','LineWidth',1.5)
    plot([median(log(size8(x6))),median(log(size8(x6)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{char} > 671d','\tau_{char} < 671d','location','northeast')
    xlabel('log(\theta_{8 GHz})','FontSize', 20)
    ylim([0 0.25])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.1,0.25,0.33])
    histogram(log(size15(x7)),15,'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log(size15(x8)),15,'binwidth',0.2,'Normalization','probability')
    plot([median(log(size15(x7))),median(log(size15(x7)))],[0,1],'b--','LineWidth',1.5)
    plot([median(log(size15(x8))),median(log(size15(x8)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{char} > 413d','\tau_{char} < 413d','location','northeast')
    ylabel('Normalized Frequency','FontSize', 20)
    xlabel('log(\theta_{15 GHz})','FontSize', 20)
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.1,0.25,0.33])
    histogram(log(size24(x9)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log(size24(x10)),15,'binwidth',0.1,'Normalization','probability')
    plot([nanmedian(log(size24(x9))),nanmedian(log(size24(x9)))],[0,1],'b--','LineWidth',1.5)
    plot([median(log(size24(x10))),median(log(size24(x10)))],[0,1],'--','color',[0.8500,0.3250,0.0980,0.5],'LineWidth',1.5)
    hold off
    legend('\tau_{char} > 508d','\tau_{char} < 508d','location','northeast')
    xlabel('log(\theta_{24 GHz})','FontSize', 20)
    ylim([0 0.25])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.25,0.33])
    histogram(log(size43(x11)),15,'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log(size43(x12)),15,'binwidth',0.1,'Normalization','probability')
    plot([median(log(size43(x11))),median(log(size43(x11)))],[0,1],'b--','LineWidth',1.5)
    plot([median(log(size43(x12))),median(log(size43(x12)))],[0,1],'--','color',[0.8500,0.3250,0.0980,0.5],'LineWidth',1.5)
    hold off
    legend('\tau_{char} > 469d','\tau_{char} < 469d','location','northeast')
    xlabel('log(\theta_{43 GHz})','FontSize', 20)
    ylim([0 0.4])
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Characteristic timescale and Apparent Source Size 2 Sample K-S Test');
sgt.FontSize = 20;
sgt.LineWidth = 2;  
    
[szr2,szp2] = kstest2(size2(x1),size2(x2));
[szr5,szp5] = kstest2(size5(x3),size5(x4));
[szr8,szp8] = kstest2(size8(x5),size8(x6));
[szr15,szp15] = kstest2(size15(x7),size15(x8));
[szr24,szp24] = kstest2(size24(x9),size24(x10));
[szr43,szp43] = kstest2(size43(x11),size43(x12));

fobszKS = [[szr2,szp2];[szr5,szp5];[szr8,szp8];[szr15,szp15];[szr24,szp24];[szr43,szp43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
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

medx1 = nanmedian(log(realsize2(x1)));
medx2 = nanmedian(log(realsize2(x2)));
medx3 = nanmedian(log(realsize5(x3)));
medx4 = nanmedian(log(realsize5(x4)));
medx5 = nanmedian(log(realsize8(x5)));
medx6 = nanmedian(log(realsize8(x6)));
medx7 = nanmedian(log(realsize15(x7)));
medx8 = nanmedian(log(realsize15(x8)));
medx9 = nanmedian(log(realsize24(x10)));
medx10 = nanmedian(log(realsize24(x9)));
medx11 = nanmedian(log(realsize43(x11)));
medx12 = nanmedian(log(realsize43(x12)));
%%% SF Amplitude D1000 vs Actual Source Size
figure(52) 
set(gcf,'pos',[100,100,1200,800]);

    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(log(realsize2(x1)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize2(x2)),'binwidth',0.5,'Normalization','probability')  
    plot([medx1,medx1],[0,1],'b--','LineWidth',1.5)
    plot([medx2,medx2],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0592','D(1000d) < 0.0592','location','northeast')
    xlabel('log(l_{2 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(log(realsize5(x3)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize5(x4)),'binwidth',0.5,'Normalization','probability')
    plot([medx3,medx3],[0,1],'b--','LineWidth',1.5)
    plot([medx4,medx4],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0566','D(1000d) < 0.0566','location','northeast')
    xlabel('log(l_{5 GHz})','FontSize', 20) 
    ylim([0 0.25])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(log(realsize8(x5)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize8(x6)),'binwidth',0.5,'Normalization','probability')
    plot([medx5,medx5],[0,1],'b--','LineWidth',1.5)
    plot([medx6,medx6],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0612','D(1000d) < 0.0612','location','northeast')
    xlabel('log(l_{8 GHz})','FontSize', 20) 
    ylim([0 0.30])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.1,0.25,0.33])
    histogram(log(realsize15(x7)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize15(x8)),'binwidth',0.5,'Normalization','probability')
    plot([medx7,medx7],[0,1],'b--','LineWidth',1.5)
    plot([medx8,medx8],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0801','D(1000d) < 0.0801','location','northeast')
    xlabel('log(l_{15 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.1,0.25,0.33])
    histogram(log(realsize24(x9)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize24(x10)),'binwidth',0.5,'Normalization','probability')
    plot([medx9,medx9],[0,1],'b--','LineWidth',1.5)
    plot([medx10,medx10],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0817','D(1000d) < 0.0817','location','northeast')
    xlabel('log(l_{24 GHz})','FontSize', 20) 
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.25,0.33])
    histogram(log(realsize43(x11)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize43(x12)),'binwidth',0.5,'Normalization','probability')
    plot([medx11,medx11],[0,1],'b--','LineWidth',1.5)
    plot([medx12,medx12],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.1028','D(1000d) < 0.1028','location','northeast')
    xlabel('log(l_{43 GHz})','FontSize', 20)
    ylim([0 0.5])
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('SF Amplitude D(\tau = 1000 d) and Actual Source Size 2 Sample K-S Test');
sgt.FontSize = 20;
sgt.LineWidth = 2;  
    
[realsizer2,realsizep2] = kstest2(realsize2(x1),realsize2(x2));
[realsizer5,realsizep5] = kstest2(realsize5(x3),realsize5(x4));
[realsizer8,realsizep8] = kstest2(realsize8(x5),realsize8(x6));
[realsizer15,realsizep15] = kstest2(realsize15(x7),realsize15(x8));
[realsizer24,realsizep24] = kstest2(realsize24(x9),realsize24(x10));
[realsizer43,realsizep43] = kstest2(realsize43(x11),realsize43(x12));

D1000wactszKS = [[realsizer2,realsizep2];[realsizer5,realsizep5];[realsizer8,realsizep8];[realsizer15,realsizep15];[realsizer24,realsizep24];[realsizer43,realsizep43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
medx1 = nanmedian(log(size2(x1)));
medx2 = nanmedian(log(size2(x2)));
medx3 = nanmedian(log(size5(x3)));
medx4 = nanmedian(log(size5(x4)));
medx5 = nanmedian(log(size8(x5)));
medx6 = nanmedian(log(size8(x6)));
medx7 = nanmedian(log(size15(x7)));
medx8 = nanmedian(log(size15(x8)));
medx9 = nanmedian(log(size24(x10)));
medx10 = nanmedian(log(size24(x9)));
medx11 = nanmedian(log(size43(x11)));
medx12 = nanmedian(log(size43(x12)));
%%% SF Amplitude D1000 vs Apparent Source Size
figure(53) 
set(gcf,'pos',[100,100,1200,800]);

    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(log(size2(x1)),'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log(size2(x2)),'binwidth',0.2,'Normalization','probability')  
    plot([medx1,medx1],[0,1],'b--','LineWidth',1.5)
    plot([medx2,medx2],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0592','D(1000d) < 0.0592','location','northeast')
    xlabel('log(\theta_{2 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(log(size5(x3)),'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log(size5(x4)),'binwidth',0.2,'Normalization','probability')
    plot([medx3,medx3],[0,1],'b--','LineWidth',1.5)
    plot([medx4,medx4],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0566','D(1000d) < 0.0566','location','northeast')
    xlabel('log(\theta_{5 GHz})','FontSize', 20) 
    ylim([0 0.25])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(log(size8(x5)),'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log(size8(x6)),'binwidth',0.2,'Normalization','probability')
    plot([medx5,medx5],[0,1],'b--','LineWidth',1.5)
    plot([medx6,medx6],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0612','D(1000d) < 0.0612','location','northeast')
    xlabel('log(\theta_{8 GHz})','FontSize', 20) 
    ylim([0 0.25])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.1,0.25,0.33])
    histogram(log(size15(x7)),'binwidth',0.2,'Normalization','probability')
    hold on
    histogram(log(size15(x8)),'binwidth',0.2,'Normalization','probability')
    plot([medx7,medx7],[0,1],'b--','LineWidth',1.5)
    plot([medx8,medx8],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0801','D(1000d) < 0.0801','location','northeast')
    xlabel('log(\theta_{15 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.30])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.1,0.25,0.33])
    histogram(log(size24(x9)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log(size24(x10)),'binwidth',0.1,'Normalization','probability')
    plot([medx9,medx9],[0,1],'b--','LineWidth',1.5)
    plot([medx10,medx10],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.0817','D(1000d) < 0.0817','location','northeast')
    xlabel('log(\theta_{24 GHz})','FontSize', 20) 
    ylim([0 0.20])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.25,0.33])
    histogram(log(size43(x11)),'binwidth',0.1,'Normalization','probability')
    hold on
    histogram(log(size43(x12)),'binwidth',0.1,'Normalization','probability')
    plot([medx11,medx11],[0,1],'b--','LineWidth',1.5)
    plot([medx12,medx12],[0,1],'--','color',[0.8500,0.3250,0.0980],'LineWidth',1.5)
    hold off
    legend('D(1000d) > 0.1028','D(1000d) < 0.01028','location','northeast')
    xlabel('log(\theta_{43 GHz})','FontSize', 20)
    ylim([0 0.45])
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('SF Amplitude D(\tau = 1000 d) and Apparent Source Size 2 Sample K-S Test');
sgt.FontSize = 20;
sgt.LineWidth = 2;  
    
[sizer2,sizep2] = kstest2(size2(x1),size2(x2));
[sizer5,sizep5] = kstest2(size5(x3),size5(x4));
[sizer8,sizep8] = kstest2(size8(x5),size8(x6));
[sizer15,sizep15] = kstest2(size15(x7),size15(x8));
[sizer24,sizep24] = kstest2(size24(x9),size24(x10));
[sizer43,sizep43] = kstest2(size43(x11),size43(x12));

D1000wappszKS = [[sizer2,sizep2];[sizer5,sizep5];[sizer8,sizep8];[sizer15,sizep15];[sizer24,sizep24];[sizer43,sizep43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
x1 = find(MF2 > median(MF2));
x2 = find(MF2 < median(MF2));
x3 = find(MF5 > median(MF5));
x4 = find(MF5 < median(MF5));
x5 = find(MF8 > median(MF8));
x6 = find(MF8 < median(MF8));
x7 = find(MF15 > median(MF15));
x8 = find(MF15 < median(MF15));
x9 = find(MF24 > median(MF24));
x10 = find(MF24 < median(MF24));
x11 = find(MF43 > median(MF43));
x12 = find(MF43 < median(MF43));
%%%% MF vs actual source size KS-Test
figure(54) 
set(gcf,'pos',[100,100,1200,800]);

    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(log(realsize2(x1)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize2(x2)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of mean flux','< median of mean flux','location','northeast')
    xlabel('log(soure size_{2 GHz})','FontSize', 20) 
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(log(realsize5(x3)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize5(x4)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of mean flux','< median of mean flux','location','northeast')
    xlabel('log(soure size_{5 GHz})','FontSize', 20) 
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(log(realsize8(x5)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize8(x6)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of mean flux','< median of mean flux','location','northeast')
    xlabel('log(soure size_{8 GHz})','FontSize', 20) 
    ylim([0 0.30])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.1,0.25,0.33])
    histogram(log(realsize15(x7)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize15(x8)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of mean flux','< median of mean flux','location','northeast')
    xlabel('log(soure size_{15 GHz})','FontSize', 20) 
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.1,0.25,0.33])
    histogram(log(realsize24(x9)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize24(x10)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of mean flux','< median of mean flux','location','northeast')
    xlabel('log(soure size_{24 GHz})','FontSize', 20) 
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.25,0.33])
    histogram(log(realsize43(x11)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize43(x12)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of mean flux','< median of mean flux','location','northeast')
    xlabel('log(soure size_{43 GHz})','FontSize', 20) 
    ylim([0 0.4])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    sgt = sgtitle('Mean Flux and Actual Source Size 2 Sample K-S Test');
    sgt.FontSize = 20;
    sgt.LineWidth = 2;
    
[realsizer2,realsizep2] = kstest2(realsize2(x1),realsize2(x2));
[realsizer5,realsizep5] = kstest2(realsize5(x3),realsize5(x4));
[realsizer8,realsizep8] = kstest2(realsize8(x5),realsize8(x6));
[realsizer15,realsizep15] = kstest2(realsize15(x7),realsize15(x8));
[realsizer24,realsizep24] = kstest2(realsize24(x9),realsize24(x10));
[realsizer43,realsizep43] = kstest2(realsize43(x11),realsize43(x12));

MFszKS = [[realsizer2,realsizep2];[realsizer5,realsizep5];[realsizer8,realsizep8];[realsizer15,realsizep15];[realsizer24,realsizep24];[realsizer43,realsizep43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
x1 = find(fowb2 > median(fowb2));
x2 = find(fowb2 < median(fowb2));
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
%%%% charateristic timescale fowb vs actual source size KS-Test
figure(55) 
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(log(realsize2(x1)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize2(x2)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of \tau_{char}','< median of \tau_{char}','location','northeast')
    xlabel('log(soure size_{2 GHz})','FontSize', 20) 
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(log(realsize5(x3)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize5(x4)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of \tau_{char}','< median of \tau_{char}','location','northeast')
    xlabel('log(soure size_{5 GHz})','FontSize', 20) 
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(log(realsize8(x5)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize8(x6)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of \tau_{char}','< median of \tau_{char}','location','northeast')
    xlabel('log(soure size_{8 GHz})','FontSize', 20) 
    ylim([0 0.30])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.1,0.25,0.33])
    histogram(log(realsize15(x7)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize15(x8)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of \tau_{char}','< median of \tau_{char}','location','northeast')
    xlabel('log(soure size_{15 GHz})','FontSize', 20) 
    ylim([0 0.40])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.1,0.25,0.33])
    histogram(log(realsize24(x9)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize24(x10)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of \tau_{char}','< median of \tau_{char}','location','northeast')
    xlabel('log(soure size_{24 GHz})','FontSize', 20) 
    ylim([0 0.40])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.25,0.33])
    histogram(log(realsize43(x11)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize43(x12)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of \tau_{char}','< median of \tau_{char}','location','northeast')
    xlabel('log(soure size_{43 GHz})','FontSize', 20) 
    ylim([0 0.45])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    sgt = sgtitle('Charateristic Timesclae \tau_{char} and Actual Source Size 2 Sample K-S Test');
    sgt.FontSize = 20;
    sgt.LineWidth = 2;  
    
[r2,p2] = kstest2(realsize2(x1),realsize2(x2));
[r5,p5] = kstest2(realsize5(x3),realsize5(x4));
[r8,p8] = kstest2(realsize8(x5),realsize8(x6));
[r15,p15] = kstest2(realsize15(x7),realsize15(x8));
[r24,p24] = kstest2(realsize24(x9),realsize24(x10));
[r43,p43] = kstest2(realsize43(x11),realsize43(x12));

fowbszKS = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%fowbtotal = [fowb2 ,fowb5, fowb8, fowb15, fowb24, fowb43];
ztotal = [z2, z5, z8, z15, z24, z43];

eqobslim_2 = find(fob(numreSt2) == fowb(numreSt2));
eqobslim_5 = find(fob(numreSt5) == fowb(numreSt5));
eqobslim_8 = find(fob(numreSt8) == fowb(numreSt8));
eqobslim_15 = find(fob(numreSt15) == fowb(numreSt15));
eqobslim_24 = find(fob(numreSt24) == fowb(numreSt24));
eqobslim_43 = find(fob(numreSt43) == fowb(numreSt43));

noteqobslim_2 = find(fob(numreSt2) ~= fowb(numreSt2));
noteqobslim_5 = find(fob(numreSt5) ~= fowb(numreSt5));
noteqobslim_8 = find(fob(numreSt8) ~= fowb(numreSt8));
noteqobslim_15 = find(fob(numreSt15) ~= fowb(numreSt15));
noteqobslim_24 = find(fob(numreSt24) ~= fowb(numreSt24));
noteqobslim_43 = find(fob(numreSt43) ~= fowb(numreSt43));
   
eqobslim = [eqobslim_2,eqobslim_5,eqobslim_8,eqobslim_15,eqobslim_24,eqobslim_43];
noteqobslim = [noteqobslim_2,noteqobslim_5,noteqobslim_8,noteqobslim_15,noteqobslim_24,noteqobslim_43];
     
figure(56) 
set(gcf,'pos',[100,100,1200,800]);
    histogram(ztotal(eqobslim),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(ztotal(noteqobslim),'binwidth',0.5,'Normalization','probability')
    hold off
    
    legend('\tau_{char} > observation limit','\tau_{char} < observation limit','location','northeast')
    set(gca,'FontSize',15,'LineWidth',2); 
    
    sgt = sgtitle('Charateristic Timesclae \tau_{char} and Redshift z 2 Sample K-S Test');
    sgt.FontSize = 20;
    sgt.LineWidth = 2;  
    
[r,p] = kstest2(ztotal(noteqobslim),ztotal(eqobslim));
fowbzKS = [r,p];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
MFtotal = [MF2, MF5, MF8, MF15, MF24, MF43];
%%%% Mean flux vs charateristic timescale fowb
figure(58) 
set(gcf,'pos',[100,100,1200,800]);
    
    histogram(log(MFtotal(eqobslim)),'binwidth',0.5,'Normalization','probability') 
    hold on
    histogram(log(MFtotal(noteqobslim)),'binwidth',0.5,'Normalization','probability') 
    hold off
    
    legend('\tau_{char} > observation limit','\tau_{char} < observation limit','location','northeast')
    set(gca,'FontSize',15,'LineWidth',2); 
    xlabel('log(Mean Flux))','FontSize', 20)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    sgt = sgtitle('Charateristic Timesclae \tau_{char} and Mean Flux 2 Sample K-S Test');
    sgt.FontSize = 20;
    sgt.LineWidth = 2;  

[r,p] = kstest2(MFtotal(noteqobslim),MFtotal(eqobslim));
fowbMFKS = [r,p];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Intrinsic timescale (fowb) vs actual source size KS-Test
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

figure(59) 
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(log(realsize2(x1)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize2(x2)),'binwidth',0.5,'Normalization','probability')
    plot([nanmedian(log(realsize2(x1))),median(log(realsize2(x1)))],[0,1],'b--','LineWidth',1.5)
    plot([nanmedian(log(realsize2(x2))),median(log(realsize2(x2)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{src} > 1474d','\tau_{src} < 1474d','location','northeast')
    xlabel('log(l_{2 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.55])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(log(realsize5(x3)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize5(x4)),'binwidth',0.5,'Normalization','probability')
    plot([nanmedian(log(realsize5(x3))),median(log(realsize5(x3)))],[0,1],'b--','LineWidth',1.5)
    plot([nanmedian(log(realsize5(x4))),median(log(realsize5(x4)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{src} > 1700d','\tau_{src} < 1700d','location','northeast')
    xlabel('log(l_{5 GHz})','FontSize', 20) 
    ylim([0 0.55])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(log(realsize8(x5)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize8(x6)),'binwidth',0.5,'Normalization','probability')
    plot([nanmedian(log(realsize8(x5))),median(log(realsize8(x5)))],[0,1],'b--','LineWidth',1.5)
    plot([nanmedian(log(realsize8(x6))),median(log(realsize8(x6)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{src} > 1439d','\tau_{src} < 1439d','location','northeast')
    xlabel('log(l_{8 GHz})','FontSize', 20) 
    ylim([0 0.50])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.1,0.25,0.33])
    histogram(log(realsize15(x7)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize15(x8)),'binwidth',0.5,'Normalization','probability')
    plot([nanmedian(log(realsize15(x7))),median(log(realsize15(x7)))],[0,1],'b--','LineWidth',1.5)
    plot([nanmedian(log(realsize15(x8))),median(log(realsize15(x8)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{src} > 1495d','\tau_{src} < 1495d','location','northeast')
    xlabel('log(l_{15 GHz})','FontSize', 20) 
    ylabel('Normalized Frequency','FontSize', 20)
    ylim([0 0.55])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.1,0.25,0.33])
    histogram(log(realsize24(x9)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize24(x10)),'binwidth',0.5,'Normalization','probability')
    plot([nanmedian(log(realsize24(x9))),median(log(realsize24(x9)))],[0,1],'b--','LineWidth',1.5)
    plot([nanmedian(log(realsize24(x10))),median(log(realsize24(x10)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{src} > 1240d','\tau_{src} < 1240d','location','northeast')
    xlabel('log(l_{24 GHz})','FontSize', 20) 
    ylim([0 0.60])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.25,0.33])
    histogram(log(realsize43(x11)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize43(x12)),'binwidth',0.5,'Normalization','probability')
    plot([nanmedian(log(realsize43(x11))),median(log(realsize43(x11)))],[0,1],'b--','LineWidth',1.5)
    plot([nanmedian(log(realsize43(x12))),median(log(realsize43(x12)))],[0,1],'--','color',[0.8500 0.3250 0.0980],'LineWidth',1.5)
    hold off
    legend('\tau_{src} > 997d','\tau_{src} < 997d','location','northeast')
    xlabel('log(l_{43 GHz})','FontSize', 20) 
    ylim([0 0.65])
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Intrinsic Timesclae \tau_{src} with Actual Source Size 2 Sample K-S Test');
sgt.FontSize = 20;
sgt.LineWidth = 2;  
    
[r2,p2] = kstest2(realsize2(x1),realsize2(x2));
[r5,p5] = kstest2(realsize5(x3),realsize5(x4));
[r8,p8] = kstest2(realsize8(x5),realsize8(x6));
[r15,p15] = kstest2(realsize15(x7),realsize15(x8));
[r24,p24] = kstest2(realsize24(x9),realsize24(x10));
[r43,p43] = kstest2(realsize43(x11),realsize43(x12));

fowbactszKS = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% Intrinsic timescale (fowb) vs redshift z
figure(60) 
set(gcf,'pos',[100,100,1200,800]);
    histogram(ztotal(eqobslim),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(ztotal(noteqobslim),'binwidth',0.5,'Normalization','probability')
    hold off
    
    legend('\tau_{src} > observation limit','\tau_{src} < observation limit','location','northeast')
    set(gca,'FontSize',15,'LineWidth',2); 
    
    sgt = sgtitle('Charateristic Timesclae \tau_{src} and Redshift z 2 Sample K-S Test');
    sgt.FontSize = 20;
    sgt.LineWidth = 2;  
    
[r,p] = kstest2(ztotal(noteqobslim),ztotal(eqobslim));
fowbactzKS = [r,p];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
MFtotal = [MF2, MF5, MF8, MF15, MF24, MF43];
%%%% Mean flux vs intrinsic timescale (fowb)
figure(61) 
set(gcf,'pos',[100,100,1200,800]);
    
    histogram(log(MFtotal(eqobslim)),'binwidth',0.5,'Normalization','probability') 
    hold on
    histogram(log(MFtotal(noteqobslim)),'binwidth',0.5,'Normalization','probability') 
    hold off
    
    legend('\tau_{src} > observation limit','\tau_{src} < observation limit','location','northeast')
    set(gca,'FontSize',15,'LineWidth',2); 
    xlabel('log(Mean Flux)','FontSize', 20)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    sgt = sgtitle('Charateristic Timesclae \tau_{src} and Mean Flux 2 Sample K-S Test');
    sgt.FontSize = 20;
    sgt.LineWidth = 2;  

[r,p] = kstest2(MFtotal(noteqobslim),MFtotal(eqobslim));
fowbtotMFKS = [r,p];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% SF Amplitude (D2000) vs Actual Source Size
x1 = find(D2000w2 > median(D2000w2));
x2 = find(D2000w2 < median(D2000w2));
x3 = find(D2000w5 > median(D2000w5));
x4 = find(D2000w5 < median(D2000w5));
x5 = find(D2000w8 > median(D2000w8));
x6 = find(D2000w8 < median(D2000w8));
x7 = find(D2000w15 > median(D2000w15));
x8 = find(D2000w15 < median(D2000w15));
x9 = find(D2000w24 > median(D2000w24));
x10 = find(D2000w24 < median(D2000w24));
x11 = find(D2000w43 > median(D2000w43));
x12 = find(D2000w43 < median(D2000w43));

figure(62) 
set(gcf,'pos',[100,100,1200,800]);

    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(log(realsize2(x1)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize2(x2)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=2000)','< median of D(\tau=2000)','location','northeast')
    xlabel('log(soure size_{2 GHz})','FontSize', 20) 
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(log(realsize5(x3)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize5(x4)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=2000)','< median of D(\tau=2000)','location','northeast')
    xlabel('log(soure size_{5 GHz})','FontSize', 20) 
    ylim([0 0.25])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(log(realsize8(x5)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize8(x6)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=2000)','< median of D(\tau=2000)','location','northeast')
    xlabel('log(soure size_{8 GHz})','FontSize', 20) 
    ylim([0 0.25])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.1,0.25,0.33])
    histogram(log(realsize15(x7)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize15(x8)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=2000)','< median of D(\tau=2000)','location','northeast')
    xlabel('log(soure size_{15 GHz})','FontSize', 20) 
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.1,0.25,0.33])
    histogram(log(realsize24(x9)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize24(x10)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=2000)','< median of D(\tau=2000)','location','northeast')
    xlabel('log(soure size_{24 GHz})','FontSize', 20) 
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.25,0.33])
    histogram(log(realsize43(x11)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize43(x12)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=2000)','< median of D(\tau=2000)','location','northeast')
    xlabel('log(soure size_{43 GHz})','FontSize', 20) 
    ylim([0 0.5])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    sgt = sgtitle('SF Amplitude D(\tau = 2000) and Actual Source Size 2 Sample K-S Test');
    sgt.FontSize = 20;
    sgt.LineWidth = 2;  
    
[realsizer2,realsizep2] = kstest2(D2000w2(x1),D2000w2(x2));
[realsizer5,realsizep5] = kstest2(D2000w5(x3),D2000w5(x4));
[realsizer8,realsizep8] = kstest2(D2000w8(x5),D2000w8(x6));
[realsizer15,realsizep15] = kstest2(D2000w15(x7),D2000w15(x8));
[realsizer24,realsizep24] = kstest2(D2000w24(x9),D2000w24(x10));
[realsizer43,realsizep43] = kstest2(D2000w43(x11),D2000w43(x12));

D2000actszKS = [[realsizer2,realsizep2];[realsizer5,realsizep5];[realsizer8,realsizep8];[realsizer15,realsizep15];[realsizer24,realsizep24];[realsizer43,realsizep43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%% SF Amplitude (D1500) vs Actual Source Size
x1 = find(D1500w2 > median(D1500w2));
x2 = find(D1500w2 < median(D1500w2));
x3 = find(D1500w5 > median(D1500w5));
x4 = find(D1500w5 < median(D1500w5));
x5 = find(D1500w8 > median(D1500w8));
x6 = find(D1500w8 < median(D1500w8));
x7 = find(D1500w15 > median(D1500w15));
x8 = find(D1500w15 < median(D1500w15));
x9 = find(D1500w24 > median(D1500w24));
x10 = find(D1500w24 < median(D1500w24));
x11 = find(D1500w43 > median(D1500w43));
x12 = find(D1500w43 < median(D1500w43));

figure(65) 
set(gcf,'pos',[100,100,1200,800]);

    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(log(realsize2(x1)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize2(x2)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=1500)','< median of D(\tau=1500)','location','northeast')
    xlabel('log(soure size_{2 GHz})','FontSize', 20) 
    ylim([0 0.3])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(log(realsize5(x3)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize5(x4)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=1500)','< median of D(\tau=1500)','location','northeast')
    xlabel('log(soure size_{5 GHz})','FontSize', 20) 
    ylim([0 0.25])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(log(realsize8(x5)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize8(x6)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=1500)','< median of D(\tau=1500)','location','northeast')
    xlabel('log(soure size_{8 GHz})','FontSize', 20) 
    ylim([0 0.30])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.1,0.25,0.33])
    histogram(log(realsize15(x7)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize15(x8)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=1500)','< median of D(\tau=1500)','location','northeast')
    xlabel('log(soure size_{15 GHz})','FontSize', 20) 
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.1,0.25,0.33])
    histogram(log(realsize24(x9)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize24(x10)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=1500)','< median of D(\tau=1500)','location','northeast')
    xlabel('log(soure size_{24 GHz})','FontSize', 20) 
    ylim([0 0.35])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.1,0.25,0.33])
    histogram(log(realsize43(x11)),'binwidth',0.5,'Normalization','probability')
    hold on
    histogram(log(realsize43(x12)),'binwidth',0.5,'Normalization','probability')
    hold off
    legend('> median of D(\tau=1500)','< median of D(\tau=1500)','location','northeast')
    xlabel('log(soure size_{43 GHz})','FontSize', 20) 
    ylim([0 0.5])
    set(gca,'FontSize',15,'LineWidth',2); 
    
    sgt = sgtitle('SF Amplitude D(\tau = 1500) and Actual Source Size 2 Sample K-S Test');
    sgt.FontSize = 20;
    sgt.LineWidth = 2;  
    
[realsizer2,realsizep2] = kstest2(D1500w2(x1),D1500w2(x2));
[realsizer5,realsizep5] = kstest2(D1500w5(x3),D1500w5(x4));
[realsizer8,realsizep8] = kstest2(D1500w8(x5),D1500w8(x6));
[realsizer15,realsizep15] = kstest2(D1500w15(x7),D1500w15(x8));
[realsizer24,realsizep24] = kstest2(D1500w24(x9),D1500w24(x10));
[realsizer43,realsizep43] = kstest2(D1500w43(x11),D1500w43(x12));

D1500wactszKS = [[realsizer2,realsizep2];[realsizer5,realsizep5];[realsizer8,realsizep8];[realsizer15,realsizep15];[realsizer24,realsizep24];[realsizer43,realsizep43]];
end