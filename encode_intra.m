function encode_intra(input_yuv_file, coded_file, width, height, transform_blocksize, qp)

[output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame(input_yuv_file, 1, width, height);
transformed_image = blockbased_dct_on_image(output_image_Y, transform_blocksize);
quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
quantised_image = blockbased_quantizer_to_levels(transformed_image, quantisation_matrix);
zigzag_scanned = blockbased_encoding_to_zigzag_scanned(quantised_image, transform_blocksize);
zigzag_scanned = optional_dc_prediction(zigzag_scanned);
runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);
huffman_table = create_huffman_table_from_signal(runlevel_representation);
bitstream = bitstream_init();
bitstream = encode_signal_to_huffman_bitstream(bitstream, huffman_table, runlevel_representation);
save(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream');
end