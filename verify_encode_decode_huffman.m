function verify_encode_decode_huffman(student_huffman_encoder, student_huffman_decoder)
% This script checks the student huffman encode and decode scripts
% use: verify_encode_decode_huffman('name_of_huffman_encoder', 'name_of_huffman_decoder')

% define execution strings
student_encoder=strcat('bitstream_test=',student_huffman_encoder,'(bitstream_test, huffman_table, signal);')
student_decoder=strcat('[bitstream_test signal_decoded_test]=',student_huffman_decoder,'(bitstream_test, huffman_table);')

% define variables
bitstream_ref = [24 0 24 12880738];
bitstream_test=(bitstream_init);
signal = [244 244;245 244;243 244;243 244;244 244;243 244;244 244;245 244;243 244;242 242;240 241];

% load Huffman-table for defined signal
load huffman_table.mat;

% Print signal
signal

% test student encode signal to huffman bitstream
fprintf('Start Encoding:\n');
eval(student_encoder);

fprintf('Verify Encoding:\n');
% compare bitstreams
if(sum(bitstream_ref==bitstream_test)==size(bitstream_ref,2))
	fprintf('Encoded Bitstream ok!\n');
% 	bitstream_test
else
	fprintf('Encoded Bitstream wrong!\n');
end


%% Decodierung
% test decode signal from bitstream
fprintf('Start Decoding:\n');
eval(student_decoder);

% compare decoded signals
fprintf('Verify Decoding:\n');
if(sum(sum(signal==signal_decoded_test))==(size(signal,2)*size(signal,1)))
	fprintf('Decoded Bitstream ok!\n');
else
	fprintf('Decoded Bitstream wrong!\n');
end

% Print decoded signal
signal_decoded_test
