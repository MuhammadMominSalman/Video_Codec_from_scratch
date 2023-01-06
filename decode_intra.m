function decode_intra(coded_file, decoded_yuv_file)
load(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream')
[~, runlevel_representation] = decode_signal_from_huffman_bitstream(bitstream, huffman_table);
zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation, transform_blocksize);
zigzag_scanned = optional_dc_prediction_inverse(zigzag_scanned);
input_levels = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
zigzag_scanned = blockbased_dequantizer_from_levels(input_levels, quantisation_matrix);
itransformed_image = blockbased_idct_on_image(zigzag_scanned, transform_blocksize);
itransformed_image(itransformed_image<0) = 0;
itransformed_image(itransformed_image>1) = 1;
retval = yuv_write_one_frame(decoded_yuv_file, 1,itransformed_image);
