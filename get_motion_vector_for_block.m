%ivc lab 4.2
function motion_vector = get_motion_vector_for_block(padded_input_image, padded_previous_image, blockstart_x, blockstart_y,blocksize, searchrange)
current_block = padded_input_image(blockstart_y:blockstart_y+blocksize(1)-1, blockstart_x:blockstart_x+blocksize(2)-1);
min = 255*size(padded_input_image,1)*size(padded_input_image, 2); %max sad
for dm = -searchrange:searchrange
    for dn = -searchrange:searchrange
        a = blockstart_y+dm;
        b = blockstart_y+dm+blocksize(1)-1;
        c = blockstart_x+dn;
        d = blockstart_x+dn+blocksize(2)-1;
        candidate_block = padded_previous_image(blockstart_y+dm:blockstart_y+dm+blocksize(1)-1, blockstart_x+dn:blockstart_x+dn+blocksize(2)-1);
        candidate_sad = calculate_sad(current_block, candidate_block);
        if candidate_sad <= min
            min = candidate_sad;
            motion_vector = [dm, dn];
        end
    end
end
%min
    