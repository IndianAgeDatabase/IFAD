detector = FaceDetector();
faces = {};
Databasepath = '..\AgeDatabase\';
Facesfiles = {};

Subjects = ListSubfolders(Databasepath);
for Subject=1:size(Subjects)
    files = ListDirectory(strcat(Databasepath,Subjects{Subject}));
    Facesfiles = [Facesfiles; files];
end


%%
faceid = 1;
for f = 1:size(Facesfiles,1)
 fprintf('Adding File to database :%s\n',Facesfiles{f});
 try
 img = imread(Facesfiles{f});
 [bbox bbimg face bbfaces] = detectFaceParts(detector,img,2);
    faces{faceid} = face{1};
    %imwrite(face{1},strcat(strrep(Facesfiles{f},'AgeDatabase','out'),'-out.jpg'));
    imwrite(face{1},strrep(Facesfiles{f},'AgeDatabase','test1'));
    faceid = faceid + 1;
catch
    fprintf('Unable to read file\n',Facesfiles{f});
 end
 
end

%%
save('AgeDatabase.mat','faces');
clear
fprintf('Databased has been Exported Successfully\n');
