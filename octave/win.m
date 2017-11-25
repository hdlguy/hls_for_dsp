clear;

N=32; 
Nfft=256;
B=16; % bits in window word.

w=hanning(N,'symmetric'); 

%plot(w,'ro-');
%plot(20*log10(fftshift(abs(fft(w,Nfft)))),'r.-');

%hold on;
%w=hamming(N,'symmetric'); 
%plot(20*log10(fftshift(abs(fft(w,Nfft)))),'b.-');

% scale and quantize the window coefficients.
A = (2^(B-1))-1;
w_q = round(A*w);

% print the table in verilog format.
printf('    // Nwin = %d; Hanning window\n', N); 
printf('    const logic [%d-1:0][%d-1:0] win = {\n', N, B);
for i=1:N
    printf('        %d,\n', w_q(i));
end
printf('    };\n');