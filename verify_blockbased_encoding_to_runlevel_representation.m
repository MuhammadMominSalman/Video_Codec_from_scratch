function verify_blockbased_encoding_to_runlevel_representation

for n=1:2
	if n==1
		zigzag_scanned = ...
		[15 1 0 0 0 -1 0 0 0 0 0 0 0 0 0 0; ...
		12 -1 -1 0 -1 0 0 0 0 0 0 0 0 0 0 0; ...
		13 -1 -1 0 0 0 1 0 0 0 0 0 0 0 0 0; ...
		13 -1 -1 0 0 0 -1 -1 0 0 0 0 0 0 0 0; ...
		15 0 1 0 -1 0 0 -1 0 0 0 0 0 0 0 0; ...
		17 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0; ...
		17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

		runlevel_representation_expected = ...
		[0 15; 0 1; 3 -1; -1 -1; 0 12; 0 -1; 0 -1; 1 -1; -1 -1; 0 13; ...
		0 -1; 0 -1; 3 1; -1 -1; 0 13; 0 -1; 0 -1; 3 -1; 0 -1; -1 -1; ...
		0 15; 1 1; 1 -1; 2 -1; -1 -1; 0 17; 5 -1; -1 -1; 0 17; -1 -1];
	else
		zigzag_scanned = 0;
		runlevel_representation_expected = [-1 -1];
	end

	runlevel_representation = blockbased_encoding_to_runlevel_representation ...
		(zigzag_scanned);

	fprintf('\nTest %i:\n\n', n)
	fprintf('Input data (zigzag_scanned):\n')
	disp(zigzag_scanned)
	fprintf('\nExpected run/level representation:\n')
	disp(runlevel_representation_expected)
	fprintf('\nYour run/level representation:\n')
	disp(runlevel_representation)

	ok = size(runlevel_representation)==size(runlevel_representation_expected);

	if ok
		ok = runlevel_representation==runlevel_representation_expected;
	end

	if ok
		fprintf('\n===== OK! =====\n\n')
	else
		fprintf('\n===== ERROR FOUND! =====\n\n')
	end
end