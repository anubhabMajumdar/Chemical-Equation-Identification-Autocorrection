function [equation,operandLine]=endRemoval(I,equation,operandLine,s2)
%removes the farthest word in the starting and end

v=vProj(I);
[row,col]=size(I);

leftBlack=0;
rightBlack=0;
blank=0;
        for b=1:col-1
            if v(b)>0 && v(b+1)==0
                lsb=b+1;
                blank=1;
            else if v(b)==0 && v(b+1)>0 && blank==1
                    leb=b;
                    leftBlack=leb-lsb;
                    break;
                end
            end
        end
  
 blank=0;
        for b=col:-1:2
            if v(b)>0 && v(b-1)==0
                reb=b;
                blank=1;
            else if v(b)==0 && v(b-1)>0 && blank==1
                    rsb=b;
                    rightBlack=reb-rsb;
                    break;
                end
            end
        end

        if leftBlack > 5*s2
            I(:,1:lsb)=0;
            equation(:,1:lsb)=0;
            operandLine(:,1:lsb)=0;
        end
        if rightBlack> 5*s2
            I(:,reb:col)=0;
            equation(:,reb:col)=0;
            operandLine(:,reb:col)=0;
        end
    


end