function bitstream=bitstream_init()
% This function returns a bitstream which is inited to start
% writing and reading at position 0
% The first uint32 is the length, then read and write pointer follow
%
bitstream=uint32(zeros(1,3));
