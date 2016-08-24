function [operand_list, operator_list] = make_lists_2(operand_img, operator_img, model)

char_gap = average_char_gap(operand_img);
se = strel('Line', char_gap, 0);
temp = operand_img;
[BW, n] = bwlabel(operand_img);
stat = regionprops(BW, 'BoundingBox');
for j=1:n
        bb=stat(j).BoundingBox;
        r1=round(bb(2));
        c1=round(bb(1));
        r2=r1+round(bb(4));
        c2=c1+round(bb(3));
        operand_img(r1:r2,c1:c2)=1;
end

closed_img = imclose(operand_img, se);
operand_img = temp;
%% operand list

[BW, n] = bwlabel(closed_img);
stat = regionprops(BW, 'BoundingBox');
operand_list = cell(n,1);

for i=1:n
    bb = stat(i).BoundingBox;
    operand = imcrop(operand_img, bb);
    str = getEachCharacter(operand);
    %figure,imshow(operand);%,title(str);
    
    operand_list{i} = str;
end

%% operator list

%closed_equal = check_equal(operator_img);
[BW, n] = bwlabel(operator_img);
stat = regionprops(BW, 'BoundingBox');
operator_list = cell(n,1);

for i=1:n
    bb = stat(i).BoundingBox;
    operand = imcrop(operator_img, bb);
    fv = feature_vector_2(im2bw(operand));
    label = 1;
    
    libsvmwrite('features.txt', label, sparse(fv));
    system('svm-scale.exe -l -1 -u 1 -s range_file.txt features.txt > scaled_features.txt');
    [label_vector, instance_matrix] = libsvmread('scaled_features.txt');
    [p] = svmpredict(label_vector, instance_matrix, model);
    figure,imshow(operand),title(num2str(p));
end
    
end

    

