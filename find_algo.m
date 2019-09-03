function [jr,jc,flag1,Areas]=find_algo(L,Areas,BL)
    M=0;jr=[];jc=[];
    for index=1:length(Areas)
        if(Areas(index)==0)
            continue;
        end
            [La,Lb] = find(Areas==Areas(index));    
             if(length(La)>1)
                 for k=1:length(La)
                      [a,b]   = find(L==La(k));                  % Find Biggest Binary Region (Plate)
                    [nRow,nCol] = size(BL);
                    T       = 0;                           % Extend Plate Region By T Pixel
                    jr1=[];jc1=[];
                    jr1      = (min(a)-T :max(a)+T);
                    jc1      = (min(b)-T :max(b)+T);
                    jr1      = jr1(jr1 >= 1 & jr1 <= nRow);
                    jc1      = jc1(jc1 >= 1 & jc1 <= nCol);
                    if(length(jr1)>length(jc1) || (jc1(end)==nCol && sum(BL(jr1, jc1(end)))==1) || length(jc1)>3.3*length(jr1)||  length(jc1)<1.7*length(jr1))
                       Areas(find(Areas==Areas(index)))=0;
                    else
                       
                        S1=sum(sum(BL(jr1,jc1)));
                        S2=length(jr1)*length(jc1);
                        S=S1/S2;
                        if(M<S)
                            jr=[];jc=[];
                            jr=jr1;jc=jc1;
                            M=S;
                        end
                    end
                 end
             else
            % Biggest Binary Region Index
            %% Post Processing
                [a,b]   = find(L==La);                  % Find Biggest Binary Region (Plate)
                [nRow,nCol] = size(BL);
                T       = 0;                           % Extend Plate Region By T Pixel
                jr1=[];jc1=[];
                jr1      = (min(a)-T :max(a)+T);
                jc1      = (min(b)-T :max(b)+T);
                jr1      = jr1(jr1 >= 1 & jr1 <= nRow);
                jc1      = jc1(jc1 >= 1 & jc1 <= nCol);
                if(length(jr1)>length(jc1) || (jc1(end)==nCol && sum(BL(jr1, jc1(end)))==1) || length(jc1)>3.3*length(jr1) ||  length(jc1)<1.7*length(jr1))
                   Areas(find(Areas==Areas(index)))=0;
                else
                    
                    S1=sum(sum(BL(jr1,jc1)));
                     S2=length(jr1)*length(jc1);
                    S=S1/S2;
                    if(M<S)
                        jr=[];jc=[];
                        jr=jr1;jc=jc1;
                        M=S;
                    end
                end
             end
    end
    if(M==0)
        flag1=1;
    else
        flag1=0;
    end
end