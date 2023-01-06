function output_psnr=psnr_of_frame(orignal_image, distorted_image)

[h,w] = size(orignal_image);
x = (orignal_image - distorted_image).^2;
output_psnr = sum(x, "all");
output_psnr = (h*w)/output_psnr;
output_psnr = 10*log10(output_psnr);
end