% This script file takes the .mat files that has information regarding the
% evolution of the clusters with time, and saves the resultant graphs into
% .png and .fig formats.
%
%
% Author: Gaurvi Goyal

for videonum = [1 2 5 8]
    switch videonum
        case 1
            filename = '1-reaching';
        case 2
            filename = '2-transporting';
        case 5
            filename = '5-mixing';
        case 8
            filename = '8-crank';
    end
    for camera = 1:2
        for j = 1:5
            if camera == 1
                filename2 = ['robot_' filename];
            else %camera == 2
                filename2 = ['canon_' filename];
            end
            load(['G:\Dataset\Clustering_files\' filename2 '_a_cluster' num2str(j) '_cluster_and_vid.mat'])
            figure(1)
            shearlet_plot_clusters_over_time(clusters_idx, 2, 99);
            title(['Evolution of Clusters over time in file ' filename2 ' using cluster ' num2str(j)]);
            print(['G:\Dataset\ImageFiles_second\' filename2(1:5) '\TimeEvolution_' filename '_cluster_' num2str(j)], '-dpng');
            savefig(['G:\Dataset\ImageFiles_second\' filename2(1:5) '\TimeEvolution_' filename '_cluster_' num2str(j) '.fig']);
            close all
        end
    end
end





