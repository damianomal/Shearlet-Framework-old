close all
clear all
load('Shearlet-Framework\Outputs\frontal_from_robot_circle_l_sc_2_th_0_5_win_11.mat')
load('frontal_from_robot_circle_l.mat')

s = size(output_cell);
figure(1)
currentframe = 1;
% all_coordinates=[];
plotfigure
f=gcf;
while true
    pause(1)
    val_arrow=double(get(gcf,'CurrentCharacter'));
    if val_arrow==28 
        currentframe=currentframe-1;
        if currentframe==0
            currentframe=1;
        end
        plotfigure
    elseif val_arrow == 29 
        currentframe=currentframe+1;
        if currentframe>length(output_cell)
            close all
            break
        end
        plotfigure
    elseif (val_arrow == 30 | val_arrow==31)
        close all
        break
    end
    clear val_arrow;
end
    
    