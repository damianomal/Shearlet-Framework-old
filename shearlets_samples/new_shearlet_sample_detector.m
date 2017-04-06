
%%

% load the video sequence

clear VID 
% video_filename = '7-0006.mp4';
% [VID, COLOR_VID] = load_video_to_mat(video_filename,160,1,100);

video_filename = 'person04_boxing_d1_uncomp.avi';
[VID, COLOR_VID] = load_video_to_mat(video_filename,160,1,100);

% video_filename = 'alessia_rectangle.mp4';
% [VID, COLOR_VID] = load_video_to_mat(video_filename,160, 600,700);

% calculate the 3D Shearlet Transform

clear COEFFS idxs
[COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1, [2]);

%%

% parameters for the detection process
LOWER_THRESHOLD = 0.2;
SPT_WINDOW = 7;
SCALES = [2];
CONE_WEIGHTS = [1 1 1];

% detect spatio-temporal interesting points within the sequence

close all;

output_name = shearlet_create_video_outname( video_filename, SCALES, LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS);

[COORDINATES, CHANGE_MAP] = shearlet_detect_points( VID(:,:,1:91), COEFFS, SCALES, [], LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS, false, output_name);

%%

comparison_local_maxima_in_frame(VID(:,:,1:91), COLOR_VID(:,:,:,1:91), 19, CHANGE_MAP, LOWER_THRESHOLD, SPT_WINDOW, 3, colormap(jet(256)));  % buono boxing? centrato in 46, SCALA 2

%%

[COUNTS] = comparison_points_over_time(VID(:,:,1:91), COORDINATES);

%%

comparison_heatmap_from_points(VID, floor(COORDINATES));

%%

close all;

shearlet_frames_with_most_points(COLOR_VID, COUNTS, [4], COORDINATES);

%%

close all;

shearlet_visualize_change_map( VID(:,:,1:91), CHANGE_MAP, 3, colormap(jet(256)));

%%

close all;

load('kth_bg_averaged.mat');

[FG_MASKS, FG_CENTROIDS] = comparison_mask_from_kth_video(VID(:,:,1:91), bg_averaged, 65);


%% 

[TRANSLATED] = comparison_translate_points_by_centroid(COORDINATES, FG_CENTROIDS, VID(:,:,1));

%%

comparison_heatmap_from_points(VID, floor(TRANSLATED));

%%

permuted = true;

VIS_FG_MASKS = FG_MASKS;

if(permuted)
    VIS_FG_MASKS = permute(VIS_FG_MASKS,[3 2 1]);
end

close all;

comparison_3d_visualization_from_points(VIS_FG_MASKS, COORDINATES, permuted);

