function [coded_bits, mse_per_frame] = encoder_basic_intra(input_yuv_file, coded_file, width, height, transform_blocksize, qp)

[output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame(input_yuv_file, 1, width, height);
transformed_image = blockbased_dct_on_image(output_image_Y, transform_blocksize);
quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
quantised_image = blockbased_quantizer_to_levels(transformed_image, quantisation_matrix);
zigzag_scanned = blockbased_encoding_to_zigzag_scanned(quantised_image, transform_blocksize);
runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);
%% For Prediction
zigzag_scanned_prediction = blockbased_decoding_from_runlevel_representation(runlevel_representation, transform_blocksize);
input_levels_pred = blockbased_decoding_from_zigzag_scanned(zigzag_scanned_prediction, transform_blocksize, width, height);
zigzag_scanned_prediction = blockbased_dequantizer_from_levels(input_levels_pred, quantisation_matrix);
prediction_frame = blockbased_idct_on_image(zigzag_scanned_prediction);
%% end 
huffman_table = create_huffman_table_from_signal(runlevel_representation);
bitstream = bitstream_init();
bitstream = encode_signal_to_huffman_bitstream(bitstream, huffman_table, runlevel_representation);
save(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream');
coded_bits = len(bitstream);
mse_per_frame = mse_of_frame(input_yuv_file, output_image_Y);
end