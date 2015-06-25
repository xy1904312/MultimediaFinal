function img = DeleteSeam(vector, I)
	[rmax, cmax, tmp] = size(I);
	[rmax, num] = size(vector);
	for h=1:num
		for row=1:rmax
			[col, index] = max(vector(row, :));
			I(row, col:cmax-1,:) = I(row, col+1:cmax,:);
			vector(row, index) = 0;
		end
		I(:, cmax, :) = [];
		cmax = cmax-1;
	end
	img = I;
end