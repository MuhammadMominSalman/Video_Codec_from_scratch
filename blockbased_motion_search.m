%ivc lab 4.3
function motion_vectors = blockbased_motion_search(input_image, previous_image, blocksize, searchrange)
% padded_current = padarray(input_image,[2*searchrange 2*searchrange],0,'post'); %searchrange = 2
% padded_reference = padarray(previous_image,[2*searchrange 2*searchrange],0,'post');
padded_current = padarray(input_image,[searchrange searchrange],'replicate','post');
padded_current = padarray(padded_current,[searchrange searchrange],'replicate','pre');
padded_reference = padarray(previous_image,[searchrange searchrange],'replicate','post');
padded_reference = padarray(padded_reference,[searchrange searchrange],'replicate','pre');

%a = mod(blocksize(1), size(padded_current,1))
a = mod( size(padded_current,1), blocksize(1));
% b = mod(blocksize(2), size(padded_current,2))
b = mod( size(padded_current,2), blocksize(2));

% c = mod(blocksize(1), size(padded_reference,1));
c = mod( size(padded_reference,2), blocksize(2));
% d = mod(blocksize(2), size(padded_reference,2));
d = mod( size(padded_reference,2), blocksize(2));
padded_current = padarray(padded_current, [a,0],'post');
padded_current = padarray(padded_current, [0,b],'post');
padded_reference = padarray(padded_reference, [c,0],'post');
padded_reference = padarray(padded_reference, [0,d],'post');
t = size(padded_current, 1);

blockrows = size(input_image,1)/blocksize(1);
blockcolumns = size(input_image, 2)/blocksize(2);
blockstart_x = searchrange+1;
blockstart_y = searchrange+1;
motion_vectors = [];

% imshow(padded_current)
% imshow(padded_reference)
for i = 1:blockrows
    blockstart_x = searchrange+1;
    for j = 1:blockcolumns
        mv = get_motion_vector_for_block(padded_current, padded_reference, blockstart_x, blockstart_y, blocksize, searchrange);
        motion_vectors = [motion_vectors; mv];
        blockstart_x = blockstart_x+blocksize(1);
    end
%     blockstart_x = searchrange+1;
    blockstart_y = blockstart_y+blocksize(2);
end


