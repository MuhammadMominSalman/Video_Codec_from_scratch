function [bitstream, signal] = decode_signal_from_huffman_bitstream(bitstream, huffman_table, nr_of_symbols)
 
 switch nargin
        case 2
            nr_of_symbols = 2^128;
 end
hyper_count = 0;
nr_of_huffman_entries = size(huffman_table,1);
huffman_length = zeros(size(nr_of_huffman_entries));
for i = 1:nr_of_huffman_entries
    huffman_length(i) = size(huffman_table{i,1}, 2); %we need column length so dim in size = 2
end
min_bits = min(huffman_length);
max_bits = max(huffman_length);
signal = [];
  for i = 1:nr_of_symbols
      symbol_found = false;
      current_nr_of_bits = min_bits;
      while((symbol_found == false) && (current_nr_of_bits <= max_bits))
          [this_huffman, new_bitstream] = bitstream_read_bits(bitstream, current_nr_of_bits);
          if isempty(this_huffman)
              disp('The end of the bitstream has been reached');
              break
          end
          symbol_row = find(huffman_length == current_nr_of_bits);
          for i = 1: size(symbol_row,2)%assume symbol_row contains index of h table
              if this_huffman == huffman_table{symbol_row(i),1}
                  this_symbol = huffman_table{symbol_row(i),2};
                  signal = [signal ; this_symbol];
                  bitstream = new_bitstream;
                  symbol_found = true;
                  hyper_count = hyper_count +1;
                  break
              end
          end
          current_nr_of_bits = current_nr_of_bits + 1;
      end    %while ends
      if symbol_found == false
          break
      end
  end   %for end
  
  if hyper_count < nr_of_symbols
      disp("An error has occurred when reading the bitstream")
  end 