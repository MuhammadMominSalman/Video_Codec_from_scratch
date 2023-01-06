function zigzag_scanned = optional_dc_prediction(zigzag_scanned)
prev_coeff = zigzag_scanned(1,1);
for i=2:size(zigzag_scanned,1)
    current_coeff = zigzag_scanned(i,1);
    zigzag_scanned(i,1) = current_coeff - prev_coeff;
    prev_coeff = current_coeff;
end

