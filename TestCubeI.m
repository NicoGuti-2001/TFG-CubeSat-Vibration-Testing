%% Análisis Cubesat INTA
clear all
clc
close all

%% cargar datos matlab - (ojo al tamaño)
%load('TestCI130526_300.mat')
%load('TestCI130526_1000.mat')
load('TestCI140526_2000.mat')
%load('TestCI130526_3000.mat')

%% Asignar nombres por comodidad
t = Data1_time_AI_1__1__minus;
winlen = size(Data1_AO_3__46__Shaker_grande,1); %__47__ para 300, 3000 y 1000/ 46 - 2000

exc = Data1_AO_3__46__Shaker_grande;
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

%% Resta aceleraciones

% para ver que pasa cuando las aceleraciones son las puras del cubesat
acel(1,:) = a(1,:) - a(7,:);
acel(2,:) = a(3,:) - a(6,:);
acel(3,:) = a(2,:) - a(5,:);
acel(4,:) = a(8,:) - a(4,:);


%% Análisis modal

figure(4)
hold on
for z=1:8
    [tf(:,z), frec(:,z)] = tfestimate(exc,a(z,:),hann(winlen), 0.5*winlen, [],Sample_rate);
    tfestimate(exc,a(z,:),hann(winlen), 0.5*winlen, [],Sample_rate)
end
hold off
legend('sensor 1','sensor 2','sensor 3','sensor 4','sensor 5','sensor 6','sensor 7','sensor 8')

%% TF Restas 
figure(5)
hold on
for w=1:4
    [tfr(:,w), frecr(:,w)] = tfestimate(exc,acel(w,:),hann(winlen), 0.5*winlen, [],Sample_rate);
    tfestimate(exc,acel(w,:),hann(winlen), 0.5*winlen, [],Sample_rate)
end
hold off
legend('Esquina 5','Esquina 6','Esquina 7','Esquina 8')

%% Picos FRF
idx = find(frecr(:,1)>400,1); %para mejorar resolucion y tiempo calculo

[peak1, distp1] = findpeaks(mag2db(abs(tfr(1:idx,1))),frecr(1:idx,1), MinPeakDistance=9);
[peak2, distp2] = findpeaks(mag2db(abs(tfr(1:idx,2))),frecr(1:idx,2), MinPeakDistance=9);
[peak3, distp3] = findpeaks(mag2db(abs(tfr(1:idx,3))),frecr(1:idx,3), MinPeakDistance=9);
[peak4, distp4] = findpeaks(mag2db(abs(tfr(1:idx,4))),frecr(1:idx,4), MinPeakDistance=9);

[vall1, distv1] = findpeaks(-mag2db(abs(tfr(1:idx,1))),frecr(1:idx,1), MinPeakDistance=9);
[vall2, distv2] = findpeaks(-mag2db(abs(tfr(1:idx,2))),frecr(1:idx,2), MinPeakDistance=9);
[vall3, distv3] = findpeaks(-mag2db(abs(tfr(1:idx,3))),frecr(1:idx,3), MinPeakDistance=9);
[vall4, distv4] = findpeaks(-mag2db(abs(tfr(1:idx,4))),frecr(1:idx,4), MinPeakDistance=9);

vall1 = -1*vall1; % el cálculo de antes deja los mínimos en negativo
vall2 = -1*vall2; % corrección del valor 
vall3 = -1*vall3;
vall4 = -1*vall4;


%% notas
% t = Data1_time_AI_1__1__minus;
% ind =find(t>3,1);
% t = Data1_time_AI_1__1__minus(ind:end);
% winlen = size(Data1_AO_3__47__Shaker_grande(ind:end),1); %la variable
% shaker c
% 
% exc = Data1_AO_3__47__Shaker_grande(ind:end);
% a(1,:) = Data1_AI_1__1__minus(ind:end);
% a(2,:) = Data1_AI_2__2__minus(ind:end);
% a(3,:) = Data1_AI_3__3__minus(ind:end);
% a(4,:) = Data1_AI_4__4__minus(ind:end);
% a(5,:) = Data1_AI_5__5__minus(ind:end);
% a(6,:) = Data1_AI_6__6__minus(ind:end);
% a(7,:) = Data1_AI_7__7__minus(ind:end);
% a(8,:) = Data1_AI_8__8__minus(ind:end);