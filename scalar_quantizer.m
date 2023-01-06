function output_levels = scalar_quantizer(input_image, quantizer_matrix)
output_levels = round(input_image./quantizer_matrix);
end