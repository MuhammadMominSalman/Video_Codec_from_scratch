function verify_intra_coding(qp)
% verify_intra_coding(qp)
%
% test function for encode_intra.m and decode_intra.m
%
% reads one frame from the sequence 'flowergarden_short_cif.yuv',
% codes it to the file 'coded_file.mat', and decodes it
% The resulting image is shown and compared to the original image
%
% For 'qp', a vector can be specified containing more than one
% quantisation parameter. In that case, all qp's are tested
% and a RD-curve is shown

input_yuv_file = 'flowergarden_short_cif.yuv';
coded_file = 'coded_file.mat';
decoded_yuv_file = 'decoded_yuv_file.yuv';
width = 352;
height = 288;
transformation_blocksize = 8;

bpp_values = [];
psnr_values = [];

if nargin~=1
	error('Specify one ore more quantisation parameters QP, please!')
end

Y_original = yuv_read_one_frame(input_yuv_file, 1, width, height);

% change Default font size (12)
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultTextFontSize',16)
set(0,'DefaultLineLineWidth',2)
set(0,'DefaultLineMarkerSize',12)

h = figure;
hold off
set(h, 'Position', [100 100 1000 800])
subplot(2, 2, 1)
imshow(Y_original)
title('Original image')


for n=1:length(qp(:))
	qp_now = qp(n);

	fprintf('Encoding image, QP=%i\n', qp_now)
	encode_intra(input_yuv_file, coded_file, width, height, ...
		transformation_blocksize, qp_now)

	fprintf('Decoding image\n')
	decode_intra(coded_file, decoded_yuv_file)

	fprintf('Showing reconstructed image\n')
	Y_reconstructed = yuv_read_one_frame(decoded_yuv_file, 1, width, height);

	subplot(2, 2, 2)
	imshow(Y_reconstructed)
	title('Reconstructed image')

	% calculate quality measures
	Y_diff = Y_reconstructed - Y_original;
	mse = mean(Y_diff(:).*Y_diff(:));
	if (mse==0)
		psnr = inf;
	else
		psnr = 10*log10(1 / mse);
	end

	fileinfo = dir(coded_file);
	reconstructed_size = 8*fileinfo.bytes;
	bpp = reconstructed_size / (width*height);
	original_size = 8*width*height;
	coderate = original_size / reconstructed_size;

	% display quality measures
	s = sprintf(['QP = %i\nMSE = %.5f\nPSNR = %.2f dB\ndata rate = %.3f bpp\n' ...
		'code rate = %.2f'], ...
		qp_now, mse, psnr, bpp, coderate);
	text(80, 530, s)

	% display RD-curve
	bpp_values = [bpp_values, bpp];
	psnr_values = [psnr_values, psnr];

	subplot(2, 2, 3)
	plot(bpp_values, psnr_values, 'b-x')
	axis([0 5 0 50])
	grid on
	xlabel('data rate [bpp]')
	ylabel('PSNR [dB]')

	pause(0.5)
end
