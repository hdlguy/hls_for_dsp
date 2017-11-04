function fd = doppler_frequency(fc,v,units)

%
% fd = doppler_frequency(fc,v,units)
%
% Computes Doppler frequency fd in Hz.  Carrier frequency fc is in MHz.
% Velocity v is in units of 'kmh' (default) or 'mph'.
%

% Default inputs.
if nargin < 3
   units = 'kmh';
end

% Convert velocity to m/s.
switch units
case 'kmh'
    v = v * 1000 / 3600;
case 'mph'
    v = v * 5280 * 12 * 2.54 / 100 / 3600;
end

% Speed of light in m/s.
c = 299792458; 

% Compute Doppler frequency in Hz.
fd = (v/c) * 1e6 * fc;
