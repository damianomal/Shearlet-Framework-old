% This file takes a set of video files as input, crops them (and saves them),
% extacts or loads a cluster set, and using it, clusters all the video
% files, and saves the output, then generates and saves graphs depicting
% flow of the clusters through each of the video sequence in the areas
% which have dynamic motion (dynamism.)

%% Database

actions = {'carrot', 'eggs', 'lemon', 'mezzaluna', 'potato', 'pouring', 'rolling', 'spreading', 'table'};
cameras = {'cam0','cam1','cam2'};
temp = 1;
for i = 1:numel(actions)
    for j = 1:numel(cameras)
        for instance = 1:3
            filenames{temp} = [actions{i} num2str(instance) '_' cameras{j}];
            temp = temp+1;
        end
    end
end
% clusters = {'KTH_12_centroids_scale2','EATING2_12_centroids_scale2',...
%     'EATING2CAM2_12_centroids_scale2','EATING2CAM2_12_centroids_scale3','EATING2CAM2_20_centroids_scale3'} ;
clusters = {'EATING2_12_centroids_scale2'};
% file_num = 1:27; %files being used in this code.
% action_num = ceil(file_num/9);
% camera_num = mod(file_num-1,3);
%%

for file_num = 1: numel(filenames)
    % Part 1: Extracting dynamism data from videos
    
    %     load('Database.mat')
    for scale = 3
        end_frame = 90;
        tic
        i=file_num; %1:numel(filenames) %define the files to be used.
        disp(['Extracting dynamism of File number ' num2str(i) 'on scale' num2str(scale)]);
        filename = filenames{i};
        res = shearlet_dynamism_measure_save_for_testing([filename '.avi' ], scale , end_frame);
        save(['Dataset\Dynamism_data\Dynamism_' filenames{i} '_scale' num2str(scale)], 'res');
        close all
        
    end
    toc
    datestr(now)
    % clear all
    %% Part 2.1: Extract/Load Cluster set
    % This section makes a new cluster set or loads a pre-saved cluster from
    % system memory.
    tic
    %     load('Database.mat')
    for cluster_num =1
        
        %         if cluster_num == 1
        %             load('G:\Shearlet-Framework\Shearlet_detection_clustering\centroids_sets.mat')
        %             SORT_CTRS = KTH_12_centroids_scale2;
        %             scale = 2;
        %         else
        %             load('G:\Shearlet-Framework\Shearlet_detection_clustering\eating2_centroids.mat')
        %             switch cluster_num
        %                 case 2
        %                     SORT_CTRS = EATING2_12_centroids_scale2 ;
        %                     scale = 2;
        %                 case 3
        %                     SORT_CTRS = EATING2CAM0_12_centroids_scale2 ;
        %                     scale = 2;
        %                 case 4
        %                     SORT_CTRS = EATING2CAM0_12_centroids_scale3 ;
        %                     scale = 3;
        %                 case 5
        %                     SORT_CTRS = EATING2CAM2_20_centroids_scale3 ;
        %                     scale = 3;
        %                 case 6
        %                     SORT_CTRS = EATING2CAM1_12_centroids_scale2 ;
        %                     scale = 2;
        %                 case 7
        %                     SORT_CTRS = EATING2CAM2_12_centroids_scale2 ;
        %                     scale = 2;
        %
        %             end
        %         end
        cluster = clusters{cluster_num};
        disp(['Starting with cluster ' cluster])
        path1 = 'Dataset\';
        path2 = 'Dropbox\new_actions\Graphs\';
 
        % Part 2.2: Clustering
        % To run the clustering process on all the defined videos
        
        disp(['Clustering file number ' num2str(i) ' called ' filenames{i} ' with cluster ' cluster]);
        datestr(now)
        
        if exist(['Dataset\clustering_files\' cameras{camera_num(i)+1} '\' cluster '\' actions{ceil(file_num/9)}],'dir')~=7
            mkdir(['Dataset\clustering_files\' cameras{camera_num(i)+1} '\' cluster '\' actions{ceil(file_num/9)}])
        end
        VID = load_video_to_mat([filenames{i} '.avi'], 160, 1, 200);
        
        clusters_idx = shearlet_video_clustering_full( VID, SORT_CTRS, [cameras{camera_num(i)+1} '\' cluster '\' filenames{i} '_' cluster], true);
        load(['Dataset\Dynamism_data\Dynamism_' filenames{i}  '_scale' num2str(scale)]);
        flow = shearlet_plot_cluster_over_time_with_dynamism(VID, res, clusters_idx, 2, 99);
        title(['Evolution of Clusters over time in file ' actions{action_num(i)} ' by camera ' cameras{camera_num(i)+1} ' using cluster ' cluster]);
        print([path1 'Graphs_with_dynamism\' cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster], '-dpng');
        savefig([path1 'Graphs_with_dynamism\' cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster '.fig']);
        print([path2 cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster], '-dpng');
        savefig([path2 cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster '.fig']);
        save(['Dropbox\new_actions\flow\Flow_' filenames{i} '_' cluster '.mat'],'flow');
        close all
        clear VID
        datestr(now)
        
    end
end
toc