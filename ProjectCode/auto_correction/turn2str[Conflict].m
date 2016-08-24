%I=imread('C:\Users\Anubhab Majumdar\Google Drive\#ICDAR\images\equ_scan (8).jpg');
I=imread('C:\Users\Anubhab Majumdar\Google Drive\#ICDAR\images\equ_cbook (3).jpg');

%imshow(I);
% get the horizontal projection
[h_proj]=HProj(I);
[h]=HProj2image(h_proj,I);

%%
% since the number of lines are less and the subscript 
% and superscripts are there, one line might get divided into multiple
% lines,hence this imclose in needed.
se=strel('disk',7);
h=imclose(h,se);

% get the line information
[line_t,line_b,lw,n]=getLineTB(h);

% get each line
for i=1:n
    line=I(line_t(i):line_b(i),:);
    [operator_line] = check_equal(~im2bw(line, graythresh(line)));
    [operand_img, operator_img] =  get_operators(~im2bw(line), operator_line);
%     figure,imshow(operator_img);
%     figure,imshow(operand_img);
    figure,imshow(operator_line);
    [operand_list, operator_list] = make_lists(operand_img, operator_img);
    [operator_list] = flag_up_down_arrow(operator_line, operator_list)
    
end