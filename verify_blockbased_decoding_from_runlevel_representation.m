function verify_blockbased_decoding_from_runlevel_representation

for n=1:2
	if n==1
		blocksize = 4;

		zigzag_scanned_expected = ...
		[15 1 0 0 0 -1 0 0 0 0 0 0 0 0 0 0; ...
		12 -1 -1 0 -1 0 0 0 0 0 0 0 0 0 0 0; ...
		13 -1 -1 0 0 0 1 0 0 0 0 0 0 0 0 0; ...
		13 -1 -1 0 0 0 -1 -1 0 0 0 0 0 0 0 0; ...
		15 0 1 0 -1 0 0 -1 0 0 0 0 0 0 0 0; ...
		17 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0; ...
		17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

		runlevel_representation = ...
		[0 15; 0 1; 3 -1; -1 -1; 0 12; 0 -1; 0 -1; 1 -1; -1 -1; 0 13; ...
		0 -1; 0 -1; 3 1; -1 -1; 0 13; 0 -1; 0 -1; 3 -1; 0 -1; -1 -1; ...
		0 15; 1 1; 1 -1; 2 -1; -1 -1; 0 17; 5 -1; -1 -1; 0 17; -1 -1];
	else
		blocksize = 1;
		zigzag_scanned_expected = 0;
		runlevel_representation = [-1 -1];
	end

	zigzag_scanned = ...
		blockbased_decoding_from_runlevel_representation ...
		(runlevel_representation, blocksize);

	fprintf('\nTest %i (blocksize=%i):\n\n', n, blocksize)
	fprintf('Input data (runlevel_representation):\n')
	disp(runlevel_representation)
	fprintf('\nExpected zigzag-scanned data:\n')
	disp(zigzag_scanned_expected)
	fprintf('\nYour zigzag-scanned data:\n')
	disp(zigzag_scanned)

	ok = size(zigzag_scanned)==size(zigzag_scanned_expected);

	if ok
		ok = zigzag_scanned==zigzag_scanned_expected;
	end

	if ok
		fprintf('\n===== OK! =====\n\n')
	else
		fprintf('\n===== ERROR FOUND! =====\n\n')
	end
end