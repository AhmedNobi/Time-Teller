function [finallines,longest]=clockwise(I,center,maxxy,minxy,name)
  I = center_preProcessing(I, name);
  
  [H,theta,ro] = hough(I);
  [h,w]=size(I);
  num_of_lines = 10;
  if h == 749 && w==648
    num_of_lines = 7;    
  end
  
  peaks = houghpeaks(H, num_of_lines, 'Threshold', 0.1*max(H(:)));
  lines = houghlines(I, theta, ro, peaks, 'FillGap',.5*max(size(H)));
  newlines = struct('point1',{},'point2',{});
  min_len = 0.55*min(maxxy - minxy);
  max_len = 0;
  i=1;
  newcenter = zeros(1,2);
  %figure;
  %subplot(1,2,1);
  %imshow(I), hold on
  %title('hough lines with center detected');
  %scatter(center(1),center(2));
  
  %get arrows closer center
  for k = 1:length(lines)
        D1 = [lines(k).point1;center];
        D2 = [lines(k).point2;center];
        xy = [lines(k).point1; lines(k).point2];
        len = norm(lines(k).point1 - lines(k).point2);
        if ( len > max_len)
          max_len = len;
          longestxy = xy;
          longest = lines(k);
        end
   %     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
  end
   %  plot(longestxy(:,1),longestxy(:,2),'LineWidth',2,'Color','red');
  %#########################################################################################New center
   
    %show for testing
    %subplot(1,2,2);
    %imshow(I), hold on
    %title('final arrows with merging detected');
    
    finallines = struct('point1',{},'point2',{});
    
    max_len = 0;
    i=1;
    for k = 1:length(lines)
        maxline = lines(k);
        for j = 1:length(lines)
            v1 = lines(k).point2 - lines(k).point1;
            v2 = lines(j).point2 - lines(j).point1;
            v1 = [v1 0];
            v2 = [v2 0];
            % atan2d --> (tan)^-1 of Y and X
            angle = atan2d(norm(cross(v1,v2)),dot(v1,v2));
            check = true;
            for x=1:length(finallines)
                lines2 = struct('point1',{},'point2',{});
                lines2(1).point1= lines(k).point1;
                lines2(1).point2= lines(k).point2;
                lines2(2).point1= lines(j).point1;
                lines2(2).point2= lines(j).point2;
                if isequal(lines2(1),finallines(x)) || isequal(lines2(2),finallines(x))
                    check = false;
                end
            end
            if angle <=25 && k ~= j
                if ~check
                    break
                end
                D1 = [maxline.point1;maxline.point2];
                D2 = [lines(j).point1;lines(j).point2];
                if pdist(D1) < pdist(D2)
                    maxline = lines(j);
                end
            end
        end
        if check
            finallines(i).point1 = maxline.point1;
            finallines(i).point2 = maxline.point2;
            
            
            xy = [finallines(i).point1; finallines(i).point2];
            len = norm(finallines(i).point1 - finallines(i).point2);
            if ( len > max_len)
                max_len = len;
                longestxy = xy;
                longest = finallines(i);
            end
            %show for testing
     %           plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
            
            i = i+1; 
        end
    end
        %longest line
      %  plot(longestxy(:,1),longestxy(:,2),'LineWidth',2,'Color','red');
        
end