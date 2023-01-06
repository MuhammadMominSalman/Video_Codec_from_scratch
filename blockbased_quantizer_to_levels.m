function out_levels = blockbased_quantizer_to_levels(input_image, quantizer_matrix)
quantizer = @ (input_image) scalar_quantizer(input_image, quantizer_matrix);
out_levels = blockwise_processing(input_image, size(quantizer_matrix), quantizer);
end