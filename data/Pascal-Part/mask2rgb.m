function unmaskedRGB = mask2rgb(im, mask, outputSize)
% Given an 2D rgb image and a binary mask, return an cropped rgb image
%   corresponding to the mask location
% outputSize is 2D vector of nonnegative integers

if nargin < 3
    outputSize = size(im);
end

properties = regionprops('table', mask,'BoundingBox', 'Centroid');
param = properties.BoundingBox;
[~,row] =  max(param(:,3));         % 3rd column corresponds to width
rect = param(row,:);
for ii = 1:numel(rect)
   rect(ii) = fix(rect(ii)); 
end
unmaskedRGB = imcrop(im, rect);
unmaskedRGB = imresize(unmaskedRGB,outputSize);

end

