function [L] = detectOperator(I)
% returns an image with +, - , * , X and division operator

[L,num]=bwlabel(I);
stat=regionprops(L,'BoundingBox');
for w=1:num
    image2=im2bw(imcrop(L,stat(w).BoundingBox));
    small_bb = stat(w).BoundingBox;
                        
    [M2,N2] = size(image2);
    [m1,x2] = return_peak_location(image2);
    [m2,y2] = return_peak_location(rot90(image2));
    
    leeway_center = 5;
    leeway_max = 5;
    midway_x = M2/2;
    midway_y = N2/2;
    
    total_area = M2 * N2;
    actual_area = bwarea(image2);
    
    flag = 0;
    if((small_bb(3) <= 8 ) && (small_bb(4) <= 8))
              %disp('small char');
          
    elseif ((x2 >=(midway_x-leeway_center)) && (x2<=midway_x+leeway_center) && (m1 >= M2 - leeway_max)&&((y2>=midway_y-leeway_center) && (y2<=midway_y+leeway_center) && (m2 >= N2 - leeway_max)))%&&((actual_area/total_area)<0.3))
             %   figure, imshow(image2),title('+');
                flag = 1;
        
    elseif (M2<= 3*N2/5) && M2<15
            

            flag = 1;
%             end
             start = stat(w).BoundingBox(2);
             start_col = stat(w).BoundingBox(1);

             
                 
             
    else
        temp2 = imrotate(image2,45,'loose');
    
        [M2,N2] = size(temp2);
        [m1,x2] = return_peak_location(temp2);
        [m2,y2] = return_peak_location(rot90(temp2));

        leeway_center = 3;
        leeway_max = 5;
        midway_x = M2/2;
        midway_y = N2/2;

        if ((x2 >=(midway_x-leeway_center)) && (x2<=midway_x+leeway_center) && (m1 >= M2 - leeway_max))
            if ((y2>=midway_y-leeway_center) && (y2<=midway_y+leeway_center) && (m2 >= N2 - leeway_max))
                total_area = M2 * N2;
                actual_area = bwarea(temp2);
                if ((actual_area/total_area)<0.3)
                  %  figure, imshow(temp2),title('*');
                    flag = 1;
                end
            end
        
        end
    end
       if (flag == 0)      
            rT=round(stat(w).BoundingBox(2));
            cT=round(stat(w).BoundingBox(1));
            L(rT:rT+round(stat(w).BoundingBox(4)),cT:cT+round(stat(w).BoundingBox(3)))=0;
       end
 end

end