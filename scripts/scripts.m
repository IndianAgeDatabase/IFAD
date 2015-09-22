
%% Write Faces
for i = 1:size(faces,2)
    imwrite(faces{i},strcat(int2str(3417+ i),'.jpg'))
end