function [SORTED_CL_IMAGE, SORT_CTRS] = shearlet_cluster_single_frame(COEFFS,idxs,TARGET_FRAME,SCALE_USED,CLUSTER_NUMBER,SORT_CTRS )

% calculate the representation for a specific frame (frame number 37 of the
% sequence represented in the VID structure)

REPRESENTATION = shearlet_descriptor(COEFFS, TARGET_FRAME, SCALE_USED, idxs, true, true);

% clusters the representations for this particular frame in N clusters
if(nargin < 7)
   
[CL_IND, CTRS] = shearlet_cluster_coefficients(REPRESENTATION, CLUSTER_NUMBER, [size(COEFFS,1) size(COEFFS,2)]);

% sorts the clusters with respect to their size, and also rea

[SORTED_CL_IMAGE, SORT_CTRS] = shearlet_cluster_sort(CL_IND, CTRS);

% shows a colormap associated with the clusters found

shearlet_cluster_image(SORTED_CL_IMAGE, CLUSTER_NUMBER, true, false);
return

end
%% 
% % shows a single cluster as an overlay on the original frame
% 
% CLUSTER_TO_SHOW = 8;
% shearlet_overlay_cluster(VID(:,:,TARGET_FRAME), SORTED_CL_IMAGE, CLUSTER_TO_SHOW, true, true);

%% CLUSTERING A NEW SEQUENCE STARTING FROM THE CENTROIDS PREVIOUSLY CALCULATED

% loads the sequence (contained in the sample_sequences directory) and 
% calculates the transform

% clear VID;
% VID = load_video_to_mat('planar_from_canon_11-line_b.mp4',160, 1,100);
% 
% clear COEFFS idxs 
% [COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1);
% 
% % calculate the representation for a specific frame (frame number 35 of the
% % new sequence selected)
% 
% TARGET_FRAME = 150;
% SCALE_USED = 2;

REPRESENTATION = shearlet_descriptor(COEFFS, TARGET_FRAME, SCALE_USED, idxs, true);

% clusters the representations for this particular frame using the
% centroids coming from a previous clustering process (here the SORT_CTRS
% object is the one calculated in the previous section of this MATLAB
% script)

CL_IND = shearlet_cluster_by_seeds(REPRESENTATION, COEFFS, SORT_CTRS);

% shows a colormap associated with the clusters found

shearlet_cluster_image(CL_IND, CLUSTER_NUMBER, true, false);

% shows a single cluster as an overlay on the original frame

% CLUSTER_TO_SHOW = 5;
% shearlet_overlay_cluster(VID(:,:,TARGET_FRAME), CL_IND, CLUSTER_TO_SHOW, true, true);

