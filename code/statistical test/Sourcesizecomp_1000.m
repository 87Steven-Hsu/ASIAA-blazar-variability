%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to compare sourcesize with tau_char, sfamplitude (tau=1000) and meanflux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 要輸出的變數未改
function [foacorr,fowacorr,fobcorr,fowbcorr] = Sourcesizecomp_1000(foa,fob,fowa,fowb,nt2,nt5,nt8,nt15,nt24,nt43,...
   numreSt2,numSt2,numreSt5,numSt5,numreSt8,numSt8,numreSt15,numSt15,numreSt24,numSt24,numreSt43,numSt43)

% 圖四: source size vs foa(D1000)
figure(4);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    loglog(nt2(numSt2),foa(numreSt2),'r.','MarkerSize',6,'MarkerFaceColor','k') %foa = D(tau = 1000)
    ylim([0 max(foa(numreSt2))]) % x軸從0 ~ fob最大值
    xlim([min(nt2(numSt2)) max(nt2(numSt2))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    fulllabely = strcat('SF Amplitude without weight (D(\tau = 1000))'); % x軸標題
    ylabel(fulllabely,'FontSize', 20)   % x軸標題 & 字體大小
    xlabel('Source Size of 2 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小

    subplot('position',[0.39,0.55,0.25,0.33])
    loglog(nt5(numSt5),foa(numreSt5),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0 max(foa(numreSt5))]) % x軸從0 ~ fob最大值
    xlim([min(nt5(numSt5)) max(nt5(numSt5))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 -
    xlabel('Source Size of 5 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    subplot('position',[0.71,0.55,0.25,0.33])
    loglog(nt8(numSt8),foa(numreSt8),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0 max(foa(numreSt8))]) % x軸從0 ~ fob最大值
    xlim([min(nt8(numSt8)) max(nt8(numSt8))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    xlabel('Source Size of 8 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    subplot('position',[0.07,0.09,0.25,0.33])
    loglog(nt15(numSt15),foa(numreSt15),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0 max(foa(numreSt15))]) % x軸從0 ~ fob最大值
    xlim([min(nt15(numSt15)) max(nt15(numSt15))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    fulllabely = strcat('SF Amplitude without weight (D(\tau = 1000))'); % x軸標題
    ylabel(fulllabely,'FontSize', 20)   % x軸標題 & 字體大小
    xlabel('Source Size of 15 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    subplot('position',[0.39,0.09,0.25,0.33])
    loglog(nt24(numSt24),foa(numreSt24),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0 max(foa(numreSt24))]) % x軸從0 ~ fob最大值
    xlim([min(nt24(numSt24)) max(nt24(numSt24))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    xlabel('Source Size of 24 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    subplot('position',[0.71,0.09,0.25,0.33])
    loglog(nt43(numSt43),foa(numreSt43),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0 max(foa(numreSt43))]) % x軸從0 ~ fob最大值
    xlim([min(nt43(numSt43)) max(nt43(numSt43))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    xlabel('Source Size of 43 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    sgtitle('Compare SF Amplitude (D(\tau = 1000)) with Source Size in Different Frequency'); % 全圖標題
    sgt.FontSize = 15;
    sgt.LineWidth = 2;
    
    [r2,p2] = corr(foa(numreSt2)',nt2(numSt2)','type','Spearman'); % foa = D(tau = 1000)
    [r5,p5] = corr(foa(numreSt5)',nt5(numSt5)','type','Spearman');
    [r8,p8] = corr(foa(numreSt8)',nt8(numSt8)','type','Spearman');
    [r15,p15] = corr(foa(numreSt15)',nt15(numSt15)','type','Spearman');
    [r24,p24] = corr(foa(numreSt24)',nt24(numSt24)','type','Spearman'); 
    [r43,p43] = corr(foa(numreSt43)',nt43(numSt43)','type','Spearman');
    
    foacorr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];   
    
    [r2,p2] = corr(fob(numreSt2)',nt2(numSt2)','type','Spearman');
    [r5,p5] = corr(fob(numreSt5)',nt5(numSt5)','type','Spearman');
    [r8,p8] = corr(fob(numreSt8)',nt8(numSt8)','type','Spearman');
    [r15,p15] = corr(fob(numreSt15)',nt15(numSt15)','type','Spearman');
    [r24,p24] = corr(fob(numreSt24)',nt24(numSt24)','type','Spearman'); 
    [r43,p43] = corr(fob(numreSt43)',nt43(numSt43)','type','Spearman');
    
    fobcorr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];   
    
% 圖六: source size vs fowa
figure(6);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    loglog(nt2(numSt2),fowa(numreSt2),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0.0005 1.5*max(fowa(numreSt2))]) % x軸從0 ~ fob最大值
    xlim([0.8*min(nt2(numSt2)) 1.2*max(nt2(numSt2))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    fulllabely = strcat('SF Amplitude (D(\tau = 1000))'); % x軸標題
    ylabel(fulllabely,'FontSize', 20)   % x軸標題 & 字體大小
    xlabel('Source Size of 2 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小

    subplot('position',[0.39,0.55,0.25,0.33])
    loglog(nt5(numSt5),fowa(numreSt5),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0.0005 1.5*max(fowa(numreSt5))]) % x軸從0 ~ fob最大值
    xlim([0.8*min(nt5(numSt5)) 1.2*max(nt5(numSt5))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    xlabel('Source Size (mas)','FontSize', 20) % y軸標題
    xlabel('Source Size of 5 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    subplot('position',[0.71,0.55,0.25,0.33])
    loglog(nt8(numSt8),fowa(numreSt8),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0.0005 1.5*max(fowa(numreSt8))]) % x軸從0 ~ fob最大值
    xlim([0.8*min(nt8(numSt8)) 1.2*max(nt8(numSt8))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    xlabel('Source Size of 8 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    subplot('position',[0.07,0.09,0.25,0.33])
    loglog(nt15(numSt15),fowa(numreSt15),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0.5*min(fowa(numreSt15)) 1.5*max(fowa(numreSt15))]) % x軸從0 ~ fob最大值
    xlim([0.8*min(nt15(numSt15)) 1.2*max(nt15(numSt15))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    fulllabely = strcat('SF Amplitude (D(\tau = 1000))'); % x軸標題
    ylabel(fulllabely,'FontSize', 20)   % x軸標題 & 字體大小
    xlabel('Source Size of 15 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    subplot('position',[0.39,0.09,0.25,0.33])
    loglog(nt24(numSt24),fowa(numreSt24),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0.5*min(fowa(numreSt24)) 1.5*max(fowa(numreSt24))]) % x軸從0 ~ fob最大值
    xlim([0.8*min(nt24(numSt24)) 1.2*max(nt24(numSt24))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    xlabel('Source Size of 24 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    subplot('position',[0.71,0.09,0.25,0.33])
    loglog(nt43(numSt43),fowa(numreSt43),'r.','MarkerSize',6,'MarkerFaceColor','k')
    ylim([0.5*min(fowa(numreSt43)) 1.5*max(fowa(numreSt43))]) % x軸從0 ~ fob最大值
    xlim([0.8*min(nt43(numSt43)) 1.2*max(nt43(numSt43))])   % y軸從0.8*size最小值 ~ 1.2*size最大值 
    xlabel('Source Size of 43 GHz (mas)','FontSize', 20) % x軸標題
    set(gca,'FontSize',17,'LineWidth',2); % 全圖標題 & 字體大小
    
    sgt = sgtitle('Compare SF Amplitude (D(\tau = 1000)) with Source Size in Different Frequency'); % 全圖標題
    sgt.FontSize = 25;
    sgt.LineWidth = 2;

%     fowat2corrP = corr(fowa(numreSt2)',nt2(numSt2)','type','Pearson');
%     fowat2corrK = corr(fowa(numreSt2)',nt2(numSt2)','type','Kendall');
    [r2,p2] = corr(fowa(numreSt2)',nt2(numSt2)','type','Spearman');
    
%     fowat5corrP = corr(fowa(numreSt5)',nt5(numSt5)','type','Pearson');
%     fowat5corrK = corr(fowa(numreSt5)',nt5(numSt5)','type','Kendall');
    [r5,p5] = corr(fowa(numreSt5)',nt5(numSt5)','type','Spearman');
    
%     fowat8corrP = corr(fowa(numreSt8)',nt8(numSt8)','type','Pearson');
%     fowat8corrK = corr(fowa(numreSt8)',nt8(numSt8)','type','Kendall');
    [r8,p8] = corr(fowa(numreSt8)',nt8(numSt8)','type','Spearman');
    
%     fowat15corrP = corr(fowa(numreSt15)',nt15(numSt15)','type','Pearson');
%     fowat15corrK = corr(fowa(numreSt15)',nt15(numSt15)','type','Kendall');
    [r15,p15] = corr(fowa(numreSt15)',nt15(numSt15)','type','Spearman');
    
%     fowat24corrP = corr(fowa(numreSt24)',nt24(numSt24)','type','Pearson');     
%     fowat24corrK = corr(fowa(numreSt24)',nt24(numSt24)','type','Kendall'); 
    [r24,p24] = corr(fowa(numreSt24)',nt24(numSt24)','type','Spearman'); 
    
%     fowat43corrP = corr(fowa(numreSt43)',nt43(numSt43)','type','Pearson');
%     fowat43corrK = corr(fowa(numreSt43)',nt43(numSt43)','type','Kendall');
    [r43,p43] = corr(fowa(numreSt43)',nt43(numSt43)','type','Spearman');
    
    fowacorr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];    

    [r2,p2] = corr(fowb(numreSt2)',nt2(numSt2)','type','Spearman');
    [r5,p5] = corr(fowb(numreSt5)',nt5(numSt5)','type','Spearman');
    [r8,p8] = corr(fowb(numreSt8)',nt8(numSt8)','type','Spearman');
    [r15,p15] = corr(fowb(numreSt15)',nt15(numSt15)','type','Spearman');
    [r24,p24] = corr(fowb(numreSt24)',nt24(numSt24)','type','Spearman'); 
    [r43,p43] = corr(fowb(numreSt43)',nt43(numSt43)','type','Spearman');
    
    fowbcorr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];   
end

