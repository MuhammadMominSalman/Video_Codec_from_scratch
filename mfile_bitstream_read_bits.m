function [vector bitstream]=bitstream_read_bits(bitstream, nr_of_bits)
% This function reads bits to a bitstream. 
% The read pointer is advanced but if the bitstream is not
% overwritten, e.g. the function is called as vector=bitstream_read_bits(bitstream,4) 
% instead of [vector bitstream]=bitstream_read_bits(bitstream,4) then the read pointer
% is effectively not advanced.
% In case that the bitstream has ended during read, vector is empty
%
% Let's get the read pointer of the bitstream
% The offset is for the read and write pointer at the start of the bitstream
read_pointer=bitstream(2)+3*32;
% We get the current position both in uint32 and in bits in that uint32
read_pointer_uint32=floor(double(read_pointer)/32.0)+1;
read_pointer_bit=rem(read_pointer,32)+1;
% Check whether the read position is beyond the length of the data stream then an empty vector is returned
if bitstream(1)<bitstream(2)+nr_of_bits
  vector=[];
else
  % We initialize the output vector with zeros because we write in reverse ordering
  vector=zeros(1,nr_of_bits);
  % Now we get the uint32 at the read position
  get_uint32=bitstream(read_pointer_uint32);
  % Next we walk through the bits
  % This is terribly slow, but that shall not be our problem here
%    for idx=1:nr_of_bits
%      vector(idx)=bitget(get_uint32,read_pointer_bit);
%      read_pointer_bit=read_pointer_bit+1;
%      % Do we cross the uint32 border?
%      if(read_pointer_bit>32)
%        read_pointer_uint32=read_pointer_uint32+1;
%        read_pointer_bit=1;
%        get_uint32=bitstream(read_pointer_uint32);
%      end
%    end

   read_bitstream=[bitstream 0];
   nr_of_bits_read=0;
   vector=[];
%   bit_idx=1;
%   vector=ones(1,nr_of_bits);
 %  read_pointer_uint32
 %  read_pointer_bit
   while(nr_of_bits_read ~= nr_of_bits)
     this_nr_of_bits_to_read=min(nr_of_bits-nr_of_bits_read, 33-read_pointer_bit);
     for idx=read_pointer_bit:read_pointer_bit+this_nr_of_bits_to_read-1
       vector=[vector bitget(get_uint32,idx)];
%       vector(bit_idx)=bitget(get_uint32,idx);
%       bit_idx=bit_idx+1;
     end
     nr_of_bits_read=nr_of_bits_read+this_nr_of_bits_to_read;
     read_pointer_bit=1;
     read_pointer_uint32=read_pointer_uint32+1;
     get_uint32=read_bitstream(read_pointer_uint32);
   end
   % Now we advance the bitstream read pointer
  bitstream(2)=bitstream(2)+nr_of_bits;
end
% nr_of_bits
% vector
