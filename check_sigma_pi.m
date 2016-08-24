function [symbol] = check_sigma_pi(operand_line, avg_blob_height)

%%

%symbol = 0 ---> Not recognized
%symbol = 1 ---> sigma
%symbol = 2 ---> pi

%%
[operand_line, n] = bwlabel(operand_line);
stat = regionprops(operand_line, 'BoundingBox');

%figure,imshow(operand_line),title(num2str(n));

if n==0
    symbol = 0;
    return
end

for q = 1:n
    
    img = im2bw(imcrop(operand_line, stat(q).BoundingBox));
    
    img = imfill(img,'holes');
    
    %figure,imshow(img), title(num2str(q));
    
    symbol = 0;

    [r,c] = size(img);
    
    if (r>10 && c>10)
    projection = h_proj_sigma(img);


    black_count = zeros(1,r);

    leeway = 5;

    top_white_count = max(projection(1:leeway));
    bottom_white_count = max(projection(r-leeway:r));

    leeway2 = 10;

    vertical_proj = h_proj_sigma(rot90(img));
    top_vertical_white_count = max(vertical_proj(1:leeway2));
    bottom_vertical_white_count = max(vertical_proj(c-leeway2:c));


    top_pos = find(projection(1:leeway) == top_white_count);
    bottom_pos = find(projection(r-leeway:r) == bottom_white_count)+(r-11);

    for i=top_pos:bottom_pos
        for j=1:c
            if (img(i,j) == 0)
                black_count(i) = black_count(i) + 1;
            else
                break;
            end
        end
    end
    black_max = max(black_count);
    black_max_pos = find(black_count == black_max);

    black_max_pos = round(mean(black_max_pos));

    false_count = 2;
    top_half_flag = 0;
    bottom_half_flag =0;

    for i=top_pos:black_max_pos
        if (black_count(i)<black_count(i+1))
            continue;
        elseif ((black_count(i)>black_count(i+1)) && false_count > 0)
            false_count = false_count - 1;
        elseif ((black_count(i)>black_count(i+1)) && false_count <= 0)
            top_half_flag = 1;
            break;
        end
    end

    false_count = 2;

    for i=black_max_pos:bottom_pos-1
        if (black_count(i)>black_count(i+1))
            continue;
        elseif ((black_count(i)<black_count(i+1)) && false_count > 0)
            false_count = false_count - 1;
        elseif ((black_count(i)<black_count(i+1)) && false_count <= 0)
            bottom_half_flag = 1;
            break;
        end
    end
    %(abs(top_vertical_white_count-bottom_vertical_white_count))

    %count black pixels from bottom to top in the middle column

    black_from_bottom = 0;

    for i=r:-1:1
        if (img(i,round(c/2))==0)
            black_from_bottom = black_from_bottom + 1;
        else
            break;
        end
    end




    if ((r>=(2*avg_blob_height/3) && c>=(avg_blob_height/3)) && (top_white_count>=round((2*c)/3)) && (bottom_white_count>=round((2*c)/3)) && (black_max_pos >=round((r/2)-5) && black_max_pos <=round((r/2)+5)) && (top_half_flag == 0 && bottom_half_flag == 0))
        imtool(img);
        %figure,plot(black_count);
        symbol = 1;
        return;
    elseif ((r>=(2*avg_blob_height/3) && c>=(avg_blob_height/3)) && (top_white_count>=round((2*c)/3)) && (top_vertical_white_count >= (2*r/3)) && (bottom_vertical_white_count >= (2*r/3)) && black_from_bottom>(2*r/3))
        imtool(img);
        %figure,plot(black_count);
        symbol = 2;
        return;
    else
        symbol = 0;
        %return;
    end
    end

end
end