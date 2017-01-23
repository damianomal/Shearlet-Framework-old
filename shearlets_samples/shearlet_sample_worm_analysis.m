
% generate the structure
a = shearlets_synthetic_worm( 128, 20, 0.5);

% a = smooth3(a, 'box', 3);

% commented, not needed
% a = permute(a,[2 1 3]);

%% 

az1 = 121.7000;
el1 = 10.8000;

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
coords = [(129-80+47) 64 80];

% surface, side (SI3)
coords = [(129-90+34) 84 90];

% surface, side (EI2)
coords = [(129-80+8) 84 80];


% surface, side (SIDE, in t=65)
% coords = [85 84 65];

% surface, end (SI2)
% coords = [64 64 108]

%%

clear COEFFS idxs
[COEFFS,idxs,start_ind] = shearlet_transform_3D_fullwindow(a,coords(3),128,[0 1 1], 3, 1);

%%

figure(fH);
clf;

% coords_show = [(129-80+16) 64 63];
% coords_show = [104 84 63];
coords_show = [93 45 87];

% NICE POINTS: to show how similar spatio-temporal behaviour
% is represented similarly in the 3D representation of the two points
% coords_show = [104 84 64];
% coords_show = [64 84 64];


TARGET_SCALE = 2;

% displays the structure

p = patch(isosurface(a > 0, 0, a));
p.FaceColor = 'interp';
p.EdgeColor = 'none';

colormap([0 0.85 0.55])

% isosurface(a > 0); 
axis([0 128 0 128 0 128]);
xlabel('y','FontSize',24,'FontWeight','bold');
ylabel('x','FontSize',24,'FontWeight','bold');
zlabel('time','FontSize',24,'FontWeight','bold');
grid on;
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
set(gca,'zticklabel',[])
 
% set size to take a screenshot
set(fH, 'Position', [148 210 961 764]);


% applies two lights
% view([-132.3000 2.8]);
% camlight
% 
% view([101.1 21.2]);
% camlight

view([154.5000 10.8000]);
camlight 
lighting phong 

% sets the main view of the structure
% view([109.5 10.98]);
view([az1 el1]);

hold on;
plot3(coords_show(2), coords_show(1), coords_show(3), 'ro', 'MarkerSize', 5);
plot3(coords_show(2), coords_show(1), coords_show(3), 'ro', 'MarkerSize', 20);
hold off;

fprintf('Coord(3): %d, Changed coord: %d\n', coords_show(3), coords_show(3)-start_ind+1);

DESCR = shearlet_descriptor_for_point(COEFFS, coords_show(1), coords_show(2), coords_show(3)-start_ind+1, TARGET_SCALE, idxs);
shearlet_show_descriptor(DESCR);

set(gcf, 'Position', [934 208 961 763]);
view([-40.3 25.2]);


%% descrittore medio dei 4 punti indicati (trovati dal detector)

corners_coord =  [64   44  19;
                  103  44  19;
                  64   83  19;
                  103  83  19];

corners_descr = zeros(121,1);
       
for i=1:size(corners_coord,1)
    corners_descr = corners_descr + shearlet_descriptor_for_point(COEFFS, corners_coord(i,1), ...
                                                                  corners_coord(i,2), corners_coord(i,3)-start_ind+1, 2, idxs);
    
end

corners_descr = corners_descr ./ size(corners_coord,1);
shearlet_show_descriptor(corners_descr);

set(gcf, 'Position', [934 208 961 763]);
view([-40.3 25.2]);

figure(fH);
clf;

comparison_3d_visualization_from_points(a < 255, corners_coord, false);

axis([0 128 0 128 0 128]);
xlabel('y','FontSize',24,'FontWeight','bold');
ylabel('x','FontSize',24,'FontWeight','bold');
zlabel('time','FontSize',24,'FontWeight','bold');

view([az1 el1]);


%% descrittore medio di 4 punti sugli edge 

% edges_coord = [65 84 40;
%                   104 84 40;
%                   104 45 40;
%                   65 45 40];
              
edges_coord = [65 84 40;
                  104 84 40;
                  104 45 40;
                  65 45 40;
                  54 84 87;
                  93 84 87;
                  93 45 87];
              
edges_descr = zeros(121,1);
       
for i=1:size(edges_coord,1)
    edges_descr = edges_descr + shearlet_descriptor_for_point(COEFFS, edges_coord(i,1), ...
                                                              edges_coord(i,2), edges_coord(i,3)-start_ind+1, 2, idxs);
    
end

% edges_descr = edges_descr ./ size(edges_coord,1);
shearlet_show_descriptor(edges_descr);

set(gcf, 'Position', [934 208 961 763]);
view([-40.3 25.2]);


figure(fH);
clf;

% p = patch(isosurface(a > 0, 0, a));
% p.FaceColor = 'interp';
% p.EdgeColor = 'none';
% 
% axis([0 128 0 128 0 128]);
% xlabel('y','FontSize',24,'FontWeight','bold');
% ylabel('x','FontSize',24,'FontWeight','bold');
% zlabel('time','FontSize',24,'FontWeight','bold');
% grid on;
% set(gca,'xticklabel',[])
% set(gca,'yticklabel',[])
% set(gca,'zticklabel',[])
%  
% % set size to take a screenshot
% set(fH, 'Position', [148 210 961 764]);
% 
% 
% % applies two lights
% % view([-132.3000 2.8]);
% % camlight
% % 
% % view([101.1 21.2]);
% % camlight
% 
% view([154.5000 10.8000]);
% camlight 
% lighting phong 
% 
% % sets the main view of the structure
% % view([109.5 10.98]);
% view([az1 el1]);


comparison_3d_visualization_from_points(VIS_FG_MASKS, COORDINATES(1,:), permuted);

axis([0 128 0 128 0 128]);
xlabel('y','FontSize',24,'FontWeight','bold');
ylabel('x','FontSize',24,'FontWeight','bold');
zlabel('time','FontSize',24,'FontWeight','bold');

view([az1 el1]);

hold on;
plot3( [84 84], [65 65], [23 60], 'LineWidth', 12, 'Color', [1 0.2 0.3]);
plot3( [84 84], [104 104], [23 60], 'LineWidth', 12, 'Color', [1 0.2 0.3]);
plot3( [45 45], [104 104], [23 60], 'LineWidth', 12, 'Color', [1 0.2 0.3]);
% plot3( [45 45], [65 65], [23 60], 'LineWidth', 8, 'Color', [1 0.2 0.3]);
plot3( [84 84], [63 46], [70 104], 'LineWidth', 12, 'Color', [1 0.2 0.3]);
plot3( [84 84], [102 85], [70 104], 'LineWidth', 12, 'Color', [1 0.2 0.3]);
plot3( [45 45], [102 85], [70 104], 'LineWidth', 12, 'Color', [1 0.2 0.3]);
hold off;

%% descrittore medio di 4 punti sulla superficie 

% edges_coord = [104 64 40;
%                   104 84 40;
%                   104 45 40;
%                   65 45 40];
              
surface_coords = [104 64 40; 
               85 64 19; 
               85 84 40; 
               (129-80+47) 64 80; 
               85 84 65; 
               64 64 108; 
               (129-90+34) 84 90];              
              
           
% edges_coord = [85 84 40; (129-80+47) 64 80];

           
edges_descr = zeros(121,1);
       
for i=1:size(surface_coords,1)
    edges_descr = edges_descr + shearlet_descriptor_for_point(COEFFS, surface_coords(i,1), ...
                                                              surface_coords(i,2), surface_coords(i,3)-start_ind+1, 2, idxs);
end

edges_descr = edges_descr ./ size(surface_coords,1);
shearlet_show_descriptor(edges_descr);

set(gcf, 'Position', [934 208 961 763]);
view([-40.3 25.2]);

figure(fH);
clf;

comparison_3d_visualization_from_points(a < 255, surface_coords, false);

axis([0 128 0 128 0 128]);
xlabel('y','FontSize',24,'FontWeight','bold');
ylabel('x','FontSize',24,'FontWeight','bold');
zlabel('time','FontSize',24,'FontWeight','bold');

view([az1 el1]);





%%

clear COEFFS idxs
[COEFFS,idxs] = shearlet_transform_3D_fullwindow(a,46,127,[0 1 1], 3, 1);


%%

% parameters for the detection process
LOWER_THRESHOLD = 0.3;
SPT_WINDOW = 17;
SCALES = [3];
CONE_WEIGHTS = [1 1 1];

% detect spatio-temporal interesting points within the sequence

close all;
% 
% output_name = shearlet_create_video_outname( video_filename, SCALES, LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS);

[COORDINATES, CHANGE_MAP] = shearlet_detect_points( VID(:,:,1:127), COEFFS, SCALES, [], LOWER_THRESHOLD, SPT_WINDOW, CONE_WEIGHTS, false);


%% 

permuted = false;

VIS_FG_MASKS = VID < 255;

% if(permuted)
%     VIS_FG_MASKS = permute(VIS_FG_MASKS,[3 2 1]);
% end
% 
close all;

comparison_3d_visualization_from_points(VIS_FG_MASKS, COORDINATES(1,:), permuted);

axis([0 128 0 128 0 128]);
xlabel('y','FontSize',24,'FontWeight','bold');
ylabel('x','FontSize',24,'FontWeight','bold');
zlabel('time','FontSize',24,'FontWeight','bold');

view([az1 el1]);




