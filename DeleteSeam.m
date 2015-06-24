function DeleteSeam(vector, I)

	[rmax, cmax, tmp] = size(I);
	for row=1:rmax
		col = vector(row);
		I(row, col:cmax-1,:) = I(row, col+1:cmax,:);
		
	end
	I(:, cmax, :) = [];
imwrite(I, 'c.png');