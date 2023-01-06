function zigzag_scanned = optional_dc_prediction_inverse(zigzag_scanned)
for i = 2:size(zigzag_scanned,1)
    zigzag_scanned(i,1) = zigzag_scanned(i,1) + zigzag_scanned(i-1,1);
end