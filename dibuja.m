function dibuja(archivo)
    dataset = load(archivo);
    
    [filas, columnas] = size(dataset);
    v = dataset(1:filas);
    r = dataset(filas+1:end);

    subplot(2, 1, 1); %(x, y, position in grid)
    plot(v);
    ylim([2 8]);
    xlim([0 filas]);
    xlabel('Lecturas');
    ylabel('Potencial Natural');
    %camroll(270);
    pbaspect ([4 1 1]);

    subplot(2, 1, 2);
    plot(r, 'r');
    ylim([2 16]);
    xlim([0 filas]);
    xlabel('Lecturas');
    ylabel('Resistividad');
    %camroll(270);
    pbaspect ([4 1 1]);

end

