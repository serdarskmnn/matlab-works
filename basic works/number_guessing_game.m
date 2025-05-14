target = randi([1, 100]);
guess = -1;
while guess ~= target
    guess = input('what is your forecast (1-100): ');
    if guess < target
        disp('go up');
    elseif guess > target
        disp('get down');
    else
        disp('you are incredibly intelligent');
    end
end
