function [ outlineVertexList ] = BZC( sample_point,level,ctrlPointList )

outlineVertexList = zeros((sample_point/3)*(1/level+1),2);
acc = 1;
index = 1;
%M = [-1,3,-3,1;3,-6,3,0;-3,3,0,0;1,0,0,0];

T = zeros(1/level+1,4); 
for t=0:level:1
    T(acc,1) = (1-t).^3;
    T(acc,2) = 3*t*(1-t).^2;
    T(acc,3) = 3*t.^2*(1-t);
    T(acc,4) = t.^3;
    acc = acc +1;
end

for v =1:3:sample_point-3+1
    acc = 1;
    for t = 0:level:1
        %T = [t^3,t^2,t,1];
        if(v==sample_point-3+1)
            %G = [ctrlPointList(v,1),ctrlPointList(v,2);ctrlPointList(v+1,1),ctrlPointList(v+1,2);ctrlPointList(v+2,1),ctrlPointList(v+2,2);ctrlPointList(1,1),ctrlPointList(1,2)];
            P = [T(acc,1)*ctrlPointList(v,1)+T(acc,2)*ctrlPointList(v+1,1)+T(acc,3)*ctrlPointList(v+2,1)+T(acc,4)*ctrlPointList(1,1);T(acc,1)*ctrlPointList(v,2)+T(acc,2)*ctrlPointList(v+1,2)+T(acc,3)*ctrlPointList(v+2,2)+T(acc,4)*ctrlPointList(1,2)];
        else
            %G = [ctrlPointList(v,1),ctrlPointList(v,2);ctrlPointList(v+1,1),ctrlPointList(v+1,2);ctrlPointList(v+2,1),ctrlPointList(v+2,2);ctrlPointList(v+3,1),ctrlPointList(v+3,2)]; 
            P = [T(acc,1)*ctrlPointList(v,1)+T(acc,2)*ctrlPointList(v+1,1)+T(acc,3)*ctrlPointList(v+2,1)+T(acc,4)*ctrlPointList(v+3,1);T(acc,1)*ctrlPointList(v,2)+T(acc,2)*ctrlPointList(v+1,2)+T(acc,3)*ctrlPointList(v+2,2)+T(acc,4)*ctrlPointList(v+3,2)];
        end
        %P = T*M*G;
        outlineVertexList(index,1) = P(1);
        outlineVertexList(index,2) = P(2);
        index = index + 1;
        acc = acc +1;
    end
end

end

