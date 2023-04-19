function [wavenumber, absorbance] = Extract_FTIR_Data(filename)
%% Extract FTIR Data from .csv files %%
%
% Author: Jacob Larsen
% Date: 2 March 2023
% Description: Imports FTIR data from .csv files for analysis
%
% INPUTS: filename - The name of the FTIR file (.csv file) you want to load (enter with single quotes)
%
% OUTPUTS: wavenumber - x-axis values (cm^-1)
%          absorbance - y-axis values (a.u.)

%% Import Data & Designate Variables %%

% Set up the Import Options
inputData = readtable(filename, 'Delimiter', ',', 'MultipleDelimsAsOne', true);

% Import Data & Assign to Arrays
wavenumber = inputData(:,1);
wavenumber = table2array(wavenumber);
absorbance = inputData(:,2);
absorbance = table2array(absorbance);

end