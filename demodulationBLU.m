function [signal_demodulee_BLU] = demodulation(s_moduleBLU,f)

x=s';
Fe = 96000;
Fp = 20000;
Fc = 8000;
T = 5;
t=0:1/Fe:T-(1/Fe);

%filtrage du signal émis par transmissionBLU
[s_moduleBLU_filtree1]=PasseBande(s_moduleBLU,Fe,0,Fc);
[s_moduleBLU_filtree2]=PasseBande(s_moduleBLU,Fe,Fc,2*Fc);

%démodulation du signal filtré
s_demoduleeBLU1 = s_moduleBLU_filtree1.*cos(2*pi*Fp*t)*2;
s_demoduleeBLU2 = s_moduleBLU_filtree2.*cos(2*pi*Fp*t)*2;

%filtrage du signal démodulé
[s_demoduleeBLU_filtree1] = PasseBas(s_demoduleeBLU1,Fe,Fc);
[s_demoduleeBLU_filtree2] = PasseBas(s_demoduleeBLU2,Fe,Fc); 

%lecture et sauvegarde des sons démodulées par BLU
soundsc(s_demoduleeBLU_filtree1, Fe);
audiowrite('signaldemoduleBLU1.wav'.wav', s_demoduleeBLU_filtree1, Fe);

soundsc(s_demoduleeBLU_filtree2, Fe);
audiowrite('signaldemoduleBLU2.wav'.wav', s_demoduleeBLU_filtree2, Fe);
    
%transformées de Fourier des signaux
[S1,f1] = TransFourier(s_demoduleeBLU_filtree1,t);
[S2,f2] = TransFourier(s_demoduleeBLU_filtree2,t);

%affichage des transformées de Fourier
figure(1);
subplot(1,2,1);plot(f1, abs(S1));xlabel('TF du signal 1 démodulé par BLU');
subplot(1,2,2);plot(f2, abs(S2));xlabel('TF du signal 2 démodulé par BLU');

end



