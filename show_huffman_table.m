function show_huffman_table(huffman_table)
% function show_huffman_table(huffman_table)
% Displays the codewords and the symbol for the huffman_table in a
% readable fashion
disp('Huffman_table')
for row_nr=1:size(huffman_table,1)
  this_symbol=huffman_table{row_nr,1};
  for col_nr=1:size(this_symbol,2)
    %fprintf('%ld\t',this_symbol(col_nr));
    fprintf('%ld',this_symbol(col_nr));
  end
  fprintf('\t');
  this_huffman_code=huffman_table{row_nr,2};
  fprintf(':\t');
  for col_nr=1:size(this_huffman_code,2)
    fprintf('%ld\t',this_huffman_code(col_nr));
  end
  fprintf('\n');
end
