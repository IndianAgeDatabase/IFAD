function face = faceoperations(f)
height = 64;
width = 64;

I = imread(f{1});
I = im2double(I);
I = rgb2gray(I);
%I = histeq(I)
[h,w] = size(I);

if(height <= h &&  width <= w)
    I = imresize(I,[height,width]);
end
    
face = reshape(I,[1,height*width]);
end