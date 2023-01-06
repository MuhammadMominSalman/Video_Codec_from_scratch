function verify_decoding_from_runlevel_representation


% read test data from file
load('verify_runlevel_representation.mat')

num_tests = length(length_of_zigzag_scanned);

fprintf('\n')

for n=1:num_tests
	fprintf('Test %2d (blocksize: %2d):  ', n, blocksizes(n))

	% get test data for current test
	zigzag_scanned_expected = ...
		zigzag_scanned_array(n, 1:length_of_zigzag_scanned(n));
	run_levels = zeros(lines_in_run_levels(n), 2);
	run_levels(:,:) = run_levels_array(n, 1:lines_in_run_levels(n), :);

	% calculate result using function under test
	zigzag_scanned = decoding_from_runlevel_representation(run_levels, ...
		blocksizes(n));

	% Test for the same matrix size
	ok = size(zigzag_scanned, 2)==size(zigzag_scanned_expected, 2);
	if ok
		ok = size(zigzag_scanned, 1)==1;
	end
	% Test for the same matrix content
	if ok
		ok = min(zigzag_scanned==zigzag_scanned_expected);
	end

	if ok
		fprintf('OK\n')
	else
		fprintf('ERROR!\n\n')
		fprintf('Run/level representation:\n')
		disp(run_levels)
		fprintf('Your output vector:\n')
		disp(zigzag_scanned)
		fprintf('Expected output vector:\n')
		disp(zigzag_scanned_expected)
		fprintf('\n===== ERROR FOUND! =====\n')

		break
	end
end

fprintf('\n')
