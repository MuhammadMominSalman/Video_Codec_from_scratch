%exercise 5.2
function output_image = blockbased_idct_on_image(input_image, blocksize)
%Assume no padding required
output_image = zeros(size(input_image));
blockstart_x = 1;

for i = 1:(size(output_image,1)/blocksize) %i are row indices
    blockstart_y = 1;
    for k = 1:(size(output_image,2)/blocksize) %k are column indices
        temp_image = input_image(blockstart_x:blockstart_x+blocksize-1,blockstart_y:blockstart_y+blocksize-1);
        temp = IDCT(temp_image);
        output_image(blockstart_x:blockstart_x+blocksize-1,blockstart_y:blockstart_y+blocksize-1) = temp;
        blockstart_y = blockstart_y+blocksize;
    end
    blockstart_x = blockstart_x+blocksize;
end
        
