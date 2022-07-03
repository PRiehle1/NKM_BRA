%% CONTOURPLOT OVER THE LOSS AND DEL_PI AND DEL_X (compare Figure 4)
clear;
clc;
%% I: Load the data
load('OSR_contempTR_eta0.75_250sim_contour.mat')

%% II: Preparation for the plot

b = [0:0.25:3];
d = [0:0.25:3];
[x,y] = meshgrid(b,d);

%% III: Plot

figure('NumberTitle','off','Name','contour plot')
contourf(x,y,Loss_average,'LevelList',0:0.01:0.2)
colormap(gray);
c = colorbar;
c.Label.String ='Loss';

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',12,'FontWeight','Bold', 'LineWidth', 1);
xlabel('$\delta_x$','Interpreter','latex','FontSize',20, 'FontName','Arial','FontWeight','bold');
ylabel('$\delta_{\pi}$','Interpreter','latex','FontSize',20, 'FontName','Arial','FontWeight','bold');




