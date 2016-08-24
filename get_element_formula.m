f = fopen('periodicTable.txt');
f2 = fopen('periodicTable_formula.txt', 'w');

x = fgets(f);

while(ischar(x))
    m = regexp(x, '\ ', 'split');
    fwrite(f2, char(m{1}));
    x = fgets(f);
end

fclose('all');
    