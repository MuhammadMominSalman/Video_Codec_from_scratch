function output_mse= mse_of_frame(orignal_image, distorted_image)
[h,w] = size(orignal_image);
x = (orignal_image - distorted_image).^2;
output_mse = sum(x, "all");
output_mse = output_mse/(h*w);
end