function  shearlet_initialize_megamap_angle(sz, idxs)
%SHEARLET_INITIALIZE_MEGAMAP Summary of this function goes here
%   Detailed explanation goes here

global MEGAMAP_ANGLES real_indexes fake_indexes

MEGAMAP_ANGLES = zeros(75,3);

scale_chosen = 2;

dummy_matrix = zeros(sz(1),sz(2),sz(4));

for i = 1:3
    for j = 1:3
        dummy_matrix(i,j,:) = 1:size(dummy_matrix, 3);
    end
end

%%


[c1, c2, c3] = shearlet_dummy_calculate_grids(dummy_matrix, 2, 2, 2, scale_chosen, idxs, 0);

cc1 = c1';
cc2 = c2';
cc3 = c3';

real_indexes = [cc1(:); cc2(:); cc3(:)];

cc1 = flip(c1, 2)';
cc2 = flip(c2, 2)';
cc3 = flip(c3, 2)';

fake_indexes = [cc1(:); cc2(:); cc3(:)];

%%

for cone=1:3
    for i=1:5
        for j=1:5
            index = (cone-1)*25+(i-1)*5+j;
            MEGAMAP_ANGLES(index,:) = shearlet_shearings_to_angle([i j], [5 5], 2, cone);
        end
    end
end



end

