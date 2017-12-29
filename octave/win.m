clear;

N=32; 
Nfft=2^14;
B=16; % bits in window word.

w=hamming(N,'symmetric'); 

plot(w,'ro-');
plot(N*(-Nfft/2:Nfft/2-1)/Nfft, 20*log10(fftshift(abs(fft(w,Nfft)))),'r.-');

hold on;
w=hanning(N,'symmetric'); 
plot(N*(-Nfft/2:Nfft/2-1)/Nfft, 20*log10(fftshift(abs(fft(w,Nfft)))),'b.-');
hold off;

% scale and quantize the window coefficients.
A = (2^(B-1))-1;
w_q = round(A*w);

% print the table in verilog format.
printf('    // Nwin = %d\n', N); 
printf('    const logic [%d-1:0][%d-1:0] win = {\n', N, B);
for i=1:N
    printf('        %d,\n', w_q(i));
end
printf('    };\n');