function dibuja(archivo)
    dataset = load(archivo);
    [filas, columnas] = size(dataset);
    v = dataset(1:filas);
    r = dataset(filas+1:end);
    
    subplot(1, 2, 1); %(x, y, position in grid)
    plot(v);
    ylim([0 10]);
    xlim([filas-20 filas]);
    xlabel('Lecturas');
    ylabel('Potencial Natural');
    camroll(270);
    pbaspect ([2 0.7 1]);
    set(gca,'XTick',[1:10:filas], 'YTick', []);
    grid on;
    grid minor;

    subplot(1, 2, 2);
    plot(r, 'r');
    ylim([-20 0]);
    xlim([filas-20 filas]);
    xlabel('Lecturas');
    ylabel('Resistividad');
    camroll(270);
    pbaspect ([2 0.7 1]);
    set(gca,'XTick',[1:10:filas], 'YTick', []);
    grid on;
    grid minor;

end