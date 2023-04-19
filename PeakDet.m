function [peaks,peak_wavenumbers] = PeakDet(absorbance, wavenumber, peak_dist, peak_prom, fig_num)
%% Detection of Peaks for FTIR Analysis %%
%
% Inputs: absorbance - absorbance output from raw FTIR data file
%         wavenumber - wavenumber output from raw FTIR data file
%         peak_dist - minimum distance between peaks
%         peak_prom - minimum prominence of peaks
%         fig_num - figure number for plotting
%
% Outputs: peaks - absorbance value at determined peaks
%          peak_wavenumbers - wavenumber value at determined peaks

[peaks, peak_wavenumbers] = findpeaks(absorbance, wavenumber, 'MinPeakDistance', peak_dist, 'MinPeakProminence', peak_prom);

fsize = 10;

figure(fig_num)
hold on
plot(wavenumber, absorbance, 'b')
plot(peak_wavenumbers, peaks, 'r*')
xlabel('Wavenumber (cm ^-^1)')
ylabel ('Absorbance')
set(gca, 'xdir', 'reverse', 'XMinorGrid', 'on', 'YMinorGrid', 'on', 'TickDir', 'out', 'FontSize', fsize)
hold off

end