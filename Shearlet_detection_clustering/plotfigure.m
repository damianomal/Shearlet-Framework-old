figure(1)

%%%%% Displaying the original frame in the first subfigure.
subplot(1,3,1)
coordinates = output_cell{currentframe,2};
imshow(uint8(VID(:,:,coordinates(1,3))));
hold on
%Draw circles around interest points.
for i = 1:size(coordinates,1)
        plot(coordinates(i,1), coordinates(i,2), 'ro', 'MarkerSize', 20, 'LineWidth', 5);
end

%%%%% Displaying the temporal-spatial representation in the second subfigure.
ax2= subplot(1,3,2);
coordinates = output_cell{currentframe,2};
[ ~, ~, cl_rgb]= shearlet_cluster_image(output_cell{currentframe,1}, max(max(output_cell{currentframe,1})), false, false);
imshow((cl_rgb));
hold on
%Draw circles around interest points.
for i = 1:size(coordinates,1)
        plot(coordinates(i,1), coordinates(i,2), 'ro', 'MarkerSize', 20, 'LineWidth', 5);
end
%%%%% Displaying a histogram in the 3rd subfigure which displays how many
%%%%% interest point s lie in each of the clusters, for all the detected
%%%%% points.
clustered_vals_temp = [];
ax3=subplot(1,3,3);
for i=1: length(output_cell)
    coordinates = output_cell{i,2};
    for j = size(coordinates,1)
        clustered_vals_temp = [clustered_vals_temp; output_cell{i,1}(coordinates(j,1),coordinates(j,2))];
%     all_coordinates = [all_coordinates;output_cell{i,2}]
    end
end

[hist_vals,~] = hist(clustered_vals_temp);
ax3.Position(3:4) = ax2.Position(3:4);
% ax3.XLim = [0 11];
% ax3.YTick=0:1:max(hist_vals);
% ax3.TickLength=[1 1];
ax3.PlotBoxAspectRatio = [1 1 1];
clear hist_vals
hist(ax3,clustered_vals_temp,1:10);

