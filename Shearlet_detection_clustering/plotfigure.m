figure(1)
%%
%%%%% Displaying the original frame in the first subfigure.
subplot(1,3,1)
coordinates = output_cell{currentframe,2};
imshow(uint8(VID(:,:,coordinates(1,3))));
hold on
%Draw circles around interest points.
for i = 1:size(coordinates,1)
        plot(coordinates(i,2), coordinates(i,1), 'ro', 'MarkerSize', 20, 'LineWidth', 5);
end
%%
%%%%% Displaying the temporal-spatial representation in the second subfigure.
ax2= subplot(1,3,2);
g1 = get(ax2,'Position');
[ ~, ~, cl_rgb]= shearlet_cluster_image(output_cell{currentframe,1}, max(max(output_cell{currentframe,1})), false, false);
imshow((cl_rgb));
hold on
%Draw circles around interest points.
for i = 1:size(coordinates,1)
        plot(coordinates(i,2), coordinates(i,1), 'ro', 'MarkerSize', 20, 'LineWidth', 5);
end

%%
%%%%% Displaying a histogram in the 3rd subfigure which shows how many
%%%%% interest points lie in each of the clusters, for all the detected
%%%%% points.
clustered_vals_temp = [];
ax3=subplot(1,3,3);

g = get(ax3, 'Position');

hold on
for i=1: length(output_cell)
    coordinates = output_cell{i,2};
    for j = size(coordinates,1)
        clustered_vals_temp = [clustered_vals_temp; output_cell{i,1}(coordinates(j,1),coordinates(j,2))];
    end
end
[hist_vals,~] = hist(clustered_vals_temp,1:10);

color_map = shearlet_init_cluster_map;
for i = 1:numel(hist_vals)
    h=bar(i,hist_vals(i));
    set(h,'FaceColor', color_map(i, :));
end
g(4) = g(4) * 0.5;
 g(2) = g(2)+0.15;
set(ax3, 'Position', g);
clear g g1 ax2 ax3 cl_rgb color_map coordinates h i j s w