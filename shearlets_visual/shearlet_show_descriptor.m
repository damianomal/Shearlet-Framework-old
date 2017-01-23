function shearlet_show_descriptor( descr, descr_numb )
%SHEARLET_SHOW_DESCRIPTOR Summary of this function goes here
%   Detailed explanation goes here

global fH1 fH2 res_v
%
if(isempty(res_v))
    res_v = shearlet_create_indexes_matrix;
end

%
lines = [1 9 25 49 81];

%
if(isempty(fH1))
    fH1 = figure('Name','Bar Graph', 'Position', [726 554 560 420]);
else
    figure(fH1);
end
bar(descr);

axis([0 121 0 descr(1)*1.05]);

%
hold on;
for i=1:numel(lines)
    line([lines(i) lines(i)],get(gca,'ylim'),'Color',[1 0 0])
end
hold off;

%
[XX, YY] = meshgrid(1:15, 1:15);

%
A = zeros(225,1);

%
new_descr = zeros(1,225);
new_descr(1:numel(descr)) = descr;

% size(res_v);
% size(descr);
% size(new_descr);

%
A(res_v) = new_descr;
B = reshape(A,15,15);

%
if(isempty(fH2))
    fH2 = figure('Name','3D Visualization', 'Position', [1302 556 560 420]);
else
    figure(fH2);
end

%
if(nargin > 1 && ~isempty(descr_numb))
   title(strcat('Centroid #',int2str(descr_numb))); 
end

%
surf(XX, YY, B);
view([-42.7 19.6]);

set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
 
rotate3d on;





end

