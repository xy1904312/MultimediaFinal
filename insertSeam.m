function insertSeam(img, num, obj, Gimg)
	%insert num of seams to img
	%if obj is true
	% the energymap will be Gimg
	% otherwise calculate the energy map
	
	img2 = img;
	[rmax, cmax, t] = size(img);
	vec = zeros(rmax, num);
	add = zeros(rmax, num);
	% find num seams
	if not(obj)
		for i=1:num
			%delete seams
			Gimg = getEnergy(img2);
			tmp = FindSeam(img2, Gimg);
			img2 = DeleteSeam(tmp, img2);
			
			% align vector
		
			vec(:,i) = tmp;
			for y=1:rmax
				c = 0;
				for x=1:i-1
					if vec(y,x)<=vec(y,i)
						c = c+1;
					end
				end
				add(y,i) = c;
			end
		end
	else
		
		for i=1:num
			%delete seams
			tmp = FindSeam(img2, Gimg);
			img2 = DeleteSeam(tmp, img2);
			Gimg = DeleteSeam(tmp, Gimg);
			
			% align vector
		
			vec(:,i) = tmp;
			for y=1:rmax
				c = 0;
				for x=1:i-1
					if vec(y,x)<=vec(y,i)
						c = c+1;
					end
				end
				add(y,i) = c;
			end
		end
	end
	for i=1:num
		for y=1:rmax
			vec(y,i) = vec(y,i)+add(y,i);
		end
	end
	
	% insert seams
	for i=1:num
		for row=1:rmax
			
			[col, index] = max(vec(row, :));
			if col<cmax
				img(row, col+2:cmax+1,:) = img(row, col+1:cmax,:);
			end
			if col>1 && col < cmax
				img(row, col+1,1) = sum([img(row, col-1,1), img(row, col,1), img(row, col+1,1)]) / 3;
				img(row, col+1,2) = sum([img(row, col-1,2), img(row, col,2), img(row, col+1,2)]) / 3;
				img(row, col+1,3) = sum([img(row, col-1,3), img(row, col,3), img(row, col+1,3)]) / 3;
			elseif col ==1
				img(row, col+1,1) = sum([img(row, col,1), img(row, col+1,1)]) / 2;
				img(row, col+1,2) = sum([img(row, col,2), img(row, col+1,2)]) / 2;
				img(row, col+1,3) = sum([img(row, col,3), img(row, col+1,3)]) / 2;
			else
				img(row, col+1,1) = sum([img(row, col-1,1), img(row, col,1)]) / 2;
				img(row, col+1,2) = sum([img(row, col-1,2), img(row, col,2)]) / 2;
				img(row, col+1,3) = sum([img(row, col-1,3), img(row, col,3)]) / 2;
			end
			
			vec(row, index) = realmin;
			
		end
		cmax = cmax + 1;
	end
	imwrite(img, 'insert.png');
end
