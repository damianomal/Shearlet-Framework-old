% Temp script required only to save the flow for each of the 3 instances of
% each action.

% This file takes a set of video files as input, crops them (and saves them),
% extacts or loads a cluster set, and using it, clusters all the video
% files, and saves the output, then generates and saves graphs depicting
% flow of the clusters through each of the video sequence in the areas
% which have dynamic motion (dynamism.)

%% Database
% filenames = {'eating1_cam0','eating1_cam1','eating1_cam2',... %3
%     'eating2_cam0','eating2_cam1','eating2_cam2',... %6
%     'eating3_cam0','eating3_cam1','eating3_cam2',... %9
%              'mixing1_cam0','mixing1_cam1','mixing1_cam2',... %12
%              'mixing2_cam0','mixing2_cam1','mixing2_cam2',... %15
%              'mixing3_cam0','mixing3_cam1','mixing3_cam2',... %18
%              'salt1_cam0','salt1_cam1','salt1_cam2',... %21
%              'salt2_cam0','salt2_cam1','salt2_cam2',... %24
%              'salt3_cam0','salt3_cam1','salt3_cam2'... %27
%              }; %20
% actions = {'eating','mixing','salt'};
% cameras = {'cam0','cam1','cam2'};
% clusters = {'KTH_12_centroids_scale2','EATING2_12_centroids_scale2',...
%     'EATING2CAM2_12_centroids_scale2','EATING2CAM2_12_centroids_scale3','EATING2CAM2_20_centroids_scale3'} ;
% file_num = 1:27; %files being used in this code.
% action_num = ceil(file_num/9);
% camera_num = mod(file_num-1,3);

scale = 2;

%% Part 2.1: Extract/Load Cluster set
% This section makes a new cluster set or loads a pre-saved cluster from
% system memory.
load('Database.mat')
% file_num =1;
for cluster_num = 1:3%1:5
%     if cluster_num == 1
%         load('G:\Shearlet-Framework\Shearlet_detection_clustering\centroids_sets.mat')
%         SORT_CTRS = KTH_12_centroids_scale2;
%         scale = 2;
%     else
%         load('G:\Shearlet-Framework\Shearlet_detection_clustering\eating2_centroids.mat')
%         switch cluster_num
%             case 2
%                 SORT_CTRS = EATING2_12_centroids_scale2 ;
%                 scale = 2;
%             case 3
%                 SORT_CTRS = EATING2CAM2_12_centroids_scale2 ;
%                 scale = 2;
%             case 4
%                 SORT_CTRS = EATING2CAM2_12_centroids_scale3 ;
%                 scale = 3;
%             case 5
%                 SORT_CTRS = EATING2CAM2_20_centroids_scale3 ;
%                 scale = 3;
%         end
%     end
    cluster = clusters{cluster_num};
%     disp(['Starting with cluster ' cluster])
    path1 = 'Dataset\';
    path2 = 'Dropbox\new_actions\Graphs\';
    % Part 2.2: Clustering
    % To run the clustering process on all the defined videos
    for i=file_num(1:end)  % files to be clustered
        if cluster_num==3 && i==1
            continue
        end
%         VID = load_video_to_mat([filenames{i} '.avi'], 160, 1, 200);
          load([filenames{i} '_' cluster '_cluster_and_vid.mat']);
%           load([path1 'Clustering_files\cam' num2str(camera_num(i)) '\' cluster '\' filename '_' cluster '_scale' num2str(scale) '_cluster_and_vid.mat'])
          load(['Dynamism_' filenames{i}  '_scale' num2str(scale)]);
          [flow] = shearlet_plot_cluster_over_time_with_dynamism(VID, res, clusters_idx, 2, 99);
          title(['Evolution of Clusters over time in file ' actions{action_num(i)} ' by camera ' cameras{camera_num(i)+1} ' using cluster ' cluster]);
          print([path1 'Graphs_with_dynamism\' cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster], '-dpng');
          savefig([path1 'Graphs_with_dynamism\' cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster '.fig']);
          print([path2 cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster], '-dpng');
          savefig([path2 cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster '.fig']);
          save(['Dropbox\new_actions\flow\Flow_' filenames{i} '_' cluster '.mat'],'flow');
          close all
          clear VID
    end
    datestr(now)
%     if cluster_num == 2 && file_num==5
%         break
%     end
    
end