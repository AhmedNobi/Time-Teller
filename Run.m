clear all;close all;clc;
warning('off');
directory = '.\images'; % full path of folder with pictures
filenames_jpg = dir(fullfile(directory, '*.jpg')); % read all images with jpg extesnsion
filenames_png = dir(fullfile(directory, '*.png')); % read all images with png extension
filenames_bmp = dir(fullfile(directory, '*.gif')); % read all images with png extension
filenames = [filenames_jpg; filenames_png; filenames_bmp]; % combine them in one array
if isempty(filenames)
    error('###Wrong directory###');
end
total_images = numel(filenames);    % total number of images
for nc = 1:total_images
    full_name = fullfile(directory, filenames(nc).name);% specify image name with full path and extension       
    clock = imread(full_name);
    filenames(nc).name
    figure,imshow(clock);
    main(clock,filenames(nc).name);
end