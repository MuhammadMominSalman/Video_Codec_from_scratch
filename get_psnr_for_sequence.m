function [psnr,framemse]=get_psnr_for_sequence(original,distorted,width,height,nr_of_frames)
% [psnr,framemse]=get_psnr_for_sequence(original,distorted,width,height,nr_of_frames)
%
% get psnr (and mse per frame) for YUV components of a given sequence
for i=1:nr_of_frames
  [orig_y,orig_u,orig_v]=yuv_read_one_frame(original,i,width,height);
  [dis_y,dis_u,dis_v]=yuv_read_one_frame(distorted,i,width,height);
  framemse(i,1)=sum(sum((orig_y-dis_y).^2))/(width*height);
  framemse(i,2)=sum(sum((orig_u-dis_u).^2))/(width*height);
  framemse(i,3)=sum(sum((orig_v-dis_v).^2))/(width*height);
end %for i
psnr=10*log10(1./(mean(framemse)));
