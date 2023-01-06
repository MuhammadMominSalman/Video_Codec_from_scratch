function output_image = blockbased_decoding_from_zigzag_scanned(zigzagged_scanned, blocksize, width,height)
blockstart_x = 1;
x = 0;
for i = 1:(height/blocksize) %i are row indices
    blockstart_y = 1;
    for k = 1:(width/blocksize) %k are column indices
        x = x+1;
        output_image(blockstart_x:blockstart_x+blocksize-1,blockstart_y:blockstart_y+blocksize-1) = decoding_from_zigzag_scanned(zigzagged_scanned(x,:), blocksize(1), blocksize(1));
        blockstart_y = blockstart_y+blocksize;
    end
    blockstart_x = blockstart_x+blocksize;
end