%im = imread('DEMO\10\image0010.bmp');
%im = imread('DEMO\12\image0012.bmp');
%im = imread('DEMO\14\image0014.bmp');
%im = imread('DEMO\15\image0015.bmp');
%im = imread('DEMO\16\image0016.bmp');
%im = imread('DEMO\19\image0019.bmp');
%im = imread('DEMO\28\image0028.bmp');
num = 10;
%%
cd('segmentation_classification\');
runCoderun;
%%
cd('..');
imwrite(~finalEquation,'segmented.bmp');

%%
cd('auto_correction\');
turn2str_PJ;

