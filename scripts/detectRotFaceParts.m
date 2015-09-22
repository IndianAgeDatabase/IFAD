function [fourpoints,bbX,faces,bbfaces] = detectRotFaceParts(detector,X,thick,rotate)
if( nargin < 4 )
 rotate = 15;
end
if( nargin < 3 )
 thick = 1;
end
rotate = [0:rotate:360-rotate/2];
srcOrg = [size(X,2);size(X,1)]/2+0.5;
fourpoints = [];
k = 1;
for deg = rotate
 R = imrotate(X,deg,'bicubic');
 bbox = detectFaceParts(detector,R);
 
 if( size(bbox,1) >= 1 )
  dstOrg = [size(R,2);size(R,1)]/2+0.5;
  fourpoints = vertcat(fourpoints,bbox2fourpoint(bbox,srcOrg,dstOrg,deg));
 end
 
end
fourpoints = mergeFourPoints(fourpoints);
if( nargout >= 2 )
 bbX = drawFourPoints(X,fourpoints,thick);
 if( nargout >= 3 )
  faces = cell(size(fourpoints,1),1);
  bbfaces = cell(size(fourpoints,1),1);
  leng = round(sqrt( three2area( fourpoints(:,1:2), fourpoints(:,3:4), fourpoints(:,5:6) ) + three2area( fourpoints(:,1:2), fourpoints(:,7:8), fourpoints(:,5:6) ) ));
  
  for i=1:size(fourpoints,1)
   U = [1,1;leng(i,1)-1,1;leng(i,1)-1,leng(i,1)-1;1,leng(i,1)-1];
   V = [fourpoints(i,1:2); fourpoints(i,3:4); fourpoints(i,5:6); fourpoints(i,7:8)];
   T = maketform('projective',V,U);
   faces{i,1} = imtransform(X,T,'bicubic','XData',[1,leng(i,1)],'YData',[1,leng(i,1)]);
   bbfaces{i,1} = imtransform(bbX,T,'bicubic','XData',[1,leng(i,1)],'YData',[1,leng(i,1)]);
  end
 end
end
function fourpoint = bbox2fourpoint( bbox, srcOrg, dstOrg, deg )
T = [cos(deg*pi/180), -sin(deg*pi/180); sin(deg*pi/180), cos(deg*pi/180)];
fourpoint = zeros(size(bbox,1), 2*4*5+1);
for i=1:size(bbox,1)
 for j=0:4
  if( bbox(i,j*4+1) > 0 && bbox(i,j*4+2) > 0 )
   x = bbox(i,j*4+1:j*4+2)' - dstOrg;
   y = T * x + srcOrg;
   fourpoint(i,j*8+1:j*8+2) = y';
   x = bbox(i,j*4+1:j*4+2)' + [bbox(i,j*4+3);0] - dstOrg;
   y = T * x + srcOrg;
   fourpoint(i,j*8+3:j*8+4) = y';
   x = bbox(i,j*4+1:j*4+2)' + [bbox(i,j*4+3);bbox(i,j*4+4)] - dstOrg;
   y = T * x + srcOrg;
   fourpoint(i,j*8+5:j*8+6) = y';
   x = bbox(i,j*4+1:j*4+2)' + [0;bbox(i,j*4+4)] - dstOrg;
   y = T * x + srcOrg;
   fourpoint(i,j*8+7:j*8+8) = y';
   
  end
 end
 fourpoint(i,2*4*5+1) = deg;
end
function area = three2area(xy1, xy2, xy3)
xy1 = xy1 - xy3;
xy2 = xy2 - xy3;
area = abs( xy1(:,1) .* xy2(:,2) - xy1(:,2) .* xy2(:,1) ) / 2;
