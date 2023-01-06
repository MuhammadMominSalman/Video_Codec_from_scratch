function output_image = scalar_dequantizer(input_levels, quantizer_matrix)
output_image = input_levels.*quantizer_matrix;
end