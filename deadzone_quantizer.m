function output_levels = deadzone_quantizer(input_image, q_matrix)
output_levels = fix(input_image./q_matrix);
end
