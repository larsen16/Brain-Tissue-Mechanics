%% Jacob Larsen - Brain Tissue Mechanics %%
% Purpose: Extract, Plot & Detect Peaks of FTIR Data
% Background: Created using data points collected from porcine brains on 03012023 and 03152023.
% 
% Author: Jacob Larsen
% 2 March 2023

% Load legacy plot tools into all figure windows
set(groot,'defaultFigureCreateFcn',@(fig,~)addToolbarExplorationButtons(fig))
set(groot,'defaultAxesCreateFcn',@(ax,~)set(ax.Toolbar,'Visible','off'))

close all
clear
clc

%% Import Signals of Interest

% 1 March 2023
[wavenumber1, absorbance1] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Left_Front_Brain_Grey_Matter_ATR_Pig1_03012023.CSV');
[wavenumber2, absorbance2] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Left_Front_Brain_White_Matter_ATR_Pig1_03012023.CSV');
[wavenumber3, absorbance3] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Left_Mid_Brain_Grey_Matter_ATR_Pig1_03012023.CSV');
[wavenumber4, absorbance4] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Left_Mid_Brain_White_Matter_ATR_Pig1_03012023.CSV');
[wavenumber5, absorbance5] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Left_Rear_Brain_Grey_Matter_ATR_Pig1_03012023.CSV');
[wavenumber6, absorbance6] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Left_Rear_Brain_White_Matter_ATR_Pig1_03012023.CSV');
[wavenumber7, absorbance7] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Left_Right_Front_Grey_Matter_ATR_Pig1_03012023.CSV');
[wavenumber8, absorbance8] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Right_Front_White_Matter_ATR_Pig1_03012023.CSV');
[wavenumber9, absorbance9] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Right_Mid_Grey_Matter_ATR_Pig1_03012023.CSV');
[wavenumber10, absorbance10] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Right_Mid_White_Matter_ATR_Pig1_03012023.CSV');
[wavenumber11, absorbance11] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Right_Rear_Grey_Matter_ATR_Pig1_03012023.CSV');
[wavenumber12, absorbance12] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03012023_Porcine_Brain\Adv_ATR_Correction\Right_Rear_White_Matter_ATR_Pig1_03012023.CSV');

% 15 March 2023
[wavenumber13, absorbance13] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03152023_FTIR_Porcine_Brain\Adv_ATR\Porcine_Brain_Grey3_ATR_03152023.CSV');
[wavenumber14, absorbance14] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03152023_FTIR_Porcine_Brain\Adv_ATR\Porcine_Brain_White3_ATR_03152023.CSV');
[wavenumber15, absorbance15] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03152023_FTIR_Porcine_Brain\Adv_ATR\Porcine_Brain_Grey4_ATR_03152023.CSV');
[wavenumber16, absorbance16] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03152023_FTIR_Porcine_Brain\Adv_ATR\Porcine_Brain_White4_ATR_03152023.CSV');
[wavenumber17, absorbance17] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03152023_FTIR_Porcine_Brain\Adv_ATR\Porcine_Brain_Grey6_ATR_03152023.CSV');
[wavenumber18, absorbance18] = Extract_FTIR_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - FTIR\03152023_FTIR_Porcine_Brain\Adv_ATR\Porcine_Brain_White5_ATR_03152023.CSV');

%% Average FTIR Data %%

% Initialize Arrays
gray_sum = zeros(length(absorbance1), 1);
gray_avg = zeros(length(absorbance1), 1);
white_sum = zeros(length(absorbance1), 1);
white_avg = zeros(length(absorbance1), 1);
NaN_array = [NaN];

% Update Array Size for StD Calculations
new_abs1 = cat(1, absorbance1, NaN_array);
new_abs2 = cat(1, absorbance2, NaN_array);
new_abs3 = cat(1, absorbance3, NaN_array);
new_abs4 = cat(1, absorbance4, NaN_array);
new_abs5 = cat(1, absorbance5, NaN_array);
new_abs6 = cat(1, absorbance6, NaN_array);
new_abs7 = cat(1, absorbance7, NaN_array);
new_abs8 = cat(1, absorbance8, NaN_array);
new_abs9 = cat(1, absorbance9, NaN_array);
new_abs10 = cat(1, absorbance10, NaN_array);
new_abs11 = cat(1, absorbance11, NaN_array);
new_abs12 = cat(1, absorbance12, NaN_array);

% Calculate Averages
for i = 1:length(absorbance1)
    gray_sum(i) = absorbance1(i) + absorbance3(i) + absorbance5(i) + absorbance7(i) + absorbance9(i) + absorbance11(i) + absorbance13(i) + absorbance15(i) + absorbance17(i);
    white_sum(i) = absorbance2(i) + absorbance4(i) + absorbance6(i) + absorbance8(i) + absorbance10(i) + absorbance12(i) + absorbance14(i) + absorbance16(i) + absorbance18(i);
    total = 9;
    gray_avg(i) = gray_sum(i) / total;
    white_avg(i) = white_sum(i) / total;
end

% Calculate Standard Deviations
A = cat(3, new_abs1, new_abs3, new_abs5, new_abs7, new_abs9, new_abs11, absorbance13, absorbance15, absorbance17);
B = cat(3, new_abs2, new_abs4, new_abs6, new_abs8, new_abs10, new_abs12, absorbance14, absorbance16, absorbance18);
gray_stdev = std(A, [], 3, 'omitnan');
white_stdev = std(B, [], 3, 'omitnan');
gray_stdev(end) = [];
white_stdev(end) = [];

%% Plot FTIR Data %%
fsize = 20;

% Full FTIR Spectra
figure(1)
hold on
plot(wavenumber1, absorbance1, 'k', 'Linewidth', 1.5)
plot(wavenumber2, absorbance2, 'r', 'Linewidth', 1.5)
plot(wavenumber3, absorbance3, 'k', 'Linewidth', 1.5)
plot(wavenumber4, absorbance4, 'r', 'Linewidth', 1.5)
plot(wavenumber5, absorbance5, 'k', 'Linewidth', 1.5)
plot(wavenumber6, absorbance6, 'r', 'Linewidth', 1.5)
plot(wavenumber7, absorbance7, 'k', 'Linewidth', 1.5)
plot(wavenumber8, absorbance8, 'r', 'Linewidth', 1.5)
plot(wavenumber9, absorbance9, 'k', 'Linewidth', 1.5)
plot(wavenumber10, absorbance10, 'r', 'Linewidth', 1.5)
plot(wavenumber11, absorbance11, 'k', 'Linewidth', 1.5)
plot(wavenumber12, absorbance12, 'r', 'Linewidth', 1.5)
plot(wavenumber13, absorbance13, 'k', 'Linewidth', 1.5)
plot(wavenumber15, absorbance15, 'k', 'Linewidth', 1.5)
plot(wavenumber16, absorbance16, 'r', 'Linewidth', 1.5)
plot(wavenumber17, absorbance17, 'k', 'Linewidth', 1.5)
plot(wavenumber18, absorbance18, 'r', 'Linewidth', 1.5)
xlabel('Wavenumber (cm ^-^1)')
ylabel ('Absorbance (a.u.)')
title('Full FTIR Spectra (A)')
set(gca, 'xdir', 'reverse', 'TickDir', 'out', 'FontSize', fsize)
set(gcf, 'color', 'white')
[~, hobj, ~, ~] = legend('GM', 'WM');
hl = findobj(hobj,'type','line');
set(hl,'LineWidth', 2);
legend boxoff
hold off

% Focused FTIR Spectra
figure(2)
hold on
plot(wavenumber1, absorbance1, 'k', 'Linewidth', 1.5)
plot(wavenumber2, absorbance2, 'r', 'Linewidth', 1.5)
plot(wavenumber3, absorbance3, 'k', 'Linewidth', 1.5)
plot(wavenumber4, absorbance4, 'r', 'Linewidth', 1.5)
plot(wavenumber5, absorbance5, 'k', 'Linewidth', 1.5)
plot(wavenumber6, absorbance6, 'r', 'Linewidth', 1.5)
plot(wavenumber7, absorbance7, 'k', 'Linewidth', 1.5)
plot(wavenumber8, absorbance8, 'r', 'Linewidth', 1.5)
plot(wavenumber9, absorbance9, 'k', 'Linewidth', 1.5)
plot(wavenumber10, absorbance10, 'r', 'Linewidth', 1.5)
plot(wavenumber11, absorbance11, 'k', 'Linewidth', 1.5)
plot(wavenumber12, absorbance12, 'r', 'Linewidth', 1.5)
plot(wavenumber13, absorbance13, 'k', 'Linewidth', 1.5)
plot(wavenumber15, absorbance15, 'k', 'Linewidth', 1.5)
plot(wavenumber16, absorbance16, 'r', 'Linewidth', 1.5)
plot(wavenumber17, absorbance17, 'k', 'Linewidth', 1.5)
plot(wavenumber18, absorbance18, 'r', 'Linewidth', 1.5)
xlabel('Wavenumber (cm ^-^1)')
xlim([900 3100])
ylabel ('Absorbance (a.u.)')
title('Focused FTIR Spectra (B)')
set(gca, 'xdir', 'reverse', 'TickDir', 'out', 'FontSize', fsize)
set(gcf, 'color', 'white')
[~, hobj, ~, ~] = legend('GM', 'WM');
hl = findobj(hobj,'type','line');
set(hl,'LineWidth', 2);
legend boxoff
hold off

% Mean +/- STD for GM and WM
fsize = 15;
figure(3)
subplot(1,3,1)
hold on
patch([wavenumber1; flip(wavenumber1)], [white_avg + white_stdev;  flip(white_avg - white_stdev)], [0.9 0.5 0.7], 'FaceAlpha', 0.3, 'Linestyle', 'none')
patch([wavenumber1; flip(wavenumber1)], [gray_avg + gray_stdev;  flip(gray_avg - gray_stdev)], [0.8 0.8 0.8], 'FaceAlpha', 0.3, 'Linestyle', 'none')
plot(wavenumber1, gray_avg, 'k', 'Linewidth', 1.5)
plot(wavenumber1, white_avg, 'r', 'Linewidth', 1.5)
xlim([2800 3000])
ylabel ('Absorbance (a.u.)')
set(gca, 'xdir', 'reverse', 'TickDir', 'out', 'FontSize', fsize)
set(gcf, 'color', 'white')
title('Lipid Region')
hold off

subplot(1,3,2)
hold on
patch([wavenumber1; flip(wavenumber1)], [white_avg + white_stdev;  flip(white_avg - white_stdev)], [0.9 0.5 0.7], 'FaceAlpha', 0.3, 'Linestyle', 'none')
patch([wavenumber1; flip(wavenumber1)], [gray_avg + gray_stdev;  flip(gray_avg - gray_stdev)], [0.8 0.8 0.8], 'FaceAlpha', 0.3, 'Linestyle', 'none')
plot(wavenumber1, gray_avg, 'k', 'Linewidth', 1.5)
plot(wavenumber1, white_avg, 'r', 'Linewidth', 1.5)
xlim([1500 1800])
xlabel('Wavenumber (cm ^-^1)')
set(gca, 'xdir', 'reverse', 'TickDir', 'out', 'FontSize', fsize)
set(gcf, 'color', 'white')
title('Protein Region')
hold off

subplot(1,3,3)
hold on
patch([wavenumber1; flip(wavenumber1)], [white_avg + white_stdev;  flip(white_avg - white_stdev)], [0.9 0.5 0.7], 'FaceAlpha', 0.3, 'Linestyle', 'none')
patch([wavenumber1; flip(wavenumber1)], [gray_avg + gray_stdev;  flip(gray_avg - gray_stdev)], [0.8 0.8 0.8], 'FaceAlpha', 0.3, 'Linestyle', 'none')
plot(wavenumber1, gray_avg, 'k', 'Linewidth', 1.5)
plot(wavenumber1, white_avg, 'r', 'Linewidth', 1.5)
xlim([1000 1200])
set(gca, 'xdir', 'reverse', 'TickDir', 'out', 'FontSize', fsize)
set(gcf, 'color', 'white')
title('Carbohydrate Region')
hold off

%% Peak Detection %%

% Detection of Relevant Peaks
[peaks1, peak_wavenumbers1] = PeakDet(absorbance1, wavenumber1, 40, 0.002, 7);
[peaks2, peak_wavenumbers2] = PeakDet(absorbance2, wavenumber2, 40, 0.002, 8);
[peaks3, peak_wavenumbers3] = PeakDet(absorbance3, wavenumber3, 40, 0.002, 9);
[peaks4, peak_wavenumbers4] = PeakDet(absorbance4, wavenumber4, 40, 0.002, 10);
[peaks5, peak_wavenumbers5] = PeakDet(absorbance5, wavenumber5, 40, 0.002, 11);
[peaks6, peak_wavenumbers6] = PeakDet(absorbance6, wavenumber6, 40, 0.002, 12);
[peaks7, peak_wavenumbers7] = PeakDet(absorbance7, wavenumber7, 40, 0.002, 13);
[peaks8, peak_wavenumbers8] = PeakDet(absorbance8, wavenumber8, 40, 0.002, 14);
[peaks9, peak_wavenumbers9] = PeakDet(absorbance9, wavenumber9, 40, 0.002, 15);
[peaks10, peak_wavenumbers10] = PeakDet(absorbance10, wavenumber10, 40, 0.002, 16);
[peaks11, peak_wavenumbers11] = PeakDet(absorbance11, wavenumber11, 40, 0.002, 17);
[peaks12, peak_wavenumbers12] = PeakDet(absorbance12, wavenumber12, 40, 0.002, 18);
[peaks13, peak_wavenumbers13] = PeakDet(absorbance13, wavenumber13, 40, 0.002, 19);
[peaks14, peak_wavenumbers14] = PeakDet(absorbance14, wavenumber14, 40, 0.002, 20);
[peaks15, peak_wavenumbers15] = PeakDet(absorbance15, wavenumber15, 40, 0.002, 21);
[peaks16, peak_wavenumbers16] = PeakDet(absorbance16, wavenumber16, 40, 0.002, 22);
[peaks17, peak_wavenumbers17] = PeakDet(absorbance17, wavenumber17, 40, 0.002, 23);
[peaks18, peak_wavenumbers18] = PeakDet(absorbance18, wavenumber18, 40, 0.002, 24);

%% Statistical Analysis %%

% Initialize Relevant Variables
statdata_2852 = readtable('FTIR_2858_Data.csv', 'Delimiter', ',', 'MultipleDelimsAsOne', true);
statdata_2924 = readtable('FTIR_2924_Data.csv', 'Delimiter', ',', 'MultipleDelimsAsOne', true);
statdata_1650 = readtable('FTIR_1650_Data.csv', 'Delimiter', ',', 'MultipleDelimsAsOne', true);
statdata_1550 = readtable('FTIR_1550_Data.csv', 'Delimiter', ',', 'MultipleDelimsAsOne', true);
statdata_1080 = readtable('FTIR_1080_Data.csv', 'Delimiter', ',', 'MultipleDelimsAsOne', true);
values_2852 = statdata_2852(:,4);
values_2852 = table2array(values_2852);
values_2924 = statdata_2924(:,4);
values_2924 = table2array(values_2924);
values_1650 = statdata_1650(:,4);
values_1650 = table2array(values_1650);
values_1550 = statdata_1550(:,4);
values_1550 = table2array(values_1550);
values_1080 = statdata_1080(:,4);
values_1080 = table2array(values_1080);

% Create Arrays for Analysis
gray_matter_2924 = statdata_2924([1 3 5 7 9 11 13 15 17],4);
gray_matter_2924 = table2array(gray_matter_2924);
white_matter_2924 = statdata_2924([2 4 6 8 10 12 14 16 18],4);
white_matter_2924 = table2array(white_matter_2924);

gray_matter_2852 = statdata_2852([1 3 5 7 9 11 13 15 17],4);
gray_matter_2852 = table2array(gray_matter_2852);
white_matter_2852 = statdata_2852([2 4 6 8 10 12 14 16 18],4);
white_matter_2852 = table2array(white_matter_2852);

gray_matter_1650 = statdata_1650([1 3 5 7 9 11 13 15 17],4);
gray_matter_1650 = table2array(gray_matter_1650);
white_matter_1650 = statdata_1650([2 4 6 8 10 12 14 16 18],4);
white_matter_1650 = table2array(white_matter_1650);

gray_matter_1550 = statdata_1550([1 3 5 7 9 11 13 15 17],4);
gray_matter_1550 = table2array(gray_matter_1550);
white_matter_1550 = statdata_1550([2 4 6 8 10 12 14 16 18],4);
white_matter_1550 = table2array(white_matter_1550);

gray_matter_1080 = statdata_1080([1 3 5 7 9 11 15 17],4);
gray_matter_1080 = table2array(gray_matter_1080);
white_matter_1080 = statdata_1080([2 4 6 8 10 12 16 18],4);
white_matter_1080 = table2array(white_matter_1080);

% Conduct t-tests
[h1,p1,ci1,stats1] = ttest2(gray_matter_2852, white_matter_2852, 'Vartype', 'equal');
[h2,p2,ci2,stats2] = ttest2(gray_matter_2924, white_matter_2924, 'Vartype', 'equal');
[h3,p3,ci3,stats3] = ttest2(gray_matter_1650, white_matter_1650, 'Vartype', 'equal');
[h4,p4,ci4,stats4] = ttest2(gray_matter_1550, white_matter_1550, 'Vartype', 'equal');
[h5,p5,ci5,stats5] = ttest2(gray_matter_1080, white_matter_1080, 'Vartype', 'equal');

% Boxplot for Lipid Region
figure(4)
fsize = 16;
boxplot([gray_matter_2924 white_matter_2924 gray_matter_2852 white_matter_2852], 'Labels', {'GM2924', 'WM2924', 'GM2852', 'WM2852'})
ylabel('Absorbance (a.u.)')
set(gcf, 'color', 'white')
set(gca, 'TickDir', 'out', 'FontSize', fsize)
title('Peaks in the Lipid Region (A)')

% Boxplot for the Protein Region
figure(5)
boxplot([gray_matter_1650, white_matter_1650 gray_matter_1550, white_matter_1550], 'Labels', {'GM1650', 'WM1650', 'GM1550', 'WM1550'})
ylabel('Absorbance (a.u.)')
set(gcf, 'color', 'white')
set(gca, 'TickDir', 'out', 'FontSize', fsize)
title('Peaks in the Protein Region (B)')

% Boxplot for the Carbohydrate Region
figure(6)
boxplot([gray_matter_1080, white_matter_1080], 'Labels', {'GM1080', 'WM1080'})
ylabel('Absorbance (a.u.)')
set(gcf, 'color', 'white')
set(gca, 'TickDir', 'out', 'FontSize', fsize)
title('Peaks in the Carbohydrate Region (C)')
