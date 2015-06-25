function removeObject(img)
	%remove the object specify by user
	%STILL SOME BUG!
	Gimg = identifyObject(img, false);
	[loc1, loc2] = find(Gimg(:,:)==realmin);
	[rmax, cmax,~] = size(img);
	count = zeros(rmax, 1);
	for row=1:rmax
		count(row) = sum(loc1==row);
	end
	num = max(count)
	removeSeams(img, num, true, Gimg);
end	