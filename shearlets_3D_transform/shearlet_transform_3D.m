function [ big_coeffs, shearletIdxs] = shearlet_transform_3D( VID, central_frame, neigh_window, shearLevels, scales, useGPU )
%SHEARLET_TRANSFORM_3D Calculates the 3D Shearlet Transform for the passed
%video sequence
%
% Usage:
%   [coeffs, shearletIdxs] = shearlet_transform_3D(video, 68, 91, [0 1 1], 3, 1)
%           Calculates the transform for the 3D matrix 'video', considering
%           only a subset of all the time interval centered in frame 46 and
%           wide 91 time frames (so, actually, only considering frames from
%           23 to 113 in the sequence). The number of scales chosen is 3,
%           with shearing levels equal to 0, 1 and 1. The last '1' in
%           this function tells ShearLab3D to use the GPU for all the
%           calculations (to increase the speed of all the process).
%           
% Parameters:
%   VID: the 3D matrix representing the video sequence to process
%   central_frame: the central frame of the temporal interval we want to
%                  consider
%   neigh_window: the number of total frames to consider
%   shearLevels: the shearing levels for the different scales
%   scales: the number of scales in the transform
%   useGPU: use the GPU to make all the calculations (1 equals to TRUE)
%
% Output:
%   coeffs: the four-dimensional structure representing all the
%           coefficients calculated for the shearlet transform
%   shearletIdxs: 
%
%   See also ...
%
% 2016 Damiano Malafronte.

% impostazione di default per i livelli di shearing:
% in questo modo si avranno 3x3, 5x5, 5x5 shearing nelle scale
if(isempty(shearLevels))
    shearLevels = [0 1 1];
end

% se non specificato dall'utente, non usa la GPU
if(nargin < 5)
    useGPU = 0;
end

%
start_ind = central_frame - (neigh_window-1)/2;
end_ind = central_frame + (neigh_window-1)/2;

start_ind = max(start_ind,1);
end_ind = min(end_ind, size(VID,3));

%
Xactual = VID(:,:,start_ind:end_ind);

%
st = tic;
[Xfreq, ~, preparedFilters, dualFrameWeightsCurr, shearletIdxs] = SLprepareSerial3D(useGPU,Xactual,scales,shearLevels, true);
fprintf('-- Time for Serial Preparation: %.4f seconds\n', toc(st));

st = tic;

%
big_coeffs = zeros(size(Xactual,1), size(Xactual,2), size(Xactual,3), size(shearletIdxs,1));

%
for j = 1:size(shearletIdxs,1)
    shearletIdx = shearletIdxs(j,:);
    
    %%shearlet decomposition
    [coeffs,~, dualFrameWeightsCurr,~] = SLsheardecSerial3D(Xfreq,shearletIdx,preparedFilters,dualFrameWeightsCurr);
    
    if(~useGPU)
        big_coeffs(:,:,:,j) = coeffs;
    else
        big_coeffs(:,:,:,j) = gather(coeffs);
    end
    
end

%
fprintf('-- Time for Serial Decomposition: %.4f seconds\n', toc(st));

end

