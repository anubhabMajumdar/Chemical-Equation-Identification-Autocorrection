function [L] = detectOperator2(I, model)
% returns an image with +, - , * , X and division operator
addpath('C:\Users\Anubhab Majumdar\Documents\libsvm-3.18\windows\');

I = smallComponentRemove(I);
[L,num]=bwlabel(I);
stat=regionprops(L,'BoundingBox');
for w=1:num
    image2=im2bw(imcrop(L,stat(w).BoundingBox));
    %small_bb = stat(w).BoundingBox;
    
    fv = feature_vector(image2);
    %fv = feature_vector_hog(image2);
    
    label_test = [1];

    final_test = [label_test,fv];

    csvwrite('test_2.test', final_test);

    r = csvread('test_2.test');

    l = r(:,1);
    f = r(:,2:end);

    f_sparse = sparse(f);

    libsvmwrite('features_svm_3.test',l,f_sparse);

    system('svm-scale.exe -r range1 features_svm_3.test > svmguide2.t.scale');

    [label_vector, instance_matrix] = libsvmread('svmguide2.t.scale');

    [p] = svmpredict(label_vector, instance_matrix, model, '-q');
%    [p] = svmpredict(double(label_test), double(fv), model , '-q');
    
      if (p==1)
%          %name = strcat('arrow/','arrow (',num2str(blah),').bmp');
%          figure,imshow(image2),title('op');
%          %imwrite(image2,name);
      end
      
    if (p ~= 1)
            rT=round(stat(w).BoundingBox(2));
            cT=round(stat(w).BoundingBox(1));
            L(rT:rT+round(stat(w).BoundingBox(4)),cT:cT+round(stat(w).BoundingBox(3)))=0;
    
    end
end
    %imtool(L);
end