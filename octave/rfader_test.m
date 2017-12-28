function rfader_test(x,fs,fd)

%
% rfader_test(x,fs,fd)
%
% Compares statistics of a simulated Rayleigh faded envelope to the 
% expected theoretical benchmarks, as described in "The Mobile Radio 
% Propagation Channel" by J. D. Parsons.
%
% x   =  faded envelope (unity power)
% fs  =  sampling rate (Hz)
% fd  =  Doppler frequency in Hz
%

% Force row vactor
x = reshape(x,1,[]);

% Fade levels to test against
rho_dB = [0 -3 -6 -9 -12 -20];
rho = 10.^(rho_dB/20);

% Theoretical values
theory_duration = (exp(rho.*rho)-1) ./ (sqrt(2*pi)*fd*rho);
theory_rate = (1-exp(-rho.*rho)) ./ theory_duration;

% Chug through signal and measure statistics.
num_faded_samples = zeros(1,length(rho));
num_fades = zeros(1,length(rho));
for n = 1 : length(rho),

    y = abs(x) - rho(n);					
    num_faded_samples(n) = sum(y<0);
    num_fades(n) = sum(diff(y>0)==-1);	
    
end;

measured_duration = (num_faded_samples./num_fades)/fs;
measured_rate = fs*num_fades/length(x);

% Display results
disp(' ');
disp(' ');
disp('                          Fade rate (Hz)          Fade duration (msec)');
disp('     Threshold (dB)   Theory      Measured        Theory      Measured')
disp('     --------------   --------------------        --------------------');

format bank
Results = [rho_dB' theory_rate' measured_rate' 1000*theory_duration' 1000*measured_duration'];
disp(Results)
format long

% Compare measured distribution of the envelope, in dB, against the 
% theoretical probability density function (PDF) of the Rayleigh envelope 
% after converting to dB.
db = 1.0;
b = -40+db/2 : db : 20-db/2;
h = hist(20*log10(abs(x)),b) / length(x) / db;
bar(b,h,'r')
grid on ; hold on
p = log_rayleigh_pdf(b);
plot(b,p,'c--')
hold off
xlabel('Envelope  (dB)')
ylabel(['Probability in Bin Width ' num2str(db,'%1.2f') ' dB'])
legend('Measured','Theoretical','location','northwest')
title('Distribution of Envelope in dB')
axis([-35 15 0 0.1])
