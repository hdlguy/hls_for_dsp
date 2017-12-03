% a look at doppler spread within a 10MHz channel centered at 1500MHz.
clear;

Fc=1.5e9; 
BW=10e6; 
Nf=32; 
Vr=units('mile/hr', 'm/sec', [60] );
c=physical_constant('speed of light in vacuum'); 

freq=Fc+BW*((-Nf/2:Nf/2-1)+0.5)/Nf; 
Fdelta=freq*Vr/c; 

Fdelta

plot(Fdelta, '*r-')

