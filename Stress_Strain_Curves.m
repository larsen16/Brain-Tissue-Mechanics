%% Jacob Larsen - Brain Tissue Mechanics %%
% Purpose: To calculate the stress and strain responses of GM, WM, and G-WM to high strain unconfined compressive loadings
% Background: Code writted using stress-relaxation data collected on 03152023 and 03222023
% 
% Author: Jacob Larsen
% 17 March 2023 (Updated 03232023)

% Load legacy plot tools into all figure windows
set(groot,'defaultFigureCreateFcn',@(fig,~)addToolbarExplorationButtons(fig))
set(groot,'defaultAxesCreateFcn',@(ax,~)set(ax.Toolbar,'Visible','off'))

close all
clear
clc

%% Import Signals of Interest

[time1, z_pos1, x_pos1, force1] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_White_Grey1_SR1_03152023.txt');
[time2, z_pos2, x_pos2, force2] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_White_SR2_03152023.txt');
[time5, z_pos5, x_pos5, force5] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_White_Grey_SR5_03152023.txt');
[time6, z_pos6, x_pos6, force6] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_White_SR6_03152023.txt');
[time7, z_pos7, x_pos7, force7] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_Grey_SR7_03152023.txt');
[time8, z_pos8, x_pos8, force8] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_White_SR8_03152023.txt');
[time9, z_pos9, x_pos9, force9] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_White_Grey_SR9_03152023.txt');
[time10, z_pos10, x_pos10, force10] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_White_Grey_SR10_03152023.txt');
[time11, z_pos11, x_pos11, force11] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_White_Grey_SR11_03152023.txt');
[time12, z_pos12, x_pos12, force12] = Extract_Data('C:\Users\jacob\OneDrive - purdue.edu\Purdue University\Spring 2023\Research\HIRRT\Spring 2023\Pig - SR\Porcine_Brain_03152023_SR\Porcine_Brain_Grey_SR12_03152023.txt');

%% Stress-Strain Calculations - Preparation

% Initialize Stress Arrays
stress1 = [size(force1), 1];
stress2 = [size(force2), 1];
stress5 = [size(force5), 1];
stress6 = [size(force6), 1];
stress7 = [size(force7), 1];
stress8 = [size(force8), 1];
stress9 = [size(force9), 1];
stress10 = [size(force10), 1];
stress11 = [size(force11), 1];
stress12 = [size(force12), 1];

% Initialize Strain Arrays
strain1 = [size(force1), 1];
strain2 = [size(force2), 1];
strain5 = [size(force5), 1];
strain6 = [size(force6), 1];
strain7 = [size(force7), 1];
strain8 = [size(force8), 1];
strain9 = [size(force9), 1];
strain10 = [size(force10), 1];
strain11 = [size(force11), 1];
strain12 = [size(force12), 1];

% Update Force Values (gf to N)
force1 = force1 .* 0.00980665;
force2 = force2 .* 0.00980665;
force5 = force5 .* 0.00980665;
force6 = force6 .* 0.00980665;
force7 = force7 .* 0.00980665;
force8 = force8 .* 0.00980665;
force9 = force9 .* 0.00980665;
force10 = force10 .* 0.00980665;
force11 = force11 .* 0.00980665;
force12 = force12 .* 0.00980665;


%% Cross-Sectional Area Calculations

% Initialize Diameter (mm) OR Length/Width (mm) Values
sample_diameter1 = 6.7;
sample_length2 = 8.8;
sample_width2 = 8.4;
sample_diameter5 = 7.7;
sample_length6 = 7.9;
sample_width6 = 6.8;
sample_diameter7 = 9.2;
sample_length8 = 10.4;
sample_width8 = 5.7;
sample_diameter9 = 3.6;
sample_length10 = 13.3;
sample_width10 = 6.8;
sample_length11 = 11.1;
sample_width11 = 7.7;
sample_length12 = 10.1;
sample_width12 = 6.2;

% Initialize Thickness Values (mm)
sample_thickness1 = 6.8;
sample_thickness2 = 3.8;
sample_thickness5 = 7.6;
sample_thickness6 = 4.4;
sample_thickness7 = 4.3;
sample_thickness8 = 4.1;
sample_thickness9 = 6.4;
sample_thickness10 = 5.9;
sample_thickness11 = 4.8;
sample_thickness12 = 3.9;

% Calculate Cross-Sectional Area (mm^2)
cross_area1 = pi * ((sample_diameter1 / 2)^2);
cross_area2 = sample_length2 * sample_width2;
cross_area5 = pi * ((sample_diameter5 / 2)^2);
cross_area6 = sample_length6 * sample_width6;
cross_area7 = pi * ((sample_diameter7 / 2)^2);
cross_area8 = sample_length8 * sample_width8;
cross_area9 = pi * ((sample_diameter9 / 2)^2);
cross_area10 = sample_length10 * sample_width10;
cross_area11 = sample_length11 * sample_width11;
cross_area12 = sample_length12 * sample_width12;

%% Stress & Strain Calculations %%

% Sample 1
for i1 = 1:size(force1)
    stress1(i1) = (force1(i1) / cross_area1) * 1000;
    strain1(i1) = z_pos1(i1) / sample_thickness1 * 100;
end

% Sample 2
for i2 = 1:size(force2)
    stress2(i2) = force2(i2) / cross_area2 * 1000;
    strain2(i2) = z_pos2(i2) / sample_thickness2 * 100;
end

% Sample 5
for i5 = 1:size(force5)
    stress5(i5) = force5(i5) / cross_area5 * 1000;
    strain5(i5) = z_pos5(i5) / sample_thickness5 * 100;
end

% Sample 6
for i6 = 1:size(force6)
    stress6(i6) = force6(i6) / cross_area6 * 1000;
    strain6(i6) = z_pos6(i6) / sample_thickness6 * 100;
end

% Sample 7
for i7 = 1:size(force7)
    stress7(i7) = force7(i7) / cross_area7 * 1000;
    strain7(i7) = z_pos7(i7) / sample_thickness7 * 100;
end

% Sample 8
for i8 = 1:size(force8)
    stress8(i8) = force8(i8) / cross_area8 * 1000;
    strain8(i8) = z_pos8(i8) / sample_thickness8 * 100;
end

% Sample 9
for i9 = 1:size(force9)
    stress9(i9) = force9(i9) / cross_area9 * 1000;
    strain9(i9) = z_pos9(i9) / sample_thickness9 * 100;
end

% Sample 10
for i10 = 1:size(force10)
    stress10(i10) = force10(i10) / cross_area10 * 1000;
    strain10(i10) = z_pos10(i10) / sample_thickness10 * 100;
end

% Sample 11
for i11 = 1:size(force11)
    stress11(i11) = force11(i11) / cross_area11 * 1000;
    strain11(i11) = z_pos11(i11) / sample_thickness11 * 100;
end

% Sample 12
for i12 = 1:size(force12)
    stress12(i12) = force12(i12) / cross_area12 * 1000;
    strain12(i12) = z_pos12(i12) / sample_thickness12 * 100;
end

%% Plot Results %%

% Plot data
fsize = 20;
figure(1)
hold on
plot(time1, strain1, 'b', 'LineWidth', 1.5)
plot(time2, strain2, 'r', 'LineWidth', 1.5)
plot(time7, strain7, 'k', 'LineWidth', 1.5)
plot(time5, strain5, 'b', 'LineWidth', 1.5)
plot(time6, strain6, 'r', 'LineWidth', 1.5)
plot(time8, strain8, 'r', 'LineWidth', 1.5)
plot(time9, strain9, 'b', 'LineWidth', 1.5)
plot(time10, strain10, 'r', 'LineWidth', 1.5)
plot(time11, strain11, 'k', 'LineWidth', 1.5)
plot(time12, strain12, 'k', 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel ('Nominal Strain (%)')
title('Strain vs Time')
set(gca, 'TickDir', 'out', 'FontSize', fsize)
set(gcf, 'color', 'white')
[~, hobj, ~, ~] = legend('G-WM', 'WM', 'GM', 'Location', 'northeast');
hl = findobj(hobj,'type','line');
set(hl,'LineWidth', 2);
hold off

figure(2)
hold on
plot(time1, stress1, 'b', 'LineWidth', 1.5)
plot(time2, stress2, 'r', 'LineWidth', 1.5)
plot(time7, stress7, 'k', 'LineWidth', 1.5)
plot(time5, stress5, 'b', 'LineWidth', 1.5)
plot(time6, stress6, 'r', 'LineWidth', 1.5)
plot(time8, stress8, 'r', 'LineWidth', 1.5)
plot(time9, stress9, 'b', 'LineWidth', 1.5)
plot(time10, stress10, 'r', 'LineWidth', 1.5)
plot(time11, stress11, 'k', 'LineWidth', 1.5)
plot(time12, stress12, 'k', 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel ('Nominal Stress (kPa)')
title('Stress vs Time')
legend('G-WM', 'WM', 'GM', 'location', 'northeast')
set(gcf, 'color', 'white')
set(gca, 'TickDir', 'out', 'FontSize', fsize)
[~, hobj, ~, ~] = legend('G-WM', 'WM', 'GM', 'Location', 'northeast');
hl = findobj(hobj,'type','line');
set(hl,'LineWidth', 2);
hold off

figure(3)
hold on
plot(strain1, stress1, 'b')
plot(strain2, stress2, 'r')
plot(strain7, stress7, 'k')
plot(strain5, stress5, 'b')
plot(strain6, stress6, 'r')
plot(strain8, stress8, 'r')
plot(strain9, stress9, 'b')
plot(strain10, stress10, 'r')
plot(strain11, stress11, 'b')
plot(strain12, stress12, 'k')
xlabel('Strain (%)')
ylabel ('Stress (kPa)')
title('Stress vs Strain (C)')
legend('Gray-White', 'White', 'Gray', 'location', 'northwest')
set(gca, 'TickDir', 'out', 'FontSize', fsize)
set(gcf, 'color', 'white')
hold off

%% Maximum Peak Achieved Calculations

% Maximum Stress Achieved
max1 = max(stress1);
max2 = max(stress2);
max5 = max(stress5);
max6 = max(stress6);
max7 = max(stress7);
max8 = max(stress8);
max9 = max(stress9);
max10 = max(stress10);
max11 = max(stress11);
max12 = max(stress12);

% Create New Arrays
gray_max = [max7; max11; max12];
gray_white_max = [max1; max5; max9];
white_max = [max2; max6; max8; max10];

% Calculate Means
mean_gray_max = mean(gray_max);
mean_gray_white_max = mean(gray_white_max);
mean_white_max = mean(white_max);

% Calculate SDs
gray_max_SD = std(gray_max, [], 1, 'omitnan');
gray_white_max_SD = std(gray_white_max, [], 1, 'omitnan');
white_max_SD = std(white_max, [], 1, 'omitnan');

[h1,p1,ci1,stats1] = ttest2(gray_max, white_max, 'Vartype', 'equal');
[h2,p2,ci2,stats2] = ttest2(gray_max, gray_white_max, 'Vartype', 'equal');
[h3,p3,ci3,stats3] = ttest2(gray_white_max, white_max, 'Vartype', 'equal');

%% Tangent Moduli Calculations

% Initialize Arrays
E1 = zeros(10,1);
E2 = zeros(10,1);
E3 = zeros(10,1);

% Find indices of interest
strain1_40 = find(strain1 >= 39.5, 1, 'first');
strain1_50 = find(strain1 >= 49.5, 1, 'first');
strain1_60 = find(strain1 >= 59.5, 1, 'first');
strain1_70 = find(strain1 >= 69.5, 1, 'first');

strain2_40 = find(strain2 >= 39.5, 1, 'first');
strain2_50 = find(strain2 >= 49.5, 1, 'first');
strain2_60 = find(strain2 >= 59.5, 1, 'first');
strain2_70 = find(strain2 >= 69.5, 1, 'first');

strain5_40 = find(strain5 >= 39.5, 1, 'first');
strain5_50 = find(strain5 >= 49.5, 1, 'first');
strain5_60 = find(strain5 >= 59.5, 1, 'first');
strain5_70 = find(strain5 >= 69.5, 1, 'first');

strain6_40 = find(strain6 >= 39.5, 1, 'first');
strain6_50 = find(strain6 >= 49.5, 1, 'first');
strain6_60 = find(strain6 >= 59.5, 1, 'first');
strain6_70 = find(strain6 >= 69.5, 1, 'first');

strain7_40 = find(strain7 >= 39.5, 1, 'first');
strain7_50 = find(strain7 >= 49.5, 1, 'first');
strain7_60 = find(strain7 >= 59.5, 1, 'first');
strain7_70 = find(strain7 >= 69.5, 1, 'first');

strain8_40 = find(strain8 >= 39.5, 1, 'first');
strain8_50 = find(strain8 >= 49.5, 1, 'first');
strain8_60 = find(strain8 >= 59.5, 1, 'first');
strain8_70 = find(strain8 >= 69.5, 1, 'first');

strain9_40 = find(strain9 >= 39.5, 1, 'first');
strain9_50 = find(strain9 >= 49.5, 1, 'first');
strain9_60 = find(strain9 >= 59.5, 1, 'first');
strain9_70 = find(strain9 >= 69.5, 1, 'first');

strain10_40 = find(strain10 >= 39.5, 1, 'first');
strain10_50 = find(strain10 >= 49.5, 1, 'first');
strain10_60 = find(strain10 >= 59.5, 1, 'first');
strain10_70 = find(strain10 >= 69.5, 1, 'first');

strain11_40 = find(strain11 >= 39.5, 1, 'first');
strain11_50 = find(strain11 >= 49.5, 1, 'first');
strain11_60 = find(strain11 >= 59.5, 1, 'first');
strain11_70 = find(strain11 >= 69.5, 1, 'first');

strain12_40 = find(strain12 >= 39.5, 1, 'first');
strain12_50 = find(strain12 >= 49.5, 1, 'first');
strain12_60 = find(strain12 >= 59.5, 1, 'first');
strain12_70 = find(strain12 >= 69.5, 1, 'first');

% Modulus Calculations
E1_1 = polyfit(strain1(strain1_40:strain1_50), stress1(strain1_40:strain1_50), 1); 
E2_1 = polyfit(strain1(strain1_50:strain1_60), stress1(strain1_50:strain1_60), 1); 
E3_1 = polyfit(strain1(strain1_60:strain1_70), stress1(strain1_60:strain1_70), 1); 

E1_2 = polyfit(strain2(strain2_40:strain2_50), stress2(strain2_40:strain2_50), 1); 
E2_2 = polyfit(strain2(strain2_50:strain2_60), stress2(strain2_50:strain2_60), 1); 
E3_2 = polyfit(strain2(strain2_60:strain2_70), stress2(strain2_60:strain2_70), 1);

E1_3 = polyfit(strain5(strain5_40:strain5_50), stress5(strain5_40:strain5_50), 1); 
E2_3 = polyfit(strain5(strain5_50:strain5_60), stress5(strain5_50:strain5_60), 1); 
E3_3 = polyfit(strain5(strain5_60:strain5_70), stress5(strain5_60:strain5_70), 1);

E1_4 = polyfit(strain6(strain6_40:strain6_50), stress6(strain6_40:strain6_50), 1); 
E2_4 = polyfit(strain6(strain6_50:strain6_60), stress6(strain6_50:strain6_60), 1); 
E3_4 = polyfit(strain6(strain6_60:strain6_70), stress6(strain6_60:strain6_70), 1);

E1_5 = polyfit(strain7(strain7_40:strain7_50), stress7(strain7_40:strain7_50), 1); 
E2_5 = polyfit(strain7(strain7_50:strain7_60), stress7(strain7_50:strain7_60), 1); 
E3_5 = polyfit(strain7(strain7_60:strain7_70), stress7(strain7_60:strain7_70), 1);

E1_6 = polyfit(strain8(strain8_40:strain8_50), stress8(strain8_40:strain8_50), 1); 
E2_6 = polyfit(strain8(strain8_50:strain8_60), stress8(strain8_50:strain8_60), 1); 
E3_6 = polyfit(strain8(strain8_60:strain8_70), stress8(strain8_60:strain8_70), 1);

E1_7 = polyfit(strain9(strain9_40:strain9_50), stress9(strain9_40:strain9_50), 1); 
E2_7 = polyfit(strain9(strain9_50:strain9_60), stress9(strain9_50:strain9_60), 1); 
E3_7 = polyfit(strain9(strain9_60:strain9_70), stress9(strain9_60:strain9_70), 1);

E1_8 = polyfit(strain10(strain10_40:strain10_50), stress10(strain10_40:strain10_50), 1); 
E2_8 = polyfit(strain10(strain10_50:strain10_60), stress10(strain10_50:strain10_60), 1); 
E3_8 = polyfit(strain10(strain10_60:strain10_70), stress10(strain10_60:strain10_70), 1); 

E1_9 = polyfit(strain11(strain11_40:strain11_50), stress11(strain11_40:strain11_50), 1); 
E2_9 = polyfit(strain11(strain11_50:strain11_60), stress11(strain11_50:strain11_60), 1); 
E3_9 = polyfit(strain11(strain11_60:strain11_70), stress11(strain11_60:strain11_70), 1);

E1_10 = polyfit(strain12(strain12_40:strain12_50), stress12(strain12_40:strain12_50), 1); 
E2_10 = polyfit(strain12(strain12_50:strain12_60), stress12(strain12_50:strain12_60), 1); 
E3_10 = polyfit(strain12(strain12_60:strain12_70), stress12(strain12_60:strain12_70), 1);

E1(1) = E1_1(1);
E2(1) = E2_1(1);
E3(1) = E3_1(1);

E1(2) = E1_2(1);
E2(2) = E2_2(1);
E3(2) = E3_2(1);

E1(3) = E1_3(1);
E2(3) = E2_3(1);
E3(3) = E3_3(1);

E1(4) = E1_4(1);
E2(4) = E2_4(1);
E3(4) = E3_4(1);

E1(5) = E1_5(1);
E2(5) = E2_5(1);
E3(5) = E3_5(1);

E1(6) = E1_6(1);
E2(6) = E2_6(1);
E3(6) = E3_6(1);

E1(7) = E1_7(1);
E2(7) = E2_7(1);
E3(7) = E3_7(1);

E1(8) = E1_8(1);
E2(8) = E2_8(1);
E3(8) = E3_8(1);

E1(9) = E1_9(1);
E2(9) = E2_9(1);
E3(9) = E3_9(1);

E1(10) = E1_10(1);
E2(10) = E2_10(1);
E3(10) = E3_10(1);

% Create New Arrays
gray_E1 = [E1(5); E1(9); E1(10)];
gray_E2 = [E2(5); E2(9); E2(10)];
gray_E3 = [E3(5); E3(9); E3(10)];

gw_E1 = [E1(1); E1(3); E1(7)];
gw_E2 = [E2(1); E2(3); E2(7)];
gw_E3 = [E3(1); E3(3); E3(7)];

white_E1 = [E1(2); E1(4); E1(6); E1(8)];
white_E2 = [E2(2); E2(4); E2(6); E2(8)];
white_E3 = [E3(2); E3(4); E3(6); E3(8)];

% Calculate Means
mean_gray_E1 = mean(gray_E1);
mean_gray_E2 = mean(gray_E2);
mean_gray_E3 = mean(gray_E3);
mean_gw_E1 = mean(gw_E1);
mean_gw_E2 = mean(gw_E2);
mean_gw_E3 = mean(gw_E3);
mean_white_E1 = mean(white_E1);
mean_white_E2 = mean(white_E2);
mean_white_E3 = mean(white_E3);

% Calculate SDs
gray_E1_SD = std(gray_E1, [], 1, 'omitnan');
gray_E2_SD = std(gray_E2, [], 1, 'omitnan');
gray_E3_SD = std(gray_E3, [], 1, 'omitnan');
gw_E1_SD = std(gw_E1, [], 1, 'omitnan');
gw_E2_SD = std(gw_E2, [], 1, 'omitnan');
gw_E3_SD = std(gw_E3, [], 1, 'omitnan');
white_E1_SD = std(white_E1, [], 1, 'omitnan');
white_E2_SD = std(white_E2, [], 1, 'omitnan');
white_E3_SD = std(white_E3, [], 1, 'omitnan');

% Statistical Analysis for Tangent Moduli
[h4,p4,ci4,stats4] = ttest2(gray_E1, white_E1, 'Vartype', 'equal');
[h5,p5,ci5,stats5] = ttest2(gray_E1, gw_E1, 'Vartype', 'equal');
[h6,p6,ci6,stats6] = ttest2(gw_E1, white_E1, 'Vartype', 'equal');

[h7,p7,ci7,stats7] = ttest2(gray_E2, white_E2, 'Vartype', 'equal');
[h8,p8,ci8,stats8] = ttest2(gray_E2, gw_E2, 'Vartype', 'equal');
[h9,p9,ci9,stats9] = ttest2(gw_E2, white_E2, 'Vartype', 'equal');

[h10,p10,ci10,stats10] = ttest2(gray_E3, white_E3, 'Vartype', 'equal');
[h11,p11,ci11,stats11] = ttest2(gray_E3, gw_E3, 'Vartype', 'equal');
[h12,p12,ci12,stats12] = ttest2(gw_E3, white_E3, 'Vartype', 'equal');

%% Strain @ 10% of Max Stress %%

% Find 10% of Maximum Stress
max1_10 = max1 * 0.1;
max2_10 = max2 * 0.1;
max5_10 = max5 * 0.1;
max6_10 = max6 * 0.1;
max7_10 = max7 * 0.1;
max8_10 = max8 * 0.1;
max9_10 = max9 * 0.1;
max10_10 = max10 * 0.1;
max11_10 = max11 * 0.1;
max12_10 = max12 * 0.1;

% Find Strain at 10% of Maximum Stress
strain1_10index = find(stress1 > max1_10, 1, 'first');
strain1_10 = strain1(strain1_10index);
strain2_10index = find(stress2 > max2_10, 1, 'first');
strain2_10 = strain2(strain2_10index);
strain5_10index = find(stress5 > max5_10, 1, 'first');
strain5_10 = strain5(strain5_10index);
strain6_10index = find(stress6 > max6_10, 1, 'first');
strain6_10 = strain6(strain6_10index);
strain7_10index = find(stress7 > max7_10, 1, 'first');
strain7_10 = strain7(strain7_10index);
strain8_10index = find(stress8 > max8_10, 1, 'first');
strain8_10 = strain8(strain8_10index);
strain9_10index = find(stress9 > max9_10, 1, 'first');
strain9_10 = strain9(strain9_10index);
strain10_10index = find(stress10 > max10_10, 1, 'first');
strain10_10 = strain10(strain10_10index);
strain11_10index = find(stress11 > max11_10, 1, 'first');
strain11_10 = strain11(strain11_10index);
strain12_10index = find(stress12 > max12_10, 1, 'first');
strain12_10 = strain12(strain12_10index);

% Create Arrays
gray_10 = [strain7_10; strain11_10; strain12_10];
gw_10 = [strain1_10; strain5_10; strain9_10];
white_10 = [strain2_10; strain6_10; strain8_10; strain10_10];

% Calculate Means
mean_gray_10 = mean(gray_10);
mean_gw_10 = mean(gw_10); 
mean_white_10 = mean(white_10);

% Calculate SDs
gray_10_SD = std(gray_10, [], 1, 'omitnan');
gw_10_SD = std(gw_10, [], 1, 'omitnan');
white_10_SD = std(white_10, [], 1, 'omitnan');

% Statistical Analysis of Strain @ 10% of Max Stress
[h13,p13,ci13,stats13] = ttest2(gray_10, white_10, 'Vartype', 'equal');
[h14,p14,ci14,stats14] = ttest2(gray_10, gw_10, 'Vartype', 'equal');
[h15,p15,ci15,stats15] = ttest2(gw_10, white_10, 'Vartype', 'equal');

%% Stress Strain Curves

% Find the Index at the Maximum Stress Achieved
max1_index = find(stress1 == max1, 1, 'first');
max2_index = find(stress2 == max2, 1, 'first');
max5_index = find(stress5 == max5, 1, 'first');
max6_index = find(stress6 == max6, 1, 'first');
max7_index = find(stress7 == max7, 1, 'first');
max8_index = find(stress8 == max8, 1, 'first');
max9_index = find(stress9 == max9, 1, 'first');
max10_index = find(stress10 == max10, 1, 'first');
max11_index = find(stress11 == max11, 1, 'first');
max12_index = find(stress12 == max12, 1, 'first');

% Determine Stress adn Strain until Maximum was Reached
for i1 = 1:max1_index
    ss_stress1(i1) = stress1(i1);
    ss_strain1(i1) = strain1(i1);
end

for i2 = 1:max2_index
    ss_stress2(i2) = stress2(i2);
    ss_strain2(i2) = strain2(i2);
end

for i5 = 1:max5_index
    ss_stress5(i5) = stress1(i5);
    ss_strain5(i5) = strain1(i5);
end

for i6 = 1:max6_index
    ss_stress6(i6) = stress6(i6);
    ss_strain6(i6) = strain6(i6);
end

for i7 = 1:max7_index
    ss_stress7(i7) = stress7(i7);
    ss_strain7(i7) = strain7(i7);
end

for i8 = 1:max8_index
    ss_stress8(i8) = stress8(i8);
    ss_strain8(i8) = strain8(i8);
end

for i9 = 1:max9_index
    ss_stress9(i9) = stress9(i9);
    ss_strain9(i9) = strain9(i9);
end

for i10 = 1:max10_index
    ss_stress10(i10) = stress10(i10);
    ss_strain10(i10) = strain10(i10);
end

for i11 = 1:max11_index
    ss_stress11(i11) = stress11(i11);
    ss_strain11(i11) = strain11(i11);
end

for i12 = 1:max12_index
    ss_stress12(i12) = stress12(i12);
    ss_strain12(i12) = strain12(i12);
end

%% Mean +/- SD for Stress-Strain Curves

% Transpose Arrays
ss_strain1 = transpose(ss_strain1);
ss_stress1 = transpose(ss_stress1);
ss_strain2 = transpose(ss_strain2);
ss_stress2 = transpose(ss_stress2);
ss_strain5 = transpose(ss_strain5);
ss_stress5 = transpose(ss_stress5);
ss_strain6 = transpose(ss_strain6);
ss_stress6 = transpose(ss_stress6);
ss_strain7 = transpose(ss_strain7);
ss_stress7 = transpose(ss_stress7);
ss_strain8 = transpose(ss_strain8);
ss_stress8 = transpose(ss_stress8);
ss_strain9 = transpose(ss_strain9);
ss_stress9 = transpose(ss_stress9);
ss_strain10 = transpose(ss_strain10);
ss_stress10 = transpose(ss_stress10);
ss_strain11 = transpose(ss_strain11);
ss_stress11 = transpose(ss_stress11);
ss_strain12 = transpose(ss_strain12);
ss_stress12 = transpose(ss_stress12);

% Create Arrays
mean_ss_gray = zeros(length(ss_strain7), 1);
mean_ss_gw = zeros(length(ss_strain1), 1);
mean_ss_white = zeros(length(ss_strain2), 1);
SD_ss_gray = zeros(length(ss_strain7), 1);
SD_ss_gw = zeros(length(ss_strain1), 1);
SD_ss_white = zeros(length(ss_strain2), 1);
errors = linspace(1,200,10);
errors = round(errors);

ss_gray = [ss_stress7 ss_stress11(1:length(ss_strain7)) ss_stress12(1:length(ss_strain7))];
ss_gw = [ss_stress1 ss_stress5(1:length(ss_strain1)) ss_stress9(1:length(ss_strain1))];
ss_white = [ss_stress2 ss_stress6(1:length(ss_strain2)) ss_stress8(1:length(ss_strain2)) ss_stress10(1:length(ss_strain2))];

% Calculate Means
for i_gray = 1:length(ss_gray)
    mean_ss_gray(i_gray) = mean(ss_gray(i_gray));
end

for i_gw = 1:length(ss_gw)
    mean_ss_gw(i_gw) = mean(ss_gw(i_gw));
end

for i_white = 1:length(ss_white)
    mean_ss_white(i_white) = mean(ss_white(i_white));
end

% Calculate SDs
SD_ss_gray = std(ss_gray, [], 2, 'omitnan');
SD_ss_gw = std(ss_gw, [], 2, 'omitnan');
SD_ss_white = std(ss_white, [], 2, 'omitnan');

figure(4)
fize = 32;
hold on
plot(ss_strain1, mean_ss_gw, 'b', 'Linewidth', 1.5)
plot(ss_strain2, mean_ss_white, 'r', 'Linewidth', 1.5)
plot(ss_strain7, mean_ss_gray, 'k', 'Linewidth', 1.5)
errorbar(ss_strain7(errors), mean_ss_gray(errors), SD_ss_gray(errors), 'k', 'Linestyle', 'none', 'Linewidth', 1.5)
errorbar(ss_strain1(errors), mean_ss_gw(errors), SD_ss_gw(errors), 'b', 'Linestyle', 'none', 'Linewidth', 1.5)
errorbar(ss_strain2(errors), mean_ss_white(errors), SD_ss_white(errors), 'r', 'Linestyle', 'none', 'Linewidth', 1.5)
xlabel('Nominal Strain (%)')
ylabel ('Nominal Stress (kPa)')
title('Stress vs Strain')
set(gca, 'TickDir', 'out', 'FontSize', fsize)
set(gcf, 'color', 'white')
[~, hobj, ~, ~] = legend('G-WM', 'WM', 'GM', 'Location', 'northwest');
hl = findobj(hobj,'type','line');
set(hl,'LineWidth', 2);
legend boxoff
hold off
