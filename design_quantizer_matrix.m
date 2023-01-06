function [q_mat n_q0 n_q1]=design_quantizer_matrix(q0,q1);
%
% function [q_mat n_q0 n_q1]=design_quantizer_matrix(q0,q1)
%
% design quantizer matrix for first flowergarden frame
% the frame is divided into 2 segments: 
% flowers        : segment 0
% everything else: segment 1
%
% choose appropriate quantizer stepsizes q0,q1 for the two segments
%
% this function returns the quantizer matrix q_mat 
% and the number of pixels quantized with stepsize q0 and q1

% load segmentation matrix
load flower_segm;
% segmentation of frame: values of segmentation matrix
% 0: flowers
% 1: everything else

% design quantizer matrix
q_mat = ones(288,352);

q_mat(flower_segm==0) = q0;
q_mat(flower_segm==1) = q1;

% how many pixels are flower/other pixels?
n_q0 = sum(flower_segm(:)==0);
n_q1 = sum(flower_segm(:)==1);
