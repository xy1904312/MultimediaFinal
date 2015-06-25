function Gimg = identifyObject(img, max)
	%initial energy
	Gimg = getEnergy(img);
	
	%get user input
	imshow(img);
	[PointX, PointY] = ginput(200);
	PointList = [PointX PointY];
	
	%create points inside polygon
	[row, col, ~] = size(img);
	
	[imgX,imgY] = meshgrid(1:row,1:col);
	imgXY = imgX;
	imgXY(:,:,2) = imgY;
	imgPixN = row*col;
	imgXYList = reshape(imgXY, [ imgPixN, 2]);
	
	isInShape = inpolygon( imgXYList(:,1), imgXYList(:,2), PointList(:,1), PointList(:,2) );
	
	
	for pixI = 1 : imgPixN
		if isInShape(pixI)
			xCoord = imgXYList(pixI,1);
			yCoord = imgXYList(pixI,2);
			%set energy here
			if max
				Gimg(xCoord, yCoord) = realmax;
			else
				Gimg(xCoord, yCoord) = realmin;
		end
	end
end