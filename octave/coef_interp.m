%
clear;

Nchan = 32;    % number of complex coefficient channels to interpolate.
Nfade = 128;   % number of fade samples to interpolate.
Fs = 30.72e6;  % sample rate of the radio.
I = 16;     % fade interpolation ratio.
Nfilt = I*4;   % order of interpolating filter.

% make some fictional fades.
fade = 2.0*(rand(Nfade, Nchan) + j*rand(Nfade, Nchan) - (0.5 + j*0.5));
%plot(real(fade(:,1)));

% specify the interpolating filter.
%b = fir1(Nfilt, 0.5/I);
%plot(b, 'r*-');
%plot((-(Nfilt+1)/2:(Nfilt+1)/2-1), 20*log10(fftshift(abs(fft(b)))));

% interpolate the data by I.
fade_interp = interp(fade,I);

