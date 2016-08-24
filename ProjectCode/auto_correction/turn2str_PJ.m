%I=imread('C:\Users\Anubhab Majumdar\Google Drive\#ICDAR\images\equ_scan (8).jpg');
%I=imread('C:\Users\Anubhab Majumdar\Google Drive\#ICDAR\images\equ_cbook (5).jpg');
%imshow(I);
%I = imread('D:\Google Drive\#ICDAR\newScan\41\de.bmp');
%strCorrect='D:\Google Drive\#ICDAR\newScan\41\CorrectedResult.txt';
%strIni='D:\Google Drive\#ICDAR\newScan\31\intialResult.txt';

%  I=imread('D:\Google Drive\#ICDAR\images\equ_bscan (3).jpg');
%I = imread('single_char.jpg');
%I = imread('..\DEMO\10\de.bmp');      
%I=im2bw(I,graythresh(I));

name = strcat('..\DEMO\',num2str(num),'\de','.bmp');
I = imread(name);
% get the horizontal projection
[h_proj]=HProj(I);
[h]=HProj2image(h_proj,I);

h=~h;
%%
% since the number of lines are less and the subscript 
% and superscripts are there, one line might get divided into multiple
% lines,hence this imclose in needed.
se=strel('disk',7);
h=imclose(h,se);

% get the line information
[line_t,line_b,lw,n]=getLineTB(h);
%n=1
final_equations = cell(n,1);
% get each line
for i=1:n
    line=I(line_t(i):line_b(i),:);
    figure, imshow(line);
   % [operator_line] = check_equal(~im2bw(line, graythresh(line)));
   [operator_line] = check_equal(~(line));
    [operand_img, operator_img] =  get_operators(~im2bw(line), operator_line);
   % figure,imshow(operator_img);
   % figure,imshow(operand_img);
    %     figure,imshow(operator_line);
     [operator_img_with_blob_equal, operator_list] = ocr_of_operators(check_equal(operator_img));
    %[operand_list, operator_list] = make_lists(operand_img, operator_img);
     operator_img_without_plus = operator_img_with_blob_equal&operator_img;
    [operand_list, operator_list] = make_lists_with_ocr(operand_img, operator_img_without_plus, operator_list);
   % [operator_list] = flag_up_down_arrow(operator_line, operator_list);
    [operandCorrect]=getFinalFile(operand_list);
    [final_equation_text] = form_equation_text(operandCorrect, operator_list, operator_line)
%     [operandCorrect,operatorCorrect]=getFinalFile(operand_list,operator_list);
%     
%     fIni= fopen(strIni,'a');
%     final=write2file(fIni,operator_list,operand_list)
%     fclose(fIni);
    
%     fCorrect= fopen(strCorrect,'a');
%     finalCorrected=write2file(fCorrect,final_equation_text);
%     fclose(fCorrect);
final_equations{i} = final_equation_text;
end
write_in_tex(final_equations);