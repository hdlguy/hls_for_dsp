clear;

load -ascii fade.dat; 

N = 32; % number of channels
L = size(fade, 1);
cmplx_fade = zeros(L, N);

for samp=1:L
    for chan = 1:N
        cmplx_fade(samp, chan) = fade(samp, 2*chan-1) + j*fade(samp, 2*chan);
    end
end

abs_vec=reshape(abs(cmplx_fade),[L*N 1]); 
hist(abs_vec, 100);

