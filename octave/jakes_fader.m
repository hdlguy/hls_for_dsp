function [X,states] = jakes_fader(t,fd,N,states,M)

%
% [X,states] = jakes_fader(t,fd,N,states,M)
%
% Generates a set of approximately uncorrelated, fading waveforms, based on 
% the modified Jakes model, described in "Improved Models for the Generation 
% of Multiple Uncorrelated Rayleigh Fading Waveforms", IEEE Communications 
% Letters, June 2002.
%
% INPUTS:
% =======
% t   =  vector of times, in seconds, at which to generate fading samples.
% fd  =  Doppler frequency in Hz.
% N   =  number of waveforms to generate
% states = structure containing fader states.  These are the phases which
%          drive the oscillators.  They are generated within this function.
% M   =   number of sinusoids per fader (default = 16).
%
% OUTPUTS:
% ========
% X       =  N x length(t) matrix of complex fading samples.
% states  =  If the input structure is empty, they will be generated within 
%            this function.
%

%--------------------------------------------------------------------------

% Set default parameters.
if (nargin < 5)
   M = 16;
end

%--------------------------------------------------------------------------

% Number of time instances.
num_t = length(t);

% Select random phase shifts.  Note these must be preserved in order to
% maintain continuity.
if (isempty(states))
   states.Phi   = (2*pi) * rand(N,1,M);
   states.phi   = (2*pi) * rand(N,1,M);
   states.theta = (2*pi) * rand(N,1,1);
end

%--------------------------------------------------------------------------

% Compute alphas.
theta = repmat(states.theta,[1 1 M]);
n = zeros(1,1,M);
n(:,:,1:M) = 1:M;
n = repmat(n,[N 1 1]);
alpha = (2*pi*n - pi + theta) / (4*M);

% Expand cos(alpha) and sin(alpha) into matrices.
cos_alpha = repmat(cos(alpha),[1 num_t 1]);
sin_alpha = repmat(sin(alpha),[1 num_t 1]);

% Compute waveforms.  Sum along the 3rd dimension, i.e., the M sinusoids.
Phi = repmat(states.Phi,[1 num_t 1]);
phi = repmat(states.phi,[1 num_t 1]);
arg_0 = 2*pi*fd*repmat(t,[N 1 M]);
arg_I = (arg_0.*cos_alpha) + Phi;
arg_Q = (arg_0.*sin_alpha) + phi;
X = sqrt(1/M) * sum(cos(arg_I) + j*cos(arg_Q), 3);

%--------------------------------------------------------------------------

