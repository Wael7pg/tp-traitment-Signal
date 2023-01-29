%%la représentation temporelle de ce signal en fonction du temps

load('ecg.mat')
Fe=500;
Te=1/Fe;
N=length(ecg);
t = 0:Te:(N-1)*Te;
% subplot(3,2,1)
plot(t,ecg)
grid on
title(" représentation graphique de l’activation électrique du cœur")
xlabel("t")
ylabel("ECG")
xlim([0.5 1.5]);

%%visualisation de spectre des fréquences a partir de spectre qu'on va
%%tracer 
f=(0:N-1)*(Fe/N);
fshift=(-N/2:N/2-1)*(Fe/N);
y = fft(ecg); %calcul de la TFD du signal ECG 
%subplot(3,2,2)
plot(fshift,fftshift(abs(y)));% abs est pour calculer le spectre d'amplitude
grid on
title(" représentation graphique du pectre d'amplitudedu signal ECG ")
xlabel("f")
ylabel("An")
%%on élimine les basses fréquences en réglant les fréquences inférieurs à
%%0.5Hz à 0 : 
% conception du filtre
pass_haut=ones(size(ecg));% on génère un vecteur des uns de meme taille que le vecteur ecg
fc=0.5; 
        %{
         la fréquence de coupure c'est la fréquence depuis laquelle 
         on fait passer ou éliminer les fréquences dans  ce cas c'est 0.5Hz
        %}
index_fc= ceil((fc*N)/Fe);
pass_haut(1:index_fc)= 0;%toutes les fréquences inférieures à 0.5 deviennent nulles
pass_haut(N-index_fc+1:N) = 0;%on applique la mem chose de l'autre coté car c'est un spéctre bilatéral
%subplot(3,2,3)
%plot(f,pass_haut,"linewidth",1.5)
%% Filtrage

ecg1_freq = pass_haut.*y; %on multiple le filtre pa le signal
ecg1 = ifft(ecg1_freq,"symmetric");%on applique la transformée de fourier inverse

%% plot filterd signal 

plot(t,ecg1)
hold on
plot(t,ecg+3)
hold on 
plot(t,ecg-ecg1+1.5)
grid on

%% Filtrage fréquence 50%

%on génére un vecteur des uns du meme taille que notre signal 

pass_notch=ones(size(ecg));
fc2=50; %ce filtre prends des valeurs nulles dans la frequence 50
index_fc2= ceil((fc2*N)/Fe)+1;
pass_notch(index_fc2)= 0;
pass_notch(N-index_fc2+1) = 0;
plot(f,pass_notch,'r');
grid on 
title("filtre pass_notch pour éliminer les fréquences duent aux interférences des lignes électriques")

%% Filtrage 2 
%utilisation de filtre notch

ecg2_freq = pass_notch.*fft(ecg1); % on multiplie notre filtre par le signal
ecg2 = ifft(ecg2_freq,"symmetric");% on applique la transformée de fourier inverse

subplot(311)
plot(t,ecg1,'r')
legend("signal ECG avant le filtre notch")
grid on
subplot(312)
plot(t,ecg1-ecg2)
legend("le bruit causé par les fréquences 50Hz")
grid on
subplot(313)
plot(t,ecg2,'g')
legend("signal ECG après le filtre notch")
grid on



%% Filtrage pass_bas 
%on teste tous le trois frequence de courpure qu'on a choisi

pass_bas = zeros(size(ecg));
fc3 = 20;
index_fc3 = ceil((fc3*N)/Fe);
pass_bas(1:index_fc3)= 1;
pass_bas(N-index_fc3+1:N) = 1;


%%Filtrage 2 

ecg3_freq = pass_bas.*fft(ecg2); 
ecg3 = ifft(ecg3_freq,"symmetric");


subplot(311)
plot(t,ecg2,'r')
xlim([0 4])
legend("signal ECG avant le filtre pass_bas")
grid on
subplot(312)
plot(t,ecg2-ecg3)
xlim([0,4])
legend("le bruit causé par les hautes-fréquences")
grid on
subplot(313)
plot(t,ecg3,'g')
xlim([0 4])
legend("signal ECG après le filtre pass_bas")
grid on
%%

%{
subplot(313)
plot(t,ecg3)
subplot(311)
plot(t,ecg3-ecg2)
subplot(312)
plot(t,ecg2)

plot(t,ecg-ecg3)

%}
%%
[c,lags] = xcorr(ecg3,ecg3);
stem(lags/Fe,c)
%%
% Définir l'intervalle de recherche pour la fréquence cardiaque
min_hr = 40; % battements par minute
max_hr = 220; % battements par minute

% Calculer l'autocorrélation du signal ECG
[acf,lags] = xcorr(ecg3,ecg3);%acf : (Autocorrelation function) est un vecteur contenant
                                   % les valeurs d'autocorrélation pour chaque décalage 
                                   %Lags : est un vecteur contenant les décalages
                                         % (ou les temps de retard) utilisés pour calculer l'autocorrélation.

% Trouver la fréquence cardiaque en se basant sur l'autocorrélation
[max_corr, max_index] = max(acf) ;

heart_rate = 60*Fe/(lags(max_index)) ;

% Vérifier si la fréquence cardiaque est dans l'intervalle de recherche
if heart_rate > min_hr && heart_rate < max_hr
    disp(['Fréquence cardiaque : ', num2str(heart_rate), ' battements par minute']);
else
    disp('Fréquence cardiaque non détectée');
end