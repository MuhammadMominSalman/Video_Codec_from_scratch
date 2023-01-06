function zigzag_scanned = blockbased_encoding_to_zigzag_scanned(input_image, blocksize)
blockstart_x = 1;
zigzag_scanned = [];
for i = 1:(size(input_image,1)/blocksize) %i are row indices
    blockstart_y = 1;
    for k = 1:(size(input_image,2)/blocksize) %k are column indices
        temp_image = input_image(blockstart_x:blockstart_x+blocksize-1,blockstart_y:blockstart_y+blocksize-1);
        zigzag_scanned = [zigzag_scanned; encoding_to_zigzag_scanned(temp_image)];
        blockstart_y = blockstart_y+blocksize;
    end
    blockstart_x = blockstart_x+blocksize;
end