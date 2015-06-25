function insertSeam(img, num)
	img2 = img;
	[rmax, cmax, t] = size(img);
	vec = zeros(rmax, num);
	% find num seams
	for i=1:num
		%delete seams
		tmp = FindSeam(img2, 1);
		img2 = DeleteSeam(tmp, img2);
		
		% align vector
		
		vec(:,num) = tmp;
	end
	% insert seams
	for i=1:num
		for row=1:rmax
			col = vec(row, i);
			img(row, col+2:cmax+1,:) = img(row, col+1:cmax,:);
			img(row, col+1,1) = sum([img(row, col-1,1), img(row, col,1), img(row, col+1,1)]) / 3;
			img(row, col+1,2) = sum([img(row, col-1,2), img(row, col,2), img(row, col+1,2)]) / 3;
			img(row, col+1,3) = sum([img(row, col-1,3), img(row, col,3), img(row, col+1,3)]) / 3;
		end
	end
	imwrite(img, 'insert.png');
end
