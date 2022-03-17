%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A code to do comparasion of WHAM intensity sources and blazar sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [aa ] = Halpha_blazarsources_func(fob,fowb,D1000w,D2000w,D1500w,MF,nt2,nt5,nt8,nt15,nt24,nt43,...
    numreSt2,numSt2,numreSt5,numSt5,numreSt8,numSt8,numreSt15,numSt15,numreSt24,numSt24,numreSt43,...
    numSt43,realsize2,realsize5,realsize8,realsize15,realsize24,realsize43,z,matres_l,matres_b)

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

D1000w2 = D1000w(numreSt2); 
D1000w5 = D1000w(numreSt5); 
D1000w8 = D1000w(numreSt8); 
D1000w15 = D1000w(numreSt15); 
D1000w24 = D1000w(numreSt24); 
D1000w43 = D1000w(numreSt43); 

matres_l2 = matres_l(numSt2);
matres_l5 = matres_l(numSt5);
matres_l8 = matres_l(numSt8);
matres_l15 = matres_l(numSt15);
matres_l24 = matres_l(numSt24);
matres_l43 = matres_l(numSt43);

matres_b2 = matres_b(numSt2);
matres_b5 = matres_b(numSt5);
matres_b8 = matres_b(numSt8);
matres_b15 = matres_b(numSt15);
matres_b24 = matres_b(numSt24);
matres_b43 = matres_b(numSt43);

fowbsrc2 = fowb(numreSt2).*(1 + z(numSt2));
fowbsrc5 = fowb(numreSt5).*(1 + z(numSt5));
fowbsrc8 = fowb(numreSt8).*(1 + z(numSt8));
fowbsrc15 = fowb(numreSt15).*(1 + z(numSt15));
fowbsrc24 = fowb(numreSt24).*(1 + z(numSt24));
fowbsrc43 = fowb(numreSt43).*(1 + z(numSt43));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
absb = abs(matres_b2);

figure(1);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
    histogram(size2(abs(matres_b2) < 20),'binwidth',1) 
    hold on 
    histogram(size2(20 < abs(matres_b2) & abs(matres_b2) < 40),'binwidth',1) 
    histogram(size2(40 < abs(matres_b2) & abs(matres_b2) < 60),'binwidth',1) 
    histogram(size2(60 < abs(matres_b2) & abs(matres_b2) < 80),'binwidth',1) 
    hold off
    xlabel('Source size (mas)','FontSize', 15)
    ylabel('Count','FontSize', 15)   
    legend('0<b<20 deg','20<b<40 deg','40<b<60 deg','60<b<80 deg')
    set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
    histogram(size5(abs(matres_b5) < 20),'binwidth',0.5) 
    hold on 
    histogram(size5(20 < abs(matres_b5) & abs(matres_b5) < 40),'binwidth',0.5) 
    histogram(size5(40 < abs(matres_b5) & abs(matres_b5) < 60),'binwidth',0.5) 
    histogram(size5(60 < abs(matres_b5) & abs(matres_b5) < 80),'binwidth',0.5) 
    hold off
    xlabel('Source size (mas)','FontSize', 15)
    ylabel('Count','FontSize', 15)   
    legend('0<b<20 deg','20<b<40 deg','40<b<60 deg','60<b<80 deg')
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
    histogram(size8(abs(matres_b8) < 20),'binwidth',0.1) 
    hold on 
    histogram(size8(20 < abs(matres_b8) & abs(matres_b8) < 40),'binwidth',0.1) 
    histogram(size8(40 < abs(matres_b8) & abs(matres_b8) < 60),'binwidth',0.1) 
    histogram(size8(60 < abs(matres_b8) & abs(matres_b8) < 80),'binwidth',0.1) 
    hold off
    xlabel('Source size (mas)','FontSize', 15)
    ylabel('Count','FontSize', 15)   
    legend('0<b<20 deg','20<b<40 deg','40<b<60 deg','60<b<80 deg')
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
    histogram(size15(abs(matres_b15) < 20),'binwidth',0.1) 
    hold on 
    histogram(size15(20 < abs(matres_b15) & abs(matres_b15) < 40),'binwidth',0.1) 
    histogram(size15(40 < abs(matres_b15) & abs(matres_b15) < 60),'binwidth',0.1) 
    histogram(size15(60 < abs(matres_b15) & abs(matres_b15) < 80),'binwidth',0.1) 
    hold off
    xlabel('Source size (mas)','FontSize', 15)
    ylabel('Count','FontSize', 15)   
    legend('0<b<20 deg','20<b<40 deg','40<b<60 deg','60<b<80 deg')
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
    histogram(size24(abs(matres_b24) < 20),'binwidth',0.1) 
    hold on 
    histogram(size24(20 < abs(matres_b24) & abs(matres_b24) < 40),'binwidth',0.1) 
    histogram(size24(40 < abs(matres_b24) & abs(matres_b24) < 60),'binwidth',0.1) 
    histogram(size24(60 < abs(matres_b24) & abs(matres_b24) < 80),'binwidth',0.1) 
    hold off
    xlabel('Source size (mas)','FontSize', 15)
    ylabel('Count','FontSize', 15)   
    legend('0<b<20 deg','20<b<40 deg','40<b<60 deg','60<b<80 deg')
    set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
    histogram(size43(abs(matres_b43) < 20),'binwidth',0.05) 
    hold on 
    histogram(size43(20 < abs(matres_b43) & abs(matres_b43) < 40),'binwidth',0.05) 
    histogram(size43(40 < abs(matres_b43) & abs(matres_b43) < 60),'binwidth',0.05) 
    histogram(size43(60 < abs(matres_b43) & abs(matres_b43) < 80),'binwidth',0.05) 
    hold off
    xlabel('Source size (mas)','FontSize', 15)
    ylabel('Count','FontSize', 15)   
    legend('0<b<20 deg','20<b<40 deg','40<b<60 deg','60<b<80 deg')
    set(gca,'FontSize',15,'LineWidth',2); 

figure(2);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(size2,abs(matres_b2),'r.','MarkerSize',6,'MarkerFaceColor','k') 
    hold on
    plot(size5,abs(matres_b5),'g.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(size8,abs(matres_b8),'b.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(size15,abs(matres_b15),'k.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(size24,abs(matres_b24),'y.','MarkerSize',6,'MarkerFaceColor','k') 
    plot(size43,abs(matres_b43),'m.','MarkerSize',6,'MarkerFaceColor','k') 
    hold off
    xlabel('Source size (mas)','FontSize', 20)
    ylabel('Galactic latitude (deg)','FontSize', 20)
    xlim([0 10])   
    ylim([0 90])   
    legend('2 GHz','5 GHz','8 GHz','15 GHz','24 GHz','43 GHz','location','northeast')
    set(gca,'FontSize',15,'LineWidth',2,'Xscale','log'); 

aa= 1;



























end

