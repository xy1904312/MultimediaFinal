function Gimg = getEnergy(I)
	%calculate the energy of I
	img = double(I)/255;
	img = rgb2gray(img);
	[Ix,Iy]=gradient(img);
	img=Ix+Iy;
	Gimg=abs(img);
end