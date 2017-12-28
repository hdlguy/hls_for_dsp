clear;

Nsim = 2^12; % input samples in simulation.
I = 8; % interpolation factor (power of two)

Nfade = 128; % fade period in samples.
Ffade = 1/Nfade;

B = 16;  % number of bits in data word.
A = (2^(B-1))-1;

s0 = round(A*sin(2*pi*Ffade*(0:Nsim-1+1)));

%plot(s0, 'r*-');

s1 = zeros(1, I*length(s0));

for i=1:Nsim
    for j=0:I-1
        % here we compute the interpolated value.
        s1(1+i*I+j) = s0(i) + round((s0(i+1) - s0(i))*j/I);
    end
end
s1=s1(I+1:length(s1));

s0_up = upsample(s0,I);

plot(s1,'b.-'); hold on; plot(s0_up,'ro'); hold off;
%plot(fftshift(20*log10(1e-10+abs(fft(s1)))));

