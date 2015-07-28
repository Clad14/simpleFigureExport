function [figureHandle] = simpleFigureExport (figureHandle, fileName, fileFormats, resolutionDPI, figureUnits, figureWidth, figureRatio, fontSize, fontName, fontWeight)

% Author : Arnaud Devie
% Created : 07/23/2015
% Last revision : 07/27/2015

% Retrieve necessary handles (axes, legend)
axesHandle = findobj(figureHandle, 'Type', 'axes');
legendHandle = findobj(figureHandle, 'Type', 'legend');

% Save original properties
axesBGColor = get(axesHandle,'Color');

% Adjust text size
set(findall(figureHandle, 'type', 'text'), 'FontSize', fontSize, 'FontWeight', fontWeight, 'FontName', fontName);
set(axesHandle, 'FontSize', fontSize, 'FontWeight', fontWeight, 'FontName', fontName);
set(legendHandle, 'FontSize', fontSize-1, 'FontWeight', fontWeight, 'FontName', fontName);

% Set figure dimensions
set(figureHandle, 'Units', figureUnits, 'Position', [5 5 figureWidth figureWidth/figureRatio]); % define the new figure dimensions
set(figureHandle, 'PaperUnits', figureUnits, 'PaperSize', [figureWidth figureWidth/figureRatio], 'PaperPosition', [0 0 figureWidth figureWidth/figureRatio], 'PaperOrientation', 'portrait'); % define canvas dimensions

% Set axes dimensions
offsets = get(axesHandle,'TightInset');
padding = 1 + 5/100;
margins = [offsets(1)*padding, offsets(2)*padding, .99-offsets(1)*padding-offsets(3), .99-offsets(2)*padding-offsets(4)];
set(axesHandle, 'Units', 'normalized', 'Position', margins); % stretch axes to fill the figure

% Export as file(s)
resolution = strcat('-r', int2str(resolutionDPI));

if iscell(fileFormats)
    for i = 1:max(size(fileFormats))
        if strcmp(fileFormats{i}, 'fig')
            saveas(figureHandle, fileName);
        else
            fileFormat = strcat('-d', fileFormats{i});
            print(fileName, fileFormat, resolution);
        end
    end
else
    if strcmp(fileFormats, 'fig')
        saveas(figureHandle, fileName);
    else
    fileFormat = strcat('-d', fileFormats);
    print(fileName, fileFormat, resolution);
    end
end        

% Restore original properties
set(axesHandle, 'Color', axesBGColor);

end