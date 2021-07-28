function [I] =center_preProcessing(I, name)
  se = strel('line',2,2);
  [h,w] =  size(I);
  if h>100
  se = strel('line',3,2);
  end
  I = imerode(I,se);
 
man_pic = Max_region(I);
%I=medfilt2(man_pic);

 if w>360 && w<370
    se = strel('line',7,7);
    I = imdilate(man_pic,se);
  % 3.3 2.3 2.1 erode 4.3 dilate
 elseif w>88
 I=medfilt2(man_pic,[3, 3]);
 elseif w>44 && h<55
    I=  medfilt2(man_pic);
    se = strel('line',3,3);
    I = imdilate(I, se);
    
     n1 = I(:, 1 : uint8(end/2));
     se = strel('line',3,3);
     n1 = imdilate(n1, se);
      I(:, 1 : uint8(end/2)) = n1;
      
     n1 = I(:,uint8((7*end)/8):end);
     se = strel('line',15,15);
     n1 = imdilate(n1, se);
     I(:,  uint8(7*end/8):end) = n1;
     if h<50
     n2 = I(1:uint8((end/2)+1), uint8((end/2)+1) : end );
     se = strel('line',9,9);
     n2 = imerode(n2, se);
     I(1:uint8((end/2)+1), uint8((end/2)+1) : end) = n2;
     end
    
 end
 if h>600 
      se = strel('line',11,11);
       I= medfilt2(man_pic,[15 15]);
    I = imerode(I,se);
    
 end
   I= Max_region(I);  
     
  

%figure,imshow(I), title(name);
end