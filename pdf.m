function pdf(csv)
    dataset = load(csv);
    [filas, columnas] = size(dataset);
    v = dataset(1:filas);
    r = dataset(filas+1:end);
    figure('Toolbar', 'none', 'Menubar', 'none', 'Name', 'Gráficas', 'Tag', 'plotsFigure');
    
    subplot(1, 2, 1); %(x, y, position in grid)
    plot(v);
    ylim([0 10]);
    xlim([1 filas]);
    xlabel('Lecturas');
    ylabel('Potencial Natural');
    camroll(270);
    pbaspect ([2 0.7 1]);
    set(gca,'XTick',[1:10:filas], 'YTick', []);

    subplot(1, 2, 2);
    plot(r, 'r');
    ylim([-20 0]);
    xlim([1 filas]);
    xlabel('Lecturas');
    ylabel('Resistividad');
    camroll(270);
    pbaspect ([2 0.7 1]);
    set(gca,'XTick',[1:10:filas], 'YTick', []);
    
  [file, path] = uiputfile('*.pdf', 'Guardar gráficas como...');
  
  if(~file)
    warndlg('introduzca un nombre de archivo')
    return;
  else
    print(findobj('Tag', 'plotsFigure'), strcat(path, file), '-dpdf');
    %print requiere como primer argumento un nombre para el archivo, por eso
    %se manda primero la ruta seleccionada previamente concatenada al nombre
    %del archivo elegido, estos comandos se pueden probar en consola para tener
    %un mejor entendimiento se sus salidas
  end
end
