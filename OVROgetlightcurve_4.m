%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to do structure function analysis for single OVRO source
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sourcename,tau,ipl,foa,fob,fowa,fowb,p22,D_4d_uperr, D_4d, D_4d_lowerr] = OVROgetlightcurve_1000(sourcename,dtlag,makeplots)
%clc;clear;close all;

% sf = sf ampitude
% seesfamp = error of sf ampitude
% Serrmean = error of lightcurve
% dtlag = time lag
%dtlag = 4;      % set to 0 to automatically determine dtlag from mean diff of succesive timestamps
                % set in days (e.g. 4) to fix value for minimum timescale
%makeplots = 1;  % set to 1 to make plots, 0 for no plotting

%set(0, 'DefaultFigureVisible', 'off')
 
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
%sourcename = 'J0721+7120';
%sourcename = 'J1135-0428';
%% 
    %%% read light curve file
    name = char(sourcename);
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
    g4 = fittype('a*(1+b/1000)/(1+b/x) + Dnoise','coefficients',{'a','b'},'independent',{'x'},'problem',{'Dnoise'}); 
    % a = D(4 d); b = tau_char; x = tau
        
    errsfuse = errsf(ipl);  
    meansf = mean(sf(ipl)); 
    weight = (meansf./errsfuse);
    
    %%%% SF calculation result
    x = tau(ipl);
    y = sf(ipl);
    
    %%% SF fitting
    startPoints = [min(x), min(y)];
    %fo1000 = fit(x',aa',g1000,'problem',Dnoise, 'Start', startPoints); % fitting without weight
    fo4 = fit(x', y',g4,'problem',Dnoise, 'Start', startPoints); % fitting without weight
    foa = fo4.a; fob = fo4.b;
    fow4 = fit(x',y',g4, 'weight', weight, 'problem', Dnoise, 'Start', startPoints); % fitting with weight  %%% , 'Start', startPoints
    fowa = fow4.a; fowb = fow4.b; %fowa = SF amplitude (D(4 d)) %fowb = characteristic timescale

    %%% SF fitting line
    xx = 1:max(x);
    fityw = fow4.a*(1+fow4.b./1000)./(1+fow4.b./xx) + Dnoise;

%     p11 = predint(fow1000,x,0.95,'observation','off');
%     p12 = predint(fow1000,x,0.95,'observation','on');
%     p21 = predint(fow1000,x,0.95,'functional','off');
    p22 = predint(fow4,x,0.95,'functional','on');
    
    %%%%%%%%%%%%%%
    %%% "confint" method uncertainty """DONT USE THIS ONE""""
    %%%%%% ci = confint(fow4,0.95);
    %%%%%% SFAerru = ci(2).*(1+ci(3)./4)./(1+ci(3)./x) + Dnoise;
    %%%%%% SFAerrd = ci(1).*(1+ci(4)./4)./(1+ci(4)./x) + Dnoise;
    %%%%%%%%%%%%%%
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot lightcurves and SF
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if makeplots == 1

    figure(1);
        set(gcf,'pos',[100,100,1200,800],'visible','off');

        subplot1a = subplot(2,2,1:2); 
        set(subplot1a,'pos',[0.10,0.60,0.86,0.35]);
        
            plot(days,S,'ko','MarkerSize',5,'MarkerFaceColor','k') 
            hold on
            errorbar(days,S,Serr,Serr,'ko','MarkerSize',3,'MarkerFaceColor','k')
            plot(horline,ones(size(horline))*threshhilo,'r--','LineWidth',1.5)
            hold off
            xlim([0 max(days)]) 
            ylim([0.5*min(S) 1.2*max(S)])   
            xlabel('Sidereal Days since MJD','FontSize', 15)  
            ylabel('S (Jy)','FontSize', 15) 
            title(sourcename) 
            set(gca,'FontSize',20,'LineWidth',2); 
   
        subplot1b = subplot(2,2,3);  
        set(subplot1b,'pos',[0.10,0.11,0.38,0.36]);
        
            loglog(tau(ipl),sf(ipl),'ko','MarkerSize',5,'MarkerFaceColor','k')  
            hold on
            errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k')  
            errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k') 
            hold off
            xlim([0 max(tau(ipl))])
            ylim([0 1.7*(max(sf(ipl)))])
            xlabel('\tau (Sidereal Days)','FontSize', 15)
            ylabel('D(\tau)','FontSize', 15)
            set(gca,'FontSize',20,'LineWidth',2);
        
        subplot1c = subplot(2,2,4);  
        set(subplot1c,'pos',[0.58,0.11,0.38,0.36]);
        
            plot(tau(ipl),sf(ipl),'ko','MarkerSize',5,'MarkerFaceColor','k')  
            hold on
            errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k')  
            errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k') 
            hold off
            xlim([0 50])
            ylim([0.9*(min(sf(2:13))) 1.1*(max(sf(1:13)))])  %%ylim([0 1.7*(max(sf(1:50)))])
            xlabel('\tau (Sidereal Days)','FontSize', 15)
            ylabel('D(\tau)','FontSize', 15)
            set(gca,'FontSize',20,'LineWidth',2);
    
    %%% save file 
    %[~,~,~] = mkdir('/Users/87steven/Documents/ASIAA/Radio variability Code/result_4/', string(name));
    saveas(gcf,['/Users/87steven/Documents/ASIAA/Radio variability Code/result_4/',name,' lightcurve.png']);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SF fitting  
    figure(2)
        set(gcf,'pos',[100, 100, 1200, 800],'visible','on')
    
        plot(x,y,'ko','MarkerSize',5,'MarkerFaceColor','k'); % origin SF
        hold on
        %%% plot fitting line with weight
        plot(xx,fityw,'r','LineWidth',2, 'color', 'blue'); 
        %%%%%%%
        %%% "confint" method uncertainty """DONT USE THIS ONE""""
        %%%%% plot(x,SFAerru,'m--','Color','green','LineWidth',2);
        %%%%% plot(x,SFAerrd,'m--','Color','green','LineWidth',2);
        %%%%%%%
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
        title(sourcename) 
        xlim([0 50])    %%% xlim([0 max(x)])
        ylim([0 1.2*(max(y(1:13)))])   %%% ylim([-0.5*Dnoise 1.2*(max(sf))])
        xlabel('\tau (Sidereal Days)','FontSize',15)
        ylabel('D(\tau)','FontSize',15)
        set(gca,'FontSize',20,'LineWidth',2);

        saveas(gcf,['/Users/87steven/Documents/ASIAA/Radio variability Code/result_4/',name,' SF + SF Fitting.png']);
    end

    %%% SF amplitude at 4 days ( D(4 days) )
    D_4d_uperr = y(1)+errsf(ipl(1));
    D_4d = y(1);
    D_4d_lowerr = y(1)-errsf(ipl(1));
end

    