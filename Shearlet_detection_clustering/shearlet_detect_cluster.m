clear all
close all

video_filename = 'alessia_rectangle.mp4';
VID = load_video_to_mat(video_filename,160, 600,700);

[COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1);

%%

% parameters for the detection process

LOWER_THRESHOLD = 0.2;
SPT_WINDOW = 11;
SCALES = [2]; %aa
CONE_WEIGHTS = [1 1 1];
CLUSTER_NUMBER = 10;

% detect spatio-temporal interesting points within the sequence

close all;
[COORDINATES, ~] = shearlet_detect_points( VID(:,:,1:91), COEFFS, SCALES, [], LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS, false);

TOTAL_FRAMES = size(unique(COORDINATES(:,3)));

output_cell = cell(TOTAL_FRAMES,2);

% [SORTED_CL_IMAGE, SORT_CTRS] = shearlet_cluster_single_frame(COEFFS,idxs,COORDINATES(1,3),SCALES,CLUSTER_NUMBER);
% if TOTAL_FRAMES<2
%     exit
% end
    
for i = 1:TOTAL_FRAMES % REMEMBER TO LOAD SORT_CTRS FROM A FILE ONLY ONCE
    [SORTED_CL_IMAGE, ~] = shearlet_cluster_single_frame(COEFFS,idxs,COORDINATES(i,3),SCALES,CLUSTER_NUMBER,SORT_CTRS);
    
    output_cell{i, 1} = SORTED_CL_IMAGE;
    output_cell{i, 2} = COORDINATES(i,3);
end


