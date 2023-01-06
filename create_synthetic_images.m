function [img1,img2]=create_synthetic_images(height,width,dx,dy)
% [img1,img2]=create_synthetic_images(height,width,dx,dy)
%
% This function creates two synthetic test images. These can be used
% to validate the calculation of motion vectors.
%
% Parameters:
%     width,height: dimensions of the images
%     dx,dy:        specified motion vector 

% S.Spors / 07.02.2005
% $Id: create_synthetic_images.m,v 1.3 2005/02/25 16:07:03 garbas Exp $

if(nargin<4)
  disp('Not enough input arguments!');
  exit
end

% size of block in the foreground
size2 = 32;

% create noisy background in both images
img1 = 0.5*rand(height,width);
img2 = img1;

% create noisy block
obj=0.5+0.5*rand(size2,size2);

% copy block to center of reference image
x = width/2+1:width/2+size2;
y = height/2+1:height/2+size2;
img1(y,x) = obj;

% copy block to actual image
x = x + dx;
y = y + dy;
img2(y,x) = obj;
