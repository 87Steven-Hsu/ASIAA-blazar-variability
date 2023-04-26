%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to compare apparent/actual sourcesize with tau_char/src, SF amplitude (D(100) & D(1000)), 
% redshift and meanflux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [D1000w_appsz_corr, D1000w_actsz_corr, D4w_actsz_corr,...
    D4w_appsz_corr]= Sourcesizecomp_table2(fob,fowb, ...
    D1000w,SFerru,SFerrd,D4w,D4w_uperr,D4w_lowerr,Dnoise, save_figure,...
    numreSt2,numreSt5,numreSt8,numreSt15,numreSt24,numreSt43, ...
    numSt2,numSt5,numSt8,numSt15,numSt24,numSt43, ...
    size2_median,size5_median,size8_median,size15_median,size24_median,size43_median,...
    realsize2,realsize5,realsize8,realsize15,realsize24,realsize43, ...
    z_2_array,z_5_array,z_8_array,z_15_array,z_24_array,z_43_array)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Set up parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fowb2 = fowb(numreSt2); 
fowb5 = fowb(numreSt5); 
fowb8 = fowb(numreSt8); 
fowb15 = fowb(numreSt15); 
fowb24 = fowb(numreSt24); 
fowb43 = fowb(numreSt43); 

eqobslim_2 = find(fob(numreSt2) == fowb(numreSt2));
eqobslim_5 = find(fob(numreSt5) == fowb(numreSt5));
eqobslim_8 = find(fob(numreSt8) == fowb(numreSt8));
eqobslim_15 = find(fob(numreSt15) == fowb(numreSt15));
eqobslim_24 = find(fob(numreSt24) == fowb(numreSt24));
eqobslim_43 = find(fob(numreSt43) == fowb(numreSt43));

neqobslim_2 = find(fob(numreSt2) ~= fowb(numreSt2));
neqobslim_5 = find(fob(numreSt5) ~= fowb(numreSt5));
neqobslim_8 = find(fob(numreSt8) ~= fowb(numreSt8));
neqobslim_15 = find(fob(numreSt15) ~= fowb(numreSt15));
neqobslim_24 = find(fob(numreSt24) ~= fowb(numreSt24));
neqobslim_43 = find(fob(numreSt43) ~= fowb(numreSt43));
    
size2 = size2_median;
size5 = size5_median;
size8 = size8_median;
size15 = size15_median;
size24 = size24_median;
size43 = size43_median;    

D1000w2 = D1000w(numreSt2);
D1000w5 = D1000w(numreSt5); 
D1000w8 = D1000w(numreSt8); 
D1000w15 = D1000w(numreSt15); 
D1000w24 = D1000w(numreSt24); 
D1000w43 = D1000w(numreSt43); 

SFerru2 = SFerru(numreSt2); 
SFerru5 = SFerru(numreSt5); 
SFerru8 = SFerru(numreSt8); 
SFerru15 = SFerru(numreSt15); 
SFerru24 = SFerru(numreSt24); 
SFerru43 = SFerru(numreSt43); 

lt0u2 = find(SFerru2 < 0);
SFerru2(lt0u2) = Dnoise(numreSt2(lt0u2));
lt0u5 = find(SFerru5 < 0);
SFerru5(lt0u5) = Dnoise(numreSt5(lt0u5));
lt0u8 = find(SFerru8 < 0);
SFerru8(lt0u8) = Dnoise(numreSt8(lt0u8));
lt0u15 = find(SFerru15 < 0);
SFerru15(lt0u15) = Dnoise(numreSt15(lt0u15));
lt0u24 = find(SFerru24 < 0);
SFerru24(lt0u24) = Dnoise(numreSt24(lt0u24));
lt0u43 = find(SFerru43 < 0);
SFerru43(lt0u43) = Dnoise(numreSt43(lt0u43));

SFerrd2 = SFerrd(numreSt2); 
SFerrd5 = SFerrd(numreSt5); 
SFerrd8 = SFerrd(numreSt8); 
SFerrd15 = SFerrd(numreSt15); 
SFerrd24 = SFerrd(numreSt24); 
SFerrd43 = SFerrd(numreSt43); 

lt0d2 = find(SFerrd2 < 0);
SFerrd2(lt0d2) = Dnoise(numreSt2(lt0d2));
lt0d5 = find(SFerrd5 < 0);
SFerrd5(lt0d5) = Dnoise(numreSt5(lt0d5));
lt0d8 = find(SFerrd8 < 0);
SFerrd8(lt0d8) = Dnoise(numreSt8(lt0d8));
lt0d15 = find(SFerrd15 < 0);
SFerrd15(lt0d15) = Dnoise(numreSt15(lt0d15));
lt0d24 = find(SFerrd24 < 0);
SFerrd24(lt0d24) = Dnoise(numreSt24(lt0d24));
lt0d43 = find(SFerrd43 < 0);
SFerrd43(lt0d43) = Dnoise(numreSt43(lt0d43));

D4w2 = D4w(numreSt2);
D4w5 = D4w(numreSt5); 
D4w8 = D4w(numreSt8); 
D4w15 = D4w(numreSt15); 
D4w24 = D4w(numreSt24); 
D4w43 = D4w(numreSt43); 

D4w_uperr2 = D4w_uperr(numreSt2); 
D4w_uperr5 = D4w_uperr(numreSt5); 
D4w_uperr8 = D4w_uperr(numreSt8); 
D4w_uperr15 = D4w_uperr(numreSt15); 
D4w_uperr24 = D4w_uperr(numreSt24); 
D4w_uperr43 = D4w_uperr(numreSt43); 

D4w_lowerr2 = D4w_lowerr(numreSt2); 
D4w_lowerr5 = D4w_lowerr(numreSt5); 
D4w_lowerr8 = D4w_lowerr(numreSt8); 
D4w_lowerr15 = D4w_lowerr(numreSt15); 
D4w_lowerr24 = D4w_lowerr(numreSt24); 
D4w_lowerr43 = D4w_lowerr(numreSt43); 

fowbsrc2 = fowb(numreSt2)./(1 + z_2_array);
fowbsrc5 = fowb(numreSt5)./(1 + z_5_array);
fowbsrc8 = fowb(numreSt8)./(1 + z_8_array);
fowbsrc15 = fowb(numreSt15)./(1 + z_15_array);
fowbsrc24 = fowb(numreSt24)./(1 + z_24_array);
fowbsrc43 = fowb(numreSt43)./(1 + z_43_array);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % characteristic timescale tau_char (fowb) vs.apparent source size
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(1);
%     set(gcf,'pos',[100,100,1200,800]);
%     
%     subplot('position',[0.07,0.55,0.25,0.33])
%     plot(size2,fowb2,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(size2(eqobslim_2),fowb2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','g')
%     hold off
%     ylim([0 max(fowb2)]) 
%     xlim([0.8*min(size2) 5])   
%     xlabel('Source Size of 2 GHz (mas)','FontSize', 20)
%     ylabel('\tau_{char} (days)','FontSize', 20)   
%     set(gca,'FontSize', 20,'LineWidth',2); 
% 
%     subplot('position',[0.39,0.55,0.25,0.33])
%     plot(size5,fowb5,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(size5(eqobslim_5),fowb5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','g')
%     hold off
%     ylim([0 max(fowb5)]) 
%     xlim([0.8*min(size5) 1*max(size5)])
%     xlabel('Source Size of 5 GHz (mas)','FontSize', 20)
%     set(gca,'FontSize', 20,'LineWidth',2); 
%     
%     subplot('position',[0.71,0.55,0.25,0.33])
%     plot(size8,fowb8,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(size8(eqobslim_8),fowb8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','g')
%     hold off
%     ylim([0 max(fowb8)]) 
%     xlim([0.8*min(size8) 1*max(size8)])
%     xlabel('Source Size of 8 GHz (mas)','FontSize', 20)
%     set(gca,'FontSize', 20,'LineWidth',2); 
%     
%     subplot('position',[0.07,0.09,0.25,0.33])
%     plot(size15,fowb15,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(size15(eqobslim_15),fowb15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','g')
%     hold off
%     ylim([0 max(fowb15)]) 
%     xlim([0.8*min(size15) 1.*max(size15)])
%     ylabel('\tau_{char} (days)','FontSize', 20)   
%     xlabel('Source Size of 15 GHz (mas)','FontSize', 20)
%     set(gca,'FontSize', 20,'LineWidth',2); 
%     
%     subplot('position',[0.39,0.09,0.25,0.33])
%     plot(size24,fowb24,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(size24(eqobslim_24),fowb24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','g')
%     hold off
%     ylim([0 max(fowb24)]) 
%     xlim([0.8*min(size24) 1.*max(size24)])
%     xlabel('Source Size (mas)','FontSize', 20)
%     xlabel('Source Size of 24 GHz (mas)','FontSize', 20)
%     set(gca,'FontSize', 20,'LineWidth',2); 
%     
%     subplot('position',[0.71,0.09,0.25,0.33])
%     plot(size43,fowb43,'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(size43(eqobslim_43),fowb43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','g')
%     hold off
%     ylim([0 max(fowb43)]) 
%     xlim([0.8*min(size43) 1.*max(size43)])
%     xlabel('Source Size of 43 GHz (mas)','FontSize', 20)
%     set(gca,'FontSize', 20,'LineWidth',2); 
%     
% sgt = sgtitle('Compare Characteristic Timescale \tau_{char} Against Apparent Source Size in Multi-frequencies'); 
% sgt.FontSize = 20;
% sgt.LineWidth = 2;
% 
% %%% save figure in high resolution
% if save_figure == 1
%     fig_name = 'tau_char vs. app source size';
%     save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
%     print(gcf,save_path,'-dpng','-r400')
% end
%     
% [r2,p2] = corr(size2(neqobslim_2)',fowb2(neqobslim_2)','type','Spearman','rows','complete');
% [r5,p5] = corr(size5(neqobslim_5)',fowb5(neqobslim_5)','type','Spearman','rows','complete');
% [r8,p8] = corr(size8(neqobslim_8)',fowb8(neqobslim_8)','type','Spearman','rows','complete');
% [r15,p15] = corr(size15(neqobslim_15)',fowb15(neqobslim_15)','type','Spearman','rows','complete');
% [r24,p24] = corr(size24(neqobslim_24)',fowb24(neqobslim_24)','type','Spearman','rows','complete');
% [r43,p43] = corr(size43(neqobslim_43)',fowb43(neqobslim_43)','type','Spearman','rows','complete');
% 
% tauw_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% characteristic timescale (fowb) vs actual size 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index2 = ~isnan(realsize2);
index5 = ~isnan(realsize5);
index8 = ~isnan(realsize8);
index15 = ~isnan(realsize15);
index24 = ~isnan(realsize24);
index43 = ~isnan(realsize43);
% 
% figure(2);   
% set(gcf,'pos',[100,100,1200,800]);
%     
%     subplot('position',[0.07,0.55,0.25,0.33])
%     plot(realsize2(index2),fowbsrc2(index2),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(realsize2(eqobslim_2),fowbsrc2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','g') 
%     hold off
%     xlim([0 max(realsize2(index2))])
%     ylim([min(fowbsrc2(index2)) max(fowbsrc2(index2))])   
%     xlabel('Source Size of 2 GHz (pc)','FontSize', 20)
%     ylabel('\tau_{char} (days)','FontSize', 20)  
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
% 
%     subplot('position',[0.39,0.55,0.25,0.33])
%     plot(realsize5(index5),fowbsrc5(index5),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(realsize5(eqobslim_5),fowbsrc5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','g') 
%     hold off
%     xlim([0 max(realsize5(index5))])
%     ylim([min(fowbsrc5(index5)) max(fowbsrc5(index5))])  
%     xlabel('Source Size of 5 GHz (pc)','FontSize', 20)
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
%     
%     subplot('position',[0.71,0.55,0.25,0.33])
%     plot(realsize8(index8),fowbsrc8(index8),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(realsize8(eqobslim_8),fowbsrc8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','g') 
%     hold off
%     xlim([0 max(realsize8(index8))])
%     ylim([min(fowbsrc8(index8)) max(fowbsrc8(index8))]) 
%     xlabel('Source Size of 8 GHz (pc)','FontSize', 20)
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
%     
%     subplot('position',[0.07,0.09,0.25,0.33])
%     plot(realsize15(index15),fowbsrc15(index15),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(realsize15(eqobslim_15),fowbsrc15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','g') 
%     hold off
%     xlim([0 max(realsize15(index15))])
%     ylim([min(fowbsrc15(index15)) max(fowbsrc15(index15))]) 
%     xlabel('Source Size of 15 GHz (pc)','FontSize', 20)
%     ylabel('\tau_{char} (days)','FontSize', 20)  
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
%     
%     subplot('position',[0.39,0.09,0.25,0.33])
%     plot(realsize24(index24),fowbsrc24(index24),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     plot(realsize24(eqobslim_24),fowbsrc24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','g') 
%     hold off
%     xlim([0 max(realsize24(index24))])
%     ylim([min(fowbsrc24(index24)) max(fowbsrc24(index24))]) 
%     xlabel('Source Size of 24 GHz (pc)','FontSize', 20)
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
%     
%     subplot('position',[0.71,0.09,0.25,0.33])
%     plot(realsize43(index43),fowbsrc43(index43),'ro','MarkerSize',5,'MarkerFaceColor','r')  
%     hold on 
%     plot(realsize43(eqobslim_43),fowbsrc43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','g') 
%     hold off
%     xlim([0 max(realsize43(index43))])
%     ylim([min(fowbsrc43(index43)) max(fowbsrc43(index43))]) 
%     xlabel('Source Size of 43 GHz (pc)','FontSize', 20)
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
%     
% sgt = sgtitle('Compare Intrinsic Timescale \tau_{stc} Against Actual Source Size in Multi-frequencies'); 
% sgt.FontSize = 20;
% sgt.LineWidth = 2;
% 
% if save_figure == 1
%     fig_name = 'tau_src vs. act source size';    
%     save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
%     print(gcf,save_path,'-dpng','-r400')
% end
%     
% [r2,p2]= corr(realsize2(index2)',fowbsrc2(index2)','type','Spearman','rows','complete');
% [r5,p5] = corr(realsize5(index5)',fowbsrc5(index5)','type','Spearman','rows','complete');
% [r8,p8] = corr(realsize8(index8)',fowbsrc8(index8)','type','Spearman','rows','complete');
% [r15,p15] = corr(realsize15(index15)',fowbsrc15(index15)','type','Spearman','rows','complete');
% [r24,p24] = corr(realsize24(index24)',fowbsrc24(index24)','type','Spearman','rows','complete'); 
% [r43,p43] = corr(realsize43(index43)',fowbsrc43(index43)','type','Spearman','rows','complete');
%     
% fowbsrc_actsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% D1000w vs apparent source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.28,0.36])
    plot(size2,D1000w2,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size2,D1000w2,D1000w2-SFerrd2,SFerru2-D1000w2,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size2(D1000w2 < 0),Dnoise(numreSt2(D1000w2 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size2)*0.8 max(size2)*1.2])  
    ylim([min(D1000w2)*0.5 max(D1000w2)*3]) 
    xlabel('\theta_{2 GHz} (mas)','FontSize', 20) 
    ylabel('SF Amplitude D(1000d)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 20,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.28,0.36])
    loglog(size5,D1000w5,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size5,D1000w5,D1000w5-SFerrd5,SFerru5-D1000w5,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size5(D1000w5 < 0),Dnoise(numreSt5(D1000w5 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size5)*0.8 max(size5)*1.2]) 
    ylim([min(D1000w)*0.5 max(D1000w5)*3]) 
    xlabel('\theta_{5 GHz} (mas)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 20,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.28,0.36])
    loglog(size8,D1000w8,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size8,D1000w8,D1000w8-SFerrd8,SFerru8-D1000w8,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size8(D1000w8 < 0),Dnoise(numreSt8(D1000w8 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size8)*0.8 max(size8)*1.2])  
    ylim([min(D1000w8)*0.5 max(D1000w8)*3]) 
    xlabel('\theta_{8 GHz} (mas)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 20,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.28,0.36])
    loglog(size15,D1000w15,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size15,D1000w15,D1000w15-SFerrd15,SFerru15-D1000w15,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size15(D1000w15 < 0),Dnoise(numreSt15(D1000w15 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size15)*0.8 max(size15)*1.2]) 
    ylim([min(D1000w15)*0.5 max(D1000w15)*3]) 
    xlabel('\theta_{15 GHz} (mas)','FontSize', 20) 
    ylabel('SF Amplitude D(1000d)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 20,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.28,0.36])
    loglog(size24,D1000w24,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size24,D1000w24,D1000w24-SFerrd24,SFerru24-D1000w24,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size24(D1000w24 < 0),Dnoise(numreSt24(D1000w24 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size24)*0.8 max(size24)*1.2]) 
    ylim([min(D1000w24)*0.5 max(D1000w24)*3]) 
    xlabel('\theta_{24 GHz} (mas)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 20,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.28,0.36])
    loglog(size43,D1000w43,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size43,D1000w43,D1000w43-SFerrd43,SFerru43-D1000w43,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size43(D1000w43 < 0),Dnoise(numreSt43(D1000w43 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size43)*0.8 max(size43)*1.2]) 
    ylim([min(D1000w43)*0.5 max(D1000w43)*3]) 
    xlabel('\theta_{43 GHz} (mas)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 20,'LineWidth',2); 
    
%sgt = sgtitle('Compare SF Amplitude D(1000d) Against Observe Source Size in Multi-frequencies'); 
%sgt.FontSize = 20;
%sgt.LineWidth = 2;

if save_figure == 1
    fig_name = 'D1000 vs. app source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end

[r2,p2] = corr(D1000w(numreSt2)',size2','type','Spearman','rows','complete');
[r5,p5] = corr(D1000w(numreSt5)',size5','type','Spearman','rows','complete');
[r8,p8] = corr(D1000w(numreSt8)',size8','type','Spearman','rows','complete');
[r15,p15] = corr(D1000w(numreSt15)',size15','type','Spearman','rows','complete');
[r24,p24] = corr(D1000w(numreSt24)',size24','type','Spearman','rows','complete'); 
[r43,p43] = corr(D1000w(numreSt43)',size43','type','Spearman','rows','complete');
  
D1000w_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% D1000 vs actual source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4);   
set(gcf,'pos',[100,100,1200,800]);
    
%     subplot('position',[0.06,0.55,0.28,0.36])
%     plot(realsize2(index2),D1000w2(index2),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     errorbar(realsize2,D1000w2,D1000w2-SFerrd2,SFerru2-D1000w2,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
%     plot(realsize2(D1000w2 < 0),Dnoise(numreSt2(D1000w2 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
%     hold off
%     xlim([min(realsize2(index2))*0.8 max(realsize2(index2))*1.2]) 
%     ylim([min(D1000w2(index2))*0.5 max(D1000w2(index2))*3])  
%     xlabel('l_{2 GHz} (pc)','FontSize', 20)
%     ylabel('SF Amplitude D(1000d)','FontSize', 20)  
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 

%     subplot('position',[0.38,0.55,0.28,0.36])
%     plot(realsize5(index5),D1000w5(index5),'ro','MarkerSize',5,'MarkerFaceColor','r')
%     hold on 
%     errorbar(realsize5,D1000w5,D1000w5-SFerrd5,SFerru5-D1000w5,'r.','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
%     plot(realsize5(D1000w5 < 0),Dnoise(numreSt5(D1000w5 < 0)),'b.','MarkerSize',5,'MarkerFaceColor','k') 
%     hold off
%     xlim([0.2 max(realsize5(index5))*1.2]) 
%     ylim([min(D1000w5(index5))*0.5 max(D1000w5(index5))*3])  
%     xlabel('l_{5 GHz} (pc)','FontSize', 20)
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
    
    subplot('position',[0.70,0.55,0.28,0.36])
    plot(realsize8(index8),D1000w8(index8),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize8,D1000w8,D1000w8-SFerrd8,SFerru8-D1000w8,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize8(D1000w8 < 0),Dnoise(numreSt8(D1000w8 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(realsize8(index8))*0.8 max(realsize8(index8))*1.2]) 
    ylim([min(D1000w8(index8))*0.5 max(D1000w8(index8))*3]) 
    xlabel('l_{8 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
    
%     subplot('position',[0.06,0.09,0.28,0.36])
%     plot(realsize15(index15),D1000w15(index15),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     errorbar(realsize15,D1000w15,D1000w15-SFerrd15,SFerru15-D1000w15,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
%     plot(realsize15(D1000w15 < 0),Dnoise(numreSt15(D1000w15 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
%     hold off
%     xlim([min(realsize15(index15))*0.8 max(realsize15(index15))*1.2]) 
%     ylim([min(D1000w15(index15))*0.5 max(D1000w15(index15))*3]) 
%     xlabel('l_{15 GHz} (pc)','FontSize', 20)
%     ylabel('SF Amplitude D(1000d)','FontSize', 20)  
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
    
%     subplot('position',[0.38,0.09,0.28,0.36])
%     plot(realsize24(index24),D1000w24(index24),'ro','MarkerSize',5,'MarkerFaceColor','r') 
%     hold on 
%     errorbar(realsize24,D1000w24,D1000w24-SFerrd24,SFerru24-D1000w24,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
%     plot(realsize24(D1000w24 < 0),Dnoise(numreSt24(D1000w24 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
%     hold off
%     xlim([min(realsize24(index24))*0.8 max(realsize24(index24))*1.2]) 
%     ylim([min(D1000w24(index24))*0.5 max(D1000w24(index24))*3]) 
%     xlabel('l_{24 GHz} (pc)','FontSize', 20)
%     set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
    
    subplot('position',[0.70,0.09,0.28,0.36])
    plot(realsize43(index43),D1000w43(index43),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize43,D1000w43,D1000w43-SFerrd43,SFerru43-D1000w43,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize43(D1000w43 < 0),Dnoise(numreSt43(D1000w43 < 0)),'b.','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(realsize43(index43))*0.8 max(realsize43(index43))*1.2]) 
    ylim([min(D1000w43(index43))*0.5 max(D1000w43(index43))*3]) 
    xlabel('l_{43 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 20,'LineWidth',2); 
    
%sgt = sgtitle('Compare SF Amplitude D(1000d) Against Linear Source Size in Multi-frequencies'); 
%sgt.FontSize = 20;
%sgt.LineWidth = 2;

if save_figure == 1
    fig_name = 'D1000 vs. act source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[r2,p2]= corr(realsize2(index2)',D1000w2(index2)','type','Spearman','rows','complete');
[r5,p5] = corr(realsize5(index5)',D1000w5(index5)','type','Spearman','rows','complete');
[r8,p8] = corr(realsize8(index8)',D1000w8(index8)','type','Spearman','rows','complete');
[r15,p15] = corr(realsize15(index15)',D1000w15(index15)','type','Spearman','rows','complete');
[r24,p24] = corr(realsize24(index24)',D1000w24(index24)','type','Spearman','rows','complete'); 
[r43,p43] = corr(realsize43(index43)',D1000w43(index43)','type','Spearman','rows','complete');
    
D1000w_actsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% D4 vs apparent source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.28,0.36])
    plot(size2,D4w2,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size2,D4w2,D4w2-D4w_lowerr2,D4w_uperr2-D4w2,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size2(D4w2 < 0),Dnoise(numreSt2(D4w2 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size2)*0.8 max(size2)*1.2])  
    ylim([min(D4w2)*0.8 0.09]) 
    xlabel('\theta_{2 GHz} (mas)','FontSize', 20) 
    ylabel('SF Amplitude D(4d)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.28,0.36])
    loglog(size5,D4w5,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size5,D4w5,D4w5-D4w_lowerr5,D4w_uperr5-D4w5,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size5(D4w5 < 0),Dnoise(numreSt5(D4w5 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size5)*0.8 max(size5)*1.2]) 
    ylim([min(D4w5)*0.8 0.09]) 
    xlabel('\theta_{5 GHz} (mas)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.28,0.36])
    loglog(size8,D4w8,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size8,D4w8,D4w8-D4w_lowerr8,D4w_uperr8-D4w8,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size8(D4w8 < 0),Dnoise(numreSt8(D4w8 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size8)*0.8 max(size8)*1.2])  
    ylim([min(D4w8)*0.8 max(D4w8)*1.2]) 
    xlabel('\theta_{8 GHz} (mas)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.28,0.36])
    loglog(size15,D4w15,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size15,D4w15,D4w15-D4w_lowerr15,D4w_uperr15-D4w15,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size15(D4w15 < 0),Dnoise(numreSt15(D4w15 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size15)*0.8 max(size15)*1.2]) 
    ylim([min(D4w15)*0.8 max(D4w15)*1.2]) 
    xlabel('\theta_{15 GHz} (mas)','FontSize', 20) 
    ylabel('SF Amplitude D(4d)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.28,0.36])
    loglog(size24,D4w24,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size24,D4w24,D4w24-D4w_lowerr24,D4w_uperr24-D4w24,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size24(D4w24 < 0),Dnoise(numreSt24(D4w24 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size24)*0.8 max(size24)*1.2]) 
    ylim([min(D4w24)*0.5 max(D4w24)*1.2]) 
    xlabel('\theta_{24 GHz} (mas)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.28,0.36])
    loglog(size43,D4w43,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(size43,D4w43,D4w43-D4w_lowerr43,D4w_uperr43-D4w43,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(size43(D4w43 < 0),Dnoise(numreSt43(D4w43 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(size43)*0.8 max(size43)*1.2]) 
    ylim([min(D4w43)*0.8 0.009]) 
    xlabel('\theta_{43 GHz} (mas)','FontSize', 20) 
    set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
    
%sgt = sgtitle('Compare SF Amplitude D(4d) Against Observe Source Size in Multi-frequencies'); 
%sgt.FontSize = 20;
%sgt.LineWidth = 2;

if save_figure == 1
    fig_name = 'D4 vs. app source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end

[r2,p2] = corr(D4w(numreSt2)',size2','type','Spearman','rows','complete');
[r5,p5] = corr(D4w(numreSt5)',size5','type','Spearman','rows','complete');
[r8,p8] = corr(D4w(numreSt8)',size8','type','Spearman','rows','complete');
[r15,p15] = corr(D4w(numreSt15)',size15','type','Spearman','rows','complete');
[r24,p24] = corr(D4w(numreSt24)',size24','type','Spearman','rows','complete'); 
[r43,p43] = corr(D4w(numreSt43)',size43','type','Spearman','rows','complete');
  
D4w_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% D4 vs actual source size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.06,0.55,0.28,0.36])
    plot(realsize2(index2),D4w2(index2),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize2,D4w2,D4w2-D4w_lowerr2,D4w_uperr2-D4w2,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize2(D4w2 < 0),Dnoise(numreSt2(D4w2 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(realsize2(index2))*0.8 max(realsize2(index2))*1.2]) 
    ylim([min(D4w2(index2))*0.8 max(D4w2(index2))*1.2])  
    xlabel('l_{2 GHz} (pc)','FontSize', 20)
    ylabel('SF Amplitude D(4d)','FontSize', 20)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 

    subplot('position',[0.38,0.55,0.28,0.36])
    plot(realsize5(index5),D4w5(index5),'ro','MarkerSize',5,'MarkerFaceColor','r')
    hold on 
    errorbar(realsize5,D4w5,D4w5-D4w_lowerr5,D4w_uperr5-D4w5,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize5(D4w5 < 0),Dnoise(numreSt5(D4w5 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([0.2 max(realsize5(index5))*1.2]) 
    ylim([min(D4w5(index5))*0.8 max(D4w5(index5))*1.2])  
    xlabel('l_{5 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.70,0.55,0.28,0.36])
    plot(realsize8(index8),D4w8(index8),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize8,D4w8,D4w8-D4w_lowerr8,D4w_uperr8-D4w8,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize8(D4w8 < 0),Dnoise(numreSt8(D4w8 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(realsize8(index8))*0.8 max(realsize8(index8))*1.2]) 
    ylim([min(D4w8(index8))*0.8 max(D4w8(index8))*1.2]) 
    xlabel('l_{8 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.06,0.09,0.28,0.36])
    plot(realsize15(index15),D4w15(index15),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize15,D4w15,D4w15-D4w_lowerr15,D4w_uperr15-D4w15,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize15(D4w15 < 0),Dnoise(numreSt15(D4w15 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(realsize15(index15))*0.8 max(realsize15(index15))*1.2]) 
    ylim([min(D4w15(index15))*0.8 max(D4w15(index15))*1.2]) 
    xlabel('l_{15 GHz} (pc)','FontSize', 20)
    ylabel('SF Amplitude D(4d)','FontSize', 20)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.38,0.09,0.28,0.36])
    plot(realsize24(index24),D4w24(index24),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize24,D4w24,D4w24-D4w_lowerr24,D4w_uperr24-D4w24,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize24(D4w24 < 0),Dnoise(numreSt24(D4w24 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(realsize24(index24))*0.8 max(realsize24(index24))*1.2]) 
    ylim([min(D4w24(index24))*0.8 max(D4w24(index24))*1.2]) 
    xlabel('l_{24 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
    subplot('position',[0.70,0.09,0.28,0.36])
    plot(realsize43(index43),D4w43(index43),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(realsize43,D4w43,D4w43-D4w_lowerr43,D4w_uperr43-D4w43,'ro','MarkerSize',5,'MarkerFaceColor','r','CapSize',0,'LineWidth',1.5)
    plot(realsize43(D4w43 < 0),Dnoise(numreSt43(D4w43 < 0)),'bo','MarkerSize',5,'MarkerFaceColor','b') 
    hold off
    xlim([min(realsize43(index43))*0.8 max(realsize43(index43))*1.2]) 
    ylim([min(D4w43(index43))*0.8 max(D4w43(index43))*1.2]) 
    xlabel('l_{43 GHz} (pc)','FontSize', 20)
    set(gca,'XScale', 'log','YScale', 'log','FontSize', 15,'LineWidth',2); 
    
%sgt = sgtitle('Compare SF Amplitude D(4d) Against Linear Source Size in Multi-frequencies'); 
%sgt.FontSize = 20;
%sgt.LineWidth = 2;

if save_figure == 1
    fig_name = 'D4 vs. act source size';    
    save_path = sprintf('/Users/87steven/Downloads/%s.png',fig_name);
    print(gcf,save_path,'-dpng','-r400')
end
    
[r2,p2]= corr(realsize2(index2)',D4w2(index2)','type','Spearman','rows','complete');
[r5,p5] = corr(realsize5(index5)',D4w5(index5)','type','Spearman','rows','complete');
[r8,p8] = corr(realsize8(index8)',D4w8(index8)','type','Spearman','rows','complete');
[r15,p15] = corr(realsize15(index15)',D4w15(index15)','type','Spearman','rows','complete');
[r24,p24] = corr(realsize24(index24)',D4w24(index24)','type','Spearman','rows','complete'); 
[r43,p43] = corr(realsize43(index43)',D4w43(index43)','type','Spearman','rows','complete');
    
D4w_actsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

end
