%addpath('C:\Users\Anubhab Majumdar\Documents\libsvm-3.18\windows\');

addpath('D:\Google Drive\#ICDAR\libsvm-3.18\windows');
load('matlab.mat')
%%
pt_htable=makeElementList();
im = imread('D:\Google Drive\SKM\FINAL_RESULT\cbook (9)\cbook (9).jpg');
bin=im2bw(im);
BW=~bin;

[BW]=smallComponentRemove(BW);

%% connected component analysis and get the median character width and height
% mcw : median character width
% mche : median character height
% BW : after removal of small stray elements

[BW,mcw,mche,w,he]=connCompAnalysis(BW);

%% long and wide character removal
[BW]=eliminateTallChar(BW,mcw,mche);

%% get the line information
% line_t,line_b : line top and bottom
% n: total number of lines

[h_proj]=HProj(BW); 
[h]=HProj2image(h_proj,BW); 
%figure,imshow(h),title('Horizontal Projection');
[line_t,line_b,lw,n]=getLineTB(h);

%% character gap between two characters of every line
% x : white space distance
% y : occurances 
cw_gap = zeros(1,200);
cw_gap = char_gap( BW,line_t,line_b,n,size(BW,2),cw_gap);
%figure,plot(cw_gap),title('Gap Count');

%% get word blob information
wordBlob=formWordBlob(BW,cw_gap);
%figure,imshow(wordBlob),title('After word blob formation');

%% get single character contained image
singleCharE=getSingleChar2(BW,wordBlob);
singleChar=removeByEuler(singleCharE);

%% get operators such as plus,minus,division etc
%operator = detectOperator(singleChar);
operator = detectOperator2(singleChar,model);
%imtool(operator);

%% get line information from operator position
[equ]=getEachLine(BW,operator,line_t,line_b,n);
%imtool(equ);

%% getting the division and adding numerator and denominator
[operator,mow,mohe,w,he]=connCompAnalysis(operator);
mow=mean(w);mohe=mean(he);
totalEqu=addNumDen(operator,w,he,mow,mohe,n,line_t,line_b,lw,equ,BW);

imtool(im);
imtool(totalEqu);


%% After this part we were classifying the equations which are not needed now.

%% getting new line information from totalEqu
% eqn : total no of equations extracted
equa=totalEqu;
%hProj=HProj(equa);
hProj=zeros(1,size(BW,1));
for i=1:size(BW,1)
    for j=1:size(BW,2)
        if equa(i,j)==0
            hProj(i)=hProj(i)+1;
        end
    end
end
%plot(hProj);
count=1;
for i=2:size(BW,1)
    if hProj(i-1)==0 && hProj(i)>0
        eqline_t(count)=i;
    else if hProj(i-1)>0 && hProj(i)==0
            eqline_b(count)=i-1;
            count=count+1;
        end
    end   
end
eqn=count-1;
%% to check if each and every equation is extracted successfully
 for i=1:eqn
    figure, imshow(BW(eqline_t(i):eqline_b(i),:)),title(['Line no: ',num2str(i)]);
 end

%finalMath=zeros(size(BW));
finalEquation=zeros(size(BW));
%finalInline=zeros(size(BW));
%segInline=zeros(size(BW));

%% now per equation action time
for i=1:eqn
    
    % equation contains each original equation
    equation=BW(eqline_t(i):eqline_b(i),:);
    figure,imshow(equation),title('original equation');
    % operatorLine contains each line having operators only
    operatorLine=operator(eqline_t(i):eqline_b(i),:);
    equalizedOperatorLine = check_equal(operatorLine);
    
    imtool(equalizedOperatorLine);
    
    %[operatorLine,OPERATOR]=bwlabel(operatorLine);
    [operatorLine,OPERATOR]=bwlabel(equalizedOperatorLine);
    % take out the operands, operandLine
    operatorLine = imresize(operatorLine, size(equation));
    operandLine=im2bw(equation-operatorLine);
    
    figure,imshow(equation),title('eq');
    figure,imshow(operatorLine),title('operator');
    figure,imshow(operandLine),title('oprnd');
    
    blockOprnd = turnBlock(operandLine);
    blockOperator = turnBlock(operatorLine);
    figure,imshow(blockOprnd);
    
    % perform word gap closing operation on blockOprnd
    [closedOprnd4Rem,s2]=wordGapClose(blockOprnd,cw_gap);
    totalClosed=im2bw(imresize(closedOprnd4Rem,size(blockOperator))+blockOperator);
    %figure,imshow(totalClosed);
    % getting the final after removal equation
    [finEqu,finOprnd]=endRemoval(totalClosed,equation,operandLine,s2);
    figure,imshow(finEqu),title('End Removal');
    
    finalEquation(eqline_t(i):eqline_b(i),:)= finEqu(:,:);
    
          
end
%close all;
clc;

%imtool(finalMath);
figure,imshow(~finalEquation),title('DE');
% figure,imshow(~finalInline),title('Embedded');
% imtool(segInline);


