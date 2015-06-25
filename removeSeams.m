function removeSeams(img, num)
	for i=1:num
		vec = FindSeam(img);
		img = DeleteSeam(vec, img);
	end
	imwrite(img, 'remove.png');
end