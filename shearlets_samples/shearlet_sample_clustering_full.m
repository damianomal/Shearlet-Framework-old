
filenames = {'robot_1-reaching_a', 'robot_2-transporting_a', 'robot_5-mixing_a', ...
             'robot_8-crank_a', 'canon_1-reaching_a', 'canon_2-transporting_a', ...
             'canon_5-mixing_a', 'canon_8-crank_a'};
load('G:\Shearlet-Framework\Shearlet_detection_clustering\saved_cluster.mat')

for i=1%:numel(filenames)
   VID = load_video_to_mat([filenames{i} '.avi']);
   shearlet_video_clustering_full( VID(:,:,100:200), SORT_CTRS, filenames{i}, true);
end