function shearlet_show_cluster_colors()
%SHEARLET_SHOW_CLUSTER_COLORS Summary of this function goes here
%   Detailed explanation goes here

mm = shearlet_init_cluster_map;

figure('Name', 'Cluster Colors', 'Position', [285 463 1116 364]);

for i=1:12 
    subplot(2,6,i);
    img=reshape(mm(i,:),1,1,3);
    imshow(img, 'InitialMagnification', 50000);
    title(['Color ' int2str(i)]);
end

end

