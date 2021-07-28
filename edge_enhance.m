function out= edge_enhance(I)
%img_gray = rgb2gray(I);
%kernel =  -1*ones(3);
%kernel(3,3) = 10;
%enhancedImage = imfilter(img_gray, kernel);

%windowWidth = 10; % Whatever.  Change for different effects.
%kernel = -1 * ones(windowWidth);
%kernel(ceil(windowWidth/2), ceil(windowWidth/2)) = -sum(kernel(:)) - 1 + windowWidth^2 
%kernel = kernel / sum(kernel(:)) % Normalize.
%out = imfilter(enhancedImage, kernel);
%figure, imshow(out, []);

%figure, imshow(enhancedImage);

%===============================================================================
% Read in a standard MATLAB color demo image.


rgbImage =I;
% Extract the individual red, green, and blue color channels.

% Extract the individual red, green, and blue color channels.
[~,~,c]=size(I);
binaryImage=0;
if (c == 3)
    binaryImage = rgbImage(:, :, 3)<115;
     %figure, imshow(I);
else
    binaryImage = rgbImage<180 ; 
    se=strel('square', 3);
    binaryImage = imclose(binaryImage,se);
   
end
 out = binaryImage;

% Get rid of small blobs.
%figure, imshow(out);

end