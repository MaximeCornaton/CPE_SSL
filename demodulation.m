function [s_demodulee] = demodulation(s,f)

x=s';
Fe = 96000;
Fp = 20000;
T = 5;
t=0:1/Fe:T-(1/Fe);

%création de la porteuse
p = cos(2*pi*Fp.*t);

%démodulation du signal transmis 
x1 = x.*p;

%transformée de Fourier des signaux modulé et démodulé
[tfs,f1] = TransFourier (s,t);
[tfx1,f3] = TransFourier (x1,t);

%filtrage du signal démodulé
s_demodulee = PasseBas(x1,Fe,8000);

%transformée de Fourier du signal démodulé filtré
[tfsm,f2] = TransFourier (s_demodulee,t);

%affichage des transformées de Fourier
figure(2);
subplot(132);plot(f3,abs(tfx1));xlabel('TF du signal demodulee');
subplot(133);plot(f2,abs(tfsm));xlabel('TF du signal demodulee et filtree');
subplot(131);plot(f1,abs(tfs));xlabel('TF du signal reÃ§u');

%lecture du signal démodulé
while 255 == 255
    soundsc(s_demodulee,Fe);
    pause(6);
end
end
