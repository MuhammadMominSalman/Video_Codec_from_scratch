% returns size of image file 'filename' in bits
% numbits = get_image_filesize(filename);
function numbits = get_image_filesize(filename);

fileinfo = imfinfo(filename);
numbits = fileinfo.FileSize*8;

