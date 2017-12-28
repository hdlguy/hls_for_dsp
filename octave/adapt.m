%
clear;
N = 2^16;
Fs=30.72e6; 
Ts=1/Fs;
Ncoef = 32; 
Nfft = 4*Ncoef;

% make the filter shape (later from Jakes fader)
H = zeros(1,Ncoef);
H(Ncoef/4+1:3*Ncoef/4) = 1.0;
randphase = exp(j*2*pi*rand(1,Ncoef));
H = H.*randphase;
H = fftshift(H);
h = ifft(H);
win = hamming(Ncoef);
h = h.*transpose(win);

%plot(real(h), 'r*-'); hold on; plot(imag(h), 'b*-'); hold off;
plot(Fs*(-Nfft/2:Nfft/2-1)/Nfft,20*log10(fftshift(abs(fft(h, Nfft)))));
axis([-Fs/2,Fs/2,-50,0]);
xlabel("Frequency in Hz");
ylabel("Amplitude in dB");


