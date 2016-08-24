% Pweassseeee work

addpath('C:\Users\Anubhab Majumdar\Documents\libsvm-3.18\windows\');
%% variables

no_of_image_per_class = 280;
no_of_types = 3;
fv_size = 116;
count = 1;

td(no_of_types*no_of_image_per_class,fv_size) = 0;
label = zeros(no_of_types*no_of_image_per_class, 1);

%% get train data matrix

for i=1:no_of_types
    for j=1:no_of_image_per_class
        name = strcat(num2str(i), '/', num2str(i), ' (', num2str(j), ').bmp');
        cur_op = imread(name);
        imshow(cur_op);
        td(count,:) = feature_vector_2(cur_op);
        label(count) = i;
        count = count + 1;
    end
end
        

%% normalize td

libsvmwrite('features.txt', label, sparse(td));
system('svm-scale.exe -l -1 -u 1 -s range_file.txt features.txt > scaled_features.txt');
[label_vector, instance_matrix] = libsvmread('scaled_features.txt');

%% make model

model = svmtrain(label_vector, instance_matrix, '-c 2.0 -g 0.0078125');

p = svmpredict(label_vector, instance_matrix, model);
        
        
        
        