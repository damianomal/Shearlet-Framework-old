function output_cell = shearlet_detect_cluster(filename, VID, LOWER_THRESHOLD, SPT_WINDOW, SCALES, CONE_WEIGHTS, CLUSTER_NUMBER)
% clear all
% close all
% 
% % filename = 'alessia_rectangle.mp4';
% % VID = load_video_to_mat(filename,160, 600,700);
% load('frontal_from_robot_circle_m.mat');

[COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1);

%%

% parameters for the detection process

% LOWER_THRESHOLD = 0.2;
% SPT_WINDOW = 11;
% SCALES = [2]; %aa
% CONE_WEIGHTS = [1 1 1];
% CLUSTER_NUMBER = 10;

% detect spatio-temporal interesting points within the sequence

close all;
[COORDINATES, ~] = shearlet_detect_points( VID(:,:,1:91), COEFFS, SCALES, [], LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS, false);

[UNIQUE_FRAMES, ~] = unique(COORDINATES(:,3));
TOTAL_FRAMES = length(UNIQUE_FRAMES);

output_cell = cell(TOTAL_FRAMES,2);

% [SORTED_CL_IMAGE, SORT_CTRS] = shearlet_cluster_single_frame(COEFFS,idxs,COORDINATES(1,3),SCALES,CLUSTER_NUMBER);
% save('Shearlet-Framework\Shearlet_detection_clustering\saved_cluster','SORT_CTRS')
% if TOTAL_FRAMES<2
%     exit
% end
%     
load('Shearlet-Framework\Shearlet_detection_clustering\saved_cluster')
for i = 1:TOTAL_FRAMES % REMEMBER TO LOAD SORT_CTRS FROM A FILE ONLY ONCE
    [FINAL_CL_IMAGE, ~] = shearlet_cluster_single_frame(COEFFS,idxs,UNIQUE_FRAMES(i),SCALES,CLUSTER_NUMBER,SORT_CTRS);
    
    output_cell{i, 1} = FINAL_CL_IMAGE;
    output_cell{i, 2} = COORDINATES(find(COORDINATES(:,3)==i),:);
end
% OUT_NAME = shearlet_create_video_outname( filename, SCALES, LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS,'.mat');
% save(['Dataset\Outputs\',OUT_NAME],'output_cell','filename')

end
