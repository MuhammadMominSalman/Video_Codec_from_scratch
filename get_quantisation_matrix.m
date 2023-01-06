function [quantisation_matrix]=get_quantisation_matrix(qp,transform_size)
% [quantisation_matrix]=get_quantisation_matrix(qp,transform_blocksize)
%
% calculates the quantisation matrix of size transformation matrix to be quantized
% for a given quantisation parameter (DC=8; AC=2*qp/255)
quantisation_matrix=ones(transform_size)*2*qp*(2/256);
quantisation_matrix(1)=8/255;

