function plotTriad(trans,id)
    triad=[0 0 0 1; 0.1 0 0 1; 0 0.1 0 1; 0 0 0.1 1; 0.12 0 0 1; 0 0.12 0 1; 0 0 0.12 1].';
    triad=trans*triad;
    org=triad(1:3,1);
    xdir=triad(1:3,2)-org;
    ydir=triad(1:3,3)-org;
    zdir=triad(1:3,4)-org;
    xtxt=triad(1:3,5);
    ytxt=triad(1:3,6);
    ztxt=triad(1:3,7);
    quiver3(org(1),org(2),org(3),xdir(1),xdir(2),xdir(3),'Color','r');
    text(xtxt(1),xtxt(2),xtxt(3),['x_' num2str(id)],'HorizontalAlignment','Center');
    quiver3(org(1),org(2),org(3),ydir(1),ydir(2),ydir(3),'Color','g');
    text(ytxt(1),ytxt(2),ytxt(3),['y_' num2str(id)],'HorizontalAlignment','Center');
    quiver3(org(1),org(2),org(3),zdir(1),zdir(2),zdir(3),'Color','b');
    text(ztxt(1),ztxt(2),ztxt(3),['z_' num2str(id)],'HorizontalAlignment','Center');
end

