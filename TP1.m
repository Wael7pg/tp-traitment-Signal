

fe = 1e4; %la frequence d'echantillonage 
te = 1/fe;%la periode d'echantillonage 
N = 5000; %nombre d'echantillons 

t = 0:te:(N-1)*te; 

%% Représentation temporelle et fréquentielle

x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);
figure;

subplot(2,3,1)
plot(t,x);
title('Le signal X')
xlabel('t')
ylabel('x(t)')

%Question 2:


f =(0:N-1)*(fe/N); 
y = fft(x); 
subplot(2,3,2)
plot(f,abs(y));
title("représentation du spectre d amplitude de la TFD du signal X")
%Pour centré le spectre on utilise la fonction fshift qui aussi 
%créer des echantillons 

fshift = (-N/2:(N/2)-1)*(fe/N);

plot(fshift,fftshift(abs(y)/N))
title("représentation du spectre d amplitude de la TFD du signal X")


%Question 4:

%Introduction de bruit 
noise = 5*randn(size(x));
subplot(2,3,4)
plot(noise)
title("Le signal noise")

xnoise = x+noise;
ybruit = fft(xnoise);
subplot(2,3,5)
% plot(fshift,fftshift((abs(ybruit)).^2/N));
plot(fshift,fftshift((abs(ybruit)*2)/N));
title("Le signal noise ")

figure;
noise2 = 20*randn(size(x));
xnoise2=x+noise2;
ybruit2 = fft(xnoise2);
plot(fshift,fftshift((abs(ybruit2))*2/N));
title("Le signal noise 2")

%Après l'augementation de l'intensité du signal bruit on remarque que le
%spectre de bruit est centrées entre -3 et 3



%% Analyse fréquentielle du chant du rorqual bleu

%Question 1:
[whale,fe]=audioread("bluewhale.au");

chant = whale(2.45e4:3.10e4);
%Question 2:

sound(chant,fe)

%Question 3:
N = length(chant);
te = 1/fe;
t = (0:N-1)*(10*te);
figure;
subplot(2,1,1)
plot(t,chant)
title('Le signal whant')
y = abs(fft(chant)).^2/N; 
f = (0:floor(N/2))*(fe/N)/10;
subplot(2,1,2)
plot(f,y(1:floor(N/2)+1));
title('Le signal densité spectrale de puissance du signal')