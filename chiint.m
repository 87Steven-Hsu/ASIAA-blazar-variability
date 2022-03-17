function CI = chiint(Z,Omega_0,Lambda_0);
%-----------------------------------------------------------------------
% function chiint           chi difference for cosmological distances
% Input  : - redshift.
%          - Omega0.
%          - Lambda0.
% Output : - function definition.
% Tested : Matlab 5.3
%     By : Eran O. Ofek         Febuary 2000
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%-----------------------------------------------------------------------
CI = 1./sqrt(Omega_0.*(1+Z).^3 + (1-Omega_0-Lambda_0).*(1+Z).^2+Lambda_0);