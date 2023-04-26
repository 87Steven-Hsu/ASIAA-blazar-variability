%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to do structure function analysis for single OVRO source
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sourcename,tau,ipl,foa,fob,fowa,fowb,p22,tauchar_error_up,tauchar_error_down] = OVROgetlightcurve_1000(sourcename,dtlag,makeplots)
clc; clear; close all;

% sf = sf ampitude
% seesfamp = error of sf ampitude
% Serrmean = error of lightcurve
% dtlag = time lag
dtlag = 4;      % set to 0 to automatically determine dtlag from mean diff of succesive timestamps
                % set in days (e.g. 4) to fix value for minimum timescale
makeplots = 1;  % set to 1 to make plots, 0 for no plotting
save_figure = 0;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get lightcurve data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% good test source
%sourcename = 'J0757+0956';
%sourcename = 'J0739+0137';
%sourcename = 'J0502+1338';
%sourcename = 'J0929+5013';
%sourcename = 'J1135-0428';
%---------------------------------
%%% test cource
%sourcename = 'J0006-0623';
%sourcename = 'J0010+1058';
%%% paper sources
%sourcename = 'J0001+1914';
%sourcename = 'J0502+1338';
%sourcename = 'J0721+7120';   % thesis source 
%sourcename = 'J1135-0428';
sourcename = 'J0502+1338';   % thesis source 
%%% ALMACalibrator Catalog
%sourcename = 'J2148+0657_ALMA';

%% 
    name = char(sourcename)
    filename = strcat('lightcurvesflagged/',name,'.csv'); 
    fid = fopen(filename);  % openfile

    for i=1:1
        fgetl(fid);  % skip header of first line
    end

    Source = textscan(fid,'%f %f %f','delimiter',','); 
    fclose(fid);    % close file
    size(Source);    % check the size of the array
    
    mjd = Source{1}';    % mjd = modified Julian date   % F{1} = first row of F
    S = Source{2}';      % S = flux
    Serr = Source{3}';   % Serr = flux error
    
    soldays = mjd - mjd(1); 
    days = soldays.*0.99726957;   % convert to units of sidereal day 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % extract SF
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if dtlag == 0  % if dtlag (timelag) set to 0, will calculate dtlag automatically
        diffday = diff(days);   
        intshrt = diffday < 7;
        dtlag = round(mean(diffday(intshrt))); 
        %rmsdiff = std(diffday(intshrt));    
    end
  
    nlag = round( (max(mjd) - min(mjd))./dtlag ); % number of timelag bins
    %maxlag = nlag.*dtlag;
    
    %%% find/selecting the low and high states
    % calculate mean flux
    threshhilo =  mean(S); % S = flux
    
    [sf, stdsf, ~, tau, nsf] = strfnerrOVRO(days, S, Serr, dtlag, nlag);  % get SF for full lightcurve   % nlag = number of timelag bins % ~ = errwalt
    
    nprth = 30; % ####(ADJUSTABLE PARAMETER)#### 
    
    % only select bins in which the number of pairs are above a certain threshold
    % threshold as a percentage of total number of points in lightcurve
    ipl = find(nsf > nprth & tau ~= 0);  % nsf & tau size = 926
    
    % calculate SF error bars and errors of bin size
    SFerrorbar = 3;
    if (SFerrorbar == 1)   % Option 1 (std((Sj - Sk)^2)/sqrt(N-1)
        errsf = stdsf./(sqrt(nsf-1)); 
    elseif (SFerrorbar == 2)    % Option 2 (You et al., 2007)
        errsf = mean(sf(ipl))*(sqrt(tau/max(days)));
    elseif (SFerrorbar == 3)    % Option 3 (combination of option 1 an option 2!
        errsf = stdsf./(sqrt(nsf-1)).*sqrt(tau/max(days)); 
    end
    
    errsfbin = ones(numel(sf))*(dtlag./2);  % numel = returns the number of elements

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % return variables
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %errsfamp = errsf(ipl);  % SF amplitude error
    %sftau = tau(ipl);   % SF tau
    %dtlagused = dtlag;  % time lag 
    Serrmean = median(Serr)./mean(S);  

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SF fitting
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    horline = 1:1:5000;
    
    Dnoise = 2*Serrmean^2; % line 104
    g1000 = fittype('a*(1+b/1000)/(1+b/x) + Dnoise','coefficients',{'a','b'},'independent',{'x'},'problem',{'Dnoise'}); 
    % a = D(1000d) b = tau_char x = tau
        
    errsfuse = errsf(ipl);  
    meansf = mean(sf(ipl)); 
    weight = (meansf./errsfuse);
    
    x = tau(ipl);
    y = sf(ipl);
    
    %%% SF fitting
    startPoints = [min(x), min(y)];
    %fo1000 = fit(x',aa',g1000,'problem',Dnoise, 'Start', startPoints); % fitting without weight
    fo1000 = fit(x', y',g1000,'problem',Dnoise, 'Start', startPoints); % fitting without weight
    foa = fo1000.a; fob = fo1000.b;
    fow1000 = fit(x',y',g1000, 'weight', weight, 'problem', Dnoise, 'Start', startPoints); % fitting with weight
    fowa = fow1000.a; fowb = fow1000.b; %fowa = SF amplitude (D(1000d)) %fowb = characteristic timescale

    %%% SF fitting with weight program by myself
    sum_weight = sum(sqrt(weight));
    wet_y = y.*sqrt(weight);
    startPoints = [min(x), min(wet_y)];
    fo1000w = fit(x', wet_y', g1000, 'problem', Dnoise, 'Start', startPoints); % fitting without weight

%     p11 = predint(fow1000,x,0.95,'observation','off');
%     p12 = predint(fow1000,x,0.95,'observation','on');
%     p21 = predint(fow1000,x,0.95,'functional','off');
    p22 = predint(fow1000,x,0.95,'functional','on');
    
    ci = confint(fow1000,0.95);
    %SFAerru = ci(2).*(1+ci(3)./1000)./(1+ci(3)./x) + Dnoise;
    %SFAerrd = ci(1).*(1+ci(4)./1000)./(1+ci(4)./x) + Dnoise;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot lightcurves and SF
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if makeplots == 1

        figure(1);
            set(gcf,'pos',[100,100,1200,800]);
    
            subplot1a = subplot(2,2,1:2); 
            set(subplot1a,'pos',[0.10,0.60,0.86,0.35]);
            
                plot(days,S,'ko','MarkerSize',3,'MarkerFaceColor','k') 
                hold on
                errorbar(days,S,Serr,Serr,'k','MarkerSize',3,'MarkerFaceColor','k')
                plot(horline,ones(size(horline))*threshhilo,'r--','LineWidth',1.5)
                hold off
                xlim([0 max(days)]) 
                ylim([0.5*min(S) 1.2*max(S)])   
                xlabel(strcat('Sidereal Days since MJD ',int2str(mjd(1))),'FontSize', 15)
                ylabel('S (Jy)','FontSize', 15) 
                title(sourcename) 
                set(gca,'FontSize',20,'LineWidth',2); 
       
            subplot1b = subplot(2,2,3);  
            set(subplot1b,'pos',[0.10,0.11,0.38,0.36]);
            
                loglog(tau(ipl),sf(ipl),'k.','MarkerSize',3,'MarkerFaceColor','k')  
                hold on
                errorbar(tau(ipl),sf(ipl),errsf(ipl),'k','MarkerSize',3,'MarkerFaceColor','k')  
                errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','k','MarkerSize',3,'MarkerFaceColor','k') 
                hold off
                xlim([0 max(tau(ipl))])
                ylim([0 1.2*max(sf(ipl))])
                xlabel('\tau (Sidereal Days)','FontSize', 15)
                ylabel('D(\tau)','FontSize', 15)
                set(gca,'FontSize',20,'LineWidth',2);
            
            subplot1c = subplot(2,2,4);  
            set(subplot1c,'pos',[0.58,0.11,0.38,0.36]);
            
                plot(tau(ipl),sf(ipl),'k.','MarkerSize',3,'MarkerFaceColor','k')  
                hold on
                errorbar(tau(ipl),sf(ipl),errsf(ipl),'k','MarkerSize',3,'MarkerFaceColor','k')  
                errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','k','MarkerSize',3,'MarkerFaceColor','k') 
                hold off
                xlim([0 max(tau(ipl))])
                ylim([0 1.2*max(sf(ipl))])
                xlabel('\tau (Sidereal Days)','FontSize', 15)
                ylabel('D(\tau)','FontSize', 15)
                set(gca,'FontSize',20,'LineWidth',2);
    
        %%% save file 
        %[~,~,~] = mkdir('/Users/87steven/Documents/ASIAA/OVROname_fitting/', string(name));
        %saveas(gcf,['/Users/87steven/Documents/ASIAA/OVROname_fitting/',name,'/lightcurve.png']);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % SF fitting  
        figure(2)
            set(gcf,'pos',[100, 100, 1200, 400])
        
            plot(x,y,'k.'); % origin data
            hold on
            %%% SF fitting line
            xx = 1:max(x);
     
            %%% plot fitting line with weight
            fityw = fow1000.a*(1+fow1000.b./1000)./(1+fow1000.b./xx) + Dnoise;
            plot(xx,fityw,'r','LineWidth',2, 'color', 'blue'); 
    
    
            %%% "confint" method uncertainty
            %plot(x,SFAerru,'m--','Color','green','LineWidth',2);
            %plot(x,SFAerrd,'m--','Color','green','LineWidth',2);
            %%% "predint" method uncertainty
            plot(x,p22(:,2),'m--','LineWidth',2); % upper limit
            plot(x,p22(:,1),'m--','LineWidth',2); % lower limit
            array(1:max(x)) = Dnoise; 
            plot(xx,array,'b--','LineWidth',2);    % Dnoise
            e1 = errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k');  
            e1.Annotation.LegendInformation.IconDisplayStyle = 'off'; 
            e2 = errorbar(tau(ipl),sf(ipl), errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k'); 
            e2.Annotation.LegendInformation.IconDisplayStyle = 'off';
            hold off
            %legend('D(\tau)','Dnoise','D(\tau) fitting','D(\tau) fitting with weight') 
            title(sourcename) 
            xlim([0 max(tau(ipl))])
            ylim([-0.5*Dnoise 1.2*max(sf(ipl))])
            %xlim([0 1000])
            %ylim([-0.5*Dnoise 1])
            xlabel('\tau (Sidereal Days)','FontSize',15)
            ylabel('D(\tau)','FontSize',15)
            set(gca,'FontSize',20,'LineWidth',2);
        
            % show parameters of fitting with weight
    %         xc1 = min(ipl)+700; yc1 = 1.15*max(y); yc2 = 1.1*max(y); yc3 = 1.05*max(y); yc4 = 1.*max(y);
    %         txt1 = 'fitting with weight'; txt2 = ['2m^{2} = ',num2str(fowa)]; txt4 = ['D_{noise} = ',num2str(Dnoise)]; %txt3 = ['\tau_{char} = ',num2str(fowb)];
    %         
    %         % when we compare tau_char with the source size, we can have the upper limit of the tau_char
    %         if fowb > max(tau(ipl)) 
    %             txt3 = ['\tau_{char} = ',num2str(max(tau(ipl)))];
    %             text([xc1 xc1 xc1 xc1],[yc1 yc2 yc3 yc4],{txt1 txt2 txt3 txt4})
    %         else 
    %             txt3 = ['\tau_{char} = ',num2str(fowb)];
    %             text([xc1 xc1 xc1 xc1],[yc1 yc2 yc3 yc4],{txt1 txt2 txt3 txt4})
    %         end
    
            %saveas(gcf,['/Users/87steven/Documents/ASIAA/OVROname_fitting/',name,'/SF + SF Fitting.png']);
    
       figure(3);
            set(gcf,'pos',[100,100,1200,400]);  % [100,100,1200,400]
            
                plot(days,S,'ko','MarkerSize',3,'MarkerFaceColor','k') 
                hold on
                errorbar(days,S,Serr,Serr,'k.','MarkerSize',10,'MarkerFaceColor','k')
                plot(horline,ones(size(horline))*threshhilo,'r--','LineWidth',3)
                hold off
                xlim([0 max(days)]) 
                ylim([0.5*min(S) 1.2*max(S)])   
                xlabel(strcat('Sidereal Days since MJD ',int2str(mjd(1))),'FontSize', 15)
                ylabel('S (Jy)','FontSize', 15) 
                title(sourcename) 
                set(gca,'FontSize',20,'LineWidth',2); 
    
        figure(4);
            set(gcf,'pos',[100,100,1200,800]);
            ax = axes('Position',[0.08 0.1 0.90 0.88]);
            ax.PositionConstraint = 'innerposition';
    
            subplot('position',[0.10,0.58,0.86,0.36]);
                plot(days,S,'ko','MarkerSize',5,'MarkerFaceColor','k') 
                hold on
                errorbar(days,S,Serr,Serr,'ko','MarkerSize',5,'MarkerFaceColor','k','LineWidth',2)
                plot(horline,ones(size(horline))*threshhilo,'r--','LineWidth',3)
                hold off
                xlim([0 max(days)]) 
                ylim([0.5*min(S) 1.2*max(S)])   
                xlabel(strcat('Sidereal Days since MJD ',int2str(mjd(1))),'FontSize', 25)
                ylabel('Flux density [Jy]','FontSize', 25) 
                %title(sourcename) 
                set(gca,'FontSize',25,'LineWidth',3); 
            
            subplot('position',[0.10,0.1,0.86,0.36]);
                plot(tau(ipl),sf(ipl),'ko','MarkerSize',5,'MarkerFaceColor','k')  
                hold on
                errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',5,'MarkerFaceColor','k')  
                errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',5,'MarkerFaceColor','k') 
                e1 = errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k','LineWidth',2);  
                e1.Annotation.LegendInformation.IconDisplayStyle = 'off'; 
                e2 = errorbar(tau(ipl),sf(ipl), errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k','LineWidth',2); 
                e2.Annotation.LegendInformation.IconDisplayStyle = 'off';
                %%% SF fitting line
                xx = 1:max(x);
         
                %%% plot fitting line with weight
                fityw = fow1000.a*(1+fow1000.b./1000)./(1+fow1000.b./xx) + Dnoise;
                plot(xx,fityw,'r-','LineWidth',2, 'color', 'red'); 
        
        
                %%% "confint" method uncertainty
                %plot(x,SFAerru,'m--','Color','green','LineWidth',2);
                %plot(x,SFAerrd,'m--','Color','green','LineWidth',2);
                %%% "predint" method uncertainty
                plot(x,p22(:,2),'g--','LineWidth',2); % upper limit
                plot(x,p22(:,1),'g--','LineWidth',2); % lower limit
                array(1:max(x)) = Dnoise; 
                plot(xx,array,'b--','LineWidth',3);    % Dnoise
                

                
                hold off
                xlim([0 max(tau(ipl))])
                ylim([-0.009 1.2*max(sf(ipl))])
                xlabel('Timelag \tau [Sidereal Days]','FontSize', 25)
                ylabel('D(\tau)','FontSize', 25)
                set(gca,'FontSize',25,'LineWidth',3);

        if save_figure == 1   
            %save_path = sprintf('/Users/87steven/Documents/天文所/碩二上/TPS/%s.png',fig_name);

            save_path = sprintf('/Users/87steven/Documents/天文所/Master Thesis/figures/chapter 3/%s.png', sourcename);
            
            print(gcf,save_path,'-dpng', '-r600')
        end

    end

    %%% charactristic timescale uncertainty calculattion
    tauchar_error = predint(fow1000,fowb,0.95,'functional','on');
    tauchar_error_up = tauchar_error(2);
    tauchar_error_down = tauchar_error(1); 
end

    