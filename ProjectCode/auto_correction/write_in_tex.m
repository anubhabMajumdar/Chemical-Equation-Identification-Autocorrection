function [] = write_in_tex(final_equations)
f = fopen('final_equations.tex','w');
header1 = '\documentclass[12pt]{article}';
header2 = '\usepackage{mhchem}';
header3 = '\begin{document}';
fprintf(f,'%s\n', header1);
fprintf(f, '%s\n', header2);
fprintf(f, '%s\n', header3);


totalNum = numel(final_equations);
for i=1:totalNum
    s = final_equations{i};
    len = numel(s);
    fprintf(f,'%s','\ce{');
    for j=1:len
        fprintf(f,'%s ',s{j});
    end
    fprintf(f,'%s\n','} \\');
end
fprintf(f,'%s\n','\end{document}');
fclose(f);
end