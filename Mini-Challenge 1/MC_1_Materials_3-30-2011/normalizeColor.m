function [map] = normalizeColor(map, black)
	[r, c] = size(map);
	for ii = 1:r
		for jj = 1:c
			if map(ii,jj) > black
				map(ii,jj) = black;
		end
	end

end