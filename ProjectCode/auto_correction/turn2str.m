I=imread('C:\Users\Anubhab Majumdar\Google Drive\#ICDAR\images\equ_scan (5).jpg');
%I=imread('C:\Users\Anubhab Majumdar\Google Drive\#ICDAR\newScan\12\de.bmp');
%I = imread('single_char.jpg');
%imshow(I);
% get the horizontal projection
%I = im2bw(I);
[h_proj]=HProj(I);
[h]=HProj2image(h_proj,I);

%%
% since the number of lines are less and the subscript 
% and superscripts are there, one line might get divided into multiple
% lines,hence this imclose in needed.
se=strel('disk',7);
h=imclose(h,se);
%h = fliplr(h);
% get the line information
[line_t,line_b,lw,n]=getLineTB(h);

% get each line
for i=1:n
    line=I(line_t(i):line_b(i),:);
    [operator_line] = check_equal(~im2bw(line, graythresh(line)));
    [operand_img, operator_img] =  get_operators(~im2bw(line), operator_line);
    [operator_img_with_blob_equal, operator_list] = ocr_of_operators(check_equal(operator_img));
%     figure,imshow(operator_img);
%     figure,imshow(operand_img);
    imshow(operator_line);
    operator_img_without_plus = operator_img_with_blob_equal&operator_img;
    [operand_list, operator_list] = make_lists_with_ocr(operand_img, operator_img_without_plus, operator_list);
%     [operator_list] = flag_up_down_arrow(operator_line, operator_list);
    [final_eqation_text] = form_equation_text(operand_list, operator_list, operator_line)
    
end