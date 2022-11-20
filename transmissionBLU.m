function [s_moduleBLU] = transmissionBLU()
Fe = 96000; 
T = 2;
nu03 = 20000;
Fc = 8000;
t=0:1/Fe:T-1/Fe;


%enregistrement des 2 sons
[nomfic1,Signal1,t1] = RecordModulation(Fe,T);
[nomfic2,Signal2,t2] = RecordModulation(Fe,T);

%filtrage des 2 sons enregistrés
[s1]=PasseBas(Signal1,Fe,Fc);
[s2]=PasseBas(Signal2,Fe,Fc);

%création des signaux x1 et x2
y1=hilbert(s1);
y2=hilbert(s2);

TransHilbert1=imag(y1);
TransHilbert2=imag(y2);

x1=s1.*cos(2*pi*nu03*t) - TransHilbert1.*sin(2*pi*nu03*t);
x2=s2.*cos(2*pi*nu03*t) - TransHilbert2.*sin(2*pi*nu03*t);

%création du signal final x1+x2
s_moduleBLU= x1 + x2;

audiowrite('signalmoduleBLU.wav',s_moduleBLU,Fe);

%transformées de Fourier des signaux
[X1,f1] = TransFourier(x1,t);
[X2,f2] = TransFourier(x2,t);
[S_ModuleBLU,f] = TransFourier(s_moduleBLU,t);

%affichage des transformées de Fourier
figure(1);
subplot(1,3,1);plot(f1, abs(X1));xlabel('TF du signal x1');
subplot(1,3,2);plot(f2, abs(X2));xlabel('TF du signal x2');
subplot(1,3,3);plot(f, abs(S_ModuleBLU));xlabel('TF du signal émis');

end















