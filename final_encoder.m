function [coded_bits, mse_per_frame] = final_encoder(input_sequence_yuv, coded_file, width, height, number_of_frames, transform_blocksize,  qp, me_searchrange, me_blocksize)
transform_blocksize = 16;
me_blocksize = [16,16];
me_searchrange = 8;
mse_per_frame = [];
runlevel_allframes = [];
intra = 0;
if intra == 0
    [output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame(input_sequence_yuv, 1, width, height);
    transformed_image = blockbased_dct_on_image(output_image_Y, transform_blocksize);
    quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
    quantised_image = blockbased_quantizer_to_levels(transformed_image, quantisation_matrix);
    zigzag_scanned = blockbased_encoding_to_zigzag_scanned(quantised_image, transform_blocksize);
%     zigzag_scanned = optional_dc_prediction(zigzag_scanned);
    runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);
    %% For Prediction
    zigzag_scanned_prediction = blockbased_decoding_from_runlevel_representation(runlevel_representation, transform_blocksize);
%     zigzag_scanned_prediction = optional_dc_prediction_inverse(zigzag_scanned_prediction);
    input_levels_pred = blockbased_decoding_from_zigzag_scanned(zigzag_scanned_prediction, transform_blocksize, width, height);
    i_image = blockbased_dequantizer_from_levels(input_levels_pred, quantisation_matrix);
    prediction_frame = blockbased_idct_on_image(i_image, transform_blocksize);
    prediction_frame(prediction_frame<0) = 0;
    prediction_frame(prediction_frame>1) = 1;
    %% end
    mse_per_frame = [mse_per_frame, mse_of_frame(output_image_Y, prediction_frame)];
    runlevel_allframes = [runlevel_allframes; runlevel_representation];
    huffman_table = create_huffman_table_from_signal(runlevel_allframes);
    bitstream = bitstream_init();
    bitstream = encode_signal_to_huffman_bitstream(bitstream, huffman_table, runlevel_allframes);
    save(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream');
    coded_bits = bitstream_get_length(bitstream);
    intra = 1;
end
motion_vectors_allframes = [];
if intra == 1
    for i = 2: number_of_frames
        [output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame(input_sequence_yuv, i, width, height);
        motion_vectors = blockbased_motion_search(output_image_Y, prediction_frame, me_blocksize, me_searchrange);
        motion_vectors_allframes = [motion_vectors_allframes; motion_vectors];
        prediction_motion_compensated_frame = blockbased_motion_compensation(prediction_frame, me_blocksize, me_searchrange, motion_vectors);
        residual_frame = output_image_Y - prediction_motion_compensated_frame;
        transformed_image = blockbased_dct_on_image(residual_frame, transform_blocksize);
        quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
        quantised_image = blockbased_quantizer_to_levels(transformed_image, quantisation_matrix);
        zigzag_scanned = blockbased_encoding_to_zigzag_scanned(quantised_image, transform_blocksize);
%         zigzag_scanned = optional_dc_prediction(zigzag_scanned);
        runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);
        %% For Prediction
        zigzag_scanned_prediction = blockbased_decoding_from_runlevel_representation(runlevel_representation, transform_blocksize);
%         zigzag_scanned_prediction = optional_dc_prediction_inverse(zigzag_scanned_prediction);
        input_levels_pred = blockbased_decoding_from_zigzag_scanned(zigzag_scanned_prediction, transform_blocksize, width, height);
        i_image = blockbased_dequantizer_from_levels(input_levels_pred, quantisation_matrix);
        prediction_frame = blockbased_idct_on_image(i_image, transform_blocksize);
        prediction_frame = prediction_frame + prediction_motion_compensated_frame;
        prediction_frame(prediction_frame<0) = 0;
        prediction_frame(prediction_frame>1) = 1;
        %% end
        mse_per_frame = [mse_per_frame, mse_of_frame(output_image_Y, prediction_frame)];
        runlevel_allframes = [runlevel_allframes; runlevel_representation];
    end
    huffman_table = create_huffman_table_from_signal(runlevel_allframes);
    
    bitstream = bitstream_init();
    bitstream = encode_signal_to_huffman_bitstream(bitstream, huffman_table, runlevel_allframes);
    %%motion vectors huffman
    huffman_table_mv = create_huffman_table_from_signal(motion_vectors_allframes);
    bitstream2 = bitstream_init();
    bitstream2 = encode_signal_to_huffman_bitstream(bitstream2, huffman_table_mv, motion_vectors_allframes);
    save(coded_file, 'width', 'height', 'transform_blocksize', 'qp', ...
        'huffman_table', 'bitstream','huffman_table_mv', ...
        'bitstream2', 'me_blocksize', 'me_searchrange');
    coded_bits = bitstream_get_length(bitstream);
end