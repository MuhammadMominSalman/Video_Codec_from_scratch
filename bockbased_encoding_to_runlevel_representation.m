function runlevel_representation = bockbased_encoding_to_runlevel_representation(zigzag_scanned)
runlevel_representation= [];
for i= 1:size(zigzag_scanned,1)
    runlevel_representation= [runlevel_representation; encoding_to_runlevel_representation(zigzag_scanned(i,:)); -1, -1];
end