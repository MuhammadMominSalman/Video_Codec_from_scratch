function output_image= blockbased_dequantizer_from_levels(input_levels, quantizer_matrix)
dequantizer = @ (input_image) scalar_dequantizer(input_image, quantizer_matrix);
output_image = blockwise_processing(input_levels, size(quantizer_matrix), dequantizer);
end