clear, clc
% =========================================================
%                      Project 1 - Part A
% =========================================================

% ================================
% 1st: Time Axis Generation
% ================================
numPoints = 100e3;
timeEnd = 600e-3;
timePointEvery = timeEnd / (numPoints - 1);
timeAxis = linspace(0, timeEnd, numPoints);

timeCutoff = 10e-3;
mask = timeAxis <= timeCutoff;

% ================================
% 2nd: m1(t) Generation:
% ================================

% Define parameters
% ================================
fm1 = 1e3;

m1TimeShift = 0.5e-3;
m1TimeAxis = timeAxis - m1TimeShift; 
Am1 = 1;
m1 = Am1 * sawtooth(2 * pi * fm1 * m1TimeAxis, 0);

% Plot the signal
% ================================
figure;
plot(timeAxis(mask), m1(mask));
title('Part A - m1(t) Graph');
xlabel('Time (sec)');
ylabel('m1(t)');
grid on;
m1numberPointXaxis = 11;
xticks(linspace(0, timeCutoff, m1numberPointXaxis));

% ================================
% 3rd: m2(t) Generation
% ================================

% Define parameters
% ================================
m2TimePeriod = 2e-3;
sectionPerCycle = 4;
fm2 = 1 / m2TimePeriod;

Am2 = 1;
possiValues = [0, 0.5, 1.5, 2];

cycleTimePerSection = m2TimePeriod / sectionPerCycle;
transitionTotal = ceil(timeEnd / cycleTimePerSection);

% Generate amplitude transitions
sectionsValues = zeros(1, transitionTotal);
for n = 1:transitionTotal
    sectionsValues(n) = Am2 - possiValues(mod(n-1, sectionPerCycle) + 1);
end

% Expand signal with repeated points per section
timePoinsPerSection = round(cycleTimePerSection / timePointEvery);
m2Expanded = repelem(sectionsValues, timePoinsPerSection);

% Ensure m2 has the same length as timeAxis
if length(m2Expanded) < length(timeAxis)
    m2 = [m2Expanded, repmat(m2Expanded(end), 1, length(timeAxis) - length(m2Expanded))];
elseif length(m2Expanded) > length(timeAxis)
    m2 = m2Expanded(1:length(timeAxis));
else
    m2 = m2Expanded;
end

% Plot the signal
% ================================
figure;
plot(timeAxis(mask), m2(mask));
title('Part A - m2(t) Graph');
xlabel('Time (sec)');
ylabel('m2(t)');
grid on;
m2numberPointXaxis = 5;
xticks(linspace(0, timeCutoff, m2numberPointXaxis));

% ================================
% 4th: s(t) Generation
% ================================

% Define parameters
Ac = 5;
fc = 5e3;

% Generate modulated signal
s = Ac * m1 .* cos(2 * pi * fc * timeAxis) + Ac * m2 .* sin(2 * pi * fc * timeAxis);

% Plot the modulated signal
figure;
plot(timeAxis(mask), s(mask));
title('s(t) - QAM Modulated Signal');
xlabel('Time (sec)');
ylabel('s(t)');
grid on;

% ================================
% 5th: QAM Receiver.
% ================================

% Demodulation using coherent detection
m1_extracted = (2/Ac) * s .* cos(2 * pi * fc * timeAxis);
m2_extracted = (2/Ac) * s .* sin(2 * pi * fc * timeAxis);

% Low-pass filter to remove high-frequency components
fc_LPF = fc/10;
Fs = 1/timePointEvery;

m1_extracted = lowpass(m1_extracted,fc_LPF,Fs);
m2_extracted = lowpass(m2_extracted,fc_LPF,Fs);

% Plot extracted signals
figure;
plot(timeAxis(mask), m1_extracted(mask));
title('Extracted m1(t)');
xlabel('Time (sec)');
ylabel('m1(t)');
grid on;

figure;
plot(timeAxis(mask), m2_extracted(mask));
title('Extracted m2(t)');
xlabel('Time (sec)');
ylabel('m2(t)');
grid on;

% ================================
% 6th: Effect of Phase and Frequency Shift
% ================================

% Case 1: Receiver carrier phase shift (pi/3)
s_phase_shifted = Ac * m1 .* cos(2 * pi * fc * timeAxis + pi/3) + Ac * m2 .* sin(2 * pi * fc * timeAxis + pi/3);

m1_extracted_phase = (2/Ac) * s_phase_shifted .* cos(2 * pi * fc * timeAxis);
m2_extracted_phase = (2/Ac) * s_phase_shifted .* sin(2 * pi * fc * timeAxis);

m1_extracted_phase = lowpass(m1_extracted_phase,fc_LPF,Fs);
m2_extracted_phase = lowpass(m2_extracted_phase,fc_LPF,Fs);

figure;
plot(timeAxis(mask), m1_extracted_phase(mask));
title('Extracted m1(t) with Phase Shift');
xlabel('Time (sec)');
ylabel('m1(t)');
grid on;

figure;
plot(timeAxis(mask), m2_extracted_phase(mask));
title('Extracted m2(t) with Phase Shift');
xlabel('Time (sec)');
ylabel('m2(t)');
grid on;

% Case 2: Receiver frequency shift (2.02 * fc)
s_freq_shifted = Ac * m1 .* cos(2 * pi * 2.02 * fc * timeAxis) + Ac * m2 .* sin(2 * pi * 2.02 * fc * timeAxis);


m1_extracted_freq = (2/Ac) * s_freq_shifted .* cos(2 * pi * fc * timeAxis);
m2_extracted_freq = (2/Ac) * s_freq_shifted .* sin(2 * pi * fc * timeAxis);


m1_extracted_freq = lowpass(m1_extracted_freq,fc_LPF*2,Fs);
m2_extracted_freq = lowpass(m2_extracted_freq,fc_LPF*2,Fs);

figure;
plot(timeAxis(mask), m1_extracted_freq(mask));
title('Extracted m1(t) with Frequency Shift');
xlabel('Time (sec)');
ylabel('m1(t)');
grid on;

figure;
plot(timeAxis(mask), m2_extracted_freq(mask));
title('Extracted m2(t) with Frequency Shift');
xlabel('Time (sec)');
ylabel('m2(t)');
grid on;

