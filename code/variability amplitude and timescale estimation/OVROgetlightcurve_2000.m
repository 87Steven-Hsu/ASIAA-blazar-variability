%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to do structure function analysis for single OVRO source
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sourcename,tau,ipl,Dnoise,foa,fob,fowa,fowb] = OVROgetlightcurve_2000(sourcename,dtlag,makeplots)
tic
%clc;clear;close all;

%�?source??��?��??
% filename = strcat('OVROsourcelistJonly.csv'); % strcat = 水平???��string
% fid = fopen(filename);  % openfile
% 
% F = textscan(fid,'%s %s %s %s','delimiter',','); % 將�??��??��?��?��?�入F?��?��
% 
% fclose(fid);    % close file
%
% SN = F{1}'; % serial number
% sourcename = F{2}'; % sourcename

% sf = sf ampitude
% seesfamp = error of sf ampitude
% Serrmean = error of lightcurve
% dtlag = time lag
%dtlag = 4; % set to 0 to automatically determine dtlag from mean diff of succesive timestamps
             % set in days (e.g. 4) to fix value for minimum timescale
%makeplots = 1; % set to 1 to make plots, 0 for no plotting
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get lightcurve data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% good test source
%sourcename = 'J0757+0956';
%sourcename = 'J0739+0137';
%sourcename = 'J0502+1338';
%sourcename = 'J0929+5013';
%sourcename = 'J1135-0428';
%---------------------------------
% test cource
%sourcename = 'J006-0623';
%sourcename = 'J001+1914';
%% 

%for s = 1:1 % max(size(sourcename))
    name = char(sourcename);
    filename = strcat('lightcurvesflagged/',name,'.csv'); % strcat = 水平???��string
    fid = fopen(filename);  % openfile

    for i=1:1
        fgetl(fid);  % skip header of first line
    end

    Source = textscan(fid,'%f %f %f','delimiter',','); % 將�??��??��?��?��?�入F?��?��
    fclose(fid);    % close file
    
    mjd = Source{1}';    % mjd = modified Julian date   % F{1} = first row of F
    S = Source{2}';      % S = flux
    Serr = Source{3}';   % Serr = flux error
    
    soldays = mjd - mjd(1); % mjd(1)?���?0天�?��?��?��?�數
    days = soldays.*0.99726957;   % convert to units of sidereal day 轉�?�為??��?�日
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % extract SF
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if dtlag == 0  % if dtlag (timelag) set to 0, will calculate dtlag automatically
        diffday = diff(days);   % ??��?��?�日??�差??�函?�� (求�?�該?��??��?��?��?��?�差?��??�其導數)
        intshrt = find(diffday < 7); % ?��??��?��?�差??<7
        dtlag = round(mean(diffday(intshrt))); % ?��diffday中�?��?�為intshrt??�數?��?�平??��?��?�捨誤入?��timelag
        rmsdiff = std(diffday(intshrt));    % ?��diffday中�?��?�為intshrt??�數?��?�STDEV
    end
  
    nlag = round((max(mjd) - min(mjd))./dtlag); % number of timelag bins
    maxlag = nlag.*dtlag;
          
        %% find/selecting the low and high states
    % calculate mean flux
    threshhilo =  mean(S); % S = flux
    
    %??��?�全?��?��?�於平�?��?��?�於平�?��?�lightcurve
    [sf,stdsf, ~,tau,nsf] = strfnerrOVRO(days, S, Serr, dtlag, nlag);  % get SF for full lightcurve   % nlag = number of timelag bins % ~ = errwalt

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
    elseif (SFerrorbar == 3)    % Option 3 (combination of option 1 an option 2!
        errsf = stdsf./(sqrt(nsf-1)).*sqrt(tau/max(days)); 
    end
    
    errsfbin = ones(numel(sf))*(dtlag./2);  % numel = returns the number of elements

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % return variables
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     errsfamp = errsf(ipl);  % SF amplitude error
%     sftau = tau(ipl);   % SF tau
%     dtlagused = dtlag;  % time lag 
    Serrmean = median(Serr)./mean(S);   % using this for paper version 1 and 2 % ??�error??�中位數

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot preliminaries
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    horline = 1:1:5000;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot lightcurves and SF
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if makeplots == 1

    % ??��?
    figure(1);
set(gcf,'pos',[100,100,1200,800]);

        subplot1a = subplot(2,2,1:2); 
        set(subplot1a,'pos',[0.10,0.60,0.86,0.35]);
        
        % 上�?? % Plot lightcurve
            plot(days,S,'ko','MarkerSize',3,'MarkerFaceColor','k') % days = ??��?�日, S =flux
            hold on
            errorbar(days,S,Serr,Serr,'ko','MarkerSize',3,'MarkerFaceColor','k') % ??��?�error bar
            plot(horline,ones(size(horline))*threshhilo,'r--','LineWidth',1.5)
            hold off
            xlim([0 max(days)]) % x軸�??0 ~ ??��?�日??大�??
            ylim([0.5*min(S) 1.2*max(S)])   % y軸�??0.5*S??小�?? ~ 1.2*S??大�?? 
            fulllabelx = strcat('Sidereal Days since MJD ',int2str(mjd(1))); % x軸�?��??
            xlabel(fulllabelx,'FontSize', 15)   % x軸�?��?? & 字�?�大�?
            ylabel('S (Jy)','FontSize', 15) % y軸�?��??
            title(sourcename) % ?��??��?��??
            set(gca,'FontSize',15,'LineWidth',2); % ?��??��?��?? & 字�?�大�?
   
        % 左�?��?? ?��??�tau對�?�SF??��?�數??��?��??  % Plot SF
        subplot1b = subplot(2,2,3);  
        p1b = [0.10,0.11,0.38,0.36];
        set(subplot1b,'pos',p1b);
        
            loglog(tau(ipl),sf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k')  % ??�tau??�SF??��?�數??��?��??
            hold on
            errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k')  % ??��?�SF error bar (??�直?��???)
            errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k') % ??��?�SF bin size error bar (水平?��???)
            hold off 
            xlim([0 max(tau(ipl))])
            ylim([0 1.2*max(sf(ipl))])
            xlabel('\tau (Sidereal Days)','FontSize', 15)
            ylabel('D(\tau)','FontSize', 15)
            set(gca,'FontSize',15,'LineWidth',2);
        
        % ?��下�?? tau對�?�SF??�正常座標�?��?��?? 
        subplot1c = subplot(2,2,4);  
        p1c = [0.58,0.11,0.38,0.36];
        set(subplot1c,'pos',p1c);
        
            plot(tau(ipl),sf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k')  % ??�tau??�SF??��?�數??��?��??
            hold on
            errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k')  % ??��?�SF error bar (??�直?��???)
            errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k') % ??��?�SF bin size error bar (水平?��???)
            hold off
            xlim([0 max(tau(ipl))])
            ylim([0 1.2*max(sf(ipl))])
            xlabel('\tau (Sidereal Days)','FontSize', 15)
            ylabel('D(\tau)','FontSize', 15)
            set(gca,'FontSize',15,'LineWidth',2);
    
    % save file 
    [~,~,~] = mkdir(string(name));
    saveas(gcf,['D:\�\\ASIAA\Code\',name,'\',name,'.png']);
    
   Dnoise = 2*Serrmean^2; % line 104
   g2000 = fittype('a*(1+b/2000)/(1+b/x) + Dnoise','coefficients',{'a','b'},'independent',{'x'},'problem',{'Dnoise'}); 
   %a = D(2000d) b = tau_char x = tau
   
   % ??�入資�?��?��?��?�g
   errsfuse = errsf(ipl);  % 將用得到??�error bar?��?��?�出來�?�另存矩?��
   meansf = mean(sf(ipl)); % 將用得到??�sf?��?��?�出來�?�另存矩?��
   weight = (meansf./errsfuse); % 將error bar?��?��?�SF平�?��?�相?��作為�?
    
   % 將�?��?��?�tau(ipl) & sf(ipl)存入x & y
   x = tau(ipl);
   y = sf(ipl);
       
   % fitting
   fo2000 = fit(x',y',g2000,'problem',Dnoise); % fitting without weight
   foa = fo2000.a; fob = fo2000.b;
   fow2000 = fit(x',y',g2000,'weight',weight,'problem',Dnoise);% fitting with weight
   fowa = fow2000.a; fowb = fow2000.b;

    % SF fitting  
    figure(2)
        set(gcf,'pos',[100, 100, 1200, 800])
    
        plot(x,y,'k.'); % origin data
        %po.Annotation.LegendInformation.IconDisplayStyle = 'off';   % ??��?�po??��?��??
        hold on
        array(1:max(x)) = Dnoise; % ?��建符??�x?��?��size??�Dnoise array
        xx = 1:max(x);
        plot(xx,array,'b--');    % Dnoise
        e1 = errorbar(tau(ipl),sf(ipl),errsf(ipl),'ko','MarkerSize',3,'MarkerFaceColor','k');  % ??��?�SF error bar (??�直?��???)
        e1.Annotation.LegendInformation.IconDisplayStyle = 'off'; % ??��?�error bar??��?��??
        e2 = errorbar(tau(ipl),sf(ipl),errsfbin(ipl),'horiz','ko','MarkerSize',3,'MarkerFaceColor','k'); % ??��?�SF bin size error bar (水平?��???)
        e2.Annotation.LegendInformation.IconDisplayStyle = 'off';
        plot(fow2000,'r');
        hold off
        legend('D(\tau)','Dnoise','D(\tau) fitting','D(\tau) fitting with weight')
        title(sourcename) % ?��??��?��??
        xlim([0 max(tau(ipl))])
        ylim([-0.05 1.2*max(sf(ipl))])
        xlabel('\tau (Sidereal Days)','FontSize',15)
        ylabel('D(\tau)','FontSize',15)
        set(gca,'FontSize',15,'LineWidth',2);

        % show parameters of fitting with weight
        xc1 = min(ipl)+100; yc1 = 1.15*max(y); yc2 = 1.1*max(y); yc3 = 1.05*max(y); 
        txt1 = 'fitting with weight'; txt3 = ['D(\tau = 2000) = ',num2str(fowa)]; 
        
        % when we compare tau_char with the source size, we can have the upper limit of the tau_char
        if fowb > max(tau(ipl)) % tau_char>??��?�尺度�?��?�設定tau_char上�??
            txt2 = ['\tau_{char} = ',num2str(max(tau(ipl)))];
            text([xc1 xc1 xc1],[yc1 yc2 yc3],{txt1 txt2 txt3})
        else  % tau_char<??��?�尺度�?��?�tau_char = fowb
            txt2 = ['\tau_{char} = ',num2str(fowb)];
            text([xc1 xc1 xc1],[yc1 yc2 yc3],{txt1 txt2 txt3})
        end
        
        saveas(gcf,['D:\�\\ASIAA\Code\',name,'\','Fitting curve.png']);
    end
    toc

end

    