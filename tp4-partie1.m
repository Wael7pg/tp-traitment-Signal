%%on trace le signal x(t) et sa transformation de fourier 
%%question2

Te=0.0005;
fe=1/Te;
t=0:Te:5-Te; 


x=sin(2*pi*500*t)+sin(2*pi*400*t)+sin(2*pi*50*t);

N=length(t);%nombre d'echantillons egal à la longeur du t

f = (-N/2:N/2-1)*(fe/N); % le pas de discrétisation est fe/N 

y=fft(x);
%la fuite spectrale t=0:Te:5-Te; 

%%subplot(211)
%plot(t,x)
title("signal d'entrée x(t)")
grid on
%%subplot(212)
%plot(f,fftshift(abs(y)));
title("le sectre d'amplitude du signal d'entrée x")
grid on

%
%%question 1
%on trace le module de la fonction H(f)
f2=(0:N-1)*fe/N;
k=1;
w=2*pi*f2;
wc=50;
H=(k*1i*w/wc)./(1+1i*w/wc);
%semilogx(f2,abs(H));
grid on
title("module transmittance complexe du filtre passe haut ")
%on choisis differents pulsations de courpure wc :
wc1= 100;
wc2 =450;
wc3 =1000;

H1=(k*1i*w/wc1)./(1+1i*w/wc1);
H2=(k*1i*w/wc2)./(1+1i*w/wc2);
H3=(k*1i*w/wc3)./(1+1i*w/wc3);

%le gain pour differente fréquence de coupure

G = 20*log(abs(H));
G1 = 20*log(abs(H1));
G2 = 20*log(abs(H2));
G3 = 20*log(abs(H3));

a1= angle(H1);
a2= angle(H2);
a3= angle(H3);
%On trace le diagramme de Bode de phase 
subplot(211)
semilogx(f2,G1,f2,G2,f2,G3);
grid on
title("Diagramme de bode ")
ylabel("gains")
xlabel("fréquence")
legend("G1 : wc=100","G2 : wc=450","G3 : wc=800")


subplot(212)
semilogx(f2,a1,f2,a2,f2,a3);
grid on
title("Diagramme de bode ")
ylabel("phase")
xlabel("fréquence")
legend("a1 : wc=100","a2 : wc=450","a3 : wc=800")


%% question3
%on commence le filtrage

%concption du filtre
x_filtre1 = H1.*y; %on multiple le filtre par le signal
x_filtre2 = H2.*y;
x_filtre3 = H3.*y;

x1 = ifft(x_filtre1,"symmetric");% on applique la transformée de fourier inverse
% pour visualiser le signal filtré dans le domaine temporel
x2 = ifft(x_filtre2,"symmetric");
x3 = ifft(x_filtre3,"symmetric");

subplot(411)
plot(t,x);
grid on
ylabel("temps")
xlabel("amplitude")
xlim([0.5 1]);
title("x : le signal x avant filtrage")


subplot(412)
plot(t,x1);
grid on
ylabel("temps")
xlabel("amplitude")
xlim([0.5 1]);
title("signal x après le filtrage avec une fréquence de coupure wc=100")


subplot(413)
plot(t,x2);
grid on
ylabel("temps")
xlabel("amplitude")
xlim([0.5 1]);
title("signal x après le filtrage avec une fréquence de coupure wc=450")


subplot(414)
plot(t,x3);
grid on
ylabel("temps")
xlabel("amplitude")
xlim([0.5 1]);
title("signal x après le filtrage avec une fréquence de coupure wc=1000")













