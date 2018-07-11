path = 'video\2-personV2.mp4';
v = VideoReader(path);
ref = rgb2gray(readFrame(v));
while hasFrame(v)
    f = readFrame(v);
    [bboxes, scores] = detectPeopleACF(f, ...
            'Model','caltech',...
            'WindowStride', 2,...
            'NumScaleLevels', 4, ...
            'SelectStrongest', false);
    for i=1:size(bboxes,1)
       bbox = bboxes(i,:);
       f = insertObjectAnnotation(f,'rectangle',bbox,'Person');
    end
    
    imshow(f,[])   
    
end