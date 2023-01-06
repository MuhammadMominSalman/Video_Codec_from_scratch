function y = shape_pdf(x)

% function y = shape_pdf(x)
% change pdf of noise in x 
% for comparison of MAD and MSE in lab 2. Quantisierung
y = x.*(abs(x)>0.9*max(x(:)));

% normalize noise to get interesting MAD values...
y = sum(abs(x(:)))*y/(sum(abs(y(:))));
