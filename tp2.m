
filename = 'Centre.wav';
[y,Fs] = audioread(filename);

 
 Ts= 1/Fs;
 N=length(y); % le nbr d'echantillons égal à la taille du vecteur y

 t=0:Ts:(N-1)*Ts;
%%
%subplot(2,1,1)
%plot(t,y)
title('representation temporelle d un signal audio ')
xlabel('t')
ylabel('y(t)')
%xlim([1 3]);
grid on

%sound(y,Fs)

Fe=Fs/2; % fréquence d'echantillonnage est deux fois plus petite que la fréquence d'origine
Te= 1/Fe;
t2=0:Te:(N-1)*Te;
%sound(y,Fe)

%subplot(2,1,2)
%plot(t2,y)
title('representation temporelle du signal audio après sa dilatation  ')
xlabel('t')
ylabel('x(t) =y(2t)')
%xlim([1 3]);
grid on



%% question 4
plot(t,y)

%% question 5
riennesertde=y(1:2.01*Fs);
sound(riennesertde,Fs)

%% question 6
courir=y(2.01*Fs:2.6*Fs);
sound(courir,Fs)


ilfaut=y(3*Fs:3.4*Fs);
sound(ilfaut,Fs)


partirapoint=y(3.4*Fs:4.84129*Fs);
sound(partirapoint,Fs)

%% Question 7:
parole=[riennesertde ,partirapoint ,ilfaut,courir];
sound(parole,Fs)

%% 
% Question 1:

Fe=8192;% la fréquence d'echantillonage
te=1/Fe;
N=5000;%nbr 'echantillons
t=(0:N-1)*te;

%la note Do
f_do=262;%frequence de la note Re
Do=10*cos(2*pi*f_do*t);
%sound(Do,Fe)


%la note Re
f_Re=294;%frequence de la note Re
Re=10*cos(2*pi*f_Re*t);
%sound(Re,Fe)

%la note Mi
f_Mi=330;%frequence de la note Mi
Mi=10*cos(2*pi*f_Mi*t);
%sound(Mi,Fe)

%la note Fa
f_fa=349;%frequence de la note Fa
Fa=10*cos(2*pi*f_fa*t);
%sound(Fa,Fe)

%la note sol
f_sol=392;%frequence de la note sol
sol=10*cos(2*pi*f_sol*t);
%sound(sol,Fe)

%la note La
f_la=440;%frequence de la note La
La=10*cos(2*pi*f_la*t);
%sound(La,Fe)

%la note si
f_si=494;%frequence de la note si
si=10*cos(2*pi*f_si*t);
%sound(si,Fe)

%la note Do2
f_Do2=523;%frequence de la note do2
Do2=10*cos(2*pi*523*t);
%sound(Do2,Fe)

%musique=[Do,Re,Mi,Fa,sol,La,si,Do2];
%sound(musique,Fe)

musique2=[Do,Re,Mi,Do,Do,Re,Mi,Do2];
%sound(musique2,Fe)
 

%%Spectre de la gamme de musique

%Question 2:


%spectre_musique=fft(musique); %transformeé de fourier

%signalAnalyzer(abs(fftshift(spectre_musique)));







