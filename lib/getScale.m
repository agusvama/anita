function [ escala ] = getScale( valor )
  switch valor
    case 1
      escala = 5;
    case 2
      escala = 10;
    case 3
      escala = 20;
    case 4
      escala = 50;
    case 5
      escala = 100;
  end
end

