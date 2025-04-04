%PART B
%PART B.1__Phase Modulation
%Define carrier signal constants
Ac = 1;
fc = 1e4;                          
%Define Modulation indeces
modindex = [0.05, 1, 5, 10];
%Define time axis parameters (take into consideration Nyquist theorem)
N1 = 100000;                        
Fs = 1e5;                          
T = (N1 - 1) / Fs;                  
t_PM = 0 : 1/Fs : T;
%Plot each of the Phase modulated signals 
figure;
for kp = 1:length(modindex)
    ind = modindex(kp);
    PM = Ac * cos(2*pi*fc*t_PM + ind * m1);
    subplot(4, 1, kp);
    plot(t_PM(1:1000), PM(1:1000));
    title(['PM Signal with Modulation Index = ', num2str(ind)]);
    xlabel('Time (s)');
    ylabel('Amplitude (V)');
end

%PART B.2__Frequency Modulation

% Time for m1
N1 = 100000;
Fs1 = 1e5;
T1 = (N1 - 1) / Fs1;
t1 = 0:1/Fs1:T1;

% Time for m2
N2 = 6000;
Fs2 = 1e5;
T2 = (N2 - 1) / Fs2;
t2 = 0:1/Fs2:T2;

%FM signal using m1(t)
kf1 = 2000;
int_m1 = cumtrapz(t1, m1);
FM1 = Ac * cos(2*pi*fc*t1 + kf1 * int_m1);

% FM signal using m2(t)
kf2 = 1000;
int_m2 = cumtrapz(t2, m2Complete);
FM2 = Ac * cos(2*pi*fc*t2 + kf2 * int_m2);

figure;
plot(t1(1:1000), FM1(1:1000));
title('Frequency Modulated signal s3(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

figure;
plot(t1(1:1000), FM2(1:1000));
title('Frequency Modulated signal s2(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

%Plotting for illustration (m1(t) & s1(t))
figure;
subplot(3,1,1);
plot(t1(1:1000), m1(1:1000));
title('Message Signal m1(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

subplot(3,1,2);
plot(t1(1:1000), int_m1(1:1000));
title('Integral of m1(t)');
xlabel('Time (s)');
ylabel('Integral Value');
grid on;

subplot(3,1,3);
plot(t1(1:1000), FM1(1:1000));
title('Frequency Modulated signal s3(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

% Plotting for illustration (m2(t) % s2(t))
figure;
subplot(3,1,1);
plot(t2(1:2000), m2Complete(1:2000));
title('Message Signal m2(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

subplot(3,1,2);
plot(t2(1:2000), int_m2(1:2000));
title('Integral of m2(t)');
xlabel('Time (s)');
ylabel('Integral Value');
grid on;

subplot(3,1,3);
plot(t1(1:2000), FM2(1:2000));
title('Frequency Modulated signal s2(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;