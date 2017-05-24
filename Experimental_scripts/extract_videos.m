% function [ output_args ] = extract_videos( filename )
% Thia file extracts mat files from the defines video files.
%% Part 1: Cropping initial videos
% Inputs.....   filenames_in: files to crop (constructed using action_input).
%               filenames_out: corresponding output filenames (constructed using action_output).
%               start_frames: 4 landmark frame numbers to extract 3 videos.
%
%

input_path = 'CookingActions\';
output_path = 'Dataset\video_files\';


action_inputs= {'CARROT', 'EGGS', 'LEMON', 'MEZZALUNA', 'POTATO', 'POURING', 'ROLLING', 'SPREADING', 'TABLE'};
action_outputs = {'carrot', 'eggs', 'lemon', 'mezzaluna', 'potato', 'pouring', 'rolling', 'spreading', 'table'};
start_frames_all = [129 184 238 292; 221 277 330 383; 130 197 254 300; 168 234 297 357; 199 267 338 416;...
    256 335 429 516; 231 295 362 423; 205 277 341 400; 164 232 301 367];

for j = 9
action_input= action_inputs{j};
action_output = action_outputs{j};
start_frames = start_frames_all(j,:);

    filenames_in = {[action_input '_TR_0'],[action_input '_TR_1'],[action_input '_TR_2']};
    
    for i = 1:3
        start = start_frames(i);
        n = num2str(i);
        filenames_out = {[action_output n '_cam0'],[action_output n '_cam1'],[action_output n '_cam2']};
        
        for i = 1:numel(filenames_in)
            shearlet_video_crop([filenames_in{i} '.avi'], 160, start_frames(i),start_frames(i+1), filenames_out{i}, output_path);
        end
    end
end

clear all
disp('DONE!')
beep
% end

