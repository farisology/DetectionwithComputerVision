path = 'video\3-personV2.mp4';
v = VideoReader(path);
% begRef = zeros(272,480,10);
% for nj=1:5
%     begRef(:,:,nj) = rgb2gray(readFrame(v));
% end
% ref = uint8(mean(begRef,3));
ref = readFrame(v);
fltr= fspecial('average');
fltr2= fspecial('motion');
while hasFrame(v)
    f = readFrame(v);
    f = imfilter(imfilter(f,fltr),fltr2);  
      
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
    %im = insertText(255*uint8(bw),[100 100],int2str(count));
    im = insertText(diff,[100 100],int2str(count));
    %im = insertText(f,[100 100],int2str(count));
    imshow(im,[]);    
    if count >3
        break
    end
end