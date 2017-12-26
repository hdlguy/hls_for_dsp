clear;
N=32;     % number of independent fader channels.
M=8;     % number of reflectors per fade.
T=1;     % simulation run time in seconds.
Fs=10e3; % sampling rate of fade calculations in Hz.
fd=10;   % doppler shift in Hz.

states.Phi   = 2*pi*rand(N,1,M) - pi; 
states.phi   = 2*pi*rand(N,1,M) - pi; 
states.theta = 2*pi*rand(N,1,1) - pi;

%write_fader_hpp(states, fd, 'fader_states.hpp');
write_verilog(states, fd, 'states_pack.sv');

t = (0:1/Fs:T);  % time vector.
[X,states] = jakes_fader(t,fd,N,states,M);

plot(t,20*log10(abs(X)));
axis([0,1,-50,10]);
xlabel("time in seconds");
ylabel("fade in dB");
title("single carrier fade versus time");

