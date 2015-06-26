function removeObject(img)
	%remove the object specify by user
	%STILL SOME BUG!
	[Gimg, M] = identifyObject(img, false);
	[loc1, loc2] = find(Gimg()==M);
	[rmax, cmax, ~] = size(img);
	count = zeros(rmax, 1);
	for row=1:rmax
		count(row) = sum(loc1==row);
	end
	num = max(count)
	removeSeams(img, num, true, Gimg);
end	