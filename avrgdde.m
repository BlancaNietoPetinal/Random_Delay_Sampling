clc; clear;
% Create n average solution for DDE with random delays

M = 6; % number of realizations
p=params();
opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
mnval = 0.1;
mxval = 0.2;
vx = zeros(M,4000);
vy = zeros(M,4000);
vz = zeros(M,4000);

for i=1:M
    lag = mnval + rand*(mxval-mnval);
    sol = dde23(@(t,history,lag)ddesystem(t,history,lag,p),lag,@history,[0 400],opts);
    s = size(sol.y,2);
    vx(i,1:s) = sol.y(1,:);
    vy(i,1:s) = sol.y(2,:);
    vz(i,1:s) = sol.y(3,:);
end

avrgx = mean(vx);
avrgy = mean(vy);
avrgz = mean(vz);

multiplot(M,avrgx,vx,strcat('x cells, N. realizations = ',int2str(M)))

function multiplot(nplot,mat,multimat, tit)

    tiledlayout(2,nplot)
    title(tit);
    if nplot>3
        nplot = 3;
    end

    % Top nplots
    for i=1:nplot
    nexttile
    plot(multimat(i,1:2000))
    end

    % Bottom plot
    nexttile([1 nplot])
    plot(mat(1:2000));
    
end


