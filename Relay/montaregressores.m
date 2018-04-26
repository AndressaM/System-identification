function [a,b] = montaregressores(num,den)
gs = tf(num,den);
gz = c2d(gs,0.1);
a = gz.numerator{1,1};
b = gz.denominator{1,1};
end
