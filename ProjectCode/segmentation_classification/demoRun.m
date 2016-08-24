pt_htable=makeElementList();
%im=imread('F:\SKM\database\chem\chem (6).jpg');
%im=imread('F:\WORK\SKM\scanNCERT\scan0013.bmp');

%im=imread('C:\Users\Anubhab Majumdar\Google Drive\SKM\FINAL_RESULT\cbook (10)\cbook (10).jpg');
%im=imread('C:\Users\Anubhab Majumdar\Google Drive\SKM\math\math (2).tif');
im=imread('demo.png');
%figure;
%bin=im2bw(im);
% im = imrotate(im,-0.5);
 imshow(im);
% im=imcrop(im);
% imwrite(im,'F:\WORK\SKM\scanNCERT\scan0002.bmp');
%im=fliplr(flip(im));
%bin=im;
bin = im2bw(im);
BW=~bin;
%[BW]=smallComponentRemove(BW);
imtool(BW);
pause(1);
%% connected component analysis and get the median character width and height
% mcw : median character width
% mche : median character height
% BW : after removal of small stray elements

[BW,mcw,mche,w,he]=connCompAnalysis(BW);
%BW=~BW;
%% long and wide character removal
%[BW]=eliminateTallChar(BW,mcw,mche);

%% get the line information
% line_t,line_b : line top and bottom
% n: total number of lines

[h_proj]=HProj(BW); 
[h]=HProj2image(h_proj,BW); 
figure,imshow(h),title('Horizontal Projection');
[line_t,line_b,lw,n]=getLineTB(h);

%% character gap between two characters of every line
% x : white space distance
% y : occurances 
cw_gap = zeros(1,200);
cw_gap = char_gap( BW,line_t,line_b,n,size(BW,2),cw_gap);
figure,plot(cw_gap),title('Gap Count');
pause(1);
%% get word blob information
wordBlob=formWordBlob(BW,cw_gap);
figure,imshow(wordBlob),title('After word blob formation');

%% get single character contained image
singleCharE=getSingleChar(BW,wordBlob);
singleChar=removeByEuler(singleCharE);
%[x,y,z] = detectOperator(singleChar,x,y,z);
    





%%
%% get operators such as plus,minus,division etc
operator = detectOperator(singleChar);
imtool(operator);
pause(1);
%% get line information from operator position
[equ]=getEachLine(BW,operator,line_t,line_b,n);
imtool(equ);
pause(1);
%% getting the division and adding numerator and denominator
[operator,mow,mohe,w,he]=connCompAnalysis(operator);
mow=mean(w);mohe=mean(he);
totalEqu=addNumDen(operator,w,he,mow,mohe,n,line_t,line_b,lw,equ,BW);
%imtool(totalEqu);

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
plot(hProj);
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
%%
finalEquation=zeros(size(BW));
%eqn=2;
%% to check if each and every equation is extracted successfully
 for i=1:eqn
    figure, imshow(BW(eqline_t(i):eqline_b(i),:)),title(['Line no: ',num2str(i)]);
    finalEquation(eqline_t(i):eqline_b(i),:)=BW(eqline_t(i):eqline_b(i),:);
    %var=BW(eqline_t(i):eqline_b(i),:);
    %searchPerChar(var);
    pause(1);
 end
 imwrite(~finalEquation,'de.bmp');
%%
finalMath=zeros(size(BW));
finalEquation=zeros(size(BW));
finalInline=zeros(size(BW));
%segInline=zeros(size(BW));

%% now per equation action time
%% now per equation action time
for i=1:eqn
    
    % equation contains each original equation
    equation=BW(eqline_t(i):eqline_b(i),:);
    %figure,imshow(equation),title('original equation');
    % operatorLine contains each line having operators only
    operatorLine=operator(eqline_t(i):eqline_b(i),:);
    equalizedOperatorLine = check_equal(operatorLine);
    
    %imtool(equalizedOperatorLine);
    
    %[operatorLine,OPERATOR]=bwlabel(operatorLine);
    [operatorLine,OPERATOR]=bwlabel(equalizedOperatorLine);
    % take out the operands, operandLine
    operatorLine = imresize(operatorLine, size(equation));
    operandLine=im2bw(equation-operatorLine);
    
%     figure,imshow(equation),title('eq');
%     figure,imshow(operatorLine),title('operator');
%     figure,imshow(operandLine),title('oprnd');
     
    blockOprnd = turnBlock(operandLine);
    blockOperator = turnBlock(operatorLine);
    %figure,imshow(blockOprnd);
    
    % perform word gap closing operation on blockOprnd
    [closedOprnd4Rem,s2]=wordGapClose(blockOprnd,cw_gap);
    totalClosed=im2bw(imresize(closedOprnd4Rem,size(blockOperator))+blockOperator);
    %figure,imshow(totalClosed);
    % getting the final after removal equation
    [finEqu,finOprnd]=endRemoval(totalClosed,equation,operandLine,s2);
%    figure,imshow(finEqu),title('End Removal');
    
    %finalEquation(eqline_t(i):eqline_b(i),:)= finEqu(:,:);
    
    blockedfinEqu=turnBlock(finEqu);
    closedFinEqu=formWordBlob(blockedfinEqu,cw_gap);
%    figure,imshow(closedFinEqu),title('Closed equation after removal');
    
    blockedfinOprnd=turnBlock(finOprnd);
    closedfinOprnd=formWordBlob(blockedfinOprnd,cw_gap);
    %figure,imshow(closedfinOprnd),title('Closed operands9999999 ');
    %figure,imshow(equation),title(['Operator no: ',num2str(OPERATOR),' OperandNum ',num2str(oprndNum)]);
    %%
    % checking for sigma or pi
       % getting single character operands from closedfinOprnd and finOprnd
 %      figure,imshow(finOprnd),title('before getSingleChar22');
        singleCharOprnd=getSingleChar(finOprnd,closedfinOprnd);  
        singleCharOprnd=removeByEuler(singleCharOprnd);
     
 %      figure,imshow(singleCharOprnd), title(['line number = ',num2str(i)]);
 %%
 % getting average operandBlob height
        [finOprnd,mcw,mche,w,he]=connCompAnalysis(finOprnd);
        avg_blob_height=mean(he);
       % checking if the singleCharOperand contains any sigma or pi
       % [symbol] = check_sigma_pi(singleCharOprnd, avg_blob_height);
       % symbol=0;
        %if symbol >0 % if sigma or pi detected,its mathematical equation
         %   finalMath(eqline_t(i):eqline_b(i),:)=finEqu(:,:);
            %finalEquation(eqline_t(i):eqline_b(i),:)=finEqu;
            %figure,imshow(finEqu),title('MATHEMATICAL EQUATION sigma detected');
            
        %else % compare between operandNum and operatorNum
            closedfinOprndR=smallComponentRemove(closedfinOprnd);
            %figure,imshow(closedfinOprndR),title('Operand after removal of small');
            [closedfinOprndR,OPERAND]=bwlabel(closedfinOprndR);
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    % figure,imshow(finEqu),title(['Operand Num ',num2str(OPERAND),' Operator Num ',num2str(OPERATOR)]);
            if OPERAND<=2*OPERATOR + 2
                %search(pt_htable,finEq;
                type = search(pt_htable,finOprnd); % sending only the operands
                if (type == 1)
                    finalEquation(eqline_t(i):eqline_b(i),:)=finEqu;
                    figure,imshow(finEqu),title('Displayed Chemical');
                    pause(1);
                else if (type == 2)
                    finalMath(eqline_t(i):eqline_b(i),:)=finEqu;
                     figure,imshow(finEqu),title('Displayed Non Chemical');
                     pause(1);
                    end
                end
            else
                finalInline(eqline_t(i):eqline_b(i),:)=finEqu;
                figure,imshow(finEqu),title('Embedded');
                pause(1);
             %    closedfinOprndR=imresize(closedfinOprndR,size(operatorLine));
              %   seg=segmentInLine(finEqu,closedfinOprndR,operatorLine);
               %  segInline(eqline_t(i):eqline_b(i),:)=seg;
               
            end
         
        
          
 end
close all;
clc;

%imtool(finalMath);
%imtool(~finalEquation);
%imtool(~finalMath);

% figure,imshow(~finalInline),title('Embedded');
% imtool(segInline);

% %close all;
% %clc;
% 
%imtool(finalMath);
 figure,imshow(~finalEquation),title('DE chemical');
 pause(1);
 figure,imshow(~finalMath),title('DE non chemical');
 pause(1);
 figure,imshow(~finalInline),title('Embedded');
 pause(1);
% % imtool(segInline);
