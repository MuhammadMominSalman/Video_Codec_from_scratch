% verify functions
% blockbased_quantizer_to_levels
% and 
% blockbased_dequantizer_from_levels

function []=verify_blk_quant()

% test quantizer
input_image =      [4 6 -6;0.4 0.6 -0.6;6 0.6 -6;4 6 -6];
quantizer_matrix = [10 1; 0.1 5];
expected_result = [0 6 -1;4 0 -6; 1 1 -1; 40 1 -60];
your_result = blockbased_quantizer_to_levels(input_image,quantizer_matrix);

if any(size(your_result)~=size(expected_result)), 
  disp('blockbased_quantizer_to_levels: output size is incorrect!');beep
end
D = your_result-expected_result;
max_err = max(abs(D(:)));
if (max_err > 0)
  if (max_err > 1) % more than just a rounding error
    disp('blockbased_quantizer_to_levels: wrong output values! large errors!');beep
  else
    disp('blockbased_quantizer_to_levels: wrong output values! possibly wrong rounding!');beep
  end
else
  disp('function blockbased_quantizer_to_levels is ok!')
end

% test dequantizer
input_levels =     [0 6 -1;4 0 -6;1 1 -1;40 1 -60];
quantizer_matrix = [10 1; 0.1 5];
expected_result =  [0 6 -10;0.4 0 -0.6;10 1 -10;4 5 -6];
your_result = blockbased_dequantizer_from_levels(input_levels,quantizer_matrix);

if any(size(your_result)~=size(expected_result)), 
  disp('blockbased_dequantizer_from_levels: output size is incorrect!');beep
end
D = your_result-expected_result;
max_err = max(abs(D(:)));
if (max_err > 1e-10)
  disp('blockbased_dequantizer_from_levels: wrong output values!');beep
else
  disp('function blockbased_dequantizer_from_levels is ok!')
end
