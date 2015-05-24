% specgen.m
% Ian McDougall
% 1 May 2013
% generates a synthetic relaxation spectrum (tau_alpha, h_alpha) following
% the method in Honerkamp and Weese

clear all
close all

%% - Spectrum Parameters
L =     100;    % number of points in spectrum
T_x =   5E-2;
T_y =   5E0;
T_a =   1E-3;   % minimum tau
T_b =   1E2;    % maximum tau
alpha = 1:L;    % subscript array

%% - Calculating Spectrum
T =     T_a*(T_b/T_a).^((alpha-1)/(L-1));
h0 =    log(T_b/T_a)/(L-1);
hfun =	@(T) 0.5/sqrt(2*pi)*(exp(-0.5*(log(T)-log(T_x)).^2)...
    + exp(-0.5*(log(T)-log(T_y)).^2));
h =     h0*hfun(T);

%% - Modulus Paramters
N =     30;     % number of moduli "measurements"
w_a =   1E-3;   % minimum frequency
w_b =   1E3;    % maximum frequency
i =     1:N;    % subscript array

%% - Calculating Moduli
w =     w_a*(w_b/w_a).^((i-1)/(N-1));

[ww, TT] =  meshgrid(w,T);
ww2 =   ww.^2;
TT2 =   TT.^2;
w2T2 =  ww2.*TT2;
hh =    h0*hfun(TT);
Gp =    sum(hh.*w2T2./(1+w2T2));
Gpp =   sum(hh.*ww.*TT./(1+w2T2));

% This was an attempt to isolate the problem by an alternate method, but it
% gives the same (too large) results
% Gp =    zeros(1,length(w));
% Gpp =   Gp;
% for i = 1:N
%     for alpha = 1:L
%         Gp(i) = Gp(i) + h(alpha)*w(i)^2*T(alpha)^2/(1+w(i)^2*T(alpha)^2);
%         Gpp(i) =    Gpp(i) + h(alpha)*w(i)*T(alpha)/(1+w(i)^2*T(alpha)^2);
%     end
% end

%% - Adding Error
s = 0.04;   % std deviation
rng('default')  % I think this 'resets' the RNG, for reproducibility
gps =   Gp.*(1+s*randn(size(Gp)));
gpps =  Gpp.*(1+s*randn(size(Gpp)));