function display_faces(faces, start,num)

total= start+num
if nargin == 1
    num = 10
end
Y = faces(:,start:total);

figure
for i=1:num
    subplot(ceil(sqrt(num)),ceil(sqrt(num)),i);
    face = faces(i,:);
    imshow(reshape(face,32,32));
end