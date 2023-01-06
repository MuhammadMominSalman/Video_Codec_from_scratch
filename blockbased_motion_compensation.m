%exercise 4.4
function [motion_compensated_frame]=blockbased_motion_compensation(input_image, blocksize,searchrange,motion_vectors)
padded_reference = padarray(input_image,[searchrange searchrange],'replicate','pre'); %searchrange = 2
padded_reference = padarray(padded_reference,[searchrange searchrange],'replicate','post');
motion_compensated_frame = zeros(size(padded_reference,1), size(padded_reference,2) );
% motion_compensated_frame = padded_reference;
blockrows = size(input_image,1)/blocksize(1);
blockcolumns = size(input_image, 2)/blocksize(2);
blockstart_x = searchrange+1;
blockstart_y = searchrange+1;

% imshow(padded_current)
% imshow(padded_reference)
x=1;
for i = 1:blockrows
    blockstart_x = searchrange+1;
    for j = 1:blockcolumns
        motion_compensated_frame(blockstart_y:blockstart_y+blocksize(1)-1, blockstart_x:blockstart_x+blocksize(2)-1)= padded_reference(blockstart_y+motion_vectors(x,1):blockstart_y+blocksize(1)+motion_vectors(x,1)-1, blockstart_x+motion_vectors(x,2):blockstart_x+blocksize(2)+motion_vectors(x,2)-1);
        blockstart_x = blockstart_x+blocksize(1);
        x = x+1;
    end
%     blockstart_x = searchrange+1;
    blockstart_y = blockstart_y+blocksize(2);
end
motion_compensated_frame = motion_compensated_frame(1+searchrange: size(input_image,1)+searchrange, 1+searchrange: size(input_image,2)+searchrange);