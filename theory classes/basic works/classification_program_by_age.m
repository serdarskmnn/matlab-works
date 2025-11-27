age = input('enter your age: ');
    if age >= 0 && age <= 12
        disp('kid');
    elseif age >= 13 && age <= 19
        disp('young');
    elseif age >= 20 && age <= 64
        disp('adult');
    elseif age >= 65 && age <= 120
        disp('old');
    elseif age > 120
        disp('rip');
    else
        disp('invalid age');
    end
