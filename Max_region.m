function [region_pic]=Max_region(I)
 [L, num] = bwlabel(I);
RGB = label2rgb(L);
[h, w, ~] = size(I);
smallRatio = h*w*0.002;
new_region=[];
region_size =0;
for i=1:num
    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < smallRatio)
        continue;
    end
    region_size =region_size+ 1;
    d = zeros(size(I));
    d(:,:) = uint8(x).*uint8(I(:,:));
    %add new(d) and old (region)
    new_region=cat(3,new_region,d); 
end

if num == 1
     region_pic = new_region(:,:);
else  
     max_r = 0;
     region = 1;
     for i=1:region_size
         count = sum(sum(new_region(:,:,i)));
         if count > max_r
             max_r = count;
             region = i;
             
         end
     end 
      region_pic = new_region(:,:,region);
end
region_pic = ((region_pic ~= 0.0) .* (I));
end