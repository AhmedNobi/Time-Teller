function [im1,max1xy,min1xy,center1,im2,max2xy,min2xy,center2] =get_center(I)
ORginal_img = I;
I = edge_enhance(I);
img = I;
[L, num] = bwlabel(I);
stats = regionprops(L, 'Area', 'BoundingBox', 'Centroid');
RGB = label2rgb(L); % to fit color
%figure,imshow(RGB);

[H, W, ~] = size(RGB);
BigRatio = H*W*0.033; %to 

smallRatio = H*W*0.0005; %to 
smallRatio_L =  H*W*0.04; %to 
man=[];
x1 =0;
max1_w=-1; i_1=0; y1=0;
min2_area=100000;  i_2=0;
 
centery = H/2;
centerx = W/2;
%hold on;
new_im= I;

for k=1:size(stats,1)
      h = stats(k).BoundingBox(4);
      w = stats(k).BoundingBox(3);
      x = stats(k).BoundingBox(1);
      y = stats(k).BoundingBox(2);
      area = stats(k).Area;
      bbox= stats(k).BoundingBox;
      if(area>BigRatio || area<smallRatio)
          continue;
      end
      
        
       if(x > centerx-800 && x<centerx+500)
          if( w>60 && h>40 && h<800 && y<centery && area<smallRatio_L)
             if(w > max1_w )
                 max1_w = w;
                 i_1 = k;
             end
         end
       end
       if(x > centerx-1000 & x< centerx && y>centery-60 &&  y<centery+30)
         if( w>=44 & h>40 & w<700)%350
             if(area<min2_area)
               min2_area=area;
               i_2=k;
             end
          
         end
       end
      
     
end
im1=-1; im2=-1;
max1xy=-1; max2xy=-1;
min1xy=-1; min2xy=-1;
center1=-1; center2=-1;
if (max1_w>-1)
bbox = stats(i_1).BoundingBox;

im1 = imcrop(I,bbox);
[I,J]=find(im1);
min1xy = min([I,J],[],1);
max1xy = max([I,J],[],1);
center1=(max1xy - min1xy)/2;
end
if (i_2>0&& i_2~=i_1)
bbox = stats(i_2).BoundingBox;
im2 = imcrop(img,bbox);
[I,J]=find(im2);
min2xy = min([I,J],[],1);
max2xy = max([I,J],[],1);
[L, ~] = bwlabel(im2);
stats2 = regionprops(L,'Centroid');
center2=stats2(1).Centroid;


end

end