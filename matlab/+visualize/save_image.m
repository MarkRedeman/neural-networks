%% save_image: saves the current image to eps format
function [] = save_image(filename, graph)
    % set(graph, 'Units', 'inches');
    % screenposition = get(graph, 'Position');
    % set(gcf,...
    %     'PaperPosition',[0 0 screenposition(3:4)],...
    %     'PaperSize',[screenposition(3:4)]);
    % % print -dpdf -painters epsFig
    visualize.extract_fig.export_fig(graph, [filename], '-pdf', '-png');

    % width = 6;
    % height = width * 3 / 5;
    % % set(graph, 'PaperUnits', 'inches');
    % % set(graph, 'PaperPosition', [0 0 width height]); %
    % print(graph,[filename],'-dpng');
end