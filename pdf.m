function pdf(csv, ev, er)
    dataset = load(csv);
    [filas, columnas] = size(dataset);
    v = dataset(1:filas);
    v = v.*-1;
    r = dataset(filas+1:end);
    
    escalaV = ev;
    subplot(1, 2, 1);
    plot(v);
    ylim([-escalaV 0]);
    xlim([1 filas]);
    xlabel('Lecturas');
    ylabel(sprintf('Potencial natural \n %d                                                                   %d', escalaV, 0));
    camroll(270);
    pbaspect ([0.9 0.7 1]);
    set(gca,'XTick', [0:fix(filas/20):filas]);
    set(gca, 'YTickLabel', []);
    set(gca, 'YTick', [-escalaV:escalaV/10:0]);
    grid on;

    escalaR = er;
    subplot(1, 2, 2);
    plot(r, 'r');
    ylim([0 escalaR]);
    xlim([1 filas]);
    xlabel('Lecturas');
    ylabel(sprintf('Resistividad \n %d                                                                     %d', 0, escalaR));
    camroll(270);
    pbaspect ([0.9 0.7 1]);
    set(gca,'XTick', [0:fix(filas/20):filas]);
    set(gca, 'YTick', [0:escalaR/10:escalaR]);
    set(gca, 'YTickLabel', [])
    grid on;
    
  
end
