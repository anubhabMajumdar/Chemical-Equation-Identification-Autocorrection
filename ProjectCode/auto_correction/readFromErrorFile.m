function [H]=readFromErrorFile
%fid = fopen('D:\Google Drive\#ICDAR\ocr_error.txt');
fid = fopen('ocr_error.txt');
arr={};
tline = fgetl(fid);
while ischar(tline)
    arr{end+1} = tline;
  %  disp(tline)
    tline = fgetl(fid);
end

fclose('all');
H = HashTable(100);
num=numel(arr);
for i=1:num
    C=strsplit(arr{i},'=');
    input{i}=C{1};
    o=strsplit(C{2},' ');
    H=insertBlankinHash(H,o);
end
for i=1:num
    C=strsplit(arr{i},'=');
    input{i}=C{1};
    o=strsplit(C{2},' ');
    for j=1:numel(o)
        %bool = H.ContainsKey(o{j});
        if ~isempty(o{j})
        value=H.Get(o{j});
        value = strcat(value,{' '},input(i));
        H.Add(o{j},value);
        end
    end
end
    
end

    