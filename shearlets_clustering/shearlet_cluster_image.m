function [ cl_image, cl_bars, cl_rgb] = shearlet_cluster_image( cluster_idx, cluster_num, view, do_sort)
%SHEARLET_CLUSTER_IMAGE Summary of this function goes here
%   Detailed explanation goes here

if(~exist('cluster_map'))
    cluster_map = shearlet_init_cluster_map;
end

% cluster_map =  [0 0 1; 0 0 1; 0 0 1; ...
%                1 1 0; 1 0 0; 0 1 1; ...
%                0 1 0; 1 1 1; 0.5 0.5 0.5; ...
%                0.6 0.6 0; 1 0.4 0.4; 0.2 1 0.3; ...
%                0.9 0.8 0.1; 0.2 0.2 1; 0.2 0.3 0.2;
%                1 0.7 0.7; 0 1 0.6; 0.2 0 0.8; 
%                0.4 0.1 0.7; 0.7 1 0.35];

% cluster_map =  [0 0 1; 1 0 0; 1 0 0; ...
%                0 1 0; 0 1 0; 1 0 0; ...
%                1 1 0; 1 1 1; 0.5 0.5 0.5; ...
%                0.6 0.6 0; 1 0.4 0.4; 0.2 1 0.3; ...
%                0.9 0.8 0.1; 0.2 0.2 1; 0.2 0.3 0.2;
%                1 0.7 0.7; 0 1 0.6; 0.2 0 0.8; 
%                0.4 0.1 0.7; 0.7 1 0.35];

% cluster_map =  [0 0 1; 1 0 0; 0 1 0; ...
%                1 0 0; 0 0 0; 1 1 0; ...
%                1 0 1; 1 1 1; 0.5 0.5 0.5; ...
%                0.6 0.6 0; 1 0.4 0.4; 0.2 1 0.3; ...
%                0.9 0.8 0.1; 0.2 0.2 1; 0.2 0.3 0.2;
%                1 0.7 0.7; 0 1 0.6; 0.2 0 0.8; 
%                0.4 0.1 0.7; 0.7 1 0.35];

%
bard = zeros(cluster_num,1);

%
for j=1:cluster_num
    MASK = cluster_idx == j;
    bard(j) = sum(MASK(:));
end

if(do_sort)
    
    %
    [SRT, IN] = sort(bard, 1, 'descend');
    
    % TODO CONTROLLARE SE SERVE
    %     ctrs= ctrs(IN, :);
    cl_bars = SRT;
    
    %
    temp = zeros(size(cluster_idx));
    
    %
    for j=1:cluster_num
        temp(cluster_idx == IN(j)) = j;
    end
    
else
    cl_bars = bard;
    temp = cluster_idx;
end

%
cl_image = temp;
cl_rgb = ind2rgb(cl_image, cluster_map);

%
if(view)
    figure;
    imshow(cl_rgb);
    
    shearlet_show_bar_diagram(cl_bars, cluster_map);
end

end

