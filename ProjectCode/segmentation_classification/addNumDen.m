function [equ]=addNumDen(operator,width,height,mw,mh,n,line_t,line_b,lw,equ,BW)
% adds numerator and denominator above and below the division
[operator,num]=bwlabel(operator);
stat=regionprops(operator,'BoundingBox');
for i=1:num
    if (height(i)<= 3*width(i)/5) 
        if width(i)>mw && height(i)<mh
            
            rowi1=round(stat(i).BoundingBox(2) - height(i));
            rowi2=round(stat(i).BoundingBox(2))+height(i);
            col=floor(stat(i).BoundingBox(1)):floor( stat(i).BoundingBox(1) + stat(i).BoundingBox(3) );
            %rowi=row;
            lineNum=0;
            for count=1:n
                if rowi1>line_t(count) && rowi1<line_b(count)
                    lineNum=count;
                    break;
                end
            end
            try
            blackUp=0;
            outUp=0;
            rowu=rowi1;
            counter=0;
            top=rowu-line_t(lineNum)+round(median(lw)/2)+2;%(lw(lineNum)/2)
            while outUp==0 && counter<top
                matrix=BW(rowu,col);
                ones=nnz(matrix); % # of 1s in one line
                % black=0;
                if ones==0
                    counter=counter+1;
                end
                if ones>0 %numel(matrix)
                    blackUp=1;
                end
                if ones==0 && blackUp==1
                    outUp=1;
                end
                rowu=rowu-1;
               
            end
            %figure,imshow(BW(rowu:rowi1,col)),title(lineNum);
           
            if counter<top
            % figure,imshow(BW(rowu:rowi1,col)),title('Upper scan');
             equ(rowu:rowi1,col)=BW(rowu:rowi1,col);
             %numDen(rowu:rowi1+height(i)+1,col)=1;
            end
            blackDown=0;
            outDown=0;
            rowd=rowi2;
            counter=0;
            bottom=line_b(lineNum)-rowd+round(median(lw)/2)+2;%lw(lineNum+1)/2
            while outDown==0 && counter<bottom
                matrix=BW(rowd,col);
                ones=nnz(matrix); % # of 1s in one line
                % black=0;
                if ones==0
                    counter=counter+1;
                end
                if ones>0 %numel(matrix)
                    blackDown=1;
                end
                if ones==0 && blackDown==1
                    outDown=1;
                end
                rowd=rowd+1;
                
            end
           
            if counter<bottom
            %figure,imshow(BW(rowi2:rowd,col)),title('Lower scan');
            equ(rowi2:rowd,col)=BW(rowi2:rowd,col);
            %numDen(rowi2:rowd,col)=1;
            end
            catch
                disp('Not in line');
            end
        end
    end
end




end