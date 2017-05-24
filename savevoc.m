
hFig1 = gcf;


for i=1:6
    figure(hFig1);
    hax = subplot(2,3,i);
    set(gca,'zticklabel',[])
    
    hfig = figure;
    hax_new = copyobj(hax, hfig);
    set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
    print(gcf, '-dpng', ['kth_12_centroids_' int2str(i)])
    
end

%%

hFig1 = gcf;

for i=1:6
    
    figure(hFig1);
    hax = subplot(2,3,i);
    set(gca,'zticklabel',[])
    
    hfig = figure;
    hax_new = copyobj(hax, hfig);
    set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
    print(gcf, '-dpng', ['kth_12_centroids_' int2str(i+6)])
    
end