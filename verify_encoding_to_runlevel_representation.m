function verify_encoding_to_runlevel_representation


% read test data from file
load('verify_runlevel_representation.mat')

num_tests = length(length_of_zigzag_scanned);

fprintf('\n')

for n=1:num_tests
	fprintf('Test %2d (input length: %3d):  ', n, length_of_zigzag_scanned(n))

	% get test data for current test
	zigzag_scanned = zigzag_scanned_array(n, 1:length_of_zigzag_scanned(n));
	run_levels_expected = zeros(lines_in_run_levels(n), 2);
	run_levels_expected(:,:) = run_levels_array(n, 1:lines_in_run_levels(n), :);

	% calculate result using function under test
	run_levels = encoding_to_runlevel_representation(zigzag_scanned);

	% Test for the same matrix size
	ok = size(run_levels, 1)==size(run_levels_expected, 1);
	if ok && size(run_levels, 1)>0 && size(run_levels_expected, 1)>0
		ok = size(run_levels, 2)==2;
	end
	% Test for the same matrix content
	if ok && size(run_levels, 1)>0 && size(run_levels_expected, 1)>0
		ok = min(run_levels==run_levels_expected);
	end

	if ok
		fprintf('OK\n')
	else
		fprintf('ERROR!\n\n')
		fprintf('Input vector:\n')
		disp(zigzag_scanned)
		fprintf('Expected run/level representation:\n')
		disp(run_levels_expected)
		fprintf('Your run/level representation:\n')
		disp(run_levels)
		fprintf('\n===== ERROR FOUND! =====\n')

		break
	end
end

fprintf('\n')
