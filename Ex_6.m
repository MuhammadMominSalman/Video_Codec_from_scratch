clc
input_yuv_file = 'vimto_short_cif.yuv';
coded_file = 'coded_file.mat';
decoded_yuv_file = 'decoded_yuv_file.yuv';
% input_yuv_file = ['vimto_short_cif.yuv', 'rugby_short_cif.yuv', 'shuttle_short_cif.yuv']

width = 352;
height = 288;
transformation_blocksize = 8;
qp_values = [5, 10, 16, 28, 32];
me_searchrange = 16;
me_blocksize = [16,16];
% final_encoder(input_yuv_file, coded_file, width, height, 3,	5);
% final_decoder(coded_file, decoded_yuv_file)

[rate,psnr,enc_time,dec_time] = get_dr_result('final_encoder', 'final_decoder', input_yuv_file, qp_values, ...
    transformation_blocksize, me_searchrange, me_blocksize);