function [ DICTIONARY ] = shearlet_build_vocabulary( video_set, frames_per_sequence, detection_th, clusters_repr, words_num )
%SHEARLET_BUILD_VOCABULARY Summary of this function goes here
%   Detailed explanation goes here

%
LOWER_THRESHOLD = 0.2;
SPT_WINDOW = 7;
SCALES = [2];
CONE_WEIGHTS = [1 1 1];

ALL_CLUSTERS = zeros(100, 121);
cur_cluster = 1;

REPR_SCALE_USED = 3;


%
for n=video_set
    
    %
    clear VID
    [VID, ~] = load_video_to_mat(n.name,160, n.start, n.end);
    
    % calculate the 3D Shearlet Transform
    clear COEFFS idxs
    [COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1, [REPR_SCALE_USED]);
    
    % detect spatio-temporal interesting points within the sequence
    [COORDINATES, ~] = shearlet_detect_points( VID(:,:,1:91), COEFFS, SCALES, [], LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS, false);
    
    %
    [COUNTS] = comparison_points_over_time(VID(:,:,1:91), COORDINATES, false);
    
    %
    [FRAMES] = shearlet_n_frames_with_most_points(COUNTS, frames_per_sequence, 1);
    
    %
    for cur_frame=FRAMES
        
        % calcola la rappresentazione usando i centroidi passati
        clear REPRESENTATION
        [REPRESENTATION] = shearlet_descriptor(COEFFS, cur_frame, REPR_SCALE_USED, idxs, true, true);
        
        % clusters the representations for this particular frame in N clusters
        CLUSTER_NUMBER = 8;
        [~, CTRS] = shearlet_cluster_coefficients(REPRESENTATION, CLUSTER_NUMBER, [size(COEFFS,1) size(COEFFS,2)]);
        
        %
        if(cur_cluster + CLUSTER_NUMBER > size(ALL_CLUSTERS,1))
            ALL_CLUSTERS = [ALL_CLUSTERS;
                zeros(50, 121)];
        end
        
        %
        for cl=1:CLUSTER_NUMBER
            ALL_CLUSTERS(cur_cluster, :) = CTRS(cl, :);
            cur_cluster = cur_cluster + 1;
        end
        
    end
        
end

%
if(words_num >= cur_cluster-1)
    DICTIONARY = ALL_CLUSTERS(1:cur_cluster-1,:);
else
    
    %
    opts = statset('Display','final', 'MaxIter',200);
    [~, DICTIONARY] = kmeans(ALL_CLUSTERS(1:cur_cluster-1,:), words_num, 'Distance', 'sqeuclidean', 'Replicates',3, 'Options',opts);
    
end


end

