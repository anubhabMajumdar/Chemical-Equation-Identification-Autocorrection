function [m,coord] = return_peak_location(image2)

%figure,imshow(image2),title('image');

coordinate =0;

[M2,N2] = size(image2);
    %Horizonal Projection of remaining characters
h_proj2 = zeros(1,M2);  
for i = 1:M2
    for j = 1:N2
        if(image2(i,j) == 1)
            h_proj2(i) = h_proj2(i) + 1;
        end
    end
end

h2 = zeros(size(image2));
temp = h_proj2;


%figure,plot(temp),title('horizontal projection');

coordinate= find(temp==max(temp));
m=max(temp);
coord=coordinate(1);



end