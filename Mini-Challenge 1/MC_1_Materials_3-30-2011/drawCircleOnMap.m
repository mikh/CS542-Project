function [map] = drawCircleOnMap(map, xx, yy, radius, color)
	[map_X, map_Y] = size(map);
	for ii = (xx - radius):(xx+radius)
		for jj = (yy-radius):(yy+radius)
			if ~(ii == xx && jj == yy) && ii > 0 && ii <= map_X && jj > 0 && jj <= map_Y
				%get distance
				dist = abs(ii - xx) + abs(jj - yy);
				if dist <= radius
					map(ii,jj) = color;
				end
			end
		end
    end
    map(xx,yy) = color;
end