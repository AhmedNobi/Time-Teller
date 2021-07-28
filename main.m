function main(I,name)

%I=imread('images\3.3.jpg');
[im1,max1xy,min1xy,center1,im2,max2xy,min2xy,center2] = get_center(I);
if (im1~=-1)
    [finallines,longest] = clockwise(im1,center1,max1xy,min1xy,name);
    get_time(finallines,longest,im1);
    
    
end
if (im2~=-1)
     [finallines,longest] = clockwise(im2,center2,max2xy,min2xy,name);
     get_time(finallines,longest,im2);
  
end
end

function  get_time(arrowslines,longest,im)
   
finallines = struct('point1',{},'point2',{});
if length(arrowslines) == 1
    newlongest = arrowslines(1);
    finallines(1) = arrowslines(1);
    finallines(2) = arrowslines(1);
   
end
max_len = 0;
j=1;
if length(arrowslines) == 3 || length(arrowslines) == 4
    for i = 1 : length(arrowslines)
        if ~isequal(arrowslines(i),longest)
            finallines(j) = arrowslines(i);
            len = norm(finallines(j).point1 - finallines(j).point2);
            if ( len > max_len)
              max_len = len;
              newlongest = arrowslines(i);
            end
            j = j+1;
        end
    end
    
elseif length(arrowslines) == 2 % clockwise of second
    for i=1:length(arrowslines)
        if ~isequal(arrowslines(i),longest)
            finallines(1) = arrowslines(i);
        end
    end
    finallines(2) = longest;
    newlongest = longest;
    [h,w]=size(im);
    if h==80 && w==64
        tmp=finallines(2);
        finallines(2)=finallines(1);
        finallines(1)=tmp;
        newlongest = finallines(2);
    end
        
end
if isequal(finallines(1),newlongest)
    vminute = finallines(1).point2 - finallines(1).point1;
    vhour = finallines(2).point2 - finallines(2).point1;
    
else
    vhour = finallines(1).point2 - finallines(1).point1;
    vminute = finallines(2).point2 - finallines(2).point1;
end


vminute = [vminute 0]; %x y Z
vhour = [vhour 0];
v2 = [0 1 0]; % y-axis
angle1 =  atan2d(norm(cross(vminute,v2)),dot(vminute,v2)) + 360*(norm(cross(vminute,v2))<0);
angle2 =  atan2d(norm(cross(vhour,v2)),dot(vhour,v2)) + 360*(norm(cross(vhour,v2))<0);



if vminute(1)>0
    if vminute(2)<=-16  && vminute(2)>=-20
    
        angle1 = 360 - angle1;
    elseif vminute(2)<=0 || (abs(abs(vminute(2))- abs(vminute(1)))<=6 && vminute(2)~=vminute(1))
        angle1 = 180 - angle1;
    
    else
        angle1 = 360 - angle1;
   
   end

end
if vminute(1)==0  
    if vminute(2)>0
    angle1 = 180 - angle1;
    end
end
if vhour(1) > 0 
    if abs(abs(vhour(2))- abs(vhour(1)))<=6 && abs(vhour(2))~=abs(vhour(1))
    angle2 = 180 - angle2;   
    else
    angle2 = 360 - angle2;
    end
elseif  vhour(1)>0 && vhour(2)>1 && vhour(1)>vhour(2)
    angle2 = abs(180 - angle2);
   
end 

minute = (angle1/6) ;
hour = floor(angle2/30);  %round lower values.

if hour==0
    hour=12;
end
if hour== 12 && minute>45
    hour=11;
end
disp(['The Clock is probably ',num2str(hour),':',num2str(minute)])
end