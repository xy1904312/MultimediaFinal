function removeSeams(img, num, obj, Gimg)
	if not(obj)
		for i=1:num
			Gimg = getEnergy(img);
			vec = FindSeam(img, Gimg);
			img = DeleteSeam(vec, img);
		end
	else
		for i=1:num
			vec = FindSeam(img, Gimg);
			img = DeleteSeam(vec, img);
			Gimg = DeleteSeam(vec, Gimg);
		end
	end
	imwrite(img, 'remove.png');
end