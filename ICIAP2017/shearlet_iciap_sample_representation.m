
%%

% load the video sequence (contained in the sample_sequences directory)

clear VID

% video_filename = 'line_l.mp4';
% VID = load_video_to_mat(video_filename,160,400,500);

video_filename = 'mixing3_cam0.avi';
VID = load_video_to_mat(video_filename,160,1,100);

% video_filename = 'Sample0001_color.mp4';
% VID = load_video_to_mat(video_filename,160,1238,1338);

% calculate the 3D Shearlet Transform

clear COEFFS idxs


% calculate the 3D Shearlet Transform

clear COEFFS idxs
[COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1, [2 3]);

%% CLUSTERING OF A SINGLE FRAME USING THE SHEARLET-BASED REPRESENTATION DEVELOPED

close all;

% calculate the representation for a specific frame (frame number 37 of the
% sequence represented in the VID structure)

TARGET_FRAME = 40;
SCALE_USED = 2;

REPRESENTATION = shearlet_descriptor(COEFFS, TARGET_FRAME, SCALE_USED, idxs, true, true);

% clusters the representations for this particular frame in N clusters


%%

CLUSTER_NUMBER = 8;
[CL_IND, CTRS] = shearlet_cluster_coefficients(REPRESENTATION, CLUSTER_NUMBER, [size(COEFFS,1) size(COEFFS,2)]);

% sorts the clusters with respect to their size, and also rea

[SORTED_CL_IMAGE, SORT_CTRS] = shearlet_cluster_sort(CL_IND, CTRS);

% shows a colormap associated with the clusters found

shearlet_cluster_image(SORTED_CL_IMAGE, CLUSTER_NUMBER, true, false);


%%

% shows a single cluster as an overlay on the original frame

CLUSTER_TO_SHOW = 8;
[~, mask] = shearlet_overlay_cluster(VID(:,:,TARGET_FRAME), SORTED_CL_IMAGE, CLUSTER_TO_SHOW, true, true);
% shearlet_show_avg_descriptor(COEFFS, 46, 3, idxs, SORTED_CL_IMAGE == CLUSTER_TO_SHOW);


%%

shearlet_show_avg_descriptor(COEFFS, 46, 3, idxs, SORTED_CL_IMAGE == CLUSTER_TO_SHOW);

%% CLUSTERING A NEW SEQUENCE STARTING FROM THE CENTROIDS PREVIOUSLY CALCULATED

% loads the sequence (contained in the sample_sequences directory) and
% calculates the transform

clear VID;
% VID = load_video_to_mat('salt1_cam1.avi',160, 1,100);
VID = load_video_to_mat('mixing3_cam0.avi',160, 1,100);

clear COEFFS idxs
[COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1);

%%
% calculate the representation for a specific frame (frame number 35 of the
% new sequence selected)

TARGET_FRAME = 40;
SCALE_USED = 2;

REPRESENTATION = shearlet_descriptor(COEFFS, TARGET_FRAME, SCALE_USED, idxs, true);

% clusters the representations for this particular frame using the
% centroids coming from a previous clustering process (here the SORT_CTRS
% object is the one calculated in the previous section of this MATLAB
% script)

%%
close all
CL_IND = shearlet_cluster_by_seeds(REPRESENTATION, COEFFS, EATING2_12_centroids_scale2);

% shows a colormap associated with the clusters found
CLUSTER_NUMBER = 12;
[~,cl_bars,cl_rgb] = shearlet_cluster_image(CL_IND, CLUSTER_NUMBER, false, false);

figure;

subplot(1,2,1);
imshow(VID(:,:,TARGET_FRAME), []);

subplot(1,2,2);
imshow(cl_rgb);

shearlet_show_bar_diagram(cl_bars, shearlet_init_cluster_map);

% shows a single cluster as an overlay on the original frame

% CLUSTER_TO_SHOW = 5;
% shearlet_overlay_cluster(VID(:,:,TARGET_FRAME), CL_IND, CLUSTER_TO_SHOW, true, true);

%%

% TARGET_FRAME = 37;
% 
% [res, VID_CUT] = shearlet_dynamism_measure(VID, COEFFS, idxs, 2, 0.001, 0.001, TARGET_FRAME, TARGET_FRAME);
[res, VID_CUT] = shearlet_dynamism_measure(VID, COEFFS, idxs, 2, 0.05, 0.01, TARGET_FRAME, TARGET_FRAME); % default values

figure; imshow(res, []);

%% joint image

close all

figure;
subplot(1,3,1);
imshow(VID(:,:,TARGET_FRAME), []);
subplot(1,3,2);
imshow(cl_rgb);
subplot(1,3,3);
imshow(res);
