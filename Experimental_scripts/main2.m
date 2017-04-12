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

load('Database.mat')
file_num =16:18;
Part 1: Extracting dynamism data from videos

for scale = 2%:3
    end_frame = 90;
    tic
    for i=file_num(2:end) %1:numel(filenames) %define the files to be used.
        disp(['Extracting dynamism for File number ' num2str(i) 'on scale' num2str(scale)]);
        filename = filenames{i};
        res = shearlet_dynamism_measure_save_for_testing([filename '.avi' ], scale , end_frame);
        save(['Gaurvi\Dynamism_data\Dynamism_' filenames{i} '_scale' num2str(scale)], 'res');
        close all
    end
end
toc
disp(datestr(now))
clear all
%% Part 2.1: Extract/Load Cluster set
% This section makes a new cluster set or loads a pre-saved cluster from
% system memory.
tic
load('Database.mat')
for cluster_num =[1 2 3 6 7] %dictionaries to be used.
    file_num = 16:18; % Files to be executed
    if cluster_num == 1
        load('centroids_sets.mat')
        SORT_CTRS = KTH_12_centroids_scale2;
        scale = 2;
    else
        load('eating2_centroids.mat')
        switch cluster_num
            case 2
                SORT_CTRS = EATING2_12_centroids_scale2 ;
                scale = 2;
            case 3
                SORT_CTRS = EATING2CAM0_12_centroids_scale2 ;
                scale = 2;
            case 4
                SORT_CTRS = EATING2CAM0_12_centroids_scale3 ;
                scale = 3;
            case 5
                SORT_CTRS = EATING2CAM2_20_centroids_scale3 ;
                scale = 3;
            case 6
                SORT_CTRS = EATING2CAM1_12_centroids_scale2 ;
                scale = 2;
            case 7
                SORT_CTRS = EATING2CAM2_12_centroids_scale2 ;
                scale = 2;
                
        end
    end
    cluster = clusters{cluster_num};
    disp(['Starting with cluster ' cluster])
    path1 = 'Gaurvi\';
    path2 = 'Dropbox\new_actions\'; %%%%%% Put the dropbox folder path here!
    % Part 2.2: Clustering
    % To run the clustering process on all the defined videos
%     
%     if cluster_num == 7
%         file_num = 16:18;
%     else
%         file_num = 1:27;
%     end
    
    for i=file_num  % files to be clustered
        disp(['Clustering file number ' num2str(i) ' called ' filenames{i} ' with cluster ' cluster]);
        datestr(now)
        if exist([path1 'clustering_files\' cameras{camera_num(i)+1} '\' cluster],'dir')~=7
            mkdir([path1 'clustering_files\' cameras{camera_num(i)+1} '\' cluster])
        end
        VID = load_video_to_mat([filenames{i} '.avi'], 160, 1, 200);
        clusters_idx = shearlet_video_clustering_full( VID, SORT_CTRS, [cameras{camera_num(i)+1} '\' cluster '\' filenames{i} '_' cluster], true);
        load([path1 'Dynamism_data\Dynamism_' filenames{i}  '_scale' num2str(scale)]);
        flow = shearlet_plot_cluster_over_time_with_dynamism(VID, res, clusters_idx, 2, 99);
        title(['Evolution of Clusters over time in file ' actions{action_num(i)} ' by camera ' cameras{camera_num(i)+1} ' using cluster ' cluster]);
        print([path1 'Graphs_with_dynamism\' cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster], '-dpng');
        savefig([path1 'Graphs_with_dynamism\' cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster '.fig']);
        print([path2 'Graphs\' cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster], '-dpng');
        savefig([path2 'Graphs\' cameras{camera_num(i)+1}  '\TimeEvolution_' filenames{i} '_cluster_' cluster '.fig']);
        save([path2 'flow\Flow_' filenames{i} '_' cluster '.mat'],'flow');
        close all
        clear VID
    end
    disp(datestr(now))
    
end

toc