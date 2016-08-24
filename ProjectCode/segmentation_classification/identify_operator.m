function [type] = identify_operator(im)

type = 'other';

%%
AR = aspect_ratio(im);
    
    %%
    if AR>=0.8 && AR<=1.2
         
        fv = feature_vector_plus(im);
        [left_d, right_d] = diagonal_white_black_pixel(im);
         
         if fv(1) > 0.9 && fv(1) <= 1 && fv(2) >= 0.9 && fv(2) <= 1.1 && fv(3) > 0.9 && fv(3) <= 1 && fv(4) >= 0.9 && fv(4) <= 1.2 && left_d >= 2 && right_d >= 2
            %figure, imshow(im), title('PELASSSS');
            %count_plus = count_plus + 1;
            type = 'plus';
         end
         
    elseif AR > 1
        
        [open_img, ~] = openImg(im);
        
        if open_img == 1
            
            end_points = count_end_points(im);
            d = feature_vector_minus(im);
            
            if end_points == 2 && d>=0.8 
                %figure, imshow(im), title('MINUS');
                %count_minus = count_minus + 1;
                type = 'minus';
                
            elseif end_points >= 3
                %figure, imshow(im), title('ARROW');
                %count_arrow = count_arrow + 1;
                type = 'arrow';
            end
            
        end
    end
end