
function save_mat_file(filename,limit)
% This function extract the frames from filename, within the range "limits"
% and saves them into the a matfile with the same name.

[VID, COLOR_VID] = load_video_to_mat([filename,'.mp4'],160, limit(1),limit(2));
save(['Dataset/Matfiles/' filename '.mat'],'VID','COLOR_VID','filename');

end
