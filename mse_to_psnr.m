function psnr=mse_to_psnr(mse_per_frame)
% psnr=mse_to_psnr(mse_per_frame)
%
% calculate PSNR in dB given the mse_per_frame vector
psnr=10*log10(1/mean(mse_per_frame));
