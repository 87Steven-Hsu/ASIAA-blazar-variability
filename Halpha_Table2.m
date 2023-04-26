%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A code to do comparasion of WHAM intensity sources and blazar sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [high_low_b_app_coresize_KS, high_low_b_size_int_corr] = Halpha_Table2(fob,fowb, ...
%     D1000w,SFerru,SFerrd,D4w,D4w_uperr,D4w_lowerr,Dnoise,save_figure,...
%     size2_median,size5_median,size8_median,size15_median,size24_median,size43_median, ...
%     numreSt2,numreSt5,numreSt8,numreSt15,numreSt24,numreSt43, ...
%     numSt2,numSt5,numSt8,numSt15,numSt24,numSt43,...
%     realsize2,realsize5,realsize8,realsize15,realsize24,realsize43,z, ...
%     matres_l,matres_b,Halpha_int,Halpha_int_err)


function [ high_low_b_size_int_corr] = Halpha_Table2(save_figure,...
    size2_median,size5_median,size8_median,size15_median,size24_median,size43_median, ...
    OVRO_l, OVRO_b,Halpha_int,Halpha_int_err);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Set up parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fowb2 = fowb(numreSt2); 
% fowb5 = fowb(numreSt5); 
% fowb8 = fowb(numreSt8); 
% fowb15 = fowb(numreSt15); 
% fowb24 = fowb(numreSt24); 
% fowb43 = fowb(numreSt43); 
% 
% eqobslim_2 = find(fob(numreSt2) == fowb(numreSt2));
% eqobslim_5 = find(fob(numreSt5) == fowb(numreSt5));
% eqobslim_8 = find(fob(numreSt8) == fowb(numreSt8));
% eqobslim_15 = find(fob(numreSt15) == fowb(numreSt15));
% eqobslim_24 = find(fob(numreSt24) == fowb(numreSt24));
% eqobslim_43 = find(fob(numreSt43) == fowb(numreSt43));
% 
% neqobslim_2 = find(fob(numreSt2) ~= fowb(numreSt2));
% neqobslim_5 = find(fob(numreSt5) ~= fowb(numreSt5));
% neqobslim_8 = find(fob(numreSt8) ~= fowb(numreSt8));
% neqobslim_15 = find(fob(numreSt15) ~= fowb(numreSt15));
% neqobslim_24 = find(fob(numreSt24) ~= fowb(numreSt24));
% neqobslim_43 = find(fob(numreSt43) ~= fowb(numreSt43));
% 
% size2 = size2_median;
% size5 = size5_median;
% size8 = size8_median;
% size15 = size15_median;
% size24 = size24_median;
% size43 = size43_median;    
%   
% D1000w2 = D1000w(numreSt2); 
% D1000w5 = D1000w(numreSt5); 
% D1000w8 = D1000w(numreSt8); 
% D1000w15 = D1000w(numreSt15); 
% D1000w24 = D1000w(numreSt24); 
% D1000w43 = D1000w(numreSt43); 
% 
% %%% galactic longitude
% matres_l2 = matres_l(numreSt2);
% matres_l5 = matres_l(numreSt5);
% matres_l8 = matres_l(numreSt8);
% matres_l15 = matres_l(numreSt15);
% matres_l24 = matres_l(numreSt24);
% matres_l43 = matres_l(numreSt43);
% 
% %%% galactic latitude
% matres_b2 = matres_b(numreSt2);
% matres_b5 = matres_b(numreSt5);
% matres_b8 = matres_b(numreSt8);
% matres_b15 = matres_b(numreSt15);
% matres_b24 = matres_b(numreSt24);
% matres_b43 = matres_b(numreSt43);
% 
% lt15_matres_b2 = find(abs(matres_b2) <= 15);
% gt15_matres_b2 = find(abs(matres_b2) > 15);
% lt15_matres_b5 = find(abs(matres_b5) <= 15);
% gt15_matres_b5 = find(abs(matres_b5) > 15);
% lt15_matres_b8 = find(abs(matres_b8) <= 15);
% gt15_matres_b8 = find(abs(matres_b8) > 15);
% lt15_matres_b15 = find(abs(matres_b15) <= 15);
% gt15_matres_b15 = find(abs(matres_b15) > 15);
% lt15_matres_b24 = find(abs(matres_b24) <= 15);
% gt15_matres_b24 = find(abs(matres_b24) > 15);
% lt15_matres_b43 = find(abs(matres_b43) <= 15);
% gt15_matres_b43 = find(abs(matres_b43) > 15);
% 
% %%% H-alpha intensity
% Halpha_int2 = Halpha_int(numreSt2);
% Halpha_int5 = Halpha_int(numreSt5);
% Halpha_int8 = Halpha_int(numreSt8);
% Halpha_int15 = Halpha_int(numreSt15);
% Halpha_int24 = Halpha_int(numreSt24);
% Halpha_int43 = Halpha_int(numreSt43);
% 
% %%% H-alpha intensity uncertainty
% Halpha_int_err2 = Halpha_int_err(numreSt2);
% Halpha_int_err5 = Halpha_int_err(numreSt5);
% Halpha_int_err8 = Halpha_int_err(numreSt8);
% Halpha_int_err15 = Halpha_int_err(numreSt15);
% Halpha_int_err24 = Halpha_int_err(numreSt24);
% Halpha_int_err43 = Halpha_int_err(numreSt43);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% compare different frequencies core size in low (<15) and high(>15)
% %%% latitudes
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(1);
%     set(gcf,'pos',[100,100,1200,800]);
%     
%     subplot('position',[0.07,0.55,0.25,0.33])
%         histogram(size2(abs(matres_b2) < 15),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
%         hold on 
%         histogram(size2(abs(matres_b2) > 15 ),'binwidth',0.2,'Normalization','probability') 
%         hold off
%         xlim([0 3])
%         xlabel('\theta_{2 GHz} [mas]','FontSize', 15)
%         ylabel('Count','FontSize', 15)   
%         legend('0<|b|<15 deg','|b|>15 deg')
%         set(gca,'FontSize',15,'LineWidth',2); 
% 
%     subplot('position',[0.39,0.55,0.25,0.33])
%         histogram(size5(abs(matres_b5) < 15),'binwidth',0.2,'Normalization','probability') 
%         hold on 
%         histogram(size5( abs(matres_b5) > 15),'binwidth',0.2,'Normalization','probability') 
%         hold off
%         xlim([0 2.5])
%         xlabel('\theta_{5 GHz} [mas]','FontSize', 15)
%         ylabel('Count','FontSize', 15)   
%         legend('0<|b|<15 deg','|b|>15 deg')
%         set(gca,'FontSize',15,'LineWidth',2); 
%     
%     subplot('position',[0.71,0.55,0.25,0.33])
%         histogram(size8(abs(matres_b8) < 15),'binwidth',0.1,'Normalization','probability') 
%         hold on 
%         histogram(size8(abs(matres_b8) > 15),'binwidth',0.1,'Normalization','probability') 
%         hold off
%         xlim([0 1])
%         xlabel('\theta_{8 GHz} [mas]','FontSize', 15)
%         ylabel('Count','FontSize', 15)   
%         legend('0<|b|<15 deg','|b|>15 deg')
%         set(gca,'FontSize',15,'LineWidth',2); 
%     
%     subplot('position',[0.07,0.09,0.25,0.33])
%         histogram(size15(abs(matres_b15) < 15),'binwidth',0.05,'Normalization','probability') 
%         hold on 
%         histogram(size15(abs(matres_b15) > 15),'binwidth',0.05,'Normalization','probability') 
%         hold off
%         xlim([0 0.5])
%         xlabel('\theta_{15 GHz} [mas]','FontSize', 15)
%         ylabel('Count','FontSize', 15)   
%         legend('0<|b|<15 deg','|b|>15 deg')
%         set(gca,'FontSize',15,'LineWidth',2); 
%     
%     subplot('position',[0.39,0.09,0.25,0.33])
%         histogram(size24(abs(matres_b24) < 15),'binwidth',0.02,'Normalization','probability') 
%         hold on 
%         histogram(size24(abs(matres_b24) > 15),'binwidth',0.02,'Normalization','probability') 
%         hold off
%         %xlim([0 0.3])
%         %ylim([0 30])
%         xlabel('\theta_{24 GHz} [mas]','FontSize', 15)
%         ylabel('Count','FontSize', 15)   
%         legend('0<|b|<15 deg','|b|>15 deg')
%         set(gca,'FontSize',15,'LineWidth',2); 
%     
%     subplot('position',[0.71,0.09,0.25,0.33])
%         histogram(size43(abs(matres_b43) < 15),'binwidth',0.02,'Normalization','probability') 
%         hold on 
%         histogram(size43(abs(matres_b43) > 15),'binwidth',0.02,'Normalization','probability') 
%         hold off
%         xlim([0 0.3])
%         xlabel('\theta_{43 GHz} [mas]','FontSize', 15)
%         ylabel('Count','FontSize', 15)   
%         legend('0<|b|<15 deg','|b|>15 deg')
%         set(gca,'FontSize',15,'LineWidth',2); 
% 
% [r2, p2] = kstest2(size2(abs(matres_b2) < 15), size2(abs(matres_b2) > 15));
% [r5, p5] = kstest2(size5(abs(matres_b5) < 15), size5(abs(matres_b5) > 15));
% [r8, p8] = kstest2(size8(abs(matres_b8) < 15), size8(abs(matres_b8) > 15));
% [r15, p15] = kstest2(size15(abs(matres_b15) < 15), size15(abs(matres_b15) > 15));
% [r24, p24] = kstest2(size24(abs(matres_b24) < 15), size24(abs(matres_b24) > 15));
% [r43, p43] = kstest2(size43(abs(matres_b43) < 15), size43(abs(matres_b43) > 15));
% 
% high_low_b_app_coresize_KS = [[r2, p2];[r5, p5];[r8, p8];[r15, p15];[r24, p24];[r43, p43]];
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% plot core sizes against galactic latitude
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% b_interval = linspace(0, 90, 91);
% 
% for i = 1:90
%     index = find( b_interval(i) <= abs(matres_b2) & abs(matres_b2) <= b_interval(i+1) );
%     median_size2(i) = nanmedian(size2(index)); 
%     mean_size2(i) = nanmean(size2(index)); 
%     std_size2(i) = nanstd(size2(index)); 
%     
%     index = find( b_interval(i) <= abs(matres_b5) & abs(matres_b5) <= b_interval(i+1) );
%     mean_size5(i) = nanmean(size5(index)); 
%     median_size5(i) = nanmedian(size5(index)); 
% 
%     index = find( b_interval(i) <= abs(matres_b8) & abs(matres_b8) <= b_interval(i+1) );
%     mean_size8(i) = nanmean(size8(index)); 
%     median_size8(i) = nanmedian(size8(index)); 
% 
%     index = find( b_interval(i) <= abs(matres_b15) & abs(matres_b15) <= b_interval(i+1) );
%     mean_size15(i) = nanmean(size15(index)); 
%     median_size15(i) = nanmedian(size15(index)); 
% 
%     index = find( b_interval(i) <= abs(matres_b24) & abs(matres_b24) <= b_interval(i+1) );
%     mean_size24(i) = nanmean(size24(index)); 
%     median_size24(i) = nanmedian(size24(index)); 
% 
%     index = find( b_interval(i) <= abs(matres_b43) & abs(matres_b43) <= b_interval(i+1) );
%     mean_size43(i) = nanmean(size43(index)); 
%     median_size43(i) = nanmedian(size43(index)); 
% 
% end
% 
% figure(2);
%     set(gcf,'pos',[100,100,1200,800]);
%     
%     subplot('position',[0.07,0.55,0.25,0.33])
%         plot(abs(matres_b2),size2,'ro','MarkerSize',6,'MarkerFaceColor','r') 
%         hold on
%         plot(b_interval(1:90), median_size2,'k-','LineWidth', 3) 
%         plot(b_interval(1:90), mean_size2,'g-','LineWidth', 3) 
%         plot([15, 15],[0, 999],'b--','LineWidth', 3)
%         hold off
%         xlim([0 90])   
%         ylim([0.01 3])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{2 GHz} [mas]','FontSize', 15)   
%         legend( '','Median', 'Mean','location','northeast','FontSize', 15)
%         set(gca,'FontSize', 15,'LineWidth',2); 
% 
%     subplot('position',[0.39,0.55,0.25,0.33])
%         plot(abs(matres_b5),size5,'ro','MarkerSize',6,'MarkerFaceColor','r') 
%         hold on
%         plot(b_interval(1:90), median_size5,'k-','LineWidth', 3) 
%         plot(b_interval(1:90), mean_size5,'g-','LineWidth', 3) 
%         plot([15, 15],[0, 999],'b--','LineWidth', 3)
%         %plot(b_interval(1:90), median_size2 + std_size2,'k--','LineWidth',3) 
%         %plot(b_interval(1:90), median_size2 - std_size2,'k-','LineWidth',3) 
%         hold off
%         xlim([0 90])   
%         ylim([0.01 2])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{5 GHz} [mas]','FontSize', 15)   
%         legend( '','Median', 'Mean','location','northeast','FontSize', 15)
%         set(gca,'FontSize', 15,'LineWidth',2); 
% 
%     subplot('position',[0.71,0.55,0.25,0.33])
%         plot(abs(matres_b8),size8,'ro','MarkerSize',6,'MarkerFaceColor','r') 
%         hold on
%         plot(b_interval(1:90), median_size8,'k-','LineWidth',3) 
%         plot(b_interval(1:90), mean_size8,'g-','LineWidth',3) 
%         plot([15, 15],[0, 999],'b--','LineWidth', 3)
%         %plot(b_interval(1:90), median_size2 + std_size2,'k--','LineWidth',3) 
%         %plot(b_interval(1:90), median_size2 - std_size2,'k-','LineWidth',3) 
%         hold off
%         xlim([0 90])   
%         ylim([0.01 1])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{8 GHz} [mas]','FontSize', 15)  
%         legend( '','Median', 'Mean','location','northeast','FontSize', 15)
%         set(gca,'FontSize', 15,'LineWidth',2); 
% 
%     subplot('position',[0.07,0.09,0.25,0.33])
%         plot(abs(matres_b15),size15,'ro','MarkerSize',6,'MarkerFaceColor','r') 
%         hold on
%         plot(b_interval(1:90), median_size15,'k-','LineWidth',3) 
%         plot(b_interval(1:90), mean_size15,'g-','LineWidth',3) 
%         plot([15, 15],[0, 999],'b--','LineWidth', 3)
%         %plot(b_interval(1:90), median_size2 + std_size2,'k--','LineWidth',3) 
%         %plot(b_interval(1:90), median_size2 - std_size2,'k-','LineWidth',3) 
%         hold off
%         xlim([0 90])   
%         ylim([0.01 0.7])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{15 GHz} [mas]','FontSize', 15) 
%         legend( '','Median', 'Mean','location','northeast','FontSize', 15)
%         set(gca,'FontSize', 15,'LineWidth',2); 
% 
%     subplot('position',[0.39,0.09,0.25,0.33])
%         plot(abs(matres_b24),size24,'ro','MarkerSize',6,'MarkerFaceColor','r') 
%         hold on
%         plot(b_interval(1:90), median_size24,'k-','LineWidth',3) 
%         plot(b_interval(1:90), mean_size24,'g-','LineWidth',3) 
%         plot([15, 15],[0, 999],'b--','LineWidth', 3)
%         %plot(b_interval(1:90), median_size2 + std_size2,'k--','LineWidth',3) 
%         %plot(b_interval(1:90), median_size2 - std_size2,'k-','LineWidth',3) 
%         hold off
%         xlim([0 90])   
%         ylim([0.01 0.3])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{24 GHz} [mas]','FontSize', 15)  
%         legend( '','Median', 'Mean','location','northeast','FontSize', 15)
%         set(gca,'FontSize', 15,'LineWidth',2); 
% 
%     subplot('position',[0.71,0.09,0.25,0.33])
%         plot(abs(matres_b43),size43,'ro','MarkerSize',6,'MarkerFaceColor','r') 
%         hold on
%         plot(b_interval(1:90), median_size43,'k-','LineWidth',3) 
%         plot(b_interval(1:90), mean_size43,'g-','LineWidth',3) 
%         plot([15, 15],[0, 999],'b--','LineWidth', 3)
%         %plot(b_interval(1:90), median_size2 + std_size2,'k--','LineWidth',3) 
%         %plot(b_interval(1:90), median_size2 - std_size2,'k-','LineWidth',3) 
%         hold off
%         xlim([0 90])   
%         ylim([0.01 0.3])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{43 GHz} [mas]','FontSize', 15)   
%         legend( '','Median', 'Mean','location','northeast','FontSize', 15)
%         set(gca,'FontSize', 15,'LineWidth',2); 
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%% plot core sizes against galactic latitude with H-alpha intensity
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure(3);
%     set(gcf,'pos',[100,100,1200,800]);
%     
%     subplot('position',[0.07,0.55,0.25,0.33])
%         c = log10(Halpha_int2);
%         scatter(abs(matres_b2),size2,50,c,'filled')
%         xlim([0. 90])   
%         ylim([0. max(size2)*1.1])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{2 GHz} [mas]','FontSize', 15)
%         hcb = colorbar;
%         colormap jet
%         set(gca,'YScale','log','FontSize', 15,'LineWidth',2); 
% 
%     subplot('position',[0.39,0.55,0.25,0.33])
%         c = log10(Halpha_int5);
%         scatter(abs(matres_b5),size5,50,c,'filled')
%         xlim([0. 90])   
%         ylim([0. max(size5)*1.1])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{5 GHz} [mas]','FontSize', 15)
%         hcb = colorbar;
%         colormap jet
%         set(gca,'YScale','log','FontSize', 15,'LineWidth',2); 
%     
%     subplot('position',[0.71,0.55,0.25,0.33])
%         c = log10(Halpha_int8);
%         scatter(abs(matres_b8),size8,50,c,'filled')
%         xlim([0. 90])   
%         ylim([0. max(size8)*1.1])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{8 GHz} [mas]','FontSize', 15)
%         hcb = colorbar;
%         hcb.Label.String = "log(H-\alpha intensity)";
%         hcb.Label.FontSize = 15;
%         colormap jet
%         set(gca,'YScale','log','FontSize', 15,'LineWidth',2); 
%     
%     subplot('position',[0.07,0.09,0.25,0.33])
%         c = log10(Halpha_int15);
%         scatter(abs(matres_b15),size15,50,c,'filled')
%         xlim([0. 90])   
%         ylim([0. max(size15)*1.1])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{15 GHz} [mas]','FontSize', 15)
%         hcb = colorbar;
%         colormap jet
%         set(gca,'YScale','log','FontSize', 15,'LineWidth',2); 
% 
%     subplot('position',[0.39,0.09,0.25,0.33])
%         c = log10(Halpha_int24);
%         scatter(abs(matres_b24),size24,50,c,'filled')
%         xlim([0. 90])   
%         ylim([0. max(size24)*1.1])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{24 GHz} [mas]','FontSize', 15)
%         hcb = colorbar;
%         colormap jet
%         set(gca,'YScale','log','FontSize', 15,'LineWidth',2); 
%     
%     subplot('position',[0.71,0.09,0.25,0.33])
%         c = log10(Halpha_int43);
%         scatter(abs(matres_b43),size43,50,c,'filled')
%         xlim([0. 90])   
%         ylim([0. max(size43)*1.1])
%         xlabel('|b| [deg]','FontSize', 15)   
%         ylabel('\theta_{43 GHz} [mas]','FontSize', 15)
%         hcb = colorbar;
%         hcb.Label.String = "log(H-\alpha intensity)";
%         hcb.Label.FontSize = 15;
%         colormap jet
%         set(gca,'YScale','log','FontSize', 15,'LineWidth',2); 
% 
%     figure(4);
%     set(gcf,'pos',[100,100,1200,800]);
%     
%         subplot('position',[0.07,0.55,0.25,0.33])
%             plot(size2(gt15_matres_b2), Halpha_int2(gt15_matres_b2),'bo','MarkerSize',6,'MarkerFaceColor','b')    
%             hold on
%             plot(size2(lt15_matres_b2), Halpha_int2(lt15_matres_b2),'ro','MarkerSize',6,'MarkerFaceColor','r')    
%             hold off
%             xlim([0.2 5])   
%             ylim([0.1 150])
%             xlabel('\theta_{2 GHz} [mas]','FontSize', 15)
%             ylabel('H-\alpha intensity','FontSize', 15)   
%             legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
%             set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2)
%             
%         notnan_index_size = find(~isnan( size2(lt15_matres_b2)' ));
%         notnan_index_int = find(~isnan( Halpha_int2(lt15_matres_b2) ));
% 
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size2(lt15_matres_b2(intersect_index))';
%         new_int = Halpha_int2(lt15_matres_b2(intersect_index));
% 
%         [low_r2,low_p2] = corr(new_size, new_int,'type','Kendall');
% 
%         notnan_index_size = find(~isnan( size2(gt15_matres_b2)' ));
%         notnan_index_int = find(~isnan( Halpha_int2(gt15_matres_b2) ));
% 
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size2(gt15_matres_b2(intersect_index))';
%         new_int = Halpha_int2(gt15_matres_b2(intersect_index));
% 
%         [high_r2,high_p2] = corr(new_size, new_int,'type','Kendall');
%             
%         subplot('position',[0.39,0.55,0.25,0.33])
%             plot(size5(gt15_matres_b5), Halpha_int5(gt15_matres_b5),'bo','MarkerSize',6,'MarkerFaceColor','b')      
%             hold on
%             plot(size5(lt15_matres_b5), Halpha_int5(lt15_matres_b5),'ro','MarkerSize',6,'MarkerFaceColor','r')  
%             hold off
%             xlim([0.02 10])   
%             ylim([0.1 150])
%             xlabel('\theta_{5 GHz} [mas]','FontSize', 15)
%             ylabel('H-\alpha intensity','FontSize', 15)   
%             legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
%             set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
% 
%         notnan_index_size = find(~isnan( size5(lt15_matres_b5)' ));
%         notnan_index_int = find(~isnan( Halpha_int5(lt15_matres_b5) ));
%     
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size5(lt15_matres_b5(intersect_index))';
%         new_int = Halpha_int5(lt15_matres_b5(intersect_index));
%     
%         [low_r5,low_p5] = corr(new_size, new_int,'type','Kendall');
%     
%         notnan_index_size = find(~isnan( size5(gt15_matres_b5)' ));
%         notnan_index_int = find(~isnan( Halpha_int5(gt15_matres_b5) ));
%     
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size5(gt15_matres_b5(intersect_index))';
%         new_int = Halpha_int5(gt15_matres_b5(intersect_index));
%     
%         [high_r5,high_p5] = corr(new_size, new_int,'type','Kendall');
% 
%         subplot('position',[0.71,0.55,0.25,0.33])
%             plot(size8(gt15_matres_b8), Halpha_int8(gt15_matres_b8),'bo','MarkerSize',6,'MarkerFaceColor','b')
%             hold on
%             plot(size8(lt15_matres_b8), Halpha_int8(lt15_matres_b8),'ro','MarkerSize',6,'MarkerFaceColor','r')
%             hold off
%             xlim([0.05 2])   
%             ylim([0.1 180])
%             xlabel('\theta_{8 GHz} [mas]','FontSize', 15)
%             ylabel('H-\alpha intensity','FontSize', 15)   
%             legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
%             set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
% 
%         notnan_index_size = find(~isnan( size8(lt15_matres_b8)' ));
%         notnan_index_int = find(~isnan( Halpha_int8(lt15_matres_b8) ));
%     
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size8(lt15_matres_b8(intersect_index))';
%         new_int = Halpha_int8(lt15_matres_b8(intersect_index));
%     
%         [low_r8,low_p8] = corr(new_size, new_int,'type','Kendall');
%     
%         notnan_index_size = find(~isnan( size8(gt15_matres_b8)' ));
%         notnan_index_int = find(~isnan( Halpha_int8(gt15_matres_b8) ));
%     
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size8(gt15_matres_b8(intersect_index))';
%         new_int = Halpha_int8(gt15_matres_b8(intersect_index));
%     
%         [high_r8,high_p8] = corr(new_size, new_int,'type','Kendall');
% 
%         subplot('position',[0.07,0.09,0.25,0.33])
%             plot(size15(gt15_matres_b15), Halpha_int15(gt15_matres_b15),'bo','MarkerSize',6,'MarkerFaceColor','b') 
%             hold on
%             plot(size15(lt15_matres_b15), Halpha_int15(lt15_matres_b15),'ro','MarkerSize',6,'MarkerFaceColor','r')  
%             hold off
%             xlim([0.02 0.9])   
%             ylim([0.1 100])
%             xlabel('\theta_{15 GHz} [mas]','FontSize', 15)
%             ylabel('H-\alpha intensity','FontSize', 15)   
%             legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
%             set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
% 
%         notnan_index_size = find(~isnan( size15(lt15_matres_b15)' ));
%         notnan_index_int = find(~isnan( Halpha_int15(lt15_matres_b15) ));
%     
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size15(lt15_matres_b15(intersect_index))';
%         new_int = Halpha_int15(lt15_matres_b15(intersect_index));
%     
%         [low_r15,low_p15] = corr(new_size, new_int,'type','Kendall');
%     
%         notnan_index_size = find(~isnan( size15(gt15_matres_b15)' ));
%         notnan_index_int = find(~isnan( Halpha_int15(gt15_matres_b15) ));
%     
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size15(gt15_matres_b15(intersect_index))';
%         new_int = Halpha_int15(gt15_matres_b15(intersect_index));
%     
%         [high_r15,high_p15] = corr(new_size, new_int,'type','Kendall');
% 
%         subplot('position',[0.39,0.09,0.25,0.33])
%             plot(size24(gt15_matres_b24), Halpha_int24(gt15_matres_b24),'bo','MarkerSize',6,'MarkerFaceColor','b')
%             hold on
%             plot(size24(lt15_matres_b24), Halpha_int24(lt15_matres_b24),'ro','MarkerSize',6,'MarkerFaceColor','r') 
%             hold off
%             xlim([0.02 0.5])   
%             ylim([0.1 90])
%             xlabel('\theta_{24 GHz} [mas]','FontSize', 15)
%             ylabel('H-\alpha intensity','FontSize', 15)   
%             legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
%             set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
% 
%         notnan_index_size = find(~isnan( size24(lt15_matres_b24)' ));
%         notnan_index_int = find(~isnan( Halpha_int24(lt15_matres_b24) ));
% 
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size24(lt15_matres_b24(intersect_index))';
%         new_int = Halpha_int24(lt15_matres_b24(intersect_index));
% 
%         [low_r24,low_p24] = corr(new_size, new_int,'type','Kendall');
% 
%         notnan_index_size = find(~isnan( size24(gt15_matres_b24)' ));
%         notnan_index_int = find(~isnan( Halpha_int24(gt15_matres_b24) ));
% 
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size24(gt15_matres_b24(intersect_index))';
%         new_int = Halpha_int24(gt15_matres_b24(intersect_index));
% 
%         [high_r24,high_p24] = corr(new_size, new_int,'type','Kendall');
% 
%         subplot('position',[0.71,0.09,0.25,0.33])
%             plot(size43(gt15_matres_b43), Halpha_int43(gt15_matres_b43),'bo','MarkerSize',6,'MarkerFaceColor','b')   
%             hold on
%             plot(size43(lt15_matres_b43), Halpha_int43(lt15_matres_b43),'ro','MarkerSize',6,'MarkerFaceColor','r') 
%             hold off
%             xlim([0.01 0.3])   
%             ylim([0.1 70])
%             xlabel('\theta_{43 GHz} [mas]','FontSize', 15)
%             ylabel('H-\alpha intensity','FontSize', 15)   
%             legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
%             set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 
% 
%         notnan_index_size = find(~isnan( size43(lt15_matres_b43)' ));
%         notnan_index_int = find(~isnan( Halpha_int43(lt15_matres_b43) ));
% 
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size43(lt15_matres_b43(intersect_index))';
%         new_int = Halpha_int43(lt15_matres_b43(intersect_index));
% 
%         [low_r43,low_p43] = corr(new_size, new_int,'type','Kendall');
% 
%         notnan_index_size = find(~isnan( size43(gt15_matres_b43)' ));
%         notnan_index_int = find(~isnan( Halpha_int43(gt15_matres_b43) ));
% 
%         intersect_index = intersect(notnan_index_size, notnan_index_int);
%         new_size = size43(gt15_matres_b43(intersect_index))';
%         new_int = Halpha_int43(gt15_matres_b43(intersect_index));
% 
%         [high_r43,high_p43] = corr(new_size, new_int,'type','Kendall');
% 
%     high_low_b_size_int_corr = [[low_r2,low_p2], [high_r2,high_p2]; [low_r5,low_p5], [high_r5,high_p5]; ...
%         [low_r8,low_p8], [high_r8,high_p8]; [low_r15,low_p15], [high_r15,high_p15];... 
%         [low_r24,low_p24], [high_r24,high_p24]; [low_r43,low_p43], [high_r43,high_p43]; ];
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%% compare H-alpha intensity of low (<15) and high(>15) latitudes
%     %%% sources
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure(5);
%         set(gcf,'pos',[100,100,1200,800]);
%         
%         subplot('position',[0.07,0.55,0.25,0.33])
%             histogram( log10(Halpha_int2(lt15_matres_b2)),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
%             hold on 
%             histogram( log10(Halpha_int2(gt15_matres_b2)),'binwidth',0.2,'Normalization','probability') 
%             hold off
%             %xlim([0 5])
%             xlabel('H-\alpha Intensity','FontSize', 15)
%             ylabel('Count','FontSize', 15)   
%             legend('0<|b|<15 deg','|b|>15 deg')
%             set(gca,'FontSize',15,'LineWidth',2); 
% 
%         subplot('position',[0.39,0.55,0.25,0.33])
%             histogram( log10(Halpha_int5(lt15_matres_b5)),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
%             hold on 
%             histogram( log10(Halpha_int5(gt15_matres_b5)),'binwidth',0.2,'Normalization','probability') 
%             hold off
%             %xlim([0 5])
%             xlabel('H-\alpha Intensity','FontSize', 15)
%             ylabel('Count','FontSize', 15)   
%             legend('0<|b|<15 deg','|b|>15 deg')
%             set(gca,'FontSize',15,'LineWidth',2); 
% 
%         subplot('position',[0.71,0.55,0.25,0.33])
%             histogram( log10(Halpha_int8(lt15_matres_b8)),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
%             hold on 
%             histogram( log10(Halpha_int8(gt15_matres_b8)),'binwidth',0.2,'Normalization','probability') 
%             hold off
%             %xlim([0 5])
%             xlabel('H-\alpha Intensity','FontSize', 15)
%             ylabel('Count','FontSize', 15)   
%             legend('0<|b|<15 deg','|b|>15 deg')
%             set(gca,'FontSize',15,'LineWidth',2); 
% 
%         subplot('position',[0.07,0.09,0.25,0.33])
%             histogram( log10(Halpha_int15(lt15_matres_b15)),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
%             hold on 
%             histogram( log10(Halpha_int15(gt15_matres_b15)),'binwidth',0.2,'Normalization','probability') 
%             hold off
%             %xlim([0 5])
%             xlabel('H-\alpha Intensity','FontSize', 15)
%             ylabel('Count','FontSize', 15)   
%             legend('0<|b|<15 deg','|b|>15 deg')
%             set(gca,'FontSize',15,'LineWidth',2); 
% 
%         subplot('position',[0.39,0.09,0.25,0.33])
%             histogram( log10(Halpha_int24(lt15_matres_b24)),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
%             hold on 
%             histogram( log10(Halpha_int24(gt15_matres_b24)),'binwidth',0.2,'Normalization','probability') 
%             hold off
%             %xlim([0 5])
%             xlabel('H-\alpha Intensity','FontSize', 15)
%             ylabel('Count','FontSize', 15)   
%             legend('0<|b|<15 deg','|b|>15 deg')
%             set(gca,'FontSize',15,'LineWidth',2); 
% 
%         subplot('position',[0.71,0.09,0.25,0.33])
%             histogram( log10(Halpha_int43(lt15_matres_b43)),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
%             hold on 
%             histogram( log10(Halpha_int43(gt15_matres_b43)),'binwidth',0.2,'Normalization','probability') 
%             hold off
%             %xlim([0 5])
%             xlabel('H-\alpha Intensity','FontSize', 15)
%             ylabel('Count','FontSize', 15)   
%             legend('0<|b|<15 deg','|b|>15 deg')
%             set(gca,'FontSize',15,'LineWidth',2); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2022/11/4 new version Set up parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size2 = size2_median;
size5 = size5_median;
size8 = size8_median;
size15 = size15_median;
size24 = size24_median;
size43 = size43_median;  

matres_l = OVRO_l;
matres_b = OVRO_b;

b_lt15 = find(abs(matres_b) < 15);
b_gt15 = find(abs(matres_b) > 15);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2022/11/4 plot core sizes against galactic latitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(4);
    set(gcf,'pos',[100,100,1200,800]);
    
        subplot('position',[0.07,0.55,0.25,0.33])
            plot(size2(b_gt15), Halpha_int(b_gt15),'bo','MarkerSize',6,'MarkerFaceColor','b')    
            hold on
            plot(size2(b_lt15), Halpha_int(b_lt15),'ro','MarkerSize',6,'MarkerFaceColor','r')    
            hold off
            xlim([0.2 5])   
            ylim([0.1 150])
            xlabel('\theta_{2 GHz} [mas]','FontSize', 15)
            ylabel('H-\alpha intensity','FontSize', 15)   
            legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
            set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2)
            
        notnan_index_size = find(~isnan( size2(b_lt15) ));  % length = 81
        notnan_index_int = find(~isnan( Halpha_int(b_lt15) ));

        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size2(b_lt15(intersect_index))';  % length = 71
        new_int = Halpha_int(b_lt15(intersect_index));

        [low_r2,low_p2] = corr(new_size', new_int,'type','Kendall');

        notnan_index_size = find(~isnan( size2(b_gt15) ));
        notnan_index_int = find(~isnan( Halpha_int(b_gt15) ));

        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size2(b_gt15(intersect_index))';
        new_int = Halpha_int(b_gt15(intersect_index));

        [high_r2,high_p2] = corr(new_size', new_int,'type','Kendall');
            
        subplot('position',[0.39,0.55,0.25,0.33])
            plot(size5(b_gt15), Halpha_int(b_gt15),'bo','MarkerSize',6,'MarkerFaceColor','b')    
            hold on
            plot(size5(b_lt15), Halpha_int(b_lt15),'ro','MarkerSize',6,'MarkerFaceColor','r') 
            hold off
            xlim([0.02 10])   
            ylim([0.1 150])
            xlabel('\theta_{5 GHz} [mas]','FontSize', 15)
            ylabel('H-\alpha intensity','FontSize', 15)   
            legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
            set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 

        notnan_index_size = find(~isnan( size5(b_lt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_lt15) ));
    
        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size5(b_lt15(intersect_index))';
        new_int = Halpha_int(b_lt15(intersect_index));
    
        [low_r5,low_p5] = corr(new_size', new_int,'type','Kendall');
    
        notnan_index_size = find(~isnan( size5(b_gt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_gt15) ));
    
        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size5(b_gt15(intersect_index))';
        new_int = Halpha_int(b_gt15(intersect_index));
    
        [high_r5,high_p5] = corr(new_size', new_int,'type','Kendall');

        subplot('position',[0.71,0.55,0.25,0.33])
            plot(size8(b_gt15), Halpha_int(b_gt15),'bo','MarkerSize',6,'MarkerFaceColor','b')    
            hold on
            plot(size8(b_lt15), Halpha_int(b_lt15),'ro','MarkerSize',6,'MarkerFaceColor','r') 
            hold off
            xlim([0.05 2])   
            ylim([0.1 180])
            xlabel('\theta_{8 GHz} [mas]','FontSize', 15)
            ylabel('H-\alpha intensity','FontSize', 15)   
            legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
            set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 

        notnan_index_size = find(~isnan( size8(b_lt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_lt15) ));
    
        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size8(b_lt15(intersect_index))';
        new_int = Halpha_int(b_lt15(intersect_index));
    
        [low_r8,low_p8] = corr(new_size', new_int,'type','Kendall');
    
        notnan_index_size = find(~isnan( size8(b_gt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_gt15) ));
    
        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size8(b_gt15(intersect_index))';
        new_int = Halpha_int(b_gt15(intersect_index));
    
        [high_r8,high_p8] = corr(new_size', new_int,'type','Kendall');

        subplot('position',[0.07,0.09,0.25,0.33])
            plot(size15(b_gt15), Halpha_int(b_gt15),'bo','MarkerSize',6,'MarkerFaceColor','b')    
            hold on
            plot(size15(b_lt15), Halpha_int(b_lt15),'ro','MarkerSize',6,'MarkerFaceColor','r')  
            hold off
            xlim([0.02 0.9])   
            ylim([0.1 100])
            xlabel('\theta_{15 GHz} [mas]','FontSize', 15)
            ylabel('H-\alpha intensity','FontSize', 15)   
            legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
            set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 

        notnan_index_size = find(~isnan( size15(b_lt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_lt15) ));
    
        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size15(b_lt15(intersect_index))';
        new_int = Halpha_int(b_lt15(intersect_index));
    
        [low_r15,low_p15] = corr(new_size', new_int,'type','Kendall');
    
        notnan_index_size = find(~isnan( size15(b_gt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_gt15) ));
    
        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size15(b_gt15(intersect_index))';
        new_int = Halpha_int(b_gt15(intersect_index));
    
        [high_r15,high_p15] = corr(new_size', new_int,'type','Kendall');

        subplot('position',[0.39,0.09,0.25,0.33])
            plot(size24(b_gt15), Halpha_int(b_gt15),'bo','MarkerSize',6,'MarkerFaceColor','b')    
            hold on
            plot(size24(b_lt15), Halpha_int(b_lt15),'ro','MarkerSize',6,'MarkerFaceColor','r') 
            hold off
            xlim([0.02 0.5])   
            ylim([0.1 90])
            xlabel('\theta_{24 GHz} [mas]','FontSize', 15)
            ylabel('H-\alpha intensity','FontSize', 15)   
            legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
            set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 

        notnan_index_size = find(~isnan( size24(b_lt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_lt15) ));

        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size24(b_lt15(intersect_index))';
        new_int = Halpha_int(b_lt15(intersect_index));

        [low_r24,low_p24] = corr(new_size', new_int,'type','Kendall');

        notnan_index_size = find(~isnan( size24(b_gt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_gt15) ));

        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size24(b_gt15(intersect_index))';
        new_int = Halpha_int(b_gt15(intersect_index));

        [high_r24,high_p24] = corr(new_size', new_int,'type','Kendall');

        subplot('position',[0.71,0.09,0.25,0.33])
            plot(size43(b_gt15), Halpha_int(b_gt15),'bo','MarkerSize',6,'MarkerFaceColor','b')    
            hold on
            plot(size43(b_lt15), Halpha_int(b_lt15),'ro','MarkerSize',6,'MarkerFaceColor','r') 
            hold off
            xlim([0.01 0.3])   
            ylim([0.1 70])
            xlabel('\theta_{43 GHz} [mas]','FontSize', 15)
            ylabel('H-\alpha intensity','FontSize', 15)   
            legend('|b| > 15', '|b| <= 15','location','northeast','FontSize', 15)
            set(gca,'XScale','log','YScale','log','FontSize', 15,'LineWidth',2); 

        notnan_index_size = find(~isnan( size43(b_lt15') ));
        notnan_index_int = find(~isnan( Halpha_int(b_lt15) ));

        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size43(b_lt15(intersect_index))';
        new_int = Halpha_int(b_lt15(intersect_index));

        [low_r43,low_p43] = corr(new_size', new_int,'type','Kendall');

        notnan_index_size = find(~isnan( size43(b_gt15)' ));
        notnan_index_int = find(~isnan( Halpha_int(b_gt15) ));

        intersect_index = intersect(notnan_index_size, notnan_index_int);
        new_size = size43(b_gt15(intersect_index))';
        new_int = Halpha_int(b_gt15(intersect_index));

        [high_r43,high_p43] = corr(new_size', new_int,'type','Kendall');

    high_low_b_size_int_corr = [[low_r2,low_p2], [high_r2,high_p2]; [low_r5,low_p5], [high_r5,high_p5]; ...
        [low_r8,low_p8], [high_r8,high_p8]; [low_r15,low_p15], [high_r15,high_p15];... 
        [low_r24,low_p24], [high_r24,high_p24]; [low_r43,low_p43], [high_r43,high_p43]; ];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% compare different frequencies core size in low (<15) and high(>15)
%%% latitudes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5);
    set(gcf,'pos',[100,100,1200,800]);
    
    subplot('position',[0.07,0.55,0.25,0.33])
        histogram(size2(abs(matres_b) < 15),'binwidth',0.2,'Normalization','probability')  % ,'Normalization','probability'
        hold on 
        histogram(size2(abs(matres_b) > 15),'binwidth',0.2,'Normalization','probability') 
        hold off
        xlim([0 3])
        xlabel('\theta_{2 GHz} [mas]','FontSize', 15)
        ylabel('Count','FontSize', 15)   
        legend('0<|b|<15 deg','|b|>15 deg')
        set(gca,'FontSize',15,'LineWidth',2); 

    subplot('position',[0.39,0.55,0.25,0.33])
        histogram(size5(abs(matres_b) < 15),'binwidth',0.2,'Normalization','probability') 
        hold on 
        histogram(size5( abs(matres_b) > 15),'binwidth',0.2,'Normalization','probability') 
        hold off
        xlim([0 2.5])
        xlabel('\theta_{5 GHz} [mas]','FontSize', 15)
        ylabel('Count','FontSize', 15)   
        legend('0<|b|<15 deg','|b|>15 deg')
        set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.55,0.25,0.33])
        histogram(size8(abs(matres_b) < 15),'binwidth',0.1,'Normalization','probability') 
        hold on 
        histogram(size8(abs(matres_b) > 15),'binwidth',0.1,'Normalization','probability') 
        hold off
        xlim([0 1])
        xlabel('\theta_{8 GHz} [mas]','FontSize', 15)
        ylabel('Count','FontSize', 15)   
        legend('0<|b|<15 deg','|b|>15 deg')
        set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.07,0.09,0.25,0.33])
        histogram(size15(abs(matres_b) < 15),'binwidth',0.05,'Normalization','probability') 
        hold on 
        histogram(size15(abs(matres_b) > 15),'binwidth',0.05,'Normalization','probability') 
        hold off
        xlim([0 0.5])
        xlabel('\theta_{15 GHz} [mas]','FontSize', 15)
        ylabel('Count','FontSize', 15)   
        legend('0<|b|<15 deg','|b|>15 deg')
        set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.39,0.09,0.25,0.33])
        histogram(size24(abs(matres_b) < 15),'binwidth',0.02,'Normalization','probability') 
        hold on 
        histogram(size24(abs(matres_b) > 15),'binwidth',0.02,'Normalization','probability') 
        hold off
        %xlim([0 0.3])
        %ylim([0 30])
        xlabel('\theta_{24 GHz} [mas]','FontSize', 15)
        ylabel('Count','FontSize', 15)   
        legend('0<|b|<15 deg','|b|>15 deg')
        set(gca,'FontSize',15,'LineWidth',2); 
    
    subplot('position',[0.71,0.09,0.25,0.33])
        histogram(size43(abs(matres_b) < 15),'binwidth',0.02,'Normalization','probability') 
        hold on 
        histogram(size43(abs(matres_b) > 15),'binwidth',0.02,'Normalization','probability') 
        hold off
        xlim([0 0.3])
        xlabel('\theta_{43 GHz} [mas]','FontSize', 15)
        ylabel('Count','FontSize', 15)   
        legend('0<|b|<15 deg','|b|>15 deg')
        set(gca,'FontSize',15,'LineWidth',2); 

[r2, p2] = kstest2(size2(abs(matres_b) < 15), size2(abs(matres_b) > 15));
[r5, p5] = kstest2(size5(abs(matres_b) < 15), size5(abs(matres_b) > 15));
[r8, p8] = kstest2(size8(abs(matres_b) < 15), size8(abs(matres_b) > 15));
[r15, p15] = kstest2(size15(abs(matres_b) < 15), size15(abs(matres_b) > 15));
[r24, p24] = kstest2(size24(abs(matres_b) < 15), size24(abs(matres_b) > 15));
[r43, p43] = kstest2(size43(abs(matres_b) < 15), size43(abs(matres_b) > 15));

high_low_b_app_coresize_KS = [[r2, p2];[r5, p5];[r8, p8];[r15, p15];[r24, p24];[r43, p43]];









notnan_index_size = find(~isnan( size2 ));  % length = 81
notnan_index_int = find(~isnan( Halpha_int));

intersect_index = intersect(notnan_index_size, notnan_index_int);
new_size = size2(intersect_index)';  % length = 71
new_int = Halpha_int(intersect_index);

[all_r2,all_p2] = corr(new_size', new_int,'type','Kendall');













end

