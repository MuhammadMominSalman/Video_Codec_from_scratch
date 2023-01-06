function [bitstream] = encode_signal_to_huffman_bitstream(bitstream, huffman_table, signal)

huffman_table_lookup = cell2mat(huffman_table(:,2));
for index = 1:size(signal,1)
    a = signal(index,:);
    find_col1 = find(huffman_table_lookup(:,1) == a(1), size(huffman_table,1));
    find_col2 = find(huffman_table_lookup(find_col1,2) == a(2), 1);
    position_in_huffman_table = find_col1(find_col2);
    huffman_table{position_in_huffman_table,1};
    bitstream = bitstream_append_bits(bitstream, huffman_table{position_in_huffman_table,1});
end