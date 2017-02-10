% This script extracts frames from a video file and savs them into a .mat files 
% for an entire dataset of sequences explicitly defining the starting and ending  
% frames to be extracted.

%
%
%
clear all 
close all
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
limits1 = ones(1,2,length(sizes1));
for i=1: length(sizes1)
    limits1(:,:,i) = [900,1100];
end
for n=1:length(sizes1)
    save_mat_file(sequences1(n,1:sizes1(n)),limits1(:,:,n));
end
%%
sequences2 = char('frontal_from_webcam_circle_l','frontal_from_webcam_circle_m','frontal_from_webcam_circle_s'...
    ,'frontal_from_webcam_ellipse_l','frontal_from_webcam_ellipse_m','frontal_from_webcam_ellipse_s'...
    ,'frontal_from_webcam_flower_l','frontal_from_webcam_flower_s'...
    ,'frontal_from_webcam_hearth_l','frontal_from_webcam_hearth_s'...
    ,'frontal_from_webcam_infinite_l','frontal_from_webcam_infinite_s'...
    ,'frontal_from_webcam_line_l','frontal_from_webcam_line_s'...
    ,'frontal_from_webcam_rectangle_l','frontal_from_webcam_rectangle_s'...
    ,'frontal_from_webcam_star_l','frontal_from_webcam_star_s'...
    ,'frontal_from_webcam_writing_l','frontal_from_webcam_writing_s');
sizes2 = sizes1+1;
limits2 = ones(1,2,length(sizes2));
for i=1: length(sizes2)
    limits2(:,:,i) = [600,800];
end
limits2(:,:,13) = [300,500];
for n=1:length(sizes2)
    save_mat_file(sequences2(n,1:sizes2(n)),limits2(:,:,n));
end
%%
sequences3 = char('planar_from_canon_9-infinite_a','planar_from_canon_9-infinite_b'...
    ,'planar_from_canon_10-ellipse_a','planar_from_canon_10-ellipse_b'...
    ,'planar_from_canon_11-line_a','planar_from_canon_11-line_b'...
    ,'planar_from_canon_12-rectangle_a','planar_from_canon_12-rectangle_b'...
    ,'planar_from_canon_13-hearth_a','planar_from_canon_13-hearth_b'...
    ,'planar_from_canon_14-writing_a','planar_from_canon_14-writing_b');
sizes3= [30,30,30,30,27,27,32,32,29,29,30,30];
limits3 = ones(1,2,length(sizes3));
for i=1: length(sizes3)
    limits3(:,:,i) = [400,600];
end
for n=1:length(sizes3)
    save_mat_file(sequences3(n,1:sizes3(n)),limits3(:,:,n));
end
%%
sequences4 = char('planar_from_robot_9-infinite_a','planar_from_robot_9-infinite_b'...
    ,'planar_from_robot_10-ellipse_a','planar_from_robot_10-ellipse_b'...
    ,'planar_from_robot_11-line_a','planar_from_robot_11-line_b'...
    ,'planar_from_robot_12-rectangle_a','planar_from_robot_12-rectangle_b'...
    ,'planar_from_robot_13-hearth_a','planar_from_robot_13-hearth_b'...
    ,'planar_from_robot_14-writing_a','planar_from_robot_14-writing_b');
sizes4=sizes3;
limits4 = ones(1,2,length(sizes4));
for i=1: length(sizes3)
    limits4(:,:,i) = [1000,1200];
end
for n=1:length(sizes4)
    save_mat_file(sequences4(n,1:sizes4(n)),limits4(:,:,n));
end
