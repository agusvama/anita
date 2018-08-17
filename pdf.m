function pdf(csv, handles)
    dataset = load(csv);
    [filas, columnas] = size(dataset);
    v = dataset(1:filas);
    r = dataset(filas+1:end);
    
    subplot(1, 2, 1);
    plot(v);
    ylim([0 10]);
    xlim([1 filas]);
    xlabel('Lecturas');
    ylabel('Potencial Natural');
    camroll(270);
    pbaspect ([0.9 0.7 1]);
    set(gca, 'YTick', []);

    subplot(1, 2, 2);
    plot(r, 'r');
    ylim([-20 0]);
    xlim([1 filas]);
    xlabel('Lecturas');
    ylabel('Resistividad');
    camroll(270);
    pbaspect ([0.9 0.7 1]);
    set(gca, 'YTick', []);
    
  
end
