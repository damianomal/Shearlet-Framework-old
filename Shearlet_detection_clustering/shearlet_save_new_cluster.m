% File to save a new set of clusters using a given video file.
%
%
% Author: Gaurvi Goyal


filename = 'robot_2-transporting_a_original_cropped.avi';
VID = load_video_to_mat(filename,160);

[COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1);

% parameters for the detection process

% LOWER_THRESHOLD = 0.2;
% SPT_WINDOW = 5;
SCALES = [2]; %aa
% CONE_WEIGHTS = [1 1 1];
CLUSTER_NUMBER = 10;
% 
% [COORDINATES, ~] = shearlet_detect_points( VID(:,:,1:91), COEFFS, SCALES, [], LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS, false);
% 
% [UNIQUE_FRAMES, ~] = unique(COORDINATES(:,3));
% TOTAL_FRAMES = length(UNIQUE_FRAMES);
% 
% output_cell = cell(TOTAL_FRAMES,2);

% [SORTED_CL_IMAGE, SORT_CTRS] = shearlet_cluster_single_frame(COEFFS,idxs,COORDINATES(1,3),SCALES,CLUSTER_NUMBER);

% In case of a pre-defined frame number.
[SORTED_CL_IMAGE, SORT_CTRS] = shearlet_cluster_single_frame(COEFFS,idxs,32,SCALES,CLUSTER_NUMBER);
save('Shearlet-Framework\Shearlet_detection_clustering\saved_cluster5','SORT_CTRS')
