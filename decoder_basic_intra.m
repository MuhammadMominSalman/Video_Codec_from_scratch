function decode_basic_intra(coded_file, decoded_yuv_file)
load(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream')
[~, runlevel_representation] = decode_signal_from_huffman_bitstream(bitstream, huffman_table);
num_blocks_per_frame = height*width/(transform_blocksize^2) 
end_index = 1;
start_index = 1;
frame_index = 0;
count = 0;
for i = 1:size(runlevel_representation,1)
    if runlevel_representation(i,:) == [-1,-1]
        count = count +1;
        end_index =  i;
    end
    if count == num_blocks_per_frame
        count = 0;
        frame_index = frame_index+1;
        runlevel_representation_perframe = runlevel_representation(start_index:end_index,:); 
        start_index = end_index+1;
        zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation_perframe, transform_blocksize);
        input_levels = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
        quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
        zigzag_scanned = blockbased_dequantizer_from_levels(input_levels, quantisation_matrix);
        itransformed_image = blockbased_idct_on_image(zigzag_scanned, transform_blocksize);
        itransformed_image(itransformed_image<0) = 0;
        itransformed_image(itransformed_image>1) = 1;
        imshow(itransformed_image);
        retval = yuv_write_one_frame(decoded_yuv_file, frame_index, itransformed_image);
    end
end