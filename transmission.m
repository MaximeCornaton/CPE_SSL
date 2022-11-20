function [s_module] = transmission()
   
Fe = 96000; 
T = 2;
nu03 = 20000;
Fc = 8000;
t=0:1/Fe:T-1/Fe;


%enregistrement du son
[nomfic,Signal,t] = RecordModulation(Fe,T);

%filtrage du son enregistré
[s]=PasseBas(Signal,Fe,Fc);

%création de la porteuse
porteuse = cos(2*pi*nu03*t);

%modulation du signal
s_module = porteuse.*s;

%sauvegarde du signal modulé
audiowrite('signalmodule.wav',s_module,Fe);

%transformée de Fourier du signal modulé
[S,f] = TransFourier(s,t);

%affichage de la transformée de Fourier
plot(f,abs(S));
size(t)
size(s)

end

