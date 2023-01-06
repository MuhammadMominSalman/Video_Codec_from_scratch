function show_huffman_tree(huffman_tree)
% function show_huffman_tree(huffman_tree)
% Displays the peobabilities and the index of the codewords for the huffman_tree
disp('Huffman_tree')
for row_nr=1:size(huffman_tree,1)
  this_symbol=huffman_tree{row_nr,1};
  for col_nr=1:size(this_symbol,2)
    fprintf('%g\t',this_symbol(col_nr));
  end
  this_huffman_code=huffman_tree{row_nr,2};
  fprintf(':');
  for col_nr=1:size(this_huffman_code,2)
    fprintf('%ld ',this_huffman_code(col_nr));
  end
  fprintf('\n');
end
