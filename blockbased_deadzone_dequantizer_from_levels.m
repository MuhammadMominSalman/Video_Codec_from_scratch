function output_image = blockbased_deadzone_dequantizer_from_levels(input_levels, q_matrix)
dequantizer = @ (input_image) scalar_dequantizer(input_image, q_matrix);
output_image = blockwise_processing(input_levels, size(q_matrix), dequantizer);
end