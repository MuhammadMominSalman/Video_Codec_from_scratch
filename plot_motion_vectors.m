function []=plot_motion_vectors(height,width,blocksize,searchrange,motion_vectors);
% function []=plot_motion_vectors(height,width,blocksize,searchrange,motion_vectors)
%
% Function to visualize motion vectors
%
% Parameters:
%     width,height:   dimensions of the images
%     blocksize:      blocksize used for the motion vector
%                     estimation
%     searchrange:    searchrange used for the motion vector
%                     estimation
%     motion_vectors: matrix containing all motion vectors  

% S.Spors / 17.02.2005
% $Id: plot_motion_vectors.m,v 1.2 2005/02/25 16:07:16 garbas Exp $

% create position vectors for the plot
x = ceil(blocksize/2)+(1:blocksize:width);
x = repmat(x,1,height/blocksize);

y = ceil(blocksize/2)+(((1:blocksize:height)'*ones(1,width/blocksize))');
y=y(:)';

% plot motion vectors
quiver(x,y,motion_vectors(:,2)',motion_vectors(:,1)',0);

% set some properties of the plot
set(gca,'YDir','reverse');
set(gca,'XAxisLocation','top');
axis([-searchrange width+searchrange -searchrange height+searchrange]);

% set(gca,'XTick',1:2*blocksize:width);
% set(gca,'YTick',1:2*blocksize:height);
