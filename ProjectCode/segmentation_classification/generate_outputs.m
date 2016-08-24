base = 'C:\Users\Anubhab Majumdar\Google Drive\#ICDAR\newScan\';
for loop=53:53
    name = strcat(base,num2str(loop),'\image00',num2str(loop),'.bmp');
    im = imread(name);
    runCoderun2;
    name2 = strcat(base,num2str(loop),'\de.bmp');
    imwrite(~finalEquation,name2);
end