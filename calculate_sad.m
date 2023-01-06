%IVC Lab 4.1
function sad_value = calculate_sad(input_block1, input_block2)
sad_value = sum(sum(abs(input_block1-input_block2)));

