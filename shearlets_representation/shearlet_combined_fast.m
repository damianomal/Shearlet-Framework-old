function [ coeffs_mat, velocity_map, cone_map ] = shearlet_combined_fast( big_coeffs, t, scales, idxs, motion_th, print_debug, profiling)
%SHEARLET_COMBINED_FAST Summary of this function goes here
%   Detailed explanation goes here

global MEGAMAP_ANGLES MEGAMAP real_indexes fake_indexes

if(isempty(MEGAMAP) || isempty(MEGAMAP_ANGLES))
    shearlet_initialize_megamap(size(big_coeffs), idxs);
    shearlet_initialize_megamap_angle(size(big_coeffs), idxs);
end

coeffs_mat = zeros(size(big_coeffs,1)*size(big_coeffs,2), 121);

cone_map = zeros(size(big_coeffs,1), size(big_coeffs,2));
velocity_map = zeros(size(big_coeffs,1), size(big_coeffs,2), 3);

%
if(profiling)
    st = tic;
end

COEFFS_SHIFT = shearlet_average_shifted_coeffs(big_coeffs, idxs, t, 1);


for xx=2:size(big_coeffs,1)-1
    
    for yy=2:size(big_coeffs,2)-1
        
        % part about the representation
        
        [~, ii] = max(abs(COEFFS_SHIFT(xx, yy, idxs(:,2) == scales(1))));
        
        ii = find(fake_indexes{scales(1)} == real_indexes{scales(1)}(ii));
        
        coeff_order = squeeze(MEGAMAP(ii,scales(1),:));
        coeff_order(coeff_order == 0) = 1;
        
        res = abs(COEFFS_SHIFT(xx, yy, coeff_order));
        
        res(MEGAMAP(ii,scales(1),:) == 0) = 0;
        
        coeffs_mat((xx-1)*size(big_coeffs,2)+yy,:) = res;
        
        % part about the motion estimation
        
        [mx, ii] = max(abs(COEFFS_SHIFT(xx, yy, idxs(:,2) == scales(2))));
        
        if(mx < scales(2))
            continue;
        end
        
        ii = find(fake_indexes{scales(2)} == real_indexes{scales(2)}(ii));
        
        cone_map(xx,yy) = floor((ii-1)/25)+1;
        
        velocity_map(xx,yy, :) = MEGAMAP_ANGLES(ii,:);
        
        if(MEGAMAP_ANGLES(ii,3) == 0)
            continue;
        end
        
    end
end

% 
if(profiling)
    fprintf('-- Time for Repr./Motion Extraction: %.4f seconds\n', toc(st));
end


end

