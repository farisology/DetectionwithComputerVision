path = 'video\3-personV2.mp4';
v = VideoReader(path);
ref = readFrame(v);

for i=1:25*5
   f = readFrame(v); 
end

r = abs(ref(:,:,1)-f(:,:,1));
g = abs(ref(:,:,2)-f(:,:,2));
b = abs(ref(:,:,3)-f(:,:,3));
figure,imshow(r,[])
figure,imshow(g,[])
figure,imshow(b,[])