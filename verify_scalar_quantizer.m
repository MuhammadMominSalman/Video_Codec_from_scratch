% verify function scalar_quantizer

function []=verify_scalar_quantizer()

input_image =      [0 0.4 0.6; -0.4499 -0.4501 100; 4  6  -4; 5.3  5.5  -5.5];
quantizer_matrix = [1 1   1  ;  0.1     0.1    0.1; 10 10 10; 10.8 10.8 10.8];
expected_result =  [0 0   1  ; -4      -5      1000; 0  1  0; 0    1    -1  ];

your_result = scalar_quantizer(input_image, quantizer_matrix);

if any(size(your_result)~=size(expected_result)), 
  error('output size is incorrect!'); 
end
D = your_result-expected_result;
max_err = max(abs(D(:)));
if (max_err > 0)
  if (max_err > 1) % more than just a rounding error
    error('wrong output values! large errors!'); 
  else
    error('wrong output values! possibly wrong rounding!'); 
  end
end
disp('function scalar_quantizer is ok!')
