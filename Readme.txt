use imread to read image first
e.g.
	img = imread('.png');

some examples:
1. to remove 100 seams:
	removeSeams(img, 100, false, 0);
2. to insert 100 seams:
	insertSeam(img, 100, false, 0);
3. let user specify object (where the energy will be max) and delete 100 seams
	[Gimg, ~] = identifyObject(img, true);
	removeSeams(img, 100, true, Gimg);
4. let user specify object (where the energy will be max) and insert 100 seams
	[Gimg, ~] = identifyObject(img, true);
	insertSeam(img, 100, true, Gimg);
	