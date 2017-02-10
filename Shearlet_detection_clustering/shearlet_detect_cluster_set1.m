clear all
close all

load('Shearlet-Framework\Shearlet_detection_clustering\saved_cluster')
sequences1 = char('frontal_from_robot_circle_l','frontal_from_robot_circle_m'...
    ,'frontal_from_robot_circle_s','frontal_from_robot_ellipse_l','frontal_from_robot_ellipse_m'...
    ,'frontal_from_robot_ellipse_s','frontal_from_robot_flower_l','frontal_from_robot_flower_s'...
    ,'frontal_from_robot_hearth_l','frontal_from_robot_hearth_s'...
    ,'frontal_from_robot_infinite_l','frontal_from_robot_infinite_s'...
    ,'frontal_from_robot_line_l','frontal_from_robot_line_s'...
    ,'frontal_from_robot_rectangle_l','frontal_from_robot_rectangle_s'...
    ,'frontal_from_robot_star_l','frontal_from_robot_star_s'...
    ,'frontal_from_robot_writing_l','frontal_from_robot_writing_s');
sizes1 = [27,27,27,28,28,28,27,27,27,27,...
    29,29,25,25,30,30,25,25,28,28];
LOWER_THRESHOLD = 0.5;
SPT_WINDOW = 11;
SCALES = [2]; 
CONE_WEIGHTS = [1 1 1];
CLUSTER_NUMBER = 10;
tic

for i = 4:10%length(sizes1)
    load([sequences1(i,1:sizes1(i)),'.mat'])
    output_cell = shearlet_detect_cluster(VID, LOWER_THRESHOLD, SPT_WINDOW, SCALES, CONE_WEIGHTS, CLUSTER_NUMBER);
    OUT_NAME = shearlet_create_video_outname( filename, SCALES, LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS,'.mat');
    save(['Shearlet-Framework\Outputs\',OUT_NAME],'output_cell','filename')
    disp(i)
end
toc