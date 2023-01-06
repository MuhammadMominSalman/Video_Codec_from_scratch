function [rate,psnr,enc_time,dec_time]=get_dr_result_intra(encoder_function, decoder_function, sequence, qp_values, transform_size)
%  [rate,psnr,enc_time,dec_time]=get_dr_result(encoder_function, decoder_function, sequence, qp_values, transform_size);
%
% comfort function using CIF format and 5 frames to 
% get rate and psnr for a given encoder-decoder pair and given qp_values and sequence (CIF format, 5 frames)
% Also the time for decoding/encoding is returned
%
% example: get_dr_result('encoder_basic','decoder_basic','flowergarden_short_cif.yuv',[4 5 8 10]);
% NOTE: definition of function parameters:
%       encoder_function(sequence, coded_file, width, height, nr_of_frames, transform_blocksize, qp, me_blocksize, me_searchrange)
%       decoder_function(coded_file, decoded_yuv)
%

rate=[];
psnr=[];
framemse=[];
if (~exist(sequence))
  fprintf ('Error: Cannot find sequence: %s\n',sequence);
  return;
end %if

coded_file=sprintf('%s_bitstream.mat',regexprep(sequence,'\.yuv$',''))
reconfile='recon.yuv'
for qp_count=1:length(qp_values)
  qp=qp_values(qp_count);
  fprintf ('Simulating QP %d\n',qp);
  enc_cmd=sprintf('%s(sequence,coded_file,352,288,5,transform_size,qp);',encoder_function);
  dec_cmd=sprintf('%s(coded_file,reconfile);',decoder_function);
  tic;
  eval(enc_cmd);
  enc_time(qp_count)=toc
  tic;
  eval(dec_cmd);
  dec_time(qp_count)=toc
  fileinfo=dir(coded_file);
  rate(qp_count)=fileinfo.bytes*8*12.5/5/1024;
  seqpsnr=get_psnr_for_sequence(sequence,reconfile,352,288,5)
  psnr(qp_count)=seqpsnr(1)
  delete(coded_file);
  delete(reconfile);
end %for qp
figure;
plot(rate,psnr);
xlabel ('Rate in kbit/s');
ylabel ('PSNR_Y in dB');
etstr=sprintf ('enc time: %3.1f',mean(enc_time));
dtstr=sprintf ('dec time: %3.1f',mean(dec_time));
titlstr=sprintf('%s mean durations: %s, %s',encoder_function,etstr,dtstr);
title(titlstr);
statfile=sprintf('%s_%s_%s.mat',sequence,encoder_function,datestr(now,'mmDD_HHMMSS'));
save(statfile,'psnr','rate','sequence','qp_values','encoder_function','decoder_function','transform_size');


