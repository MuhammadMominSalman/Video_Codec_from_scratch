function verify_blockbased_encoding_to_zigzag_scanned
%
% function verify_blockbased_encoding_to_zigzag_scanned
%

% Stefan Wehr, 2005


height		= 8;			% input image height: 8 pixel
width		= 6;			% input image width:  6 pixel
blocksize	= 2;			% blocksize

input_image	= [	...			% input_image
	 1  2  5  6  9 10;	...
	 3  4  7  8 11 12;	...
	13 14 17 18 21 22;	...
	15 16 19 20 23 24;	...
	25 26 29 30 33 34;	...
	27 28 31 32 35 36;	...
	37 38 41 42 45 46;	...
	39 40 43 44 47 48	];

zigzag_scanned	= [	...		% expected zigzag_scanned
	 1  2  3  4;	...
	 5  6  7  8;	...
	 9 10 11 12;	...
	13 14 15 16;	...
	17 18 19 20;	...
	21 22 23 24;	...
	25 26 27 28;	...
	29 30 31 32;	...
	33 34 35 36;	...
	37 38 39 40;	...
	41 42 43 44;	...
	45 46 47 48		];

your_zigzag_scanned = blockbased_encoding_to_zigzag_scanned(input_image,blocksize);


fprintf('\n\n')
fprintf('image height:  %d\n',height)
fprintf('image width:   %d\n',width)
fprintf('blocksize:     %d\n',blocksize)

fprintf('\n\n given input_image:\n\n')
disp(input_image);

fprintf('\n expected zigzag_scanned:\n\n')
disp(zigzag_scanned);

fprintf('\n your zigzag_scanned:\n\n')
disp(your_zigzag_scanned);

if isequal(zigzag_scanned,your_zigzag_scanned)
	fprintf('\n OK !!!\n\n')
else
	fprintf('\n ERROR !!!\n\n')
end



