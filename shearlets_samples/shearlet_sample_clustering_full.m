% This file takes a set of .avi files, and using a pre-saved cluster, runs
% the clustering process on each of the videos. The output is saved in
% .mat files, separate for each input file.
filenames = {'robot_1-reaching_a', 'robot_2-transporting_a', 'robot_5-mixing_a', ...
             'robot_8-crank_a', 'canon_1-reaching_a', 'canon_2-transporting_a', ...
             'canon_5-mixing_a', 'canon_8-crank_a'};

for k = 5      
    load('G:\Shearlet-Framework\Shearlet_detection_clustering\saved_cluster5.mat');
%     if k==1
%         load('G:\Shearlet-Framework\Shearlet_detection_clustering\saved_cluster.mat');
%     else 
%         load('G:\Shearlet-Framework\Shearlet_detection_clustering\saved_cluster2.mat');
%     end
    tic
    for i=1:8%:numel(filenames)
        disp(i);
        VID = load_video_to_mat([filenames{i} '.avi'], 160, 100, 200);
        shearlet_video_clustering_full( VID, SORT_CTRS, [filenames{i} '_cluster' num2str(k)], true);
        % TO save cropped original videos.
%         shearlet_video_crop( [filenames{i} '.avi'], 160, 100, 191,[filenames{i} '_original_cropped']);
    end
    toc
    beep
    datestr(now)
end