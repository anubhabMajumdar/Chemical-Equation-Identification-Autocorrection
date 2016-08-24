%equ=imread('C:\Users\Anubhab Majumdar\Google Drive\SKM\FINAL_RESULT\chem (33)\equ_chem (21).jpg');
%org=imread('C:\Users\Anubhab Majumdar\Google Drive\SKM\FINAL_RESULT\chem (33)\chem (21).jpg');

equ=imread('D:\SKM\FINAL_RESULT\bscan (1)\equ_bscan (1).jpg');
org=imread('D:\SKM\FINAL_RESULT\bscan (1)\scan0002.gif');
%  
% [r,c]=size(bin);
%  org=ones(r,c,3);
%  org(:,:,1)=bin;
%  org(:,:,2)=bin;
%  org(:,:,3)=bin;
%equ=~finalEquation;
%equ=~finalInline;
%org=im;
figure,imshow(org);
array=resultCheck(equ);
%array=[0,0,0,1,0,0];
%array(1)=1;
%array(2)=1;
equ=im2bw(equ);
%org=im2bw(org);
figure,imshow(equ),title('binary of equ');
[h_proj]=HProj(~equ); 
[h]=HProj2image(h_proj,~equ); 
se=strel('square',10);
h=imclose(h,se);
%figure,imshow(h),title('Horizontal Projection');
[line_t,line_b,lw,n]=getLineTB(h);

for i=1:n
    img=rot90(~equ(line_t(i):line_b(i),:));
    [h_proj]=HProj(img); 
    [h]=HProj2image(h_proj,img);
    v=rot90(h,-1);
    %figure,imshow(v),title('Horizontal Projection');
        for c=1:size(v,2)
            if v(1,c)==1
                startCol=c
                break;
            end
        end
        for c=size(v,2):-1:1
            if v(1,c)==1
                endCol=c
                break;
            end
        end
    if array(i)==1
    org(line_t(i),startCol:endCol,1)=1;
    org(line_t(i),startCol:endCol,2)=0;
    org(line_t(i),startCol:endCol,3)=0;
    
    org(line_b(i),startCol:endCol,1)=1;
    org(line_b(i),startCol:endCol,2)=0;
    org(line_b(i),startCol:endCol,3)=0;
    
    org(line_t(i):line_b(i),startCol,1)=1;
    org(line_t(i):line_b(i),startCol,2)=0;
    org(line_t(i):line_b(i),startCol,3)=0;
    
    org(line_t(i):line_b(i),endCol,1)=1;
    org(line_t(i):line_b(i),endCol,2)=0;
    org(line_t(i):line_b(i),endCol,3)=0;
    else if array(i)==0
            
                org(line_t(i),startCol:endCol,1)=0;
                org(line_t(i),startCol:endCol,2)=255;
                org(line_t(i),startCol:endCol,3)=0;

                org(line_b(i),startCol:endCol,1)=0;
                org(line_b(i),startCol:endCol,2)=255;
                org(line_b(i),startCol:endCol,3)=0;

                org(line_t(i):line_b(i),startCol,1)=0;
                org(line_t(i):line_b(i),startCol,2)=255;
                org(line_t(i):line_b(i),startCol,3)=0;

                org(line_t(i):line_b(i),endCol,1)=0;
                org(line_t(i):line_b(i),endCol,2)=255;
                org(line_t(i):line_b(i),endCol,3)=0;
            
        else if array(i)==2
                 org(line_t(i),startCol:endCol,1)=0;
                org(line_t(i),startCol:endCol,2)=0;
                org(line_t(i),startCol:endCol,3)=255;

                org(line_b(i),startCol:endCol,1)=0;
                org(line_b(i),startCol:endCol,2)=0;
                org(line_b(i),startCol:endCol,3)=255;

                org(line_t(i):line_b(i),startCol,1)=0;
                org(line_t(i):line_b(i),startCol,2)=0;
                org(line_t(i):line_b(i),startCol,3)=255;

                org(line_t(i):line_b(i),endCol,1)=0;
                org(line_t(i):line_b(i),endCol,2)=0;
                org(line_t(i):line_b(i),endCol,3)=255;
            end
            
        end
     end
end

close all;
imtool(org);
%imwrite(org,'C:\Users\Anubhab Majumdar\Google Drive\SKM\FINAL_RESULT\chem (33)\boxed_scan(21).jpg');
imwrite(org,'D:\SKM\FINAL_RESULT\bscan (1)\boxed.jpg');