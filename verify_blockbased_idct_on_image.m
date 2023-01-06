function verify_blockbased_idct_on_image()
%
% function verify_blockbased_idct_on_image()
%

% Stefan Wehr, 2005

load('verify_blockbased_idct_on_image_testimages');	% load IDCT-testimages
vM = [2 4 8];					% illustrate blocksizes 2,4,8


% plot IDCT-coefficents and images
H = figure;
set(gcf,'Position',[173 174 809 750]);

for iM = 1:length(vM)
	
	M = vM(iM);

	subplot(3,3,iM)
	imshow(testimage.input{M})
	if iM == 1,	ylabel('input DCT-coeff.'); end
	title(sprintf('blocksize = %d',M))
	plotGrid(M);

	subplot(3,3,iM+3)
	imshow(testimage.output{M})
	if iM == 1,	ylabel('expected image'); end
	plotGrid(M);

	subplot(3,3,iM+6)
	output{M} = blockbased_idct_on_image(testimage.input{M},M);
	imshow(output{M})
	if iM == 1,	ylabel('your image'); end
	plotGrid(M);

end

% print images (only for blocksize 2)
fprintf('\n\n')
for iM = 1:1
	
	M = vM(iM);
	
	fprintf([repmat('=',1,58) '\n'])
	fprintf(' blocksize = %d\n',M)
	fprintf([repmat('=',1,58) '\n\n'])
	fprintf('| (row,col) || expected pixel value |   your pixel value  |\n')
	fprintf([repmat('-',1,58) '\n'])
	
	for row = 1:size(testimage.output{M},1)
	for col = 1:size(testimage.output{M},2)
		fprintf('| ( %d , %d ) ||  %19.10f | %19.10f |\n',...
			row,col,testimage.output{M}(row,col),output{M}(row,col))
	end 
	end
	
	fprintf([repmat('-',1,58) '\n'])
	fprintf('\n\n')
	
end


function plotGrid(M)
for m = M:M:M^2-M
	line([m+0.5 m+0.5],[0.5 M^2+.5],'LineWidth',2,'LineStyle','-','Color','r')
	line([0.5 M^2+.5],[m+0.5 m+0.5],'LineWidth',2,'LineStyle','-','Color','r')
end

