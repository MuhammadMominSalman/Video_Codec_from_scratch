%lab 4 main
%  clc
% [y_reference, y_current] = create_mv_test_matrix;
% sad = calculate_sad(y_reference(5:6, 3:4), y_current(5:6,3:4)); %should be 66 d = (0,0)
% searchrange = 2;
% padded_current = padarray(y_current,[searchrange searchrange],'replicate','post'); %searchrange = 2
% padded_current = padarray(padded_current,[searchrange searchrange],'replicate','pre');
% padded_reference = padarray(y_reference,[searchrange searchrange],'replicate','post');
% padded_reference = padarray(padded_reference,[searchrange searchrange],'replicate','pre');
% searchrange = 8;
% blocksize = [16,16];
% [img1, img2] = create_synthetic_images(288, 352, 4, 4);
% imshowpair(img1,img2)
% imgx = sum(sum(img1 - img2));
% motion_vectors = blockbased_motion_search(img2, img1, blocksize, searchrange);
% plot_motion_vectors(288, 352, blocksize(1), searchrange, motion_vectors)

%exercise 4.4
% input_image = yuv_read_one_frame('flowergarden_short_cif.yuv',1, 352, 288);
% %subplot(1,2,1), imshow(input_image)
img2 =yuv_read_one_frame('flowergarden_short_cif.yuv',2, 352, 288);
%subplot(1,2,2), imshow(img2)
load('flower_motion.mat');
searchrange = 8;
blocksize = [16,16];
motion_vectors = blockbased_motion_search(img2, input_image, blocksize, searchrange);
plot_motion_vectors(288, 352, blocksize(1), searchrange, motion_vectors_flower)
plot_motion_vectors(288, 352, blocksize(1), searchrange, motion_vectors)
motionvectordiff = sum(sum(motion_vectors - motion_vectors_flower));
% 
output_image = blockbased_motion_compensation(input_image, blocksize, searchrange, motion_vectors_flower);
[motion_compensated_frame] = verify_motion_compensation;
imshowpair(output_image, motion_compensated_frame, 'montage');
psnr_of_frame(img2, output_image);
imgx = sum(sum(output_image - motion_compensated_frame));
% x = [];
% psnr = [];
% for i = 1:5
%     motion_vectors = blockbased_motion_search(img2, input_image, blocksize, 2^i);
%     output_image = blockbased_motion_compensation(input_image, blocksize, 2^i, motion_vectors);
%     x = [x, 2^i];
%     psnr = [psnr; psnr_of_frame(img2, output_image)];
% end
% plot(x,psnr)