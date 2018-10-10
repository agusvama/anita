function [ dateString ] = getDate( normalDate )
  s = char(normalDate);
  dateString = strcat(s(13), s(14),... %hora
                      s(15),       ...  %:
                      s(16), s(17),... %minutos
                      s(18),       ... %:
                      s(19), s(20) ... %segundos
                     );
end

