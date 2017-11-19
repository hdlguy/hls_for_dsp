clear;
N=1; 
M=4; 

states.Phi=(2*pi)*rand(N,1,M); 
states.phi=(2*pi)*rand(N,1,M); 
states.theta=(2*pi)*rand(N,1,1);

T=1; 
Fs=1e6; 
t=(0:1/Fs:T); 
fd=100;
[X,states] = jakes_fader(t,fd,N,states,M);

plot(t,20*log10(abs(X)));
axis([0,1,-50,10]);
xlabel("time in seconds");
ylabel("fade in dB");
title("single carrier fade versus time");