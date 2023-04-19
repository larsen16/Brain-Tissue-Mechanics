function [time, z_pos, x_pos, force] = Extract_Data(filename)
%% Extract Compression Data from .csv files %%
%
% Author: Jacob Larsen
% Date: 17 March 2023
% Description: Imports unconfined compression data from .csv files for analysis
%
% INPUTS: filename - The name of the data file (.csv file) you want to load (enter with single quotes)
%
% OUTPUTS: time - time values (s)
%          z_pos - z-position values (mm)
%          x_pos - x-position values (mm)
%          force - magnitude of force values (gf)

%% MATLAB Generated Code %%
% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [27, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["Time (s)", "Position Z-direction (mm)", "Position X-direction (mm)", "Force Z-direction (gf)"];
opts.VariableTypes = ["double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Time (s)", "Position Z-direction (mm)", "Position X-direction (mm)", "Force Z-direction (gf)"], "ThousandsSeparator", ",");

% Create Data Table
data_table = readtable(filename, opts);

% Create Variables
time = data_table(:,1); % time variables (s)
z_pos = data_table(:,2); % displacement in Z-direction (mm)
x_pos = data_table(:,3); % displacement in X-direction (mm)
force = data_table(:,4); % force (gf)

time = table2array(time);
z_pos = table2array(z_pos);
x_pos = table2array(x_pos);
force = table2array(force);

end