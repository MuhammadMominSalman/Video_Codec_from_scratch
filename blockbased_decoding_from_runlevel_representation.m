function zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation, blocksize)
zigzag_scanned = [];
prev = 0;
for i= 1:size(runlevel_representation,1)
    if runlevel_representation(i,:) == [-1,-1]
        next = i;
        array = runlevel_representation(prev+1:next-1,:);
        prev = i;
        zigzag_scanned = [zigzag_scanned; decoding_from_runlevel_representation(array,blocksize)];
    end
end