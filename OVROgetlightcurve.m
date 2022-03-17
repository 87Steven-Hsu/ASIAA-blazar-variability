%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to do structure function analysis for single OVRO source
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sourcename,tau,ipl,Dnoise,foa,fob,fowa,fowb,D100w,D1000w,SFAerru,SFAerrd] = OVROgetlightcurve(sourcename,dtlag,makeplots)
tic
clc;clear;close all;

% sf = sf ampitude
% seesfamp = error of sf ampitude
% Serrmean = error of lightcurve
% dtlag = time lag
dtlag = 4; % set to 0 to automatically determine dtlag from mean diff of succesive timestamps
             % set in days (e.g. 4) to fix value for minimum timescale
makeplots = 1; % set to 1 to make plots, 0 for no plotting
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get lightcurve data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% good test source
%sourcename = 'J0757+0956';
%sourcename = 'J0739+0137';
%sourcename = 'J0502+1338';
%sourcename = 'J0929+5013';
%sourcename = 'J0559-1817';
%sourcename = 'J1135-0428';
%---------------------------------
% test cource
%sourcename = 'J006-0623';
%sourcename = 'J001+1914';
%%% paper sources
%sourcename = 'J0001+1914';
%sourcename = 'J0502+1338';
%sourcename = 'J0721+7120';
sourcename = 'J1135-0428';
%% 
    name = char(sourcename);
    filename = strcat('lightcurvesflagged/',name,'.csv'); 
    fid = fopen(filename);  

    for i=1:1
        fgetl(fid);  % skip header of first line
    end

    Source = textscan(fid,'%f %f %f','delimiter',','); 
    fclose(fid);    
 
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
  
    nlag = round((max(mjd) - min(mjd))./dtlag); % number of timelag bins
          
 %% find/selecting the low and high states
    % calculate mean flux
    threshhilo =  mean(S); % S = flux
    
    [sf,stdsf,~,tau,nsf] = strfnerrOVRO(days,S,Serr,dtlag,nlag);  % get SF for full lightcurve   % nlag = number of timelag bins % ~ = errwalt

    nprth = 30; % ####(ADJUSTABLE PARAMETER)#### 
    
    % only select bins in which the number of pairs are above a certain threshold
    % threshold as a percentage of total number of points in lightcurve
    ipl = find(nsf > nprth & tau ~= 0);  
    
    % calculate SF error bars and errors of bin size
    SFerrorbar = 3;
    if (SFerrorbar == 1)   % Option 1 (std((Sj - Sk)^2)/sqrt(N-1)
        errsf = stdsf./(sqrt(nsf-1)); 
    elseif (SFerrorbar == 2)    % Option 2 (You et al., 2007)
        errsf = mean(sf(ipl))*(sqrt(tau/max(days)));
    elseif (SFerrorbar == 3)    % Option 3 (combination of option 1 an option 2)
        errsf = stdsf./(sqrt(nsf-1)).*sqrt(tau/max(days)); 
    end
    
    errsfbin = ones(numel(sf))*(dtlag./2);  % numel = returns the number of elements

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % return variables
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %errsfamp = errsf(ipl);  % SF amplitude error
    %sftau = tau(ipl);   % SF tau
    %dtlagused = dtlag;  % time lag 
    Serrmean = median(Serr)./mean(S);   % using this for paper version 1 and 2 % ??

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot preliminaries
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    horline = 1:1:5000;
    
    Dnoise = 2*Serrmean^2; 
    g = fittype('a*x/(x+b) + Dnoise','coefficients',{'a','b'},'independent',{'x'},'problem',{'Dnoise'});    % a = 2m^2 b = tau_char x = tau
    %g1000 = fittype('a*(1+b/1000)/(1+b/x) + Dnoise','coefficients',{'a','b'},'independent',{'x'},'problem',{'Dnoise'}); 
        
    errsfuse = errsf(ipl); 
    meansf = mean(sf(ipl));
    weight = (meansf./errsfuse); 
    
    x = tau(ipl);
    y = sf(ipl);
    
    % fitting
    fo = fit(x',y',g,'problem',Dnoise); % fitting without weight
    foa = fo.a; fob = fo.b;
    fow = fit(x',y',g,'weight',weight,'problem',Dnoise);% fitting with weight
    fowa = fow.a; fowb = fow.b;

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
            errorbar(days,S,Serr,Serr,'ko','MarkerSize',3,'MarkerFaceColor','k') 
            plot(horline,ones(size(horline))*threshhilo,'r--','LineWidth',1.5)
            hold off
            xlim([0 max(days)]) 
            ylim([0.5*min(S) 1.2*max(S)])  
            fulllabelx = strcat('Sidereal Days since MJD ',int2str(mjd(1))); 
            xlabel(fulllabelx,'FontSize', 15)   
            ylabel('S (Jy)','FontSize', 15) 
            title(sourcename) 
            set(gca,'FontSize',15,'LineWidth',2); 
   
        subplot1b = subplot(2,2,3);  
        p1b = [0.10,0.11,0.38,0.36];
        set(subplot1b,'pos',p1b);
        
            loglog(tau(ipl),sf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k') 
            hold on
            errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k')  
            errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k')
            hold off 
            xlim([0 max(tau(ipl))])
            ylim([0 1.2*max(sf(ipl))])
            xlabel('\tau (Sidereal Days)','FontSize', 15)
            ylabel('D(\tau)','FontSize', 15)
            set(gca,'FontSize',15,'LineWidth',2);
        
        subplot1c = subplot(2,2,4);  
        p1c = [0.58,0.11,0.38,0.36];
        set(subplot1c,'pos',p1c);
        
            plot(tau(ipl),sf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k')  
            hold on
            errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k') 
            errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k')
            hold off
            xlim([0 max(tau(ipl))])
            ylim([0 1.2*max(sf(ipl))])
            xlabel('\tau (Sidereal Days)','FontSize', 15)
            ylabel('D(\tau)','FontSize', 15)
            set(gca,'FontSize',15,'LineWidth',2);
    
    % save file 
    %[~,~,~] = mkdir(string(name));
    %saveas(gcf,['D:\³\\ASIAA\Code\',name,'\',name,'.png']);
    
    % plot SF fitting  
    figure(2)
        set(gcf,'pos',[100, 100, 1200, 800])
        
        plot(x,y,'o','MarkerSize',3,'MarkerFaceColor','k'); 
        hold on
        %plot(x,SFAerru,'m--');
        %plot(x,SFAerrd,'m--');
        array(1:max(x)) = Dnoise; 
        xx = 1:max(x);
        plot(xx,array,'b--','LineWidth',2);    % Dnoise
        e1 = errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k');  
        e1.Annotation.LegendInformation.IconDisplayStyle = 'off'; 
        e2 = errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k'); 
        e2.Annotation.LegendInformation.IconDisplayStyle = 'off';
        fity = fow.a*xx./(xx+fow.b) + Dnoise;
        plot(xx,fity,'r','LineWidth',2); 
        hold off        
        leg = legend('D(\tau)','Dnoise','D(\tau) fitting with weight','location','best');
        set(leg,'visible','off')
        xlim([0 max(tau(ipl))])
        ylim([-0.005 1.2*max(sf(ipl))])
        xlabel('\tau (Sidereal Days)','FontSize',15)
        ylabel('D(\tau)','FontSize',15)
        title(sourcename) 
        set(gca,'FontSize',15,'LineWidth',2);
   
        % show parameters of fitting with weight
        xc1 = min(ipl)+200; yc1 = 1.15*max(y); yc2 = 1.1*max(y); yc3 = 1.05*max(y); yc4 = 1.*max(y);
        txt1 = 'fitting with weight'; txt2 = ['2m^{2} = ',num2str(fowa)]; txt4 = ['D_{noise} = ',num2str(Dnoise)]; 
        
        % when we compare tau_char with the source size, we can have the upper limit of the tau_char
        if fowb > max(tau(ipl)) 
            txt3 = ['\tau_{char} = ',num2str(max(tau(ipl)))];
            text([xc1 xc1 xc1 xc1],[yc1 yc2 yc3 yc4],{txt1 txt2 txt3 txt4})
            
            D100w = fowa*100/(100+max(tau(ipl))) + Dnoise;
            D1000w = fowa*1000/(1000+max(tau(ipl))) + Dnoise;
        else  
            txt3 = ['\tau_{char} = ',num2str(fowb)];
            text([xc1 xc1 xc1 xc1],[yc1 yc2 yc3 yc4],{txt1 txt2 txt3 txt4})
            
            D100w = fowa*100/(100+fowb) + Dnoise;
            D1000w = fowa*1000/(1000+fowb) + Dnoise;
        end
        
    %saveas(gcf,['D:\³\\ASIAA\Code\',name,'\','Fitting curve.png']);
    
    figure(3)
    set(gcf,'pos',[100, 100, 1200, 800])
        
        subplot1a = subplot(2,2,1:2); 
        set(subplot1a,'pos',[0.10,0.60,0.86,0.35]);
        
            plot(days,S,'ko','MarkerSize',3,'MarkerFaceColor','k') 
            hold on
            errorbar(days,S,Serr,Serr,'ko','MarkerSize',3,'MarkerFaceColor','k') 
            plot(horline,ones(size(horline))*threshhilo,'r--','LineWidth',1.5)
            hold off
            xlim([0 max(days)]) 
            ylim([0.5*min(S) 1.2*max(S)])  
            fulllabelx = strcat('Sidereal Days since MJD ',int2str(mjd(1))); 
            xlabel(fulllabelx,'FontSize', 15)   
            ylabel('S (Jy)','FontSize', 15) 
            title(sourcename) 
            set(gca,'FontSize',15,'LineWidth',2); 
            
        subplot1b = subplot(2,2,3:4); 
        set(subplot1b,'pos',[0.10,0.11,0.86,0.35]);
            
            plot(x,y,'o','MarkerSize',3,'MarkerFaceColor','k'); 
            hold on
            %plot(x,SFAerru,'m--');
            %plot(x,SFAerrd,'m--');
            array(1:max(x)) = Dnoise; 
            xx = 1:max(x);
            plot(xx,array,'b--','LineWidth',1.5);    
            e1 = errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k'); 
            e1.Annotation.LegendInformation.IconDisplayStyle = 'off'; 
            e2 = errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k'); 
            e2.Annotation.LegendInformation.IconDisplayStyle = 'off';
            %plot(fo,'g');
            plot(fow,'r'); 
            hold off        
            leg = legend('D(\tau)','Dnoise','D(\tau) fitting with weight','location','best');
            set(leg,'visible','off')
            xlim([0 max(tau(ipl))])
            ylim([-0.005 1.2*max(sf(ipl))])
            xlabel('\tau (Sidereal Days)','FontSize',15)
            ylabel('D(\tau)','FontSize',15)
            set(gca,'FontSize',15,'LineWidth',2);
        
    end
    toc

end

    