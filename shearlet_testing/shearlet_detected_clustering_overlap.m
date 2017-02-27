close all
clear all
% filename = 'frontal_from_robot_circle_s';
% filename = 'frontal_from_robot_circle_m';
% filename = 'frontal_from_robot_circle_l';
% filename = 'frontal_from_robot_ellipse_m';
% filename = 'frontal_from_robot_ellipse_l';
% filename = 'frontal_from_robot_flower_s';
% filename = 'frontal_from_robot_flower_l';
% filename = 'frontal_from_robot_hearth_s';
% filename = 'frontal_from_robot_hearth_l';
% filename = 'frontal_from_robot_rectangle_l';
% filename = 'frontal_from_robot_star_s';
% filename = 'frontal_from_webcam_line_s';
% filename = 'frontal_from_webcam_ellipse_m';
% filename = 'planar_from_robot_10-ellipse_a';
% filename = 'planar_from_canon_10-ellipse_a';


extension = '_sc_2_th_0_2_win_11.mat';

load([filename '.mat']);
load([filename extension]);
disp(['The number of interest points: ' num2str(length(output_cell))])
s = size(output_cell);
figure(1)
currentframe = 1;
plotfigure

while true
    w = waitforbuttonpress;
    if w
         if double(get(gcf,'currentcharacter'))==28
            currentframe=currentframe-1;
            if currentframe==0
                currentframe=1;
            end
            plotfigure
        elseif double(get(gcf,'currentcharacter'))==29
            currentframe=currentframe+1;
            if currentframe>length(output_cell)
                currentframe =currentframe-1;
            end
            plotfigure
         elseif double(get(gcf,'currentcharacter'))==120
             close all
             break
        end
    end
end