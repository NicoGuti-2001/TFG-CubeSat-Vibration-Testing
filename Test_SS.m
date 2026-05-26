%% Análisis Sine Sweep
clear all
clc
close all

%% cargar datos matlab - (ojo al tamaño)
%load('SinSWCp_14052026.mat')
load('SinSWCi_14052026.mat')


%% Asignar nombres por comodidad
t = Data1_time_AI_1__1__minus;
winlen = size(Data1_AO_3__9__Shaker_grande,1);

exc = Data1_AO_3__9__Shaker_grande;
a(1,:) = Data1_AI_1__1__minus;
a(2,:) = Data1_AI_2__2__minus;
a(3,:) = Data1_AI_3__3__minus;
a(4,:) = Data1_AI_4__4__minus;
a(5,:) = Data1_AI_5__5__minus;
a(6,:) = Data1_AI_6__6__minus;
a(7,:) = Data1_AI_7__7__minus;
a(8,:) = Data1_AI_8__8__minus;

am(1,:) = 9.81*a(1,:);     % conversión g-m/s^2 para poder obtener velocidad y posición
am(2,:) = 9.81*a(1,:);
am(3,:) = 9.81*a(1,:);
am(4,:) = 9.81*a(1,:);
am(5,:) = 9.81*a(1,:);
am(6,:) = 9.81*a(1,:);
am(7,:) = 9.81*a(1,:);
am(8,:) = 9.81*a(1,:);

%% Plots aceleración
figure(1)
tiledlayout(3,1)
nexttile
plot(t,a(1,:))
%xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
title('Esquina 5')

nexttile
plot(t,a(7,:))
%xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
title('Sensor 7')

nexttile
hold on
plot(t,a(1,:))     %Esquina 5
plot(t,a(7,:))      %Sensor 7
xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
legend('Esquina 5', 'Sensor 7')
hold off
title('Comparativa de ambas señales')

figure(2)
tiledlayout(3,1)
nexttile
plot(t,a(3,:))
% xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
title('Esquina 6')

nexttile
plot(t,a(6,:))
% xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
title('Sensor 6')

nexttile
hold on
plot(t,a(3,:))     %Esquina 5
plot(t,a(6,:))      %Sensor 7
xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
legend('Esquina 6', 'Sensor 6')
hold off
title('Comparativa de ambas señales')

figure(3)
tiledlayout(3,1)
nexttile
plot(t,a(2,:))
% xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
title('Esquina 7')

nexttile
plot(t,a(4,:))
% xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
title('Sensor 4')

nexttile
hold on
plot(t,a(2,:))     %Esquina 7
plot(t,a(4,:))      %Sensor 4
xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
legend('Esquina 7', 'Sensor 4')
hold off
title('Comparativa de ambas señales')

figure(4)
tiledlayout(3,1)
nexttile
plot(t,a(8,:))
%xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
title('Esquina 8')

nexttile
plot(t,a(5,:))
%xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
title('Sensor 5')

nexttile
hold on
plot(t,a(8,:))     %Esquina 5
plot(t,a(5,:))      %Sensor 7
xlabel('time (s)')
ylabel('acceleration (g)')
ylim([-10 10])
grid on
legend('Esquina 8', 'Sensor 5')
hold off
title('Comparativa de ambas señales')


%% Plots velocidad/posición
for i=1:8
    v(i,:) = cumtrapz(t,am(i,:));
end
figure(5)
plot(t,v(1,:))      %1 por ejemplo
xlabel('time (s)')
ylabel('velocity (m/s)')
grid on

for j=1:8
    p(j,:) = cumtrapz(t,v(j,:));
end
figure(6)
plot(t,p(1,:))      %1 por ejemplo
xlabel('time (s)')
ylabel('position (m)')
grid on

%% Máximos, mínimos y media

ac = transpose(a); %para poder operar
disp('Aceleraciones máximas')
maxs = max(ac)

disp('Aceleraciones mínimas')
mins = min(ac)
