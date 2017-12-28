%
clear;

Nsim = 2^12;   % length of sim
I = 8;        % interpolation ratio.
Fs = 30.72e6;
Tfade = 0.1e-3;
Fc = 1/Tfade;
Nfilt = 7;

% make some fictional fades.
s0 = sin(2*pi*(Fc/Fs)*(0:Nsim-1));
s0_up = upsample(s0,I);

% specify the interpolating filter.
b = fir1(Nfilt, 0.5/I);
%plot(b, 'r*-');
%plot((-(Nfilt+1)/2:(Nfilt+1)/2-1), 20*log10(fftshift(abs(fft(b)))));

% interpolate the data by I.
%s1 = interp(s0,I);
s1 = I*filter(b, 1, s0_up);


plot(real(s1),'b.-'); hold on; plot(real(s0_up),'r.'); hold off;