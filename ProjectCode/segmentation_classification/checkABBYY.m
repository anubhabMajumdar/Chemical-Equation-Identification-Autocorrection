function []=checkABBYY()

fid = fopen('C:\Users\Anubhab Majumdar\Google Drive\SKM\FINAL_RESULT\bscan (1)\text_bscan (1).txt');
i=1;
while ~feof(fid)
    tline(i,:) = fgetl(fid);
    disp(tline(i,:));
     i=i+1;
end

fclose(fid);


end