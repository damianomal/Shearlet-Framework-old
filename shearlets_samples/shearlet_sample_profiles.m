
% load the video sequence (contained in the sample_sequences directory)

clear VID

% video_filename = 'line_l.mp4';
% VID = load_video_to_mat(video_filename,160,400,500, true);

video_filename = 'mixing_cam1.avi';
VID = load_video_to_mat(video_filename,160,1,100, true);

% video_filename = 'person04_running_d1_uncomp.avi';
% video_filename = 'person04_boxing_d1_uncomp.avi';
% video_filename = 'person01_handwaving_d1_uncomp.avi';
% VID = load_video_to_mat(video_filename,160,1,100, true);

% calculate the 3D Shearlet Transform

clear COEFFS idxs 
[COEFFS,idxs] = shearlet_transform_3D(VID,46,91,[0 1 1], 3, 1, [2 3]);

%% CLUSTERING OF A SINGLE FRAME USING THE SHEARLET-BASED REPRESENTATION DEVELOPED

% calculate the representation for a specific frame (frame number 37 of the
% sequence represented in the VID structure)

TARGET_FRAME = 37;
SCALE_USED = 2;

REPRESENTATION = shearlet_descriptor_fast(COEFFS, TARGET_FRAME, SCALE_USED, idxs, true, true);

% clusters the representations for this particular frame in N clusters


%% VISUALIZING THE CLUSTERING RESULTS FOR A FIXED NUMBER OF CLUSTERS

CLUSTER_NUMBER = 8;
[CL_IND, CTRS] = shearlet_cluster_coefficients(REPRESENTATION, CLUSTER_NUMBER, [size(COEFFS,1) size(COEFFS,2)]);

% sorts the clusters with respect to their size, and also rea

[SORTED_CL_IMAGE, SORT_CTRS] = shearlet_cluster_sort(CL_IND, CTRS);

% shows a colormap associated with the clusters found

[~,~,img] = shearlet_cluster_image(SORTED_CL_IMAGE, CLUSTER_NUMBER, false, false);

close all;

figure;
subplot(1,2,1); imshow(VID(:,:,TARGET_FRAME), []);
subplot(1,2,2); imshow(img);

%%

st = tic;

full_cluster_indexes = zeros(size(COEFFS,1), size(COEFFS,2), size(COEFFS,3));

for t=2:90
    REPRESENTATION = shearlet_descriptor_fast(COEFFS, t, SCALE_USED, idxs, true, true);
    CL_IND = shearlet_cluster_by_seeds(REPRESENTATION, COEFFS, SORT_CTRS);
    full_cluster_indexes(:,:,t) = shearlet_cluster_image(CL_IND, size(SORT_CTRS,1), false, false);    
end

fprintf('-- Time for Full Video Repr. Extraction: %.4f seconds\n', toc(st));

%%

st = tic;

scale = 2;
th = 0.1;

full_motion = zeros(size(COEFFS,1), size(COEFFS,2), size(COEFFS,3));

for t=2:90
    angle = shearlet_normal_fast(COEFFS, idxs, t, scale, th);
    full_motion(:,:,t) = angle(:,:,3);
end

fprintf('-- Time for Full Video Motion Extraction: %.4f seconds\n', toc(st));

%%

shearlet_plot_clusters_over_time(full_cluster_indexes, 2, 90, false, 1:8);


%%

full_cluster_filtered = full_cluster_indexes;
full_cluster_filtered(full_motion == 0) = 0;

shearlet_plot_clusters_over_time(full_cluster_filtered, 2, 90, false, 1:8);


%%

count = 1;
START_IND = 2;
END_LIM = 90;

while true
    
    subplot(1,2,1);
    imshow(VID(:,:,START_IND-1+count), []);
    imshow(cat(3,VID(:,:,START_IND-1+count),VID(:,:,START_IND-1+count),VID(:,:,START_IND-1+count))./255);
    subplot(1,2,2);
    imshow(abs(full_motion(:,:,count)), [0 1]);
    colormap(hot);
    colorbar;
%     subplot(1,3,3);
%     imshow(squeeze(color_map(:,:,count, :)));
    
    title(['Frame ' int2str(START_IND-1+count)]);
    
    pause(0.01);
    
%         if(ismember(START_IND-1+count, frames_to_save))
%             imwrite(VID(:,:,START_IND-1+count)./255, ['frame_' savenacme '_' int2str(START_IND-1+count) '.png']);
%             imwrite(squeeze(color_map(:,:,count, :)), ['frame_color_' savename '_' int2str(START_IND-1+count) '.png']);
%         end
    
    %     if(ismember(START_IND-1+count, frames_to_pause))
    %         pause;
    %     end
    
    count = count + 1;
        
    % skipping last frames
    if(count > size(full_motion,3))
        count = 1;
        break;
    end
    
end

