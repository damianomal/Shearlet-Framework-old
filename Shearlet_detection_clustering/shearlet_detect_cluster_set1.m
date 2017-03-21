% This file takes a set of video files and for each of the files, it
% detects frames with interesting points and clusters the frames.
clear all
close all

% load('Shearlet-Framework\Shearlet_detection_clustering\saved_cluster')
% sequences1 = char('frontal_from_robot_circle_l','frontal_from_robot_circle_m'...
%     ,'frontal_from_robot_circle_s','frontal_from_robot_ellipse_l','frontal_from_robot_ellipse_m'...
%     ,'frontal_from_robot_ellipse_s','frontal_from_robot_flower_l','frontal_from_robot_flower_s'...
%     ,'frontal_from_robot_hearth_l','frontal_from_robot_hearth_s'...
%     ,'frontal_from_robot_infinite_l','frontal_from_robot_infinite_s'...
%     ,'frontal_from_robot_line_l','frontal_from_robot_line_s'...
%     ,'frontal_from_robot_rectangle_l','frontal_from_robot_rectangle_s'...
%     ,'frontal_from_robot_star_l','frontal_from_robot_star_s'...
%     ,'frontal_from_robot_writing_l','frontal_from_robot_writing_s');
% sizes1 = [27,27,27,28,28,28,27,27,27,27,29,29,25,25,30,30,25,25,28,28];
% 
% sequences1 = char('frontal_from_webcam_circle_l','frontal_from_webcam_circle_m','frontal_from_webcam_circle_s'...
%     ,'frontal_from_webcam_ellipse_l','frontal_from_webcam_ellipse_m','frontal_from_webcam_ellipse_s'...
%     ,'frontal_from_webcam_flower_l','frontal_from_webcam_flower_s'...
%     ,'frontal_from_webcam_hearth_l','frontal_from_webcam_hearth_s'...
%     ,'frontal_from_webcam_infinite_l','frontal_from_webcam_infinite_s'...
%     ,'frontal_from_webcam_line_l','frontal_from_webcam_line_s'...
%     ,'frontal_from_webcam_rectangle_l','frontal_from_webcam_rectangle_s'...
%     ,'frontal_from_webcam_star_l','frontal_from_webcam_star_s'...
%     ,'frontal_from_webcam_writing_l','frontal_from_webcam_writing_s');
% sizes1 = [27,27,27,28,28,28,27,27,27,27,29,29,25,25,30,30,25,25,28,28];
% sizes1 = sizes1+1;

% sequences1 = char('planar_from_canon_9-infinite_a','planar_from_canon_9-infinite_b'...
%     ,'planar_from_canon_10-ellipse_a','planar_from_canon_10-ellipse_b'...
%     ,'planar_from_canon_11-line_a','planar_from_canon_11-line_b'...
%     ,'planar_from_canon_12-rectangle_a','planar_from_canon_12-rectangle_b'...
%     ,'planar_from_canon_13-hearth_a','planar_from_canon_13-hearth_b'...
%     ,'planar_from_canon_14-writing_a','planar_from_canon_14-writing_b');
% sizes1= [30,30,30,30,27,27,32,32,29,29,30,30];

% sequences1 = char('planar_from_robot_9-infinite_a','planar_from_robot_9-infinite_b'...
%     ,'planar_from_robot_10-ellipse_a','planar_from_robot_10-ellipse_b'...
%     ,'planar_from_robot_11-line_a','planar_from_robot_11-line_b'...
%     ,'planar_from_robot_12-rectangle_a','planar_from_robot_12-rectangle_b'...
%     ,'planar_from_robot_13-hearth_a','planar_from_robot_13-hearth_b'...
%     ,'planar_from_robot_14-writing_a','planar_from_robot_14-writing_b');
% sizes1=[30,30,30,30,27,27,32,32,29,29,30,30];

filenames = {'robot_1-reaching_a', 'robot_2-transporting_a', 'robot_5-mixing_a', ...
             'robot_8-crank_a', 'canon_1-reaching_a', 'canon_2-transporting_a', ...
             'canon_5-mixing_a', 'canon_8-crank_a'};
%%
LOWER_THRESHOLD = 0.5;
SPT_WINDOW = 5;
SCALES = [2]; 
CONE_WEIGHTS = [1 1 1];
CLUSTER_NUMBER = 8;
tic
for i = 1:8%11:length(sizes1)
%     load([sequences1(i,1:sizes1(i)),'.mat'])
    disp(i);
    VID = load_video_to_mat([filenames{i} '.avi'], 160, 100, 200);
    filename = filenames{i};
    output_cell = shearlet_detect_cluster(VID, LOWER_THRESHOLD, SPT_WINDOW, SCALES, CONE_WEIGHTS, CLUSTER_NUMBER);
    OUT_NAME = shearlet_create_video_outname( filename, SCALES, LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS,'.mat');
    save(['Shearlet-Framework\Outputs\',OUT_NAME],'output_cell','filename')
    datestr(now)
end
toc
beep