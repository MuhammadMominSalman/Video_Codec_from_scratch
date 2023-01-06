% plots myfun(x,c) for x in [0..1] and c = 2

clf; % clears figure
x = 0:0.01:1;
c = 2;
plot(x,c) % adjust this line!
title(['myfun(x,c); c=' num2str(c)]);
xlabel('x');
ylabel('myfun(x)');


