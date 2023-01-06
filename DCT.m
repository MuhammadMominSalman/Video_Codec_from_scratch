%to be used in 5.1
function coeff_matrix = DCT(image)
coeff_matrix = zeros(size(image));
M = size(image,1); %vertical length/height/number of rows
N = size(image,2);
lambda_k = sqrt(1/M);
lambda_l = sqrt(1/N);
for k = 0:M-1
    for l = 0:N-1
        if k ~= 0
            lambda_k = sqrt(2/M);
        end
        if l ~= 0
            lambda_l = sqrt(2/N);
        end
        for n = 0:N-1
            for m = 0:M-1
                coeff_matrix(l+1,k+1)= coeff_matrix(l+1,k+1)+ image(n+1,m+1)*cos((pi*(2*m+1)* k)/(2*M))*cos((pi*(2*n+1)*l)/(2*N));
            end            
        end   
        coeff_matrix(l+1,k+1) = lambda_k*lambda_l*coeff_matrix(l+1,k+1);
        lambda_l = sqrt(1/N);
    end
end

        
        
        