function huffman_table = create_huffman_table_from_probability(probability_matrix)
sorted_probability_matrix = sortrows(probability_matrix);
nr_of_codewords = size(sorted_probability_matrix,1);
huffman_table = cell(nr_of_codewords, 2);
final = size(probability_matrix,2);
for i = 1:nr_of_codewords
    huffman_table{i, 2} = sorted_probability_matrix(i,2:final);
end

huffman_tree = cell(nr_of_codewords, 2);
for i = 1:nr_of_codewords
    huffman_tree{i, 1} = sorted_probability_matrix(i,1);
    huffman_tree{i, 2} = i;
end
% show_huffman_tree(huffman_tree);
%exercise 2.5 starts here///////////////////////////////////////////////

 while(size(huffman_tree,1)>1)
    for t = 1:size(huffman_tree{1,2},2)
    huffman_table{huffman_tree{1,2}(t),1} = [1 huffman_table{huffman_tree{1,2}(t),1}];%need a vector here
    end
    for t = 1:size(huffman_tree{2,2},2)
    huffman_table{huffman_tree{2,2}(t),1} = [0 huffman_table{huffman_tree{2,2}(t),1}];
    end

    new_huffman_tree = cell((size(huffman_tree, 1))-1, 2); %current huffman tree size -1
    new_huffman_tree{1,1} = huffman_tree{1,1}+huffman_tree{2,1};
    new_huffman_tree{1,2} = [huffman_tree{1,2} huffman_tree{2,2}];
    for f = 2:size(huffman_tree, 1)-1
        new_huffman_tree{f,1} = huffman_tree{f+1,1};
        new_huffman_tree{f,2} = huffman_tree{f+1,2};
    end

    huffman_tree = cell(size(new_huffman_tree));%overwriting original huffman tree
    new_probabilities = [new_huffman_tree{:,1}];
    [new_probabilities I] = sort(new_probabilities);
    for i = 1:size(new_huffman_tree)
        huffman_tree{i,1} = new_probabilities(i); 
        huffman_tree{i,2} = new_huffman_tree{I(i),2};
    end
%     show_huffman_table(huffman_table)
%     show_huffman_tree(huffman_tree)
 end