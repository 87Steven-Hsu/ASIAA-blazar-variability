%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to compare apparent/actual sourcesize with tau_char/src, SF amplitude (D(100) & D(1000)), 
% redshift and meanflux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [tau_appsize_corr,tauw_appsz_corr,D100_appsz_corr,D100w_appsz_corr,D1000_appsz_corr,...
    D1000w_appsz_corr,MF_appsz_corr,fowb_actsz_corr,D1000w_actsz_corr,z_actsz_corr,MF_actsz_corr,...
    fowbsrc_actsz_corr,D2000w_MF_corr,D1500w_MF_corr]= Sourcesizecomp(fob,fowb,D100,D1000, ...
    D100w,D1000w,D2000w,D1500w,MF,nt2,nt5,nt8,nt15,nt24,nt43,numreSt2,numSt2,numreSt5,numSt5, ...
    numreSt8,numSt8,numreSt15,numSt15,numreSt24,numSt24,numreSt43,numSt43,realsize2,realsize5, ...
    realsize8,realsize15,realsize24,realsize43,z,SFerru,SFerrd,Dnoise)

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
    
size2 = nt2(numSt2);
size5 = nt5(numSt5);
size8 = nt8(numSt8);
size15 = nt15(numSt15);
size24 = nt24(numSt24);
size43 = nt43(numSt43);    

D1002 = D100(numreSt2); 
D1005 = D100(numreSt5); 
D1008 = D100(numreSt8); 
D10015 = D100(numreSt15);
D10024 = D100(numreSt24); 
D10043 = D100(numreSt43); 

D100w2 = D100w(numreSt2); 
D100w5 = D100w(numreSt5); 
D100w8 = D100w(numreSt8); 
D100w15 = D100w(numreSt15);
D100w24 = D100w(numreSt24); 
D100w43 = D100w(numreSt43); 

D10002 = D1000(numreSt2); 
D10005 = D1000(numreSt5); 
D10008 = D1000(numreSt8); 
D100015 = D1000(numreSt15); 
D100024 = D1000(numreSt24); 
D100043 = D1000(numreSt43); 

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

MF2 = MF(numreSt2); 
MF5 = MF(numreSt5); 
MF8 = MF(numreSt8); 
MF15 = MF(numreSt15); 
MF24 = MF(numreSt24); 
MF43 = MF(numreSt43);

z2 = z(numSt2);
z5 = z(numSt5);
z8 = z(numSt8);
z15 = z(numSt15);
z24 = z(numSt24);
z43 = z(numSt43);

fowbsrc2 = fowb(numreSt2).*(1 + z(numSt2));
fowbsrc5 = fowb(numreSt5).*(1 + z(numSt5));
fowbsrc8 = fowb(numreSt8).*(1 + z(numSt8));
fowbsrc15 = fowb(numreSt15).*(1 + z(numSt15));
fowbsrc24 = fowb(numreSt24).*(1 + z(numSt24));
fowbsrc43 = fowb(numreSt43).*(1 + z(numSt43));

D2000w2 = D2000w(numreSt2); 
D2000w5 = D2000w(numreSt5); 
D2000w8 = D2000w(numreSt8); 
D2000w15 = D2000w(numreSt15); 
D2000w24 = D2000w(numreSt24); 
D2000w43 = D2000w(numreSt43); 

D1500w2 = D1500w(numreSt2); 
D1500w5 = D1500w(numreSt5); 
D1500w8 = D1500w(numreSt8); 
D1500w15 = D1500w(numreSt15); 
D1500w24 = D1500w(numreSt24); 
D1500w43 = D1500w(numreSt43); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
fob2gt3200 = find(fob2 > 3200);
fob5gt3200 = find(fob5 > 3200);
fob8gt3200 = find(fob8 > 3200);
fob15gt3200 = find(fob15 > 3200);
fob24gt3200 = find(fob24 > 3200);
fob43gt3200 = find(fob43 > 3200);

fob2lt3200 = find(fob2 < 3200);
fob5lt3200 = find(fob5 < 3200);
fob8lt3200 = find(fob8 < 3200);
fob15lt3200 = find(fob15 < 3200);
fob24lt3200 = find(fob24 < 3200);
fob43lt3200 = find(fob43 < 3200);
%tau_char (fob) vs apparent source size
figure(1);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    loglog(size2,fob2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size2(fob2gt3200),fob2(fob2gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fob2)]) 
    xlim([0.8*min(size2) 1.2*max(size2)])   
    xlabel('Source Size of 2 GHz (mas)','FontSize', 15)
    ylabel('\tau_{char} without weight (days)','FontSize', 15)   
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    loglog(size5,fob5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size5(fob5gt3200),fob5(fob5gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fob5)]) %
    xlim([0.8*min(size5) 1.2*max(size5)])
    xlabel('Source Size of 5 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    loglog(size8,fob8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size8(fob8gt3200),fob8(fob8gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fob8)]) 
    xlim([0.8*min(size8) 1.2*max(size8)])
    xlabel('Source Size of 8 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    loglog(size15,fob15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size15(fob15gt3200),fob15(fob15gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fob15)]) 
    xlim([0.8*min(size15) 1.2*max(size15)])
    ylabel('\tau_{char} with weight (days)','FontSize', 15)   
    xlabel('Source Size of 15 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    loglog(size24,fob24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size24(fob24gt3200),fob24(fob24gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fob24)]) 
    xlim([0.8*min(size24) 1.2*max(size24)])
    xlabel('Source Size (mas)','FontSize', 15)
    xlabel('Source Size of 24 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    loglog(size43,fob43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size43(fob43gt3200),fob43(fob43gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fob43)]) 
    xlim([0.8*min(size43) 1.2*max(size43)])
    xlabel('Source Size of 43 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Characteristic Timescale without weight with Apparent Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2] = corr(size2(fob2lt3200)',fob2(fob2lt3200)','type','Spearman');
[r5,p5] = corr(size5(fob5lt3200)',fob5(fob5lt3200)','type','Spearman');
[r8,p8] = corr(size8(fob8lt3200)',fob8(fob8lt3200)','type','Spearman');
[r15,p15] = corr(size15(fob15lt3200)',fob15(fob15lt3200)','type','Spearman');
[r24,p24] = corr(size24(fob24lt3200)',fob24(fob24lt3200)','type','Spearman');
[r43,p43] = corr(size43(fob43lt3200)',fob43(fob43lt3200)','type','Spearman');

tau_appsize_corr = [[r2,p2],[r5,p5],[r8,p8],[r15,p15],[r24,p24],[r43,p43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tau_char (fowb) vs.apparent source size
figure(2);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(size2,fowb2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(size2(eqobslim_2),fowb2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fowb2)]) 
    xlim([0.8*min(size2) 1*max(size2)])   
    xlabel('Source Size of 2 GHz (mas)','FontSize', 15)
    ylabel('\tau_{char} (days)','FontSize', 15)   
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(size5,fowb5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(size5(eqobslim_5),fowb5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fowb5)]) 
    xlim([0.8*min(size5) 1*max(size5)])
    xlabel('Source Size of 5 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(size8,fowb8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(size8(eqobslim_8),fowb8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fowb8)]) 
    xlim([0.8*min(size8) 1*max(size8)])
    xlabel('Source Size of 8 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(size15,fowb15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(size15(eqobslim_15),fowb15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fowb15)]) 
    xlim([0.8*min(size15) 1.*max(size15)])
    ylabel('\tau_{char} (days)','FontSize', 15)   
    xlabel('Source Size of 15 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(size24,fowb24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(size24(eqobslim_24),fowb24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fowb24)]) 
    xlim([0.8*min(size24) 1.*max(size24)])
    xlabel('Source Size (mas)','FontSize', 15)
    xlabel('Source Size of 24 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(size43,fowb43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(size43(eqobslim_43),fowb43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    ylim([0 max(fowb43)]) 
    xlim([0.8*min(size43) 1.*max(size43)])
    xlabel('Source Size of 43 GHz (mas)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Characteristic Timescale \tau_{char} with Apparent Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2] = corr(size2(neqobslim_2)',fowb2(neqobslim_2)','type','Spearman');
[r5,p5] = corr(size5(neqobslim_5)',fowb5(neqobslim_5)','type','Spearman');
[r8,p8] = corr(size8(neqobslim_8)',fowb8(neqobslim_8)','type','Spearman');
[r15,p15] = corr(size15(neqobslim_15)',fowb15(neqobslim_15)','type','Spearman');
[r24,p24] = corr(size24(neqobslim_24)',fowb24(neqobslim_24)','type','Spearman');
[r43,p43] = corr(size43(neqobslim_43)',fowb43(neqobslim_43)','type','Spearman');

tauw_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D1002gt3200 = find(D100 > 3200);
D1005gt3200 = find(D100 > 3200);
D1008gt3200 = find(D100 > 3200);
D10015gt3200 = find(D100 > 3200);
D10024gt3200 = find(D100 > 3200);
D10043gt3200 = find(D100 > 3200);
    
% SF amplitude (D100) vs source size
figure(3);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    loglog(size2,D1002,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size2(D1002gt3200),D1002(D1002gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size2) max(size2)])
    ylim([0 max(D1002)]) 
    xlabel('Source Size of 2 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude without weight (D100)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    loglog(size5,D1005,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size5(D1005gt3200),D1005(D1005gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size5) max(size5)])
    ylim([0 max(D1005)]) 
    xlabel('Source Size of 5 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    loglog(size8,D1008,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size8(D1008gt3200),D1008(D1008gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size8) max(size8)])
    ylim([0 max(D1008)])
    xlabel('Source Size of 8 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    loglog(size15,D10015,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size15(D10015gt3200),D10015(D10015gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size15) max(size15)])
    ylim([0 max(D10015)])
    xlabel('Source Size of 15 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude without weight (D100)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    loglog(size24,D10024,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size24(D10024gt3200),D10024(D10024gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size24) max(size24)])
    ylim([0 max(D10024)])
    xlabel('Source Size of 24 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    loglog(size43,D10043,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size43(D10043gt3200),D10043(D10043gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size43) max(size43)])
    ylim([0 max(D1008)])
    xlabel('Source Size of 43 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude (D(\tau = 100)) with APparent Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2] = corr(D1002',size2','type','Spearman');
[r5,p5] = corr(D1005',size5','type','Spearman');
[r8,p8] = corr(D1008',size8','type','Spearman');
[r15,p15] = corr(D10015',size15','type','Spearman');
[r24,p24] = corr(D10024',size24','type','Spearman'); 
[r43,p43] = corr(D10043',size43','type','Spearman');
    
D100_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D10002gt3200 = find(D10002 > 3200);
D10005gt3200 = find(D10005 > 3200);
D10008gt3200 = find(D10008 > 3200);
D100015gt3200 = find(D100015 > 3200);
D100024gt3200 = find(D100024 > 3200);
D100043gt3200 = find(D100043 > 3200);
    
% D1000 vs source size
figure(4);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    loglog(size2,D10002,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size2(D10002gt3200),D10002(D10002gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size2) max(size2)])   
    ylim([0 max(D10002)]) 
    xlabel('Source Size of 2 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude without weight (D1000)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    loglog(size5,D10005,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size5(D10005gt3200),D10005(D10005gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size5) max(size5)]) 
    ylim([0 max(D10005)]) 
    xlabel('Source Size of 5 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    loglog(size8,D10008,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size8(D10008gt3200),D10008(D10008gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off    
    xlim([min(size8) max(size8)])   
    ylim([0 max(D10008)]) 
    xlabel('Source Size of 8 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    loglog(size15,D100015,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size15(D100015gt3200),D100015(D100015gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size15) max(size15)])   
    ylim([0 max(D100015)]) 
    xlabel('Source Size of 15 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude without weight (D1000)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    loglog(size24,D100024,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size24(D100024gt3200),D100024(D100024gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size24) max(size24)])   
    ylim([0 max(D100024)]) 
    xlabel('Source Size of 24 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude without weight (D1000)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    loglog(size43,D100043,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size43(D100043gt3200),D100043(D100043gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size43) max(size43)])
    ylim([0 max(D100043)]) 
    xlabel('Source Size of 43 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude (D(\tau = 1000)) Without Weight Against Apparent Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2] = corr(D10002',size2','type','Spearman');
[r5,p5] = corr(D10005',size5','type','Spearman');
[r8,p8] = corr(D10008',size8','type','Spearman');
[r15,p15] = corr(D100015',size15','type','Spearman');
[r24,p24] = corr(D100024',size24','type','Spearman'); 
[r43,p43] = corr(D100043',size43','type','Spearman');
    
D1000_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D100w2gt3200 = find(D100w2 > 3200);
D100w5gt3200 = find(D100w5 > 3200);
D100w8gt3200 = find(D100w8 > 3200);
D100w15gt3200 = find(D100w15 > 3200);
D100w24gt3200 = find(D100w24 > 3200);
D100w43gt3200 = find(D100w43 > 3200);

% D100w vs source size
figure(5);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    loglog(size2,D100w2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size2(D100w2gt3200),D100w2(D100w2gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size2) max(size2)])  
    ylim([0 max(D100w2)]) 
    xlabel('Source Size of 2 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude with weight (D100w)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    loglog(size5,D100w5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size5(D100w5gt3200),D100w5(D100w5gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size5) max(size5)])  
    ylim([0 max(D100w5)]) 
    xlabel('Source Size of 5 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    loglog(size8,D100w8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size8(D100w8gt3200),D100w8(D100w8gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size8) max(size8)])  
    ylim([0 max(D100w8)]) 
    xlabel('Source Size of 8 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    loglog(size15,D100w15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size15(D100w15gt3200),D100w15(D100w15gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size15) max(size15)])  
    ylim([0 max(D100w15)]) 
    xlabel('Source Size of 15 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude with weight (D100w)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    loglog(size24,D100w24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size24(D100w24gt3200),D100w24(D100w24gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size24) max(size24)])  
    ylim([0 max(D100w24)]) 
    xlabel('Source Size of 24 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    loglog(size43,D100w43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    loglog(size43(D100w43gt3200),D100w43(D100w43gt3200),'g^','MarkerSize',6,'MarkerFaceColor','k')
    hold off
    xlim([min(size43) max(size43)])  
    ylim([0 max(D100w43)]) 
    xlabel('Source Size of 43 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude With Weight (D(\tau = 100)) with Apparent Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2] = corr(D100w2',size2','type','Spearman');
[r5,p5] = corr(D100w5',size5','type','Spearman');
[r8,p8] = corr(D100w8',size8','type','Spearman');
[r15,p15] = corr(D100w15',size15','type','Spearman');
[r24,p24] = corr(D100w24',size24','type','Spearman'); 
[r43,p43] = corr(D100w43',size43','type','Spearman');

D100w_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% D1000w vs apparent source size
figure(6);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(size2,D1000w2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(size2,D1000w2,D1000w2-SFerrd2,SFerru2-D1000w2,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(size2(D1000w2 < 0),Dnoise(numreSt2(D1000w2 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.3 12])  
    ylim([0 max(D1000w2)]) 
    xlabel('Source Size of 2 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude (D(\tau=1000d))','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    set(gca,'XScale','log','YScale','log');

    subplot('position',[0.39,0.55,0.25,0.33])
    loglog(size5,D1000w5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(size5,D1000w5,D1000w5-SFerrd5,SFerru5-D1000w5,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(size5(D1000w5 < 0),Dnoise(numreSt5(D1000w5 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.07 6])  
    ylim([0 max(D1000w5)]) 
    xlabel('Source Size of 5 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    loglog(size8,D1000w8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(size8,D1000w8,D1000w8-SFerrd8,SFerru8-D1000w8,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(size8(D1000w8 < 0),Dnoise(numreSt8(D1000w8 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.08 2])  
    ylim([0 max(D1000w8)]) 
    xlabel('Source Size of 8 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    loglog(size15,D1000w15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(size15,D1000w15,D1000w15-SFerrd15,SFerru15-D1000w15,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(size15(D1000w15 < 0),Dnoise(numreSt15(D1000w15 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.03 1])  
    ylim([0 max(D1000w15)]) 
    xlabel('Source Size of 15 GHz (mas)','FontSize', 15) 
    ylabel('SF amplitude (D(\tau=1000d))','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    loglog(size24,D1000w24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(size24,D1000w24,D1000w24-SFerrd24,SFerru24-D1000w24,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(size24(D1000w24 < 0),Dnoise(numreSt24(D1000w24 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.05 0.7])  
    ylim([0 max(D1000w24)]) 
    xlabel('Source Size of 24 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    loglog(size43,D1000w43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(size43,D1000w43,D1000w43-SFerrd43,SFerru43-D1000w43,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(size43(D1000w43 < 0),Dnoise(numreSt43(D1000w43 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.03 0.25])  
    ylim([0 max(D1000w43)]) 
    xlabel('Source Size of 15 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude (D(\tau = 1000)) with Apparent Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

[r2,p2] = corr(D1000w(numreSt2)',nt2(numSt2)','type','Spearman');
[r5,p5] = corr(D1000w(numreSt5)',nt5(numSt5)','type','Spearman');
[r8,p8] = corr(D1000w(numreSt8)',nt8(numSt8)','type','Spearman');
[r15,p15] = corr(D1000w(numreSt15)',nt15(numSt15)','type','Spearman');
[r24,p24] = corr(D1000w(numreSt24)',nt24(numSt24)','type','Spearman'); 
[r43,p43] = corr(D1000w(numreSt43)',nt43(numSt43)','type','Spearman');
  
D1000w_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% source size vs mean flux 
figure(7);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    loglog(size2,MF2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([min(size2) max(size2)])   
    ylim([0 max(MF2)]) 
    xlabel('Source Size of 2 GHz (mas)','FontSize', 15) 
    ylabel('Mean Flux','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    loglog(size5,MF5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([min(size5) max(size5)])   
    ylim([0 max(MF5)]) 
    xlabel('Source Size of 5 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    loglog(size8,MF8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([min(size8) max(size8)])   
    ylim([0 max(MF8)]) 
    xlabel('Source Size of 8 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    loglog(size15,MF15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([min(size15) max(size15)])   
    ylim([0 max(MF15)]) 
    xlabel('Source Size of 15 GHz (mas)','FontSize', 15) 
    ylabel('Mean Flux','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    loglog(size24,MF24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([min(size24) max(size24)])   
    ylim([0 max(MF24)]) 
    xlabel('Source Size of 24 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    loglog(size43,MF43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([min(size43) max(size43)])   
    ylim([0 max(MF43)]) 
    xlabel('Source Size of 43 GHz (mas)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Mean Flux With Apparent Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

[r2,p2]= corr(MF(numreSt2)',nt2(numSt2)','type','Spearman');
[r5,p5] = corr(MF(numreSt5)',nt5(numSt5)','type','Spearman');
[r8,p8] = corr(MF(numreSt8)',nt8(numSt8)','type','Spearman');
[r15,p15] = corr(MF(numreSt15)',nt15(numSt15)','type','Spearman');
[r24,p24] = corr(MF(numreSt24)',nt24(numSt24)','type','Spearman'); 
[r43,p43] = corr(MF(numreSt43)',nt43(numSt43)','type','Spearman');
  
MF_appsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index2 = ~isnan(realsize2);
index5 = ~isnan(realsize5);
index8 = ~isnan(realsize8);
index15 = ~isnan(realsize15);
index24 = ~isnan(realsize24);
index43 = ~isnan(realsize43);

%%%% fowb vs actual size 
figure(9);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(index2),fowb2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(realsize2(eqobslim_2),fowb2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 max(realsize2(index2))])
    ylim([min(fowb2(index2)) max(fowb2(index2))])   
    xlabel('Source Size of 2 GHz (pc)','FontSize', 15)
    ylabel('\tau_{char} (days)','FontSize', 15)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(index5),fowb5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(realsize5(eqobslim_5),fowb5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 max(realsize5(index5))])
    ylim([min(fowb5(index5)) max(fowb5(index5))])  
    xlabel('Source Size of 5 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(index8),fowb8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(realsize8(eqobslim_8),fowb8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 max(realsize8(index8))])
    ylim([min(fowb8(index8)) max(fowb8(index8))]) 
    xlabel('Source Size of 8 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(index15),fowb15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(realsize15(eqobslim_15),fowb15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 max(realsize15(index15))])
    ylim([min(fowb15(index15)) max(fowb15(index15))]) 
    xlabel('Source Size of 15 GHz (pc)','FontSize', 15)
    ylabel('\tau_{char} (days)','FontSize', 15)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(index24),fowb24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(realsize24(eqobslim_24),fowb24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 max(realsize24(index24))])
    ylim([min(fowb24(index24)) max(fowb24(index24))]) 
    xlabel('Source Size of 24 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(index43),fowb43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k')  
    hold on 
    plot(realsize43(eqobslim_43),fowb43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 max(realsize43(index43))])
    ylim([min(fowb43(index43)) max(fowb43(index43))]) 
    xlabel('Source Size of 43 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Charateristic Timescale \tau_{char} With Actual Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2]= corr(realsize2(index2)',fowb2(index2)','type','Spearman');
[r5,p5] = corr(realsize5(index5)',fowb5(index5)','type','Spearman');
[r8,p8] = corr(realsize8(index8)',fowb8(index8)','type','Spearman');
[r15,p15] = corr(realsize15(index15)',fowb15(index15)','type','Spearman');
[r24,p24] = corr(realsize24(index24)',fowb24(index24)','type','Spearman'); 
[r43,p43] = corr(realsize24(index24)',fowb24(index24)','type','Spearman');
    
fowb_actsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% D1000 vs actual source size
figure(10);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(index2),D1000w2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(realsize2,D1000w2,D1000w2-SFerrd2,SFerru2-D1000w2,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(realsize2(D1000w2 < 0),Dnoise(numreSt2(D1000w2 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.7 70])
    ylim([min(D1000w2(index2)) max(D1000w2(index2))])  
    xlabel('Source Size of 2 GHz(pc)','FontSize', 15)
    ylabel('SF Amplitude (D(1000)','FontSize', 15)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(index5),D1000w5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k')
    hold on 
    errorbar(realsize5,D1000w5,D1000w5-SFerrd5,SFerru5-D1000w5,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(realsize5(D1000w5 < 0),Dnoise(numreSt5(D1000w5 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.4 30])
    ylim([min(D1000w5(index5)) max(D1000w5(index5))])  
    xlabel('Source Size of 5 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(index8),D1000w8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(realsize8,D1000w8,D1000w8-SFerrd8,SFerru8-D1000w8,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(realsize8(D1000w8 < 0),Dnoise(numreSt8(D1000w8 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.035 13])
    ylim([min(D1000w8(index8)) max(D1000w8(index8))]) 
    xlabel('Source Size of 8 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(index15),D1000w15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(realsize15,D1000w15,D1000w15-SFerrd15,SFerru15-D1000w15,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(realsize15(D1000w15 < 0),Dnoise(numreSt15(D1000w15 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.2 10])
    ylim([min(D1000w15(index15)) max(D1000w15(index15))]) 
    xlabel('Source Size of 15 GHz (pc)','FontSize', 15)
    ylabel('SF Amplitude D(1000)','FontSize', 15)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(index24),D1000w24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(realsize24,D1000w24,D1000w24-SFerrd24,SFerru24-D1000w24,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(realsize24(D1000w24 < 0),Dnoise(numreSt24(D1000w24 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.1 3.5])
    ylim([min(D1000w24(index24)) max(D1000w24(index24))]) 
    xlabel('Source Size of 24 GHz(pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(index43),D1000w43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    errorbar(realsize43,D1000w43,D1000w43-SFerrd43,SFerru43-D1000w43,'r.','MarkerSize',3,'MarkerFaceColor','k','CapSize',0)
    plot(realsize43(D1000w43 < 0),Dnoise(numreSt43(D1000w43 < 0)),'b.','MarkerSize',10,'MarkerFaceColor','k') 
    hold off
    xlim([0.1 2])
    ylim([min(D1000w43(index43)) max(D1000w43(index43))]) 
    xlabel('Source Size of 43 GHz(pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude D(\tau = 1000) With Actual Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2]= corr(realsize2(index2)',D1000w2(index2)','type','Spearman');
[r5,p5] = corr(realsize5(index5)',D1000w5(index5)','type','Spearman');
[r8,p8] = corr(realsize8(index8)',D1000w8(index8)','type','Spearman');
[r15,p15] = corr(realsize15(index15)',D1000w15(index15)','type','Spearman');
[r24,p24] = corr(realsize24(index24)',D1000w24(index24)','type','Spearman'); 
[r43,p43] = corr(realsize43(index43)',D1000w43(index43)','type','Spearman');
    
D1000w_actsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% Redshift z vs actual source size   
figure(11);   
set(gcf,'pos',[100,100,1200,800]);    
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(index2),z2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize2(index2))])
    ylim([min(z2(index2)) max(z2(index2))])   
    xlabel('Source Size of 2 GHz (pc)','FontSize', 15)
    ylabel('Redshift z','FontSize', 15)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(index5),z5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize5(index5))])
    ylim([min(z5(index5)) max(z5(index5))])  
    xlabel('Source Size of 5 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(index8),z8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize8(index8))])
    ylim([min(z8(index8)) max(z8(index8))]) 
    xlabel('Source Size of 8 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(index15),z15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize15(index15))])
    ylim([min(z15(index15)) max(z15(index15))]) 
    xlabel('Source Size of 15 GHz (pc)','FontSize', 15)
    fulllabely = strcat('Redshift z'); 
    ylabel(fulllabely,'FontSize', 15)  
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(index24),z24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize24(index24))])
    ylim([min(z24(index24)) max(z24(index24))]) 
    xlabel('Source Size of 24 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(index43),z43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k')  
    xlim([0 max(realsize43(index43))])
    ylim([min(z43(index43)) max(z43(index43))]) 
    xlabel('Source Size of 43 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Redshift z With Actual Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2]= corr(realsize2(index2)',z2(index2)','type','Spearman');
[r5,p5] = corr(realsize5(index5)',z5(index5)','type','Spearman');
[r8,p8] = corr(realsize8(index8)',z8(index8)','type','Spearman');
[r15,p15] = corr(realsize15(index15)',z15(index15)','type','Spearman');
[r24,p24] = corr(realsize24(index24)',z24(index24)','type','Spearman'); 
[r43,p43] = corr(realsize43(index43)',z43(index43)','type','Spearman');
    
z_actsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];  
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% MF vs actual source size
figure(12);   
set(gcf,'pos',[100,100,1200,800]);   

    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(index2),MF2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize2(index2))])
    ylim([min(MF2(index2)) max(MF2(index2))])   
    xlabel('Source Size of 2 GHz (pc)','FontSize', 15)
    ylabel('Mean flux (Jy)','FontSize', 15)  
    set(gca,'YScale', 'log','FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(index5),MF5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize5(index5))])
    ylim([min(MF5(index5)) max(MF5(index5))])  
    xlabel('Source Size of 5 GHz (pc)','FontSize', 15)
    set(gca,'YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(index8),MF8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize8(index8))])
    ylim([min(MF8(index8)) max(MF8(index8))]) 
    xlabel('Source Size of 8 GHz (pc)','FontSize', 15)
    set(gca,'YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(index15),MF15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize15(index15))])
    ylim([min(MF15(index15)) max(MF15(index15))]) 
    xlabel('Source Size of 15 GHz (pc)','FontSize', 15)
    fulllabely = strcat('Mean Flux (Jy)');
    ylabel(fulllabely,'FontSize', 15)  
    set(gca,'YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(index24),MF24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize24(index24))])
    ylim([min(MF24(index24)) max(MF24(index24))]) 
    xlabel('Source Size of 24 GHz (pc)','FontSize', 15)
    set(gca,'YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(index43),MF43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k')  
    xlim([0 max(realsize43(index43))])
    ylim([min(MF43(index43)) max(MF43(index43))]) 
    xlabel('Source Size of 43 GHz (pc)','FontSize', 15)
    set(gca,'YScale', 'log','FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Mean Flux With Actual Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2]= corr(realsize2(index2)',MF2(index2)','type','Spearman');
[r5,p5] = corr(realsize5(index5)',MF5(index5)','type','Spearman');
[r8,p8] = corr(realsize8(index8)',MF8(index8)','type','Spearman');
[r15,p15] = corr(realsize15(index15)',MF15(index15)','type','Spearman');
[r24,p24] = corr(realsize24(index24)',MF24(index24)','type','Spearman'); 
[r43,p43] = corr(realsize43(index43)',MF43(index43)','type','Spearman');
    
MF_actsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]]; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% charateristic timescale (fowb) vs Redshift z
figure(13);   
set(gcf,'pos',[100,100,1200,800]);   
    
    plot(z2,fowb2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(z5,fowb5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z8,fowb8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z15,fowb15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z24,fowb24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z43,fowb43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z2(eqobslim_2),fowb2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z5(eqobslim_5),fowb5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z8(eqobslim_8),fowb8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z15(eqobslim_15),fowb15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z24(eqobslim_24),fowb24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z43(eqobslim_43),fowb43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    ylim([0 3600])
    xlim([0 5])   
    xlabel('Redshift z','FontSize', 15) 
    ylabel('\tau_{char} (days)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = title('Compare Charateristic Timesclae \tau_{char} With Redshift z');
sgt.FontSize = 20;
sgt.LineWidth = 2;  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SF Amplitude (D1000w) vs Redshift z   
figure(14);   
set(gcf,'pos',[100,100,1200,800]);    
    
    plot(z2(index2),D1000w2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(z5(index5),D1000w5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z8(index8),D1000w8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z15(index15),D1000w15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z24(index24),D1000w24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z43(index43),D1000w43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    xlabel('Redshift z','FontSize', 15)
    ylabel('SF Amplitude D(\tau = 1000)','FontSize', 15) 
    xlim([0 5])
    ylim([0 2])    
    set(gca,'YScale', 'log','FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude D(\tau = 1000) with Redshift z  '); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SF Amplitude (D1000w) vs Mean flux
figure(15);   
set(gcf,'pos',[100,100,1200,800]);
    
    plot(MF(numreSt2),D1000w2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(MF(numreSt5),D1000w5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF(numreSt8),D1000w8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF(numreSt15),D1000w15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF(numreSt24),D1000w24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF(numreSt43),D1000w43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    set(gca,'XScale', 'log','YScale', 'log')
    xlabel('Mean Flux (Jy)','FontSize', 15)
    ylabel('SF Amplitude D(\tau = 1000)','FontSize', 15) 
    xlim([0 30])
    ylim([0 2])    
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Mean Flux with SF Amplitude D(\tau = 1000)'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Characteristic timescale (fowb) vs log(MF)
logMF2 = log(MF(numreSt2));
logMF5 = log(MF(numreSt5));
logMF8 = log(MF(numreSt8));
logMF15 = log(MF(numreSt15));
logMF24 = log(MF(numreSt24));
logMF43 = log(MF(numreSt43));

figure(16);   
set(gcf,'pos',[100,100,1200,800]);
    
    plot(logMF2,fowb2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(logMF5,fowb5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF8,fowb8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF15,fowb15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF24,fowb24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF43,fowb43,'r.','MarkerSize',6,'MarkerFaceColor','k')
    plot(logMF2(eqobslim_2),fowb2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF5(eqobslim_5),fowb5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF8(eqobslim_8),fowb8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF15(eqobslim_15),fowb15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF24(eqobslim_24),fowb24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF43(eqobslim_43),fowb43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    %set(gca,'XScale', 'log','YScale', 'log')
    xlabel('log(Mean Flux (Jy))','FontSize', 15)
    ylabel('\tau_{char} (days)','FontSize', 15) 
    %xlim([0 30])
    %ylim([0 5500])    
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Mean Flux with Charateristic Timescale \tau_{char}'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%%%% intrinsic timescale (fowbsrc) vs actual size
figure(17);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(index2),fowbsrc2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(realsize2(eqobslim_2),fowbsrc2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 60])
    ylim([min(fowbsrc2(index2)) max(fowbsrc2(index2))])   
    xlabel('Source size of 2 GHz (pc)','FontSize', 15) 
    ylabel('\tau_{src} (days)','FontSize', 15)  
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(index5),fowbsrc5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(realsize5(eqobslim_5),fowbsrc5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 45])
    ylim([min(fowbsrc5(index5)) max(fowbsrc5(index5))])  
    xlabel('Source size of 5 GHz (pc)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(index8),fowbsrc8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(realsize8(eqobslim_8),fowbsrc8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 13])
    ylim([min(fowbsrc8(index8)) max(fowbsrc8(index8))]) 
    xlabel('Source size of 8 GHz (pc)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(index15),fowbsrc15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(realsize15(eqobslim_15),fowbsrc15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 4])
    ylim([min(fowbsrc15(index15)) max(fowbsrc15(index15))]) 
    xlabel('Source size of 15 GHz (pc)','FontSize', 15) 
    ylabel('\tau_{src} (days)','FontSize', 15)  
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(index24),fowbsrc24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(realsize24(eqobslim_24),fowbsrc24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 3])
    ylim([min(fowbsrc24(index24)) max(fowbsrc24(index24))]) 
    xlabel('Source size of 24 GHz (pc)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(index43),fowbsrc43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k')  
    hold on
    plot(realsize43(eqobslim_43),fowbsrc43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlim([0 2])
    ylim([min(fowbsrc43(index43)) max(fowbsrc43(index43))]) 
    xlabel('Source size of 43 GHz (pc)','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Intrinsic Timescale \tau_{src} With Actual Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;
    
[r2,p2]= corr(realsize2(index2)',fowbsrc2(index2)','type','Spearman');
[r5,p5] = corr(realsize5(index5)',fowbsrc5(index5)','type','Spearman');
[r8,p8] = corr(realsize8(index8)',fowbsrc8(index8)','type','Spearman');
[r15,p15] = corr(realsize15(index15)',fowbsrc15(index15)','type','Spearman');
[r24,p24] = corr(realsize24(index24)',fowbsrc24(index24)','type','Spearman'); 
[r43,p43] = corr(realsize24(index24)',fowbsrc24(index24)','type','Spearman');
    
fowbsrc_actsz_corr = [[r2,p2];[r5,p5];[r8,p8];[r15,p15];[r24,p24];[r43,p43]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% intrinsic timescale (fowbsrc) vs redshift z
figure(18);   
set(gcf,'pos',[100,100,1200,800]);   
    
    plot(z2,fowbsrc2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(z5,fowbsrc5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z8,fowbsrc8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z15,fowbsrc15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z24,fowbsrc24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z43,fowbsrc43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z2(eqobslim_2),fowbsrc2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z5(eqobslim_5),fowbsrc5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z8(eqobslim_8),fowbsrc8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z15(eqobslim_15),fowbsrc15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z24(eqobslim_24),fowbsrc24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z43(eqobslim_43),fowbsrc43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    ylim([0 18000])
    xlim([0 5])   
    ylabel('\tau_{src} (days)','FontSize', 15)
    xlabel('Redshift z','FontSize', 15) 
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = title('Compare Charateristic Timesclae \tau_{src} With Redshift z');
sgt.FontSize = 20;
sgt.LineWidth = 2;  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%%%% intrinsic timescale (fowbsrc) vs SF Amplitude D1000w
figure(19);   
set(gcf,'pos',[100,100,1200,800]);
    
    plot(log(MF(numreSt2)),fowbsrc2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(log(MF(numreSt5)),fowbsrc5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(log(MF(numreSt8)),fowbsrc8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(log(MF(numreSt15)),fowbsrc15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(log(MF(numreSt24)),fowbsrc24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(log(MF(numreSt43)),fowbsrc43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF2(eqobslim_2),fowbsrc2(eqobslim_2),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF5(eqobslim_5),fowbsrc5(eqobslim_5),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF8(eqobslim_8),fowbsrc8(eqobslim_8),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF15(eqobslim_15),fowbsrc15(eqobslim_15),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF24(eqobslim_24),fowbsrc24(eqobslim_24),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    plot(logMF43(eqobslim_43),fowbsrc43(eqobslim_43),'g^','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    %set(gca,'XScale', 'log','YScale', 'log')
    xlabel('log(Mean Flux (Jy))','FontSize', 15)
    ylabel('\tau_{src} (days) ','FontSize', 15) 
    %xlim([0 30])
    ylim([0 18000])    
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Mean Flux with Charateristic Timescale \tau_{src}'); 
sgt.FontSize = 20;
sgt.LineWidth = 2; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SF Amplitude D2000w vs characteristic timescale fowb src
figure(20);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(index2),D2000w2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    set(gca,'XScale', 'log','YScale', 'log')
    xlim([0 max(realsize2(index2))])
    ylim([min(D2000w2(index2)) max(D2000w2(index2))])  
    xlabel('Source Size of 2 GHz (pc)','FontSize', 15)
    ylabel('SF Amplitude (D2000)','FontSize', 15)   
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(index5),D2000w5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    set(gca,'XScale', 'log','YScale', 'log')
    xlim([0 max(realsize5(index5))])
    ylim([min(D2000w5(index5)) max(D2000w5(index5))])  
    xlabel('Source Size of 5 GHz (pc)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(index8),D2000w8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    set(gca,'XScale', 'log','YScale', 'log')
    xlim([0 max(realsize8(index8))])
    ylim([min(D2000w8(index8)) max(D2000w8(index8))]) 
    xlabel('Source Size of 8 GHz (pc)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(index15),D2000w15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    set(gca,'XScale', 'log','YScale', 'log')
    xlim([0 max(realsize15(index15))])
    ylim([min(D2000w15(index15)) max(D2000w15(index15))]) 
    xlabel('Source Size of 15 GHz (pc)','FontSize', 15)
    ylabel('SF Amplitude (D2000)','FontSize', 15)   
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(index24),D2000w24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    set(gca,'XScale', 'log','YScale', 'log')
    xlim([0 max(realsize24(index24))])
    ylim([min(D2000w24(index24)) max(D2000w24(index24))]) 
    xlabel('Source Size of 24 GHz (pc)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(index43),D2000w43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k')  
    set(gca,'XScale', 'log','YScale', 'log')
    xlim([0 max(realsize43(index43))])
    ylim([min(D2000w43(index43)) max(D2000w43(index43))]) 
    xlabel('Source Size of 43 GHz (pc)','FontSize', 15)
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude D(\tau = 2000) With Actual Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SF Amplitude (D2000w) vs Redshift z   
figure(21);   
set(gcf,'pos',[100,100,1200,800]);    
    
    plot(z2(index2),D2000w2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(z5(index5),D2000w5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z8(index8),D2000w8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z15(index15),D2000w15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z24(index24),D2000w24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z43(index43),D2000w43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    set(gca,'YScale', 'log')
    xlabel('Redshift z','FontSize', 15)
    ylabel('SF Amplitude D(\tau = 2000)','FontSize', 15) 
    xlim([0 5])
    ylim([0 10])    
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude D(2000) with Redshift z  '); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SF Amplitude (D2000w) vs Mean flux
figure(22);   
set(gcf,'pos',[100,100,1200,800]);
    
    plot(MF2,D2000w2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(MF5,D2000w5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF8,D2000w8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF15,D2000w15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF24,D2000w24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF43,D2000w43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    xlabel('Mean Flux (Jy)','FontSize', 15)
    ylabel('SF Amplitude D(\tau = 2000)','FontSize', 15) 
    xlim([-1 2])
    ylim([0 2])    
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Mean Flux with SF Amplitude D(\tau = 2000)'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

MFtotal = [MF(numreSt2),MF(numreSt5),MF(numreSt8),MF(numreSt15),MF(numreSt24),MF(numreSt43)];
D2000total = [D2000w2,D2000w5,D2000w8,D2000w15,D2000w24,D2000w43];

[r,p] = corr(MFtotal',D2000total','type','Spearman');
D2000w_MF_corr = [r,p];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SF Amplitude (D1500w) vs characteristic timescale fowb src
figure(23);   
set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    plot(realsize2(index2),D1500w2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize2(index2))])
    ylim([min(D1500w2(index2)) max(D1500w2(index2))])   
    xlabel('Source Size of 2 GHz (pc)','FontSize', 15)
    ylabel('SF Amplitude (D(1500))','FontSize', 15)   
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    plot(realsize5(index5),D1500w5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize5(index5))])
    ylim([min(D1500w5(index5)) max(D1500w5(index5))])  
    xlabel('Source Size of 5 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    plot(realsize8(index8),D1500w8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize8(index8))])
    ylim([min(D1500w8(index8)) max(D1500w8(index8))]) 
    xlabel('Source Size of 8 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    plot(realsize15(index15),D1500w15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize15(index15))])
    ylim([min(D1500w15(index15)) max(D1500w15(index15))]) 
    xlabel('Source Size of 15 GHz (pc)','FontSize', 15)
    ylabel('SF Amplitude (D(1500))','FontSize', 15)   
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    plot(realsize24(index24),D1500w24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    xlim([0 max(realsize24(index24))])
    ylim([min(D1500w24(index24)) max(D1500w24(index24))]) 
    xlabel('Source Size of 24 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    plot(realsize43(index43),D1500w43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k')  
    xlim([0 max(realsize43(index43))])
    ylim([min(D1500w43(index43)) max(D1500w43(index43))]) 
    xlabel('Source Size of 43 GHz (pc)','FontSize', 15)
    set(gca,'XScale', 'log','YScale', 'log','FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude D(\tau = 1500) With Actual Source Size in Different Frequency'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SF Amplitude (D1500w) vs Redshift z   
figure(24);   
set(gcf,'pos',[100,100,1200,800]);    
    
    plot(z2(index2),D1500w2(index2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on 
    plot(z5(index5),D1500w5(index5),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z8(index8),D1500w8(index8),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z15(index15),D1500w15(index15),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z24(index24),D1500w24(index24),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(z43(index43),D1500w43(index43),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    set(gca,'YScale', 'log')
    xlabel('Redshift z','FontSize', 15)
    ylabel('SF Amplitude D(\tau = 1500)','FontSize', 15) 
    xlim([0 5])
    ylim([0 10])    
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare SF Amplitude D(\tau = 1500) with Redshift z  '); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SF Amplitude D1500w vs Mean flux
figure(25);   
set(gcf,'pos',[100,100,1200,800]);
    
    plot(MF2,D1500w2,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(MF5,D1500w5,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF8,D1500w8,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF15,D1500w15,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF24,D1500w24,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(MF43,D1500w43,'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    
    set(gca,'XScale', 'log','YScale', 'log')
    xlabel('Mean Flux (Jy)','FontSize', 15)
    ylabel('SF Amplitude D(\tau = 1500)','FontSize', 15) 
    xlim([-1 2])
    ylim([0 2])    
    set(gca,'FontSize',15,'LineWidth',2); 
    
sgt = sgtitle('Compare Mean Flux with SF Amplitude D(\tau = 1500)'); 
sgt.FontSize = 20;
sgt.LineWidth = 2;

D1500wtotal = [D1500w2,D1500w5,D1500w8,D1500w15,D1500w24,D1500w43];

[r,p] = corr(MFtotal',D1500wtotal','type','Spearman');
D1500w_MF_corr = [r,p];   
    
 
end
