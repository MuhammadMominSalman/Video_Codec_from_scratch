function displayDRcurve(image)
bits = [];
psnr = [];
for i=1:10:99
    imwrite(image,"newfile.jpeg", "jpeg", "Quality",i);
    bits = [bits get_image_filesize("newfile.jpeg")];
    lossy_image = imread("newfile.jpeg");
    lossy_image = im2double(lossy_image)
    psnr = [psnr psnr_of_frame(image, lossy_image)];
    plot(bits, psnr);
    imshow(image);
    imshow(lossy_image);
end
end