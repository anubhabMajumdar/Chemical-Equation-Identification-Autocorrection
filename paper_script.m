I = im2bw(c);
figure,imshow(I),title('Multiplication');
I=~I;

new_p = HProj(I);
new_img = HProj2image(new_p, I);
figure,imshow(~new_img),title('Horizontal projection of Multiplication');

I=rot90(I);
new_p = HProj(I);
new_img = HProj2image(new_p, I);
new_img=rot90(new_img,1);
figure,imshow(~new_img),title('Vertical projection of Multiplication');
