function [h_proj2]=h_proj_sigma(image2)

[M3,N3] = size(image2);
    %Horizonal Projection of remaining characters
h_proj2 = zeros(1,M3);  
for i = 1:M3
    for j = 5:N3
        if(image2(i,j) == 1)
            h_proj2(i) = h_proj2(i) + 1;
%         elseif ((image2(i,j) == 0) && (j<=(N3-3)) && (image2(i,j+3)==0))
%             break;
         end
    end
end


%figure,plot(temp),title('horizontal projection');


end