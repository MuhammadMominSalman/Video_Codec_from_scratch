% verify function scalar_dequantizer

function []=verify_scalar_dequantizer()

input_levels =     [0 0 1  ; -4      -5      1000; 0  1  0; 0    1    -1  ];
quantizer_matrix = [1 1 1  ;  0.1     0.1    0.1; 10 10 10; 10.8 10.8 10.8];
expected_result =  [0 0 1  ;  -0.4   -0.5    100; 0 10 0  ; 0   10.8 -10.8];

your_result = scalar_dequantizer(input_levels, quantizer_matrix);

if any(size(your_result)~=size(expected_result)), 
  error('output size is incorrect!'); 
end
D = your_result-expected_result;
max_err = max(abs(D(:)));
if (max_err > 1e-10)
  error('wrong output values!'); 
end
disp('function scalar_dequantizer is ok!')
