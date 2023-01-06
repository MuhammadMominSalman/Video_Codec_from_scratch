function [rate,psnr,enc_time,dec_time]=get_final_result(sequence)
% function [rate,psnr,enc_time,dec_time]=get_final_result(sequence)

encoder_function='final_encoder';
decoder_function='final_decoder';
qp_values=[6,8,10,15,20];
%  [rate,psnr,enc_time,dec_time]=get_dr_result(encoder_function, decoder_function, sequence, qp_values, transform_size,me_searchrange, me_blocksize);
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
[status,mess, messid]=mkdir('~/final');
if(~status)
    fprintf ('Error: Cannot create directory! Reason: %s\n',mess);
    return;
end
if (~exist(sequence))
  fprintf ('Error: Cannot find sequence: %s\n',sequence);
  return;
end %if

for qp_count=1:length(qp_values)
  qp=qp_values(qp_count);
  coded_file=sprintf('~/final/%s_bitstream_QP%s.mat',regexprep(sequence,'\.yuv$',''),num2str(qp));
  reconfile=sprintf('~/final/%s_recon_QP%s.yuv',regexprep(sequence,'\.yuv$',''),num2str(qp));

  fprintf ('Simulating QP %d\n',qp);
  enc_cmd=sprintf('%s(sequence,coded_file,352,288,5,qp);',encoder_function);
  dec_cmd=sprintf('%s(coded_file,reconfile);',decoder_function);
  tic;
  eval(enc_cmd);
  enc_time(qp_count)=toc
  tic;
  eval(dec_cmd);
  dec_time(qp_count)=toc
  fileinfo=dir(coded_file);
  rate(qp_count)=fileinfo.bytes*8*12.5/5/1024;
  seqpsnr=get_psnr_for_sequence(sequence,reconfile,352,288,5);
  psnr(qp_count)=seqpsnr(1)
  % delete(coded_file);
  % delete(reconfile);
end %for qp
fh=figure(1);
subplot(1,2,1)
p=plot(rate,psnr,'DisplayName',regexprep(sequence,'\.yuv$',''));
xlabel ('Rate in kbit/s');
ylabel ('PSNR_Y in dB', 'Interpreter', 'none'); % do not interpret underscore with LaTeX
title('D(R)-Curve');
grid on
legend('off');
set(legend('show'), 'Interpreter', 'none');
hold all
subplot(1,2,2)
hold all
p=plot(qp_values,enc_time,'-o','DisplayName',['enc time ' regexprep(sequence,'\.yuv$','')]);
p=plot(qp_values,dec_time,'-.o','DisplayName',['dec time ' regexprep(sequence,'\.yuv$','')]);
set(gca,'XDir','reverse')
legend('off');
set(legend('show'), 'Interpreter', 'none');
grid on
xlabel ('QP');
ylabel ('Time in s');
title('Encoding/Decoding Time');
saveas(fh,'~/final/final_dr_result.fig');
filename='~/final/final_dr_result.eps';
print('-f1', '-deps2c', filename);
statfile=sprintf('~/final/%s_%s.mat',encoder_function,regexprep(sequence,'\.yuv$',''));
save(statfile,'psnr','rate','sequence','qp_values','encoder_function','decoder_function','enc_time','dec_time');


