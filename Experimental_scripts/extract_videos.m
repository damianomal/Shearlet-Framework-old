% function [ output_args ] = extract_videos( filename )
%EXTRACT_VIDEOS Summary of this function goes here
%   Detailed explanation goes here
%% Part 1: Cropping initial videos
% Inputs.....   filenames_in: files to crop.
%               filenames_out: corresponding output filenames.
%               
%


% This file takes a set of .avi files, and using a pre-saved cluster, runs
% the clustering process on each of the videos. The output is saved in
% .mat files, separate for each input file.
input_path = 'Originals\Database3\';
output_path = 'Dataset\video_files\';

filenames_in = {'MIXING_TE_0','MIXING_TE_1','MIXING_TE_2'};
% filenames_out = {['mixing' n '_cam0'],['mixing' n '_cam1'],['mixing' n '_cam2']};
% filenames_in = {'SALT_TR_0','SALT_TR_1','SALT_TR_2'};
% filenames_out = {['salt' n '_cam0'],['salt' n '_cam1'],['salt' n '_cam2']};
% filenames_in = {'EATING_TR_0','EATING_TR_1','EATING_TR_2'};%,'REACHING2_TR_0',...
%     'REACHING2_TR_0','REACHING2_TR_0'};
% filenames_out = {'eating1_cam0','eating1_cam1','eating1_cam2'};%,'reaching2_cam0',...
% %     'reaching2_cam1','reaching2_cam2'};
m=3;
for start = 305
    n = num2str(m);
    filenames_out = {['mixing' n '_cam0'],['mixing' n '_cam1'],['mixing' n '_cam2']};
%     filenames_out = {['salt' n '_cam0'],['salt' n '_cam1'],['salt' n '_cam2']};
    for i = 1:numel(filenames_in)
        shearlet_video_crop([filenames_in{i} '.avi'], 160, start, start+91, filenames_out{i}, output_path);
    end
    m = m + 1;
    if m==4
        break
    end
end
clear all
disp('DONE!')
beep
% end

