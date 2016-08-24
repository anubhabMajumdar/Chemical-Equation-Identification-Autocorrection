i_name = 'C:\Users\Anubhab Majumdar\Google Drive\SKM\FINAL_RESULT\mscan (';%2)\equ_mscan (2).jpg';   
%count = 1;
for j = 11:25
    
    try
    f_name = strcat(i_name,num2str(j),')\equ_mscan (',num2str(j),').jpg');
    im = imread(f_name);
    bin = im2bw(im);
    bin = ~bin;
    [labeled,numOfChar]=bwlabel(bin);
    stat=regionprops(labeled,'BoundingBox');
    
    for i=1:numOfChar
 
    bb=stat(i).BoundingBox;
    img=imcrop(bin,bb);
    [r,c]=size(img);
    paddedImg=zeros(r+20,c+20);
    paddedImg(10:r+9,10:c+9)=img(:,:);
    paddedImg=im2bw(paddedImg);

    %% Save all single chars in folder singlechars
        
        name = strcat('singlechars\',num2str(count),'.jpg');
        imwrite(paddedImg,name);
        imshow(paddedImg);
        count = count + 1;
    
    end
    catch
        continue;
    end
end
