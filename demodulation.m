function [s_demodulee] = demodulation(s,f)

x=s';
Fe = 96000;
Fp = 20000;
T = 5;
t=0:1/Fe:T-(1/Fe);

%cr�ation de la porteuse
p = cos(2*pi*Fp.*t);

%d�modulation du signal transmis 
x1 = x.*p;

%transform�e de Fourier des signaux modul� et d�modul�
[tfs,f1] = TransFourier (s,t);
[tfx1,f3] = TransFourier (x1,t);

%filtrage du signal d�modul�
s_demodulee = PasseBas(x1,Fe,8000);

%transform�e de Fourier du signal d�modul� filtr�
[tfsm,f2] = TransFourier (s_demodulee,t);

%affichage des transform�es de Fourier
figure(2);
subplot(132);plot(f3,abs(tfx1));xlabel('TF du signal demodulee');
subplot(133);plot(f2,abs(tfsm));xlabel('TF du signal demodulee et filtree');
subplot(131);plot(f1,abs(tfs));xlabel('TF du signal reçu');

%lecture du signal d�modul�
while 255 == 255
    soundsc(s_demodulee,Fe);
    pause(6);
end
end
