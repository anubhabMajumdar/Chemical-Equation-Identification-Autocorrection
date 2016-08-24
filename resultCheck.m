function [array]=resultCheck(I)
pt_htable=makeElementList();

%I=imread('C:/Users/Anubhab Majumdar/Google Drive/SKM/FINAL_RESULT/bscan (1)/equ_bscan (1).jpg');


bin=im2bw(I);
%bin = im;
BW=~bin;
%[BW]=smallComponentRemove(BW);
%imtool(~BW);
[h_proj]=HProj(BW); 
[h]=HProj2image(h_proj,BW);
se=strel('square',10);
h=imclose(h,se);
figure,imshow(h),title('Horizontal Projection');
[line_t,line_b,lw,n]=getLineTB(h);
%fid = fopen('C:\Users\Anubhab Majumdar\Google Drive\SKM\FINAL_RESULT\bscan (1)\text_bscan (1).txt');
 for i=1:n 
     im=BW(line_t(i):line_b(i),:);
     %tline = fgetl(fid);
    % str=collapse(tline);
    %figure, imshow(im),title(str);
    array(i)= search(pt_htable,im);
    % searchPerChar(im,str);
    % break;
 end
end
 %close all;
 %clc;
 