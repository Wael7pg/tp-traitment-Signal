clear all 
close all 
clc

[y,Fs]=audioread("test.wav");

Ts= 1/Fs;
N=length(y); % le nbr d'echantillons égal à la taille du vecteur y
t=0:Ts:(N-1)*Ts;

subplot(211)
plot(t,y)
title('representation temporelle d un signal audio ')
xlabel('t')
ylabel('y(t)')
xlim([1 1.2]);
grid on

fshift = (-N/2:N/2-1)*(Fs/N); % le pas de discrétisation est fe/N 
x=fft(y);

subplot(212)
plot(fshift,fftshift(abs(x)));
grid on
title(" représentation graphique du spectre d'amplitude du signal  ")

%%
k = 1;
fc = 5000;
%la transmitance complexe 
h =k./(1+1j*(Fs/fc).^1000);
h_filter = [h(1:floor(N/2)), flip(h(1:floor(N/2)))];

semilogx(f(1:floor(N/2)),abs( h(1:floor(N/2))),'linewidth',1.5)

%%
%H_bas = [H(1:floor(N/2)), flip(H(1:floor(N/2)))];
%y_filtre=x.*H_bas;                                                                                                                                              

x1 = ifft(y_filtre,"symmetric");% on applique la transformée de fourier inverse


plot(t,x1);
grid on
ylabel("temps")
xlabel("amplitude")
title("signal x après le filtrage avec une fréquence de coupure wc=4500")
