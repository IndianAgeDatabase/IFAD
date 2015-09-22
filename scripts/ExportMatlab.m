clc
clear
Databasepath = 'out\';
Faces = [];
id = [];
Subjects = ListSubfolders(Databasepath);
for Subject=1:size(Subjects)
    files = ListDirectory(strcat(Databasepath,Subjects{Subject}));
    for f=1:size(files)
        face = [];
        try
            files(f)
            face = faceoperations(files(f));
            Faces(end+1,:) =  face;
            id(end+1) = Subject;
        catch
        end
        
    end
    
    % for debuging uncoment return
    if(Subject == 4)
    return
    end
    
end


%id = id';
