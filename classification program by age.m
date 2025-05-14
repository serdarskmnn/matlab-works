yas = input('Yaşınızı girin: ');
    if yas >= 0 && yas <= 12
        disp('Çocuk');
    elseif yas >= 13 && yas <= 19
        disp('Genç');
    elseif yas >= 20 && yas <= 64
        disp('Yetişkin');
    elseif yas >= 65
        disp('Yaşlı');
    else
        disp('Geçersiz yaş girdiniz.');
    end

