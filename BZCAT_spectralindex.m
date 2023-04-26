%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to fit OVRO source specral index (VLA & NVSS)
% a code to do correlation test between spectral index and variability
% timescale and SF amplitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;

%%% Read data
Xmatch = strcat('/Users/87steven/Documents/ASIAA/Blazar SED code and data/data/BZCAT_Xmatch_ACC_csv.csv'); 
fid = fopen(Xmatch);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %s %f %f %f %f %f %f %f %f %f %s','delimiter',','); 
fclose(fid); 

Xmatch_name = string( Table{1} );  
Xmatch_z = Table{10}; 
Xmatch_class = Table{12};   %% 74 MHz = 74E6 Hz = 7.4E7 Hz [flux unit: Jy]

unique_name = unique(Xmatch_name);

%%
for i = 1:1 %length(unique_name)
    
    %%% set initial parameters
    Dataname = 'J0603-1716';
    plotfigure = 1;

    %%% get redshift information and class type from Xmatch 
    Dataname = unique_name(i);
    index = find(Xmatch_name == Dataname);
    z = Xmatch_z(index(1));
    cla = Xmatch_class(index(1));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% read in flux data
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Read data
    data = strcat('/Users/87steven/Documents/ASIAA/Blazar SED code and data/source individual flux/' + Dataname + '_flux.csv'); 
    fid = fopen(data);  % openfile

    for i = 1:1
        fgetl(fid);  % skip header of first line
    end

    Table = textscan(fid,'%f %f %f','delimiter',','); 
    fclose(fid); 

    Table_freq = Table{1};  
    Table_flux = Table{2}; 
    Table_flux_err = Table{3};   

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% extract flux density 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% set flux error which is nan to 0.01
    fluxerr_nan = find( isnan(Table_flux_err ));
    Table_flux_err(fluxerr_nan) = 0.01;
    %%% find flux index which is not nan
    flux_NOTnan = find( (~isnan(Table_flux)) & (Table_flux ~= 0));
    %%% save new data into array
    freq = Table_freq(flux_NOTnan);
    Fnu = Table_flux(flux_NOTnan)./freq;
    %flux_err = flux_err[flux_NOTnan]
    
    %%% select radio to sub-mm freq and Fnu
    radio_mm_index = find(freq <= 7.0E11);
    radio_mm_Freq = freq(radio_mm_index);
    radio_mm_Fnu = Fnu(radio_mm_index);

    %%% select radio ONLY freq and Fnu
    radio_index = find( (freq >= 1.0E7) & (freq <= 4.0E9));
    radio_Freq = freq(radio_index);
    radio_Fnu = Fnu(radio_index);
    
    %%% K-correction of radio to sub-mm freq and Fnu
    radio_mm_FreqK = freq(radio_mm_index).*(1+z);
    radio_mm_FnuK = Fnu(radio_mm_index).*(1+z);
    
    %%% K-correction of radio freq and Fnu
    radio_FreqK = freq(radio_index).*(1+z);
    radio_FnuK = Fnu(radio_index).*(1+z);

    %%% define fitting function
    func = fittype('C*nu^(-alp)','coefficients',{'C','alp'},'independent',{'nu'}); 
    
    %%% spectral index fitting
    startPoint = [0, radio_mm_Fnu(1)];
    fit_res = fit(radio_mm_Freq, radio_mm_Fnu, func, 'Start', startPoint)  % , 'Start', startPoint

    %point1 = fit_res.C*x(1)^(-fit_res.alp)
    %point2 = fit_res.C*x(2)^(-fit_res.alp)
    alp_array(i) = fit_res.alp';
    
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Plot figure to check the result
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if plotfigure == 1
        %%% define plotting line and points
        fit_line = fit_res.C*radio_mm_Freq.^(-fit_res.alp); % line from fit
        %fit_line = 1.9E-24*radio_mm_Freq.^(-0.1); % line from fit

        figure(1);
        set(gcf,'pos',[100,100,1200,800]);
    
        plot(log10(radio_mm_Freq), log10(radio_mm_Fnu),'bo','MarkerSize',5,'MarkerFaceColor','b') %% data point
        %plot(radio_mm_Freq, radio_mm_Fnu,'bo','MarkerSize',5,'MarkerFaceColor','b') %% data point
        hold on 
        plot(log10(radio_mm_Freq), log10(fit_line),'r-','LineWidth',2) %% data point
        %plot(fit_res, radio_mm_Freq, radio_mm_Fnu,'r-','LineWidth',2) %% data point        
        hold off

        xlim([6 13])
        ylim([-28 -22])   
        xlabel('log(\nu) [Hz]','FontSize', 15)
        ylabel('log(F(\nu)) [erg/s/cm^{2}/Hz]','FontSize', 15)   
        set(gca,'FontSize',15,'LineWidth',2) 
        grid on
    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spectral index fitting of each source
for i = 1:length(name)
    
    func = fittype('C*nu^(-alp)','coefficients',{'C','alp'},'independent',{'nu'}); 
    
    x = [7.4E7, 1.4E9];
    y = [VLA_flux(i), NVSS_flux(i)];
    
    %%% spectral index fitting
    startPoint = [0, 0];
    fit_res = fit(x', y',func, 'Start', startPoint);  % 

    %point1 = fit_res.C*x(1)^(-fit_res.alp)
    %point2 = fit_res.C*x(2)^(-fit_res.alp)
    alp_array(i) = fit_res.alp';
 end

 alp_array = alp_array';