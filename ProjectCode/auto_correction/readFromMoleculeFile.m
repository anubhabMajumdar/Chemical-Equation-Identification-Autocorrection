function [molecule]=readFromMoleculeFile()

% returns an array of cells containing all molecules

fid = fopen('molecule_list.txt');

molecule={};
tline = fgetl(fid);
while ischar(tline)
    molecule{end+1} = tline;
    %disp(tline)
    tline = fgetl(fid);
end

fclose('all');

end