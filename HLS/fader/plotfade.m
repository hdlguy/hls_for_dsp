clear;

load -ascii ./solution1/csim/build/fade.dat;

Fs = 100e3;
t = (0:size(fade,1)-1)/Fs;

clf;
hold on;
Nc=0; s1=fade(:,2*Nc+1)+j*fade(:,2*Nc+2); plot(t, 20*log10(abs(s1)),'b');
Nc=1; s1=fade(:,2*Nc+1)+j*fade(:,2*Nc+2); plot(t, 20*log10(abs(s1)),'r'); 
Nc=2; s1=fade(:,2*Nc+1)+j*fade(:,2*Nc+2); plot(t, 20*log10(abs(s1)),'g'); 
Nc=3; s1=fade(:,2*Nc+1)+j*fade(:,2*Nc+2); plot(t, 20*log10(abs(s1)),'m');
hold off;

title('Fade versus Time');
xlabel('time in seconds');
ylabel('fade in dB');
