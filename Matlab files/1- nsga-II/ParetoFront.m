function ParetoFront(F1)
close all;

% f=[F1.Cost]';
% 
% c = linspace(1,3,length(f));
% sz=50;
% figure
% s1=scatter3(f(:,1),f(:,2),f(:,3),sz);
% s1.LineWidth = 0.2;
% s1.MarkerEdgeColor = 'b';
%% 

f=[F1.Cost]';
f=sortrows(f,[1,2,3]);
c = linspace(1,3,length(f));
F = scatteredInterpolant(f(:,1),f(:,2),f(:,3),'linear','none');
sgr = linspace(min(f(:,1)),max(f(:,1)));
ygr = linspace(min(f(:,2)),max(f(:,2)));
[XX,YY] = meshgrid(sgr,ygr);
ZZ = F(XX,YY);
figure
s2=surf(XX,YY,ZZ,'FaceAlpha',.4, 'LineStyle' ,  ':');
hold on
sz=50;
s3=scatter3(f(:,1),f(:,2),f(:,3),sz);
s3.LineWidth = 0.6;
s3.MarkerEdgeColor = 'w';
s3.MarkerFaceColor = 'b';
hold off


%% 3-D Scatter Plot
% figure
% subplot(2,2,1)
% scatter3(f(:,1),f(:,2),f(:,3),'k.');
% subplot(2,2,2)
% scatter3(f(:,1),f(:,2),f(:,3),'k.');
% view(-148,8)
% subplot(2,2,3)
% scatter3(f(:,1),f(:,2),f(:,3),'k.');
% view(-180,8)
% subplot(2,2,4)
% scatter3(f(:,1),f(:,2),f(:,3),'k.');
% view(-300,8)
% 
%% Interpolated Surface Plot
% % figure
% % F = scatteredInterpolant(f(:,1),f(:,2),f(:,3),'linear','none');
% % sgr = linspace(min(f(:,1)),max(f(:,1)));
% % ygr = linspace(min(f(:,2)),max(f(:,2)));
% % [XX,YY] = meshgrid(sgr,ygr);
% % ZZ = F(XX,YY);
% % 
% % figure
% % subplot(2,2,1)
% % surf(XX,YY,ZZ,'LineStyle','none')
% % hold on
% % scatter3(f(:,1),f(:,2),f(:,3),'k.');
% % hold off
% % subplot(2,2,2)
% % surf(XX,YY,ZZ,'LineStyle','none')
% % hold on
% % scatter3(f(:,1),f(:,2),f(:,3),'k.');
% % hold off
% % view(-148,8)
% % subplot(2,2,3)
% % surf(XX,YY,ZZ,'LineStyle','none')
% % hold on
% % scatter3(f(:,1),f(:,2),f(:,3),'k.');
% % hold off
% % view(-180,8)
% % subplot(2,2,4)
% % surf(XX,YY,ZZ,'LineStyle','none')
% % hold on
% % scatter3(f(:,1),f(:,2),f(:,3),'k.');
% % hold off
% % view(-300,8)
% 
% %% Parallel Plot
% % figure
% % p = parallelplot(f);
% % p.CoordinateTickLabels =['Obj1';'Obj2';'Obj3'];
% % minObj2 = min(f(:,2));
% % maxObj2 = max(f(:,2));
% % grpRng = minObj2 + 0.1*(maxObj2-minObj2);
% % grpData = f(:,2) <= grpRng;
% % p.GroupData = grpData;
% % p.LegendVisible = 'off';
% 
end