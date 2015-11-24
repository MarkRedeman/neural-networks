% figure
% x = linspace(0, 2*pi, 50);
% y1 = sin(x);
% % y2 = cos(x);
% e1 = rand(size(y1))*.5+.5;
% % e2 = [.05 .01];

% % p = permute(0.3:-0.1:0.2 .* e1, [3 1 2])
% % ax(1) = subplot(2,2,1);
% % [l,p_] = boundedline(x, repmat(y1, 2, 1), d, ... %'-b*');
% %     'cmap', jet(2), ...
% %     'transparency', 0.25);

% figure
% q1 = quantile(iterations, 0.25);
% q3 = quantile(iterations, 0.75);
% close all;
% clc;
% figure
median_iterations = median(iterations, 'omitnan');
% confidence_interval = [median_iterations - q1; q3 - median_iterations]'
% % confidence_interval(:, :, 1) = q1';
% % confidence_interval(:, :, 2) = q3';
% [l, p_] = boundedline([results.alpha], median_iterations, ...
%         confidence_interval, 'cmap', jet(1), 'transparency', 0.25);
% % set(gca,'YScale','log');

% hold  on;

% plot([results.alpha], q1, 'k:');
% plot([results.alpha], q3, 'k:');
% figure
fig = figure(1);
set(fig,                        ...
    'NumberTitle', 'off',         ...
    'Name',         mfilename,    ...
    'MenuBar',      'none',       ...
    'Color',        [1.0 1.0 1.0] ...
);

internal_fig = subplot(1, 1, 1);
set( internal_fig,                         ...
    'Box',      'on',                      ...
    'NextPlot', 'add',                     ...
    'xgrid',    'on',                      ...
    'ygrid',    'on'                       ...
 );

confidence_interval = [];
confidence_interval(:, :, 2) = [median_iterations - q1; q3 - median_iterations]';
confidence_interval(:, :, 1) = [median_iterations - min(iterations); max(iterations) - median_iterations]';
[l, p_] = boundedline([results.alpha], repmat(median_iterations, 2, 1), ...
        confidence_interval, 'cmap', lines(2), 'transparency', 0.05);

set(p_(2), 'FaceAlpha', 0.9)
set(p_(1), 'FaceAlpha', 0.25)
hold  on;

plot([results.alpha], q1, 'k:');
plot([results.alpha], q3, 'k:');
xlabel('$\alpha$');
ylabel('Iterations');
xlim([0.1, 3]);
title(sprintf('N:= %d, max iterations: %d, total runs: %d', results(1).dimension, results(1).max_steps, results(1).total_runs));

plot([results.alpha], min(iterations), 'k:');
plot([results.alpha], max(iterations), 'k:');
set(gca,'YScale','log');

set( internal_fig,                                  ...
    'Box',      'on',                      ...
    'NextPlot', 'add',                     ...
    'xgrid',    'on',                      ...
    'ygrid',    'on' ...
 );
% plot([results.alpha], median(iterations, 'omitnan'), 'r');
% hold on;
% plot([results.alpha], upper_whisker, 'b--');
% plot([results.alpha], lower_whisker, 'b--');
% plot([results.alpha], q1, 'k--');
% plot([results.alpha], q3, 'k--');

% outlinebounds(l,p);
% title('Opaque bounds, with outline');


% figure
% ax(4) = subplot(1, 1, 1);
% repmat(y1, 2,1)
% permute([0.3:-0.1:0.2; 4.5, 0.6], [3 1 2])
% % p(:, :, 1) = e1 * p(:, :, 1);
% % p(:, :, 2) = e1 * p(:, :, 2);
% % p(:, :, 3) = e1 * p(:, :, 3);
% % p(:, :, 4) = e1 * p(:, :, 4);
% boundedline(x, repmat(y1, 2, 1), permute([0.3:-0.1:0.2; 4.5, 0.6], [3 1 2]), ...
%     'cmap', jet(2), ...
%     'transparency', 0.25);
% title('Multiple bounds using colormap');

% figure
% ax(4) = subplot(1, 1, 1);
% repmat(y1, 4,1)
% permute(0.5:-0.1:0.2, [3 1 2])
% p = permute(0.5:-0.1:0.2 .* e1, [3 1 2]);
% % p(:, :, 1) = e1 * p(:, :, 1);
% % p(:, :, 2) = e1 * p(:, :, 2);
% % p(:, :, 3) = e1 * p(:, :, 3);
% % p(:, :, 4) = e1 * p(:, :, 4);
% boundedline(x, repmat(y1, 4,1), p, ...
%     'cmap', jet(4), ...
%     'transparency', 0.25);
% title('Multiple bounds using colormap');

% clc; close all;
% scsz = get(0,'ScreenSize');
% pos1 = [scsz(3)/10  scsz(4)/10  scsz(3)/1.5  scsz(4)/1.5];
% fig55 = figure(55);
% set(fig55,'Renderer','OpenGL','Units','pixels','OuterPosition',pos1,'Color',[.95,.95,.95])
% %-------------------------------------------------------------

% %-------------------------------------------------------------
% c1= [.9 .2 .2]; c2= [.2 .4 .6]; c3= [.4 .8 .4]; c4= [.6 .6 .6]; c5= [.01 .9 .01];
% c11=[.9 .3 .3]; c22=[.3 .5 .7]; c33=[.5 .9 .5]; c44=[.7 .7 .7]; c55=[.01 .9 .01];
% applered= [.9 .2 .2]; oceanblue= [.2 .4 .6]; neongreen = [.1 .9 .1];
% liteblue = [.2 .9 .9]; hotpink=[.9 .1 .9]; c11 = 'none';
% MSz = 7;
% ax = [.10 .10 .85 .85];
% %-------------------------------------------------------------
% x=[-10:.1:10]
% dataset1 = [sin(x.*1.1)+1; x; sin(x*.9)-1];
% dataset2 = [sin(x.*1.1)+1; x; sin(x*.9)-1];

% % Assuming each line represents the average of 3 columns of data...
% % dataset1 : 55x3 (row x col) dataset
% % dataset2 : 55x3 (row x col) dataset

% %===========================================================%
% % Massage Data
% %===========================================================%

% nSETS = 2;
% rNcN = size(dataset1);
% AveOver = 1;
% DATARATE = 1;
% t = 1;


%     %==============================================%
%     MuDATA=dataset1; repDATA=rNcN(2);
%     %------------------------------
%     Mu = mean(MuDATA,2)';       Sd = std(MuDATA,0,2)';      Se = Sd./sqrt(repDATA);
%     y_Mu = Mu;                  x_Mu = 1:(size(y_Mu,2));    e_Mu = Se;
%     xx_Mu = 1:0.1:max(x_Mu);
%     yy_Mu = interp1(x_Mu,y_Mu,xx_Mu,'pchip');
%     ee_Mu = interp1(x_Mu,e_Mu,xx_Mu,'pchip');
%     p_Mu = polyfit(x_Mu,Mu,3);
%     x2_Mu = 1:0.1:max(x_Mu);    y2_Mu = polyval(p_Mu,x2_Mu);
%     XT_Mu = xx_Mu';             YT_Mu = yy_Mu';     ET_Mu = ee_Mu';
%     %==============================================%


%     hax = axes('Position',ax);

% [ph1, po1] = boundedline(XT_Mu,YT_Mu, ET_Mu,'cmap',c1,'alpha','transparency', 0.4);
%     hold on

%     %==============================================%
%     MuDATA=dataset1; repDATA=DP_REP(2);
%     %------------------------------
%     Mu = mean(MuDATA,2)';       Sd = std(MuDATA,0,2)';      Se = Sd./sqrt(repDATA);
%     y_Mu = Mu;              x_Mu = 1:(size(y_Mu,2));    e_Mu = Se;
%     xx_Mu = 1:0.1:max(x_Mu);
%     % yy_Mu = spline(x_Mu,y_Mu,xx_Mu);  % ee_Mu = spline(x_Mu,e_Mu,xx_Mu);
%     yy_Mu = interp1(x_Mu,y_Mu,xx_Mu,'pchip');
%     ee_Mu = interp1(x_Mu,e_Mu,xx_Mu,'pchip');
%     p_Mu = polyfit(x_Mu,Mu,3);
%     x2_Mu = 1:0.1:max(x_Mu);    y2_Mu = polyval(p_Mu,x2_Mu);
%     XT_Mu = xx_Mu';             YT_Mu = yy_Mu';     ET_Mu = ee_Mu';
%     %==============================================%

% [ph2, po2] = boundedline(XT_Mu,YT_Mu, ET_Mu,'cmap',c2,'alpha','transparency', 0.4);

%         axis tight; hold on;


%     leg1 = legend([ph1,ph2],{' Synapse-1',' Synapse-2'});
%     set(leg1, 'Position', [.15 .85 .11 .08], 'Color', [1 1 1],'FontSize',14);

%     %------ Legend &amp;amp; Tick Labels -------
%     if verLessThan('matlab', '8.3.1');
%         xt = roundn((get(gca,'XTick')).*AveOver*DATARATE.*(t)./(60),0);
%         set(gca,'XTickLabel', sprintf('%.0f|',xt))
%     else
%         hax2 = (get(gca));
%         xt = hax2.XTick;
%         xtt = roundn(xt*AveOver*DATARATE*(t)/(60),0);
%         hax2.XTickLabel = xtt;
%     end
%     %------


%         MS1 = 5; MS2 = 2;
%     set(ph1,'LineStyle','-','Color',c1,'LineWidth',5,...
%         'Marker','none','MarkerSize',MS1,'MarkerEdgeColor',c1);
%     set(ph2,'LineStyle','-.','Color',c2,'LineWidth',5,...
%         'Marker','none','MarkerSize',MS1,'MarkerEdgeColor',c2);

%     hTitle  = title ('\fontsize{20} Synaptic Receptors');
%     hXLabel = xlabel('\fontsize{16} Time (min)');
%     hYLabel = ylabel('\fontsize{16} Particles (+/- SEM)');
%     set(gca,'FontName','Helvetica','FontSize',12);
%     set([hTitle, hXLabel, hYLabel],'FontName','Century Gothic');
%     set(gca,'Box','off','TickDir','out','TickLength',[.01 .01], ...
%     'XMinorTick','off','YMinorTick','on','YGrid','on', ...
%     'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2);

%     %------
%     % Extra axis for boxing
%     haxes1 = gca; % handle to axes
%     haxes1_pos = get(haxes1,'Position'); % store position of first axes
%     haxes2 = axes('Position',haxes1_pos,'Color','none',...
%                   'XAxisLocation','top','YAxisLocation','right');
%     set(gca,'Box','off','TickDir','out','TickLength',[.01 .01], ...
%     'XMinorTick','off','YMinorTick','off','XGrid','off','YGrid','off', ...
%     'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2, ...
%     'XTick', [], 'YTick', []);
%     %------

% %===========================================================%
