%% Análisis mesa
clear all
clc
close all

%% cargar datos matlab - (ojo al tamaño)
load('ModalTestMesa_2204.mat')
%load('SineSweepMesa_1504.mat')
%load('ModalTestMesa_1504.mat')

%% Asignar nombres por comodidad
t = Data1_time_AI_1__1__minus;
winlen = size(Data1_AO_3__59__Shaker_grande,1);

exc = Data1_AO_3__59__Shaker_grande;
a(1,:) = Data1_AI_1__1__minus;
a(2,:) = Data1_AI_2__2__minus;
a(3,:) = Data1_AI_3__3__minus;
a(4,:) = Data1_AI_4__4__minus;
a(5,:) = Data1_AI_5__5__minus;
a(6,:) = Data1_AI_6__6__minus;
a(7,:) = Data1_AI_7__7__minus;
a(8,:) = Data1_AI_8__8__minus;

%% Plots aceleración/velocidad/posición
figure(1)
plot(t,a(1,:))
xlabel('time (s)')
ylabel('acceleration (m/s2)')
grid on

for i=1:8
    v(i,:) = cumtrapz(t,a(i,:));
end
figure(2)
plot(t,v(1,:))      %2 por ejemplo
xlabel('time (s)')
ylabel('velocity (m/s)')
grid on

for j=1:8
    p(j,:) = cumtrapz(t,v(j,:));
end
figure(3)
plot(t,p(1,:))      %3 por ejemplo
xlabel('time (s)')
ylabel('position (m)')
grid on

%% Análisis modal

figure(4)
hold on
for z=1:8
    [tf(:,z), frec(:,z)] = tfestimate(Data1_AO_3__59__Shaker_grande,a(z,:),hann(winlen), 0.5*winlen, [],Sample_rate);
    tfestimate(Data1_AO_3__59__Shaker_grande,a(z,:),hann(winlen), 0.5*winlen, [],Sample_rate)
    end
hold off
legend('sensor 1','sensor 2','sensor 3','sensor 4','sensor 5','sensor 6','sensor 7','sensor 8')

%% Calcular máximos y mínimos
idx = find(frec(:,1)>1000,1); %para mejorar resolucion y tiempo calculo - frec es la misma para todos

[peak1, distp1] = findpeaks(mag2db(abs(tf(1:idx,1))),frec(1:idx,1), MinPeakDistance=9);
[peak2, distp2] = findpeaks(mag2db(abs(tf(1:idx,2))),frec(1:idx,2), MinPeakDistance=9);
[peak3, distp3] = findpeaks(mag2db(abs(tf(1:idx,3))),frec(1:idx,3), MinPeakDistance=9);
[peak4, distp4] = findpeaks(mag2db(abs(tf(1:idx,4))),frec(1:idx,4), MinPeakDistance=9);
[peak5, distp5] = findpeaks(mag2db(abs(tf(1:idx,5))),frec(1:idx,5), MinPeakDistance=9);
[peak6, distp6] = findpeaks(mag2db(abs(tf(1:idx,6))),frec(1:idx,6), MinPeakDistance=9);
[peak7, distp7] = findpeaks(mag2db(abs(tf(1:idx,7))),frec(1:idx,7), MinPeakDistance=9);
[peak8, distp8] = findpeaks(mag2db(abs(tf(1:idx,8))),frec(1:idx,8), MinPeakDistance=9);

[vall1, distv1] = findpeaks(-mag2db(abs(tf(1:idx,1))),frec(1:idx,1), MinPeakDistance=9);
[vall2, distv2] = findpeaks(-mag2db(abs(tf(1:idx,2))),frec(1:idx,2), MinPeakDistance=9);
[vall3, distv3] = findpeaks(-mag2db(abs(tf(1:idx,3))),frec(1:idx,3), MinPeakDistance=9);
[vall4, distv4] = findpeaks(-mag2db(abs(tf(1:idx,4))),frec(1:idx,4), MinPeakDistance=9);
[vall5, distv5] = findpeaks(-mag2db(abs(tf(1:idx,5))),frec(1:idx,5), MinPeakDistance=9);
[vall6, distv6] = findpeaks(-mag2db(abs(tf(1:idx,6))),frec(1:idx,6), MinPeakDistance=9);
[vall7, distv7] = findpeaks(-mag2db(abs(tf(1:idx,7))),frec(1:idx,7), MinPeakDistance=9);
[vall8, distv8] = findpeaks(-mag2db(abs(tf(1:idx,8))),frec(1:idx,8), MinPeakDistance=9);

vall1 = -1*vall1; % el cálculo de antes deja los mínimos en negativo
vall2 = -1*vall2; % corrección del valor 
vall3 = -1*vall3;
vall4 = -1*vall4;
vall5 = -1*vall5;
vall6 = -1*vall6;
vall7 = -1*vall7;
vall8 = -1*vall8;
%% Notas
% https://www.mathworks.com/help/signal/ref/modalfrf.html#bvkxa2t-2
% winlen = size(Data1_AO_3__59__Shaker_grande,1);
% modalfrf(Data1_AO_3__28__Shaker_grande,Data1_AI_1__1__minus,Sample_rate,winlen)

% https://www.mathworks.com/help/signal/ref/tfestimate.html#bufqg8e
%tfestimate(Data1_AO_3__59__Shaker_grande,Data1_AI_1__1__minus,[],[],[],Sample_rate)

%la buena
% tfestimate(Data1_AO_3__59__Shaker_grande,Data1_AI_4__4__minus,hann(winlen), 0.5*winlen, [],Sample_rate)
%plot(frec(:,1), mag2db(abs(tf(:,1)))) POR SI HAY QUE PINTAR ALGO

% modalfrf(Data1_AO_3__59__Shaker_grande,Data1_AI_1__1__minus,Sample_rate,hann(winlen), 0.5*winlen)
% 
% [frf,f] = modalfrf(Data1_AO_3__59__Shaker_grande,Data1_AI_1__1__minus,Sample_rate,hann(winlen), 0.5*winlen);
% plot(f,mag2db(abs(frf)))
% xlim([0 10000])
% xlim([0 200])

%findpeaks(mag2db(abs(tf(:,1))), Sample_rate, MinPeakDistance=8)