
% generate the structure
a = shearlets_synthetic_worm( 128, 20 );

% commented, not needed
% a = permute(a,[2 1 3]);

%%
fH = figure('Position', [148 554 560 420]);

% applies two lights
view([-132.3000 2.8]);
camlight

view([101.1 21.2]);
camlight

%%

% surface, bottom (S1)
coords = [104 64 40];

% surface, front (S2)
coords = [85 64 19];
% 
% % surface, side (S3)
% coords = [85 84 40];
% 
% % still spatial corner (C1)
coords = [65 84 20];
% 
% % still spatial edge (E1)
% coords = [104 64 20];
% 
% % still spatial edge (E2)
% coords = [104 84 40];
% 
% % still spatial edge (E3)
% coords = [85 84 20];

% surface, bottom (SI1)
coords = [(129-90+40) 64 90];

% surface, side (SIDE, weird behaviour)
coords = [85 84 65];

%%

clear COEFFS idxs
% [COEFFS,idxs] = shearlet_transform_3D(a,65,91,[0 1 1], 3, 1);
[COEFFS,idxs] = shearlet_transform_3D_fullwindow(a,coords(3),91,[0 1 1], 3, 1);

% coords_show = coords;

%%

figure(fH);
clf;

coords_show = [85 84 65];

% displays the structure
isosurface(a > 0);
axis([0 128 0 128 0 128]);
xlabel('column');
ylabel('row');
zlabel('time');

% applies two lights
view([-132.3000 2.8]);
camlight

view([101.1 21.2]);
camlight

% sets the main view of the structure
view([109.5 10.98]);

hold on;
plot3(coords_show(2), coords_show(1), coords_show(3), 'ro', 'MarkerSize', 5);
plot3(coords_show(2), coords_show(1), coords_show(3), 'ro', 'MarkerSize', 20);
hold off;

DESCR = shearlet_descriptor_for_point( COEFFS, coords_show(1), coords_show(2), coords_show(3), 3, idxs );
shearlet_show_descriptor(DESCR);

 
% edited = true;
% 
% while true
%     
%     pause(0.5);
%     
%     if(edited)
%         
%         fprintf('-----------------------\n');
%         
%         
%         figure(fH);
%         [az,el] = view;
%         clf;
%         p = patch(isosurface(mmat < th, 0));
%         
%         p.FaceColor = [0.2 0.4 0.5];
%         p.EdgeColor = 'none';
%         daspect([1,1,1])
%         view(3); axis tight
%         camlight
%         lighting gouraud
%         
%         
%         view([az el]);
%         
%         figure(fHb);
%         [vals, shears] = get_coeffs_for(coords, scale, win);
%         fprintf('Coords: %d %d %d\n', coords(1), coords(2), coords(3));
%         
%         [as, ai] = sort(vals(:), 1, 'descend');
%         
%         sub_1 = subplot(1,3,1);
%         bar(vals(:));
%         
%         for cono=1:3
%             CONO = shears(shears(:,1) == cono, :);
%             Mdim(cono) = numel(unique(CONO(:,3)));
%             Ndim(cono) = numel(unique(CONO(:,4)));
%         end
%         
%         hold on;
%         line([Mdim(1)*Ndim(1) Mdim(1)*Ndim(1)],get(gca,'ylim'),'Color',[1 0 0])
%         line([Mdim(1)*Ndim(1)+Mdim(2)*Ndim(2) Mdim(1)*Ndim(1)+Mdim(2)*Ndim(2)],get(gca,'ylim'),'Color',[1 0 0])
%         hold off;
%         
%         %         figure(fHs);
%         sub_2 = subplot(1,3,2);
%         bar(as);
%         
%         hold on;
%         id = find(as > as(1) * 0.25, 1, 'last' );
%         line([id id],get(gca,'ylim'),'Color',[1 0 0])
%         hold off;
%         
%         %         for cono=1:3
%         %             CONO = shears(shears(:,1) == cono, :);
%         %             Mdim(cono) = numel(unique(CONO(:,3)));
%         %             Ndim(cono) = numel(unique(CONO(:,4)));
%         %
%         %
%         %             if(min(CONO(:,3)) <= 0)
%         %                 CONO(:,3) = CONO(:,3) + abs(min(CONO(:,3))) + 1;
%         %             end
%         %
%         %             if(min(CONO(:,4)) <= 0)
%         %                 CONO(:,4) = CONO(:,4) + abs(min(CONO(:,4))) + 1;
%         %             end
%         %
%         %             CONO(:,4) = -CONO(:,4);
%         %
%         %             shears(shears(:,1) == cono, :) = CONO;
%         %         end
%         
%         
%         figure(fH);
%         
%         hold on;
%         %         plot3(coords(1), coords(2), coords(3), 'ro');
%         plot3(coords(2), coords(1), coords(3), 'ro');
%         axis([1 size(mmat,1), 1 size(mmat,2), 1 size(mmat,3)]);
%         
%         r = 2*win +1;
%         [x,y,z] = sphere(20);
%         % x0 = 100; y0 = 100; z0 = 100;
%         x = x*r + coords(2);
%         y = y*r + coords(1);
%         z = z*r + coords(3);
%         % surface(x,y,z,'FaceColor', 'none','EdgeColor',[1 0.2 0.3]);
%         % surface(x,y,z,'FaceColor', [1 0.2 0.3],'EdgeColor',[1 0.2 0.3]);
%         surface(x,y,z,'FaceColor', [1 0.2 0.3],'EdgeColor','none');
%         
%         hold off;
%         
%         camlight(19, -10);
%         camlight(90, -90);
%         camlight(-90, -90);
%         
%         
%         figure(fHb);
%         
%         subplot(1,3,3);
%         cla;
%         
%         
%         
%         
%         hold on;
%         for i=1:5
%             temp = shears(ai(i),:);
%             angles{i} = angle_from_shearings(temp(1), temp(3), -temp(4), Mdim(temp(1)), Ndim(temp(1)), false);
%             angles{i} = resize_length(angles{i}, as(i)/as(1));
%             quiver3(0,0,0,angles{i}(1), angles{i}(2), angles{i}(3));
%             
%             %             figure(fH);
%             %             hold on;
%             %             %             quiver3(coords(1),coords(2),coords(3),angles{i}(1)*SCALING, angles{i}(2)*SCALING, angles{i}(3)*SCALING, 'LineWidth', 4);
%             %             %             quiver3(coords(2),coords(1),coords(3),angles{i}(1)*SCALING, angles{i}(3)*SCALING, angles{i}(2)*SCALING, 'LineWidth', 4);
%             %             quiver3(coords(2),coords(1),coords(3),angles{i}(1)*SCALING, angles{i}(2)*SCALING, angles{i}(3)*SCALING, 'LineWidth', 4);
%             %             %             quiver3(coords(2),coords(1),coords(3),angles{i}(2)*SCALING, angles{i}(3)*SCALING, angles{i}(1)*SCALING, 'LineWidth', 4);
%             %             %                         quiver3(coords(1),coords(2),coords(3),angles{i}(2)*SCALING, angles{i}(1)*SCALING, angles{i}(3)*SCALING, 'LineWidth', 4);
%             %             hold off;
%             
%             %             figure(fHa);
%             figure(fHb);
%             subplot(1,3,3);
%             fprintf('Max shearing (%d): cone %d, s1 %d, s2 %d\n', i, temp(1), temp(3), temp(4));
%             
%             %             fprintf('%f\n', sqrt(angles{i}(1)^2 + angles{i}(2)^2 + angles{i}(3)^2));
%         end
%         
%         
%         temp = shears(ai(1),:);
%         fprintf('Max shearing: cone %d, s1 %d, s2 %d\n', temp(1), temp(3), temp(4));
%         
%         hold off;
%         view([30 45]);
%         axis([-1 1, -1 1, -1 1]);
%         %         axis([-0.5 0.5, -0.5 0.5, -0.5 0.5]);
%         
%         
%         %         angles{1} = angle_from_shearings(2, 0, 0, Mdim(temp(1)), Ndim(temp(1)), false);
%         %
%         %         figure(fH);
%         %         hold on;
%         %         quiver3(coords(1),coords(2),coords(3),angles{1}(1)*SCALING, angles{1}(2)*SCALING, angles{1}(3)*SCALING, 'LineWidth', 4);
%         %         hold off;
%         
%         
%         figure(fH);
%         
%         msg = sprintf('Coords: %d %d %d', coords(1), coords(2), coords(3));
%         
%         xlabel('x');
%         ylabel('y');
%         zlabel('t');
%         
%         legend('isosurface','considered (x,y,t) point','Location','northeast')
%         
%         title(gca, msg);
%         
%         msg = sprintf('Scale %d, Win %d, Max %1.8f', scale, 2*win+1, as(1));
%         
%         title(sub_1, msg);
%         
%         xlabel(sub_1, 'shearing');
%         ylabel(sub_1, 'coefficient value');
%         
%         xlabel(sub_2, 'sorted shearings');
%         ylabel(sub_2, 'coefficient value');
%         
%         edited = false;
%         
%         figure(fHc);
%         clf;
%         hold on;
%         
%         [XX, YY] = meshgrid(1:size(mmat,3), 1:size(mmat,2));
%         CC = zeros(size(mmat,2), size(mmat,3));
%         maxZZ = zeros(size(mmat,2), size(mmat,3));
%         mmZZ = zeros(size(mmat,2), size(mmat,3));
%         
%         cmap = polarmap(35);
%         colormap(cmap);
%         
%         for ii=win+1:size(mmat,1)-win-1
%             for jj=win+1:size(mmat,2)-win-1
%                 for zz=win+1:size(mmat,3)-win-1
%                     if(mmat(ii,jj,zz) <= th && mmat(ii,jj,zz) > th-50)
%                         
%                         [vals, ~] = get_coeffs_for([ii jj zz], scale, win);
%                         
%                         [as, ~] = sort(vals(:), 1, 'descend');
%                         
%                         id = find(as > as(1) * 0.50, 1, 'last' );
%                         
%                         if(ii > maxZZ(jj,zz))
%                             maxZZ(jj,zz) = ii;
%                             mmZZ(jj,zz) = size(mmat,1) - ii;
%                             CC(jj,zz) = id;
%                         end
%                         
%                         %                         plot3(jj, ii, zz, '.', 'MarkerSize',15, ...
%                         %                             'MarkerEdgeColor', cmap(min(id, size(cmap,1)), :), 'MarkerFaceColor', cmap(min(id, size(cmap,1)), :))
%                         
%                     end
%                 end
%             end
%         end
%         
%         colorbar;
%         
%         surf(XX,YY,mmZZ,CC, 'EdgeAlpha', 0);
%         
%         hold off;
%         
%     end
%     
%     if strcmp(get(fH,'currentcharacter'),'q')
%         break;
%     end
%     
% end
% 
% %%
% 
% function KeyPressCb(~,evnt)
% 
% %         fprintf('key pressed: %s\n',evnt.Key);
% edited = true;
% 
% if strcmpi(evnt.Key,'leftarrow')
%     coords(2) = coords(2)-1;
% elseif strcmpi(evnt.Key,'rightarrow')
%     coords(2) = coords(2)+1;
% elseif strcmpi(evnt.Key,'uparrow')
%     coords(1) = coords(1)-1;
% elseif strcmpi(evnt.Key,'downarrow')
%     coords(1) = coords(1)+1;
% elseif strcmpi(evnt.Key,'w')
%     coords(3) = coords(3)+1;
% elseif strcmpi(evnt.Key,'s')
%     coords(3) = coords(3)-1;
% elseif strcmpi(evnt.Key,'2')
%     scale = 2;
% elseif strcmpi(evnt.Key,'3')
%     scale = 3;
% elseif strcmpi(evnt.Key,'d')
%     win = win + 1;
%     fprintf('Window set to %d\n', win);
% elseif strcmpi(evnt.Key,'a')
%     if(win > 0)
%         win = win - 1;
%     end
%     fprintf('Window set to %d\n', win);
% elseif strcmpi(evnt.Key,'z')
%     x = input('Save coords to: ');
%     saved_coords{x} = coords;
% elseif strcmpi(evnt.Key,'x')
%     x = input('Load coords from: ');
%     coords = saved_coords{x};
% elseif strcmpi(evnt.Key,'c')
%     x = input('Set coords to (use [ and ]): ');
%     coords = x;
% elseif strcmpi(evnt.Key,'p')
%     
%     i1 = getframe(fH);
%     i2 = getframe(fHb);
%     i3 = getframe(fHc);
%     
%     %             size(i1.cdata)
%     %             size(i2.cdata)
%     
%     i4 = cat(2, i1.cdata, i2.cdata(:,120:1050,:), i3.cdata);
%     
%     
%     filename = input('Save image to: ', 's');
%     
%     imwrite(i4, filename);
%     %             edited = f;
% elseif strcmpi(evnt.Key,'h')
%     fprintf('---------------\nHelp:\n');
%     fprintf('left-right move through x-axis\n');
%     fprintf('up-down move through y-axis\n');
%     fprintf('w-s move through z-axis\n');
%     fprintf('2-3 set scale considered\n');
%     fprintf('a-d decrease/incresed averaging window\n');
%     fprintf('c manually set coordinates\n');
% end
% 
% for j=1:3
%     if(coords(j) < 1)
%         coords(j) = 1;
%     end
% end
% 
% 
% end
% 
% function [res, shears] = get_coeffs_for(coords, scale, win)
% 
% global big_coeffs shearletIdxs
% 
% if(nargin < 3)
%     win = 0;
% end
% 
% shears = shearletIdxs(shearletIdxs(:,2) == scale, :);
% 
% if(win == 0)
%     %             res = abs(big_coeffs(coords(1), coords(3), coords(2), shearletIdxs(:,2) == scale));
%     %             res = abs(big_coeffs(coords(1), coords(2), coords(3), shearletIdxs(:,2) == scale));
%     res = abs(big_coeffs(coords(1), coords(2), coords(3), shearletIdxs(:,2) == scale));
% else
%     
%     
%     
%     %             res = abs(big_coeffs(coords(1)-win:coords(1)+win, coords(3)-win:coords(3)+win, ...
%     %                 coords(2)-win:coords(2)+win, shearletIdxs(:,2) == scale));
%     %             res = abs(big_coeffs(coords(1)-win:coords(1)+win, coords(2)-win:coords(2)+win, ...
%     %                 coords(3)-win:coords(3)+win, shearletIdxs(:,2) == scale));
%     res = abs(big_coeffs(coords(1)-win:coords(1)+win, coords(2)-win:coords(2)+win, ...
%         coords(3)-win:coords(3)+win, shearletIdxs(:,2) == scale));
%     
%     %             size(res)
%     res = squeeze((sum(sum(sum(res,1),2),3)));
%     res = res ./ ((win*2+1)^3);
% end
% end

