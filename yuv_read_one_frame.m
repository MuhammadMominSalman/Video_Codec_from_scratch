function [output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame ( filename, image_number, width, height )
% function [output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame ( filename, image_number, width, height )
% Reading a single frame from an yuv input data stream 
% of size width*height. The image_number in the sequence is starting at 1.
% The output image is written as three arrays. If the image does not exist, 
% the arrays are empty.

% Open the input file
[file_id message]=fopen(filename,'r');
if message~=''
  fprintf('Could not read image number %ld from file %s, because %s\n', image_number, filename, message);
else
  % Skip the first frames until image_number is reached
  status=fseek(file_id, (image_number-1) * width * height * 1.5, 'bof');
  % Check whether error occurred
  if status == -1
    fprintf('Could not read image number %ld from file %s, because %s\n', image_number, filename, ferror(file_id));
    output_image_Y=[];
    output_image_U=[];
    output_image_V=[];
  else % no error occurred
    [output_image_Y size_Y]=fread(file_id, [width height], 'uchar');
    [output_image_U size_U]=fread(file_id, [width/2 height/2], 'uchar');
    [output_image_V size_V]=fread(file_id, [width/2 height/2], 'uchar');
    if size_Y + size_U + size_V ~= width*height*1.5
      fprintf('Could not read image number %ld from file %s, because %s\n', image_number, filename, ferror(file_id));
      output_image_Y=[];
      output_image_U=[];
      output_image_V=[];
    else
      output_image_Y=double(output_image_Y')/255;
      output_image_U=double(output_image_U')/255;
      output_image_V=double(output_image_V')/255;
    end
  end
end

fclose(file_id); 
