function verify_generate_zigzag_permutation_matrix
%
% function verify_generate_zigzag_permutation_matrix
%

% Stefan Wehr, 2005

load('verify_generate_zigzag_permutation_matrix_data');

% reference data: perm_mat{width,height}
width	= size(perm_mat,1);
height	= size(perm_mat,2);


fprintf('\n\nVerifing "generate_zigzag_permutation_matrix"...\n')

for w = 1:width, for h = 1:height
	
	tmp = generate_zigzag_permutation_matrix(w,h);
	
	fprintf('w = %d, h = %d:  ',w,h); 
	if isequal(tmp,perm_mat{w,h})
		fprintf('OK\n')
	else
		fprintf('ERROR\n\n')
		fprintf('expected permutation matrix:\n'), disp(perm_mat{w,h})
		fprintf('    your permutation matrix:\n'), disp(tmp)
		return;
	end
	
end, end

