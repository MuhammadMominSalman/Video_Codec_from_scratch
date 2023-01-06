function output_image = deadzone_dequantizer(input_levels, q_matrix)
output_image = (input_levels+(0.5.*sign(input_levels))).*q_matrix;
end