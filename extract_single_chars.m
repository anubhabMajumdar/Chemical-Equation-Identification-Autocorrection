name_start = 'single_chars/sc_';
name_end = '.bmp';

write_name = 'each_single_char/sc_';
count = 1;

for i=1:20
    name = strcat(name_start,num2str(i),name_end)
    I = imread(name);
    I = smallComponentRemove(I);
    [L,num]=bwlabel(I);
    stat=regionprops(L,'BoundingBox');
    for w=1:num
        image2=im2bw(imcrop(L,stat(w).BoundingBox));
        f_name = strcat(write_name,num2str(count),'.bmp');
        imwrite(image2,f_name);
        count = count + 1;
    end
end

        
        
        
        