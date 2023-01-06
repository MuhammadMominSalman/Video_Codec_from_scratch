function zigzaged_scaned = encoding_to_zigzag_scanned(input_image)
permutations_matrix = input_image;
num_rows = size(input_image,1);
num_cols = size(input_image,2);
current_col =1;
current_row =1;
current_index = 1;
total_elements = num_cols*num_rows;
while current_index<=total_elements
    if current_row==1 & mod(current_row+current_col,2)==0 & current_col ~=num_cols
        zigzaged_scaned(current_index) = permutations_matrix(current_row, current_col);
        current_col = current_col+1;
        current_index = current_index+1;
    elseif current_col==1 & mod(current_row+current_col,2)~=0 & current_row ~=num_rows
        zigzaged_scaned(current_index) = permutations_matrix(current_row, current_col);
        current_row = current_row+1;
        current_index = current_index+1;
     elseif current_col==num_cols & mod(current_row+current_col,2)==0 & current_row ~=num_rows
        zigzaged_scaned(current_index) = permutations_matrix(current_row, current_col);
        current_row = current_row+1;
        current_index = current_index+1;
    elseif current_row==num_rows & mod(current_row+current_col,2)~=0 & current_col~= num_cols
        zigzaged_scaned(current_index) = permutations_matrix(current_row, current_col);
        current_col = current_col+1;
        current_index = current_index+1;
    elseif current_row~=1 & mod(current_row+current_col,2)==0 & current_col~= num_cols
        zigzaged_scaned(current_index) = permutations_matrix(current_row, current_col);
        current_col = current_col+1;
        current_row = current_row-1;
        current_index = current_index+1;
    elseif current_col~=1 & mod(current_row+current_col,2)~=0 & current_row~= num_rows
        zigzaged_scaned(current_index) = permutations_matrix(current_row, current_col);
        current_col = current_col-1;
        current_row = current_row+1;
        current_index = current_index+1;
    elseif current_row == num_rows & current_col == num_cols
        zigzaged_scaned(current_index) = permutations_matrix(current_row, current_col);
        break
    end
end

