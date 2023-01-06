function retval=yuv_write_one_frame(filename,frame_no,Y,U,V)
% function retval=yuv_write_one_frame(filename,frame_no,Y,U,V)
%
% write one YCbCr-(YUV-)frame into a file; o success the return value is 0 else it is -1
% NOTE: values for U and V are optional
%
% Input:
% filename - name of the file used for writing the unsigned char (8bit) YUV data
% frame_no - number of the frame to be written
% width - width of the frame to be written
% height - height of the frame to be written
% Y - luminance data of the frame to be written
% U - chrominance (Cb) of the frame to be written (optional; default is (uint8)128)
% V - chrominance (Cr) of the frame to be written (optional; default is (uint8)128)


% process input arguments
if (nargin<3)
  fprintf ('USAGE: write_yuv420(filename,frame_nr,Y_data[,U_data,V_data]\n');
  fprintf ('Note: if U/V data is omitted it is assumed to have a byte value of 128\n');
  retval=-1;
  return
end %if
  
% get width and height for possibliy creating missing U/V data
width=size(Y,2);
height=size(Y,1);

% check, if U/V data exists
if (nargin<4)
  U=ones(width/2,height/2)*128/255;
  V=ones(width/2,height/2)*128/255;
elseif (nargin<5)
  V=ones(width/2,height/2)*128/255;
end %if


% open the file for writing
% tests first, if a file exist. if yes, then we have to open the fiel using 'r+' in order to have 
% the availability to overwrite frames
% if the file does not exist open it using 'w+' in order to aviod errors opening a nonexisting file 
if (exist(filename))
  [fid, message]=fopen(filename,'r+');
else
  [fid, message]=fopen(filename,'w+');
end

if (fid==-1)
  fprintf ('An error has occured while opening file %s for reading.\nThe system error message was: %s\n',filename,message);
  retval=-1;
  return
end %if


% clip Y/U/V data to [0;1]
Y(find(Y>1))=1;
U(find(U>1))=1;
V(find(V>1))=1;
Y(find(Y<0))=0;
U(find(U<0))=0;
V(find(V<0))=0;

% get unsigned char array for Y/U/V
Ychar=uint8(floor(Y*255));
Uchar=uint8(floor(U*255));
Vchar=uint8(floor(V*255));

retval=0;
offset=width*height*1.5*(frame_no-1);
if (fseek(fid,offset,'bof')==-1)
  errmsg=ferror(fid);
  fprintf ('An error has occurred during writing yuv data of frame %d (offset %d) to file %s\nSystem error message was:\n%s\n',frame_no,offset,filename,errmsg);
  retval=-1;
else
  fwrite(fid,Ychar','uchar');
  fwrite(fid,Uchar','uchar');
  fwrite(fid,Vchar','uchar');
end %if

fclose(fid);
