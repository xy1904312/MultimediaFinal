function removeSeams(img, num)
	for i=1:num
		Gimg = getEnergy(img);
		vec = FindSeam(img, Gimg);
		img = DeleteSeam(vec, img);
	end
	imwrite(img, 'remove.png');
end