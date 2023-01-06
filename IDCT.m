%for use in 5.2
function image = IDCT(coeff_matrix)
image = zeros(size(coeff_matrix));
M = size(coeff_matrix,1); %vertical length/height/number of rows
N = size(coeff_matrix,2);

for m = 0:M-1
    for n = 0:N-1
        for l = 0:N-1
            for k = 0:M-1            
                if k == 0
                    lambda_k = sqrt(1/M);
                else
                    lambda_k = sqrt(2/M);
                end
                  if l == 0
                    lambda_l = sqrt(1/N);
                else
                    lambda_l = sqrt(2/N);
                  end       
                image(m+1,n+1)= image(m+1,n+1)+ lambda_k*lambda_l*coeff_matrix(k+1,l+1)*cos((pi*(2*m+1)* k)/(2*M))*cos((pi*(2*n+1)*l)/(2*N));
            end            
        end   
    end
end