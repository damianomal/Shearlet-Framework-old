function img = shearlet_plot_clusters_over_time( clusters_idx, t_start, t_end, only_return_image)
%SHEARLET_PLOT_CLUSTERS_OVER_TIME Summary of this function goes here
%   Detailed explanation goes here


close all;

if(~exist('cluster_map') || isempty(cluster_map))
    cluster_map =  shearlet_init_cluster_map;
end

%
if(nargin < 4)
    only_return_image = false;
end

%
BASELINE = 5;

mat5 = clusters_idx(:,:, t_start:t_end);

fH = figure('Position', [680 277 951 701]);

hold all;

%
START_VAL = 4;
END_VAL = 8;

%
h = zeros(1,END_VAL - START_VAL + 1);
names = cell(1, END_VAL - START_VAL + 1);

%
h_index = 1;

%
titles = {'background', 'background', 'background (higher)', 'far edges', ...
    'corner(ish)', 'edges', 'dyn. edges', 'dyn. corners'};

%
for i=START_VAL:END_VAL
    
    %
    d = squeeze(sum(sum(mat5 == i,1),2));
    
    %
    plot(1:numel(d), d, 'LineWidth', BASELINE+1, 'Color', [0 0 0]);
    h(h_index) = plot(1:numel(d), d, 'LineWidth', BASELINE, 'Color', cluster_map(i, :));
    
    %
    names{h_index} = titles{i};
    
    %
    h_index = h_index + 1;
end

%
lgd = legend(h, names);

%
lgd.FontSize = 14;
lgd.FontWeight = 'bold';
lgd.Color = [0.8 0.8 0.8];

% 
hold off;

% 
if(only_return_image)
    f = getframe(gca);
    img = f.cdata;
    close(fH);
end

end

