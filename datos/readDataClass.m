function [ dayClassify, daySignals ] = readDataClass( day )
%%% Devuelve las señales de un día y sus valores de clase.

%% Initialize variables.
filename = [ './' day '_Clasif.dat'];
delimiter = '\t';

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, ...
    'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
rawDayClassify = [dataArray{1:end-1}];

%% Split matrix: channels-by-minutes
dayClassify = permute(rawDayClassify(:,2:end), [2 1]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Read day signal
rawDaySignals = readDay(day);

%% Split matrix: channels-by-minutes-by-samples

daySignals = zeros(8, size(rawDayClassify, 1), 6000);

for i = 1 : 8
    channelSignal = rawDaySignals(i, :);
    channelSplitted = zeros(size(rawDayClassify, 1), 6000);
    
    for j = 1 : size(rawDayClassify, 1)
        initMin = (j - 1) * 6000 + 1;
        endMin = j * 6000;
        channelSplitted(j, :) = channelSignal(1, initMin : endMin);
    end
    
    daySignals(i, :, :) = channelSplitted;
end

%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans channelSignal ...
    channelSplitted i j initMin endMin;

end
