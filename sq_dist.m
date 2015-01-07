function ret = sq_dist(x,y)
[X,Y] = meshgrid(x,y);
ret = (X-Y).^2;
end