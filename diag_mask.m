% shades image using a diagonal gradient
% usage: output_image = diag_mask(input_image)

function y=diag_mask(x);

[l,c] = size(x);
h_g = (0:c-1)/c; % horizontal gradient
v_g = (0:l-1)'/l;% vertical gradient
diag_g = 0.5*(repmat(h_g,l,1) + repmat(v_g,1,c));
y = x.*diag_g;
