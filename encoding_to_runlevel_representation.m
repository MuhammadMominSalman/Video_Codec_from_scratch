%lab 5.8
function runlevel_representation = encoding_to_runlevel_representation(input_vector)
runlevel_representation = [];
nzi = find(input_vector);
for i = 1: size(nzi,2)
    if i >1
        curr = nzi(i-1);
        next = nzi(i);
        run = next-curr-1;
        level = input_vector(next);
    end
    if i == 1
      if nzi(1) > 1
        run = nzi(1)-1;
        level = input_vector(nzi(1));
      else
%         curr = nzi(i-1)
%         next = nzi(i)
        run = 0;
        level = input_vector(nzi(1));
      end    
    end
        if i == 1
            runlevel_representation = [run, level];
        else
            runlevel_representation = [runlevel_representation; run, level];
        end     
end 

            
            
        
    
        
    
