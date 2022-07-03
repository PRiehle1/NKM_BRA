%% CONTOURPLOT FOR THE IMPACT OF ETA AND PHI ON THE LOSS (compare Figure 5)
clear;
clc;
%% I: Load the data
load('impact_of_eta_contempTR.mat')
%% II: Preperation for the plot
b = [0:0.1:1];
d = [1:1:20];
[x,y] = meshgrid(b,d);

%% III: Plot
figure('NumberTitle','off','Name','contour plot')
contourf(x,y,Loss_average,'LevelList',[0:0.01:0.2] )
colormap(gray);
c = colorbar;
c.Label.String ='Loss';
set(findobj(gcf,'type','axes'),'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold', 'LineWidth', 1);
xlabel('$\eta$','Interpreter','latex','FontSize',20, 'FontName','TimesNewRoman','FontWeight','bold');
ylabel('$\phi$','Interpreter','latex','FontSize',20, 'FontName','TimesNewRoman','FontWeight','bold');