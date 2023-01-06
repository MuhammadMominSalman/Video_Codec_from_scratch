function bitstream=bitstream_append_bits(bitstream, vector)
% This function appends bits to a bitstream. The vector contains
% entries of either 0 or 1 to keep handling simple, e.g. vector=[1 0 1 1] is a valid vector
% This function shall be called with bitstream=bitstream_append_bits(bitstream,[1 0 1 1]);
%
% Let's get the write pointer of the bitstream
% The offset is for the length, the read and write pointer at the start of the bitstream
write_pointer=bitstream(3)+3*32;
% We get the current position both in uint32 and in bits in that uint32
write_pointer_uint32=floor(double(write_pointer)/32.0)+1;
write_pointer_bit=rem(write_pointer,32)+1;
% Now we get the last uint32 from the data stream
if write_pointer_bit==1
  store_uint32=uint32(0);
else
  store_uint32=bitstream(write_pointer_uint32);
end
% Next we walk through the given vector
% This is terribly slow, but that shall not be our problem here
for idx=1:size(vector,2)
  store_uint32=bitset(store_uint32,write_pointer_bit,vector(idx));
  write_pointer_bit=write_pointer_bit+1;
  % Do we cross the uint32 border?
  if(write_pointer_bit>32)
    bitstream(write_pointer_uint32)=store_uint32;
    write_pointer_uint32=write_pointer_uint32+1;
    write_pointer_bit=1;
    store_uint32=0;
  end
end
% We finally write the changed bits back to the bitstream
bitstream(write_pointer_uint32)=store_uint32;
% Now we advance the bitstream write pointer
bitstream(3)=bitstream(3)+size(vector,2);
% If the write_pointer is beyond the length, then the length is updated as well
if bitstream(1)<bitstream(3)
  bitstream(1)=bitstream(3);
end



  