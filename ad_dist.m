function Dist = ad_dist(Z_vecA,nargin)
%-------------------------------------------------------------
% ad_dist function       angular diameter distance
%                      Calculate angular diameter distance
%                      between redshift z_1 and z_2, as
%                      function of the basic cosmological
%                      parameters: H_0, Omega_0, Lambda_0.
%                      in case q_0 is given, use the following
%                      to extract the needed parameters:
%                      [q_0 = \frac{\Omega}{2} - \lambda_0].
% Input  : - vector of redshifts, in case this is
%            one cell vector, z_1 is taken as 0,
%            and the element is taken as z_2.
%            In case this is a two element vector, the first
%            elemnt is taken as z_1 and the second as z_2.
%          - scalar of H_0 in units of km/sec/Mpc.
%            (default is H=68 km/sec/Mpc).
%          - scalar of Omega_0.
%            (default is \Omega_0=0.3).
%          - scalar of Lambda_0.
%            (default is \lambda_0=0.7).
% Output : - Angular diameter distance, in parsecs.
% Tested : Matlab 5.3
%     By : Eran O. Ofek      October 1999    Revised Feb 2000 
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%-------------------------------------------------------------
c = 29979245800; % cm/sec

if (nargin==1)
   H_0      = 68;
   Omega_0  = 0.3;
   Lambda_0 = 0.7;
elseif (nargin==2)
   Omega_0  = 0.3;
   Lambda_0 = 0.7;
elseif (nargin==3)
   Lambda_0 = 0.7;
elseif (nargin==4)
   % no default
else
   error('Illigal number of input arguments');
end

% convert all the units to cgs:
% c is allready in cgs
% pc = 3.08568e18 cm
H_0 = H_0.*1000.*100./(3.08568e18.*1e6); % 1/sec.

SizeZ = size(Z_vecA);
Dist = zeros(SizeZ(1),1);
for J=1:1:SizeZ(1)
   Z_vec = Z_vecA(J,:);
   if (length(Z_vec(1,:))==1)
      Z1 = 0;
      Z2 = Z_vec(1,1);
   elseif (length(Z_vec(1,:))==2)
      Z1 = Z_vec(1,1);
      Z2 = Z_vec(1,2);
   else
      error('Illigal number of columns in redshift matrix');
   end
   
   % calculate general geometry
   Omega_Tot  = Omega_0 + Lambda_0;

   % index of close univers cases (k=+1)
   I_close = find(Omega_Tot>1);
   % index of open univers cases (k=-1)
   I_open  = find(Omega_Tot<1);
   % index of flat univers cases (k=0)
   I_flat  = find(Omega_Tot==1);
   
   R0 = c./H_0;  % cm.
   
   Tol = 1e-4;   % integration tolerance
   
   %global ChiInt
   %ChiInt = inline('1./sqrt(Omega_0.*(1+Z).^3 + (1-Omega_0-Lambda_0).*(1+Z).^2+Lambda_0)','Z','Omega_0','Lambda_0');
   
   % integrate ChiIntegrand from z1 to z2
   IntVal = quad('chiint',Z1,Z2,Tol,[],Omega_0,Lambda_0);
   
   if (Omega_Tot>1)
      % k=+1   close
      Chi12 = sqrt(abs(Omega_Tot - 1)).*IntVal;
      Dist(J)  = R0.*sin(Chi12)./((1+Z2).*sqrt(Omega_Tot-1));
   elseif (Omega_Tot<1)
      % k=-1   open
      Chi12 = sqrt(abs(Omega_Tot - 1)).*IntVal;
      Dist(J)  = R0.*sinh(Chi12)./((1+Z2).*sqrt(1-Omega_Tot));
   else
      % k=0    flat
      Chi12 = IntVal;
      Dist(J)  = R0.*Chi12./(1+Z2);
   end


end

% convert distance in cm to parsecs
Dist = Dist./3.08568e18;