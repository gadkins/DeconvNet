function [croppedRGB,croppedMask] = cropPart(im, partMask, outputSize)
% Given an 2D rgb image and a binary mask, return an cropped rgb image
%   corresponding to the mask location
% outputSize is 2D vector of nonnegative integers

if nargin < 3
    outputSize = size(im);
end

properties = regionprops('table', partMask,'BoundingBox', 'Centroid');
param = properties.BoundingBox;
[~,row] =  max(param(:,3));         % 3rd column corresponds to width
rect = param(row,:);

for ii = 1:numel(rect)
   rect(ii) = fix(rect(ii)); 
end


croppedRGB = imcrop(im, rect);
croppedRGB = imresize(croppedRGB,outputSize);
croppedMask = imcrop(partMask,rect);
croppedMask = imresize(croppedMask,outputSize);

end

