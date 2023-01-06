function final_decoder(coded_file, decoded_sequence_yuv)
load(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', ...
    'huffman_table_mv', 'bitstream', 'bitstream2', 'me_blocksize', 'me_searchrange')
[~, runlevel_representation] = decode_signal_from_huffman_bitstream(bitstream, huffman_table);
[~, motion_vectors] = decode_signal_from_huffman_bitstream(bitstream2, huffman_table_mv);
num_blocks_per_frame = height*width/(transform_blocksize^2);
nr_of_motion_vectors_per_image = height*width/(me_blocksize(1)^2);
end_index_intra = 1;
start_index_intra = 1;
end_index = 1;
start_index = 1;
frame_index = 0;
start_me = 1;
count = 0;
intra = 0;
if intra == 0
    for i = 1:size(runlevel_representation,1)
        if runlevel_representation(i,:) == [-1,-1]
            count = count +1;
            end_index_intra =  i;
        end
        if count == num_blocks_per_frame
            count = 0;
            frame_index = frame_index+1;
            runlevel_representation_perframe = runlevel_representation(start_index_intra:end_index_intra,:);
            start_index_intra = end_index_intra+1;
            start_index = end_index_intra+1;
            zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation_perframe, transform_blocksize);
%             zigzag_scanned = optional_dc_prediction_inverse(zigzag_scanned);
            input_levels = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
            quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
            zigzag_scanned = blockbased_dequantizer_from_levels(input_levels, quantisation_matrix);
            itransformed_image = blockbased_idct_on_image(zigzag_scanned, transform_blocksize);
            itransformed_image(itransformed_image<0) = 0;
            itransformed_image(itransformed_image>1) = 1;
            buffer_frame = itransformed_image;
            retval = yuv_write_one_frame(decoded_sequence_yuv, frame_index, itransformed_image);
            intra = 1;
            break;
        end
    end
end
start = 1;
if intra == 1
    for i = start_index:size(runlevel_representation,1)
        if runlevel_representation(i,:) == [-1,-1]
            count = count +1;
            end_index =  i;
        end
        if count == num_blocks_per_frame
            count = 0;
            frame_index = frame_index+1;
            runlevel_representation_perframe = runlevel_representation(start_index:end_index,:);
            start_index = end_index+1;
            motion_vector = motion_vectors(start_me:start_me+nr_of_motion_vectors_per_image-1,:);
            start_me = start_me+nr_of_motion_vectors_per_image;
            start = start+num_blocks_per_frame;
            predicted_frame = blockbased_motion_compensation(buffer_frame, me_blocksize , me_searchrange, motion_vector);
            zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation_perframe, transform_blocksize);
%             zigzag_scanned = optional_dc_prediction_inverse(zigzag_scanned);
            input_levels = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
            quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
            zigzag_scanned = blockbased_dequantizer_from_levels(input_levels, quantisation_matrix);
            itransformed_image = blockbased_idct_on_image(zigzag_scanned, transform_blocksize);
            added_image = predicted_frame + itransformed_image;
            buffer_frame = added_image;
            added_image(added_image<0) = 0;
            added_image(added_image>1) = 1;
            retval = yuv_write_one_frame(decoded_sequence_yuv, frame_index, added_image);
        end
    end
end

    