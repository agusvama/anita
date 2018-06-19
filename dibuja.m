function dibuja(v, r, p)
    
    subplot(1, 2, 1); %(x, y, position in grid)
    plot(p, v);
    ylim([-1 5]);
    xlabel('Profundidad');
    ylabel('Potencial Natural');
    camroll(270);
    pbaspect ([2 0.7 1]);

    subplot(1, 2, 2);
    plot(p, r, 'r');
    ylim([-1 5]);
    xlabel('Profundidad');
    ylabel('Resistividad');
    camroll(270);
    pbaspect ([2 0.7 1]);

end

