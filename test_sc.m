[II, JJ] = find(a(:,:,109) < 1);

ZZ = [II JJ];

% size(ZZ)

Zref = ZZ(ZZ(:,1) == max(ZZ(:,1)) | ZZ(:,1) == min (ZZ(:,1)) | ...
          ZZ(:,2) == max(ZZ(:,2)) | ZZ(:,2) == min (ZZ(:,2)),:);
      
% size(Zref)

% Zref(1,:)

II = ZZ(:,1);
JJ = ZZ(:,2);
