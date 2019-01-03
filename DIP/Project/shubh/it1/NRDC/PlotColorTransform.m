function fig = PlotColorTransform(T)

    set(0, 'DefaultLineLineWidth', 1);
    set(0, 'DefaultTextFontSize', 24);
    set(0, 'DefaultTextFontName', 'Times');
    set(0, 'DefaultAxesLineWidth', 1);
    set(0, 'DefaultAxesFontSize', 20);
    set(0, 'DefaultAxesFontName', 'Times');
    %set(0, 'DefaultAxesXTick', []);
    %set(0, 'DefaultAxesYTick', []);
    
    colors = {'red', 'green', 'blue'};
    % do your plotting here
    fig=figure; clf

    xx = 0 : 1/255 : 1;
    for c=1:3
        yyC = ppval(xx,T.RGBCurves(c));
        plot(xx,yyC,'LineWidth',2, 'Color', colors{c}), grid on, hold on
    end
    hold off
    axis([0 1 0 1]);

    % This will save the plot twice, as curves.pdf and as curves.eps
    % The eps has a tight bounding box around the plot, so then we
    % can use Preview to convert to pdf, and get something we can
    % directly include into the paper without further cropping
    %print -dpdf curves;
    %print -depsc2 curves;
    
end