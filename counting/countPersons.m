function count = countPersons(ref,im,fltr1,fltr2)
    f = im;
    f = imfilter(imfilter(f,fltr1),fltr2);   
    diffRGB = abs(ref-f);    
    [~,bestChannel] = max(sum(sum(diffRGB,1),2));
    diff = diffRGB(:,:,bestChannel);
    bw = diff > 50;
    cc = bwconncomp(bw);
    count = 0;
    for i=1:cc.NumObjects
       obj = cc.PixelIdxList{i};
       len = length(obj(:));
       if len > 3500
           count = count + 1;
       end
    end
end