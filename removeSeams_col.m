function removeSeams(img, num, obj, Gimg)
	%remove num of seams in img
	%if obj is true
	% the energymap will be Gimg
	% otherwise calculate the energy map
   
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
