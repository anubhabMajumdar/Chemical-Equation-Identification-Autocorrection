function [position] = getPosition(L,U,M,bb)

topRow=round(bb(2));
bottomRow=topRow+round(bb(4));

if (topRow>=M && bottomRow>=L) || (topRow>=M && bottomRow<=L)
    position=-1; % subscript
    else if (topRow<=U && bottomRow<=M) || (topRow>=U && bottomRow<=M)
          position=1; % superscript
            else position=0; % Normal
        end
end

end