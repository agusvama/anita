function dibuja(archivo)
    disp('dentro de la funcion dibujar');
    dataset = load(archivo);
    disp(dataset);
    [filas, columnas] = size(dataset);
    v = dataset(1:filas);
    r = dataset(filas+1:end);
    disp('izq dtst: ');
    disp(v);
    disp('der dtst: ');
    disp(r);

    subplot(1, 2, 1); %(x, y, position in grid)
    plot(v);
    ylim([2 8]);
    xlim([0 filas]);
    xlabel('Lecturas');
    ylabel('Potencial Natural');
    camroll(270);
    pbaspect ([2 0.7 1]);

    subplot(1, 2, 2);
    plot(r, 'r');
    ylim([2 16]);
    xlim([0 filas]);
    xlabel('Lecturas');
    ylabel('Resistividad');
    camroll(270);
    pbaspect ([2 0.7 1]);

end

