%Exercise 5.1
function output_image = blockbased_dct_on_image(input_image, blocksize)
%assuming square block of size [blocksize x blocksize]

a = mod( size(input_image,1), blocksize); %rows
b = mod( size(input_image,2), blocksize); %columns
padded_image = padarray(input_image, [0,a],'post');
padded_image = padarray(padded_image, [b,0],'post');
output_image = zeros(size(padded_image));
blockstart_x = 1;

for i = 1:(size(output_image,1)/blocksize) %i are row indices
    blockstart_y = 1;
    for k = 1:(size(output_image,2)/blocksize) %k are column indices
        temp_image = padded_image(blockstart_x:blockstart_x+blocksize-1,blockstart_y:blockstart_y+blocksize-1);
        temp = DCT(temp_image);
        output_image(blockstart_x:blockstart_x+blocksize-1,blockstart_y:blockstart_y+blocksize-1) = temp;
        blockstart_y = blockstart_y+blocksize;
    end
    blockstart_x = blockstart_x+blocksize;
end
        