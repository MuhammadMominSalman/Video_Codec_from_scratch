function huffman_table = create_huffman_table_from_signal(input_signal)
[x,y,z] = unique(input_signal, 'rows');
% symbol_count = zeros(size(x,1),1); %note size(x,1) returns size of dimension 1 of x
symbol_count = accumarray(z, 1); %maps count to corresponding element in x i.e. unique rows
hyper_total = size(input_signal,1);
probability_matrix = [symbol_count/hyper_total x];
huffman_table = create_huffman_table_from_probability(probability_matrix);





