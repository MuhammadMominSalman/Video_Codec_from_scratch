%5.3
function permutations_matrix = generate_zigzag_permutation_matrix(width, height)
permutations_matrix = zeros(height,width);
output = [];
num_rows = height;
num_cols = width;
current_col =1;
current_row =1;
current_index = 1;
total_elements = height*width;
while current_index<=total_elements
    if current_row==1 & mod(current_row+current_col,2)==0 & current_col ~=num_cols
        permutations_matrix(current_row, current_col)= current_index;
        current_col = current_col+1;
        current_index = current_index+1;
    elseif current_col==1 & mod(current_row+current_col,2)~=0 & current_row ~=num_rows
        permutations_matrix(current_row, current_col)=current_index;
        current_row = current_row+1;
        current_index = current_index+1;
     elseif current_col==num_cols & mod(current_row+current_col,2)==0 & current_row ~=num_rows
        permutations_matrix(current_row, current_col)=current_index;
        current_row = current_row+1;
        current_index = current_index+1;
    elseif current_row==num_rows & mod(current_row+current_col,2)~=0 & current_col~= num_cols
        permutations_matrix(current_row, current_col)=current_index;
        current_col = current_col+1;
        current_index = current_index+1;
    elseif current_row~=1 & mod(current_row+current_col,2)==0 & current_col~= num_cols
        permutations_matrix(current_row, current_col)=current_index;
        current_col = current_col+1;
        current_row = current_row-1;
        current_index = current_index+1;
    elseif current_col~=1 & mod(current_row+current_col,2)~=0 & current_row~= num_rows
        permutations_matrix(current_row, current_col)=current_index;
        current_col = current_col-1;
        current_row = current_row+1;
        current_index = current_index+1;
    elseif current_row == num_rows & current_col == num_cols
        permutations_matrix(current_row, current_col)=current_index;
        break
    end
end

    
        
        
   