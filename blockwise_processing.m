function output_image = blockwise_processing(input_image,blocksize,fun)
% Process the image input_image by applying the function fun to each block
% of input_image and then concatenating the results into the output matrix
% output_image. Blockwise_processing automatically pads the image so that
% it is divisable by blocksize(1) and blocksize(2). This padding is 
% required to ensure the correct functionality of the MATLAB in-built
% function 'blockproc'. After 'blockproc', the padding gets removed again
% and the resulting image is returned as output_image.

% Calculate the necessary padding of the input_image depending on the
% blocksize.
% pad_rows, pad_cols describes by how many rows, cols the image needs to be
% padded, respectively.

[rows, cols] = size(input_image);
pad_rows=0;
pad_cols=0;
pad_rows = blocksize(1) - mod(rows, blocksize(1));
pad_cols = blocksize(2) - mod(cols, blocksize(2));

% [h,w] = size(input_image);
% if(mod(rows, blocksize(1)) > 0) % Padding to the bottom is necessary.
%     pad_rows = mod(h, blocksize(1));
%     input_image(h:h+pad_rows,:)=0;% TODO: Row padding
% end
% if(mod(cols, blocksize(2)) > 0) % Padding to the right is necessary.
%     pad_cols =  mod(w, blocksize(2));
%     input_image(:,w:w+pad_cols)=0;% TODO: Column padding
%     
% end
% Pad the image at the bottom/right by pad_rows/pad_cols.
padded_image = padarray(input_image, [pad_rows, pad_cols], 0, 'post');

% Just as this function, the MATLAB in-built function 'blockproc' receives
% an 'input_image', a 'blocksize', and a function 'fun' as its input.
% For each block, 'blockproc' calls the function with a data
% structure 'block_struct' that contains several block-related values.
% You can learn more about this 'block_struct' by reading the information
% displayed by 'help blockproc'.
% However, our convention is, that the given function 'fun' expects the
% data of each image block directly. Therefore, we create a function handle
% 'block_fcn' that evaluates the given function 'fun' only with the data
% from the 'block_struct' that 'blockproc' provides us with. 
block_fcn = @(block_struct) feval(fun, block_struct.data);

% Process the padded image blockwise using the MATLAB in-built function
% 'blockproc'.
result_image = blockproc(padded_image,blocksize,block_fcn);

% Remove the padding from before.
output_image = result_image(1:rows,1:cols);% TODO: Remove padding

end