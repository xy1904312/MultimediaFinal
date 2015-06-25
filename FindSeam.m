function [vector] = FindSeam(I, num)
 
%   Detailed explanation goes here
%calculating image gradient as an energy image
[rmax, cmax, tmp] = size(I);
ImgOut = I;
img = double(I)/255;
img = rgb2gray(img);
vector = zeros(rmax, num);
[Ix,Iy]=gradient(img);
Gimg=Ix+Iy;
Gimg=abs(Gimg);

	%calculating sum of pixels value in each column
	test2=zeros(rmax,cmax);
	for row = 1 :rmax
		for col = 1:cmax
			if row == 1
				test2(row,col)=Gimg(row,col);
			end
			if row>1
				if col ==1
					tmp=[test2(row-1,col),test2(row-1,col+1)];
					test2(row,col)= Gimg(row,col)+min(tmp);
				end
				if col>1 && col<cmax
					tmp1=[test2(row-1,col),test2(row-1,col+1),test2(row-1,col-1)];
					test2(row,col)= Gimg(row,col)+min(tmp1);
				end
				if col == cmax
					tmp2=[test2(row-1,col),test2(row-1,col-1)];
					test2(row,col)= Gimg(row,col)+min(tmp2);
				end
			end
		end
	end
for h=1:num
	minval=min(test2(rmax,:));
	locations=find(test2(rmax,:)==minval);
	[x,y]=size(locations);
	%back traking to find the seam
		for loc=1:y
		j = locations(1,loc);
		for row=rmax:-1:2
			if row==rmax
			    ImgOut(row,j,1)=255;
			    ImgOut(row,j,2)=0;
			    ImgOut(row,j,3)=0;
				test2(row,j) = realmax;
				vector(row, h) = j;
			end
			%if row < rmax
				if j==1
					j2 = j+1;
					while test2(row-1,j+1)==realmax && j2<cmax
						j2=j2+1;
					end
					tmp=[test2(row-1,j),test2(row-1,j2)];
					[C,index]=min(tmp);
					if index==1
			            ImgOut(row-1,j,1)=255;
			            ImgOut(row-1,j,2)=0;
			            ImgOut(row-1,j,3)=0;
						test2(row-1,j) = realmax;
						vector(row-1, h) = j;
					end
					if index==2
			            ImgOut(row-1,j+1,1)=255;
			            ImgOut(row-1,j+1,2)=0;
			            ImgOut(row-1,j+1,3)=0;
						j=j2;
						vector(row-1, h) = j;
						test2(row-1,j) = realmax;
					end
				end
				if j>1 && j<cmax
					j1 = j-1;
					j2 = j+1;
					while test2(row-1,j1) == realmax && j1>1
						j1 = j1-1;
					end
					while test2(row-1,j+1)==realmax && j2<cmax
						j2=j2+1;
					end
					tmp1=[test2(row-1,j),test2(row-1,j2),test2(row-1,j1)];
					[C,index]=min(tmp1);
					if index==1
			            ImgOut(row-1,j,1)=255;
			            ImgOut(row-1,j,2)=0;
			            ImgOut(row-1,j,3)=0;
						test2(row-1,j) = realmax;
						vector(row-1, h) = j;
					end
					if index==2
			            ImgOut(row-1,j+1,1)=255;
			            ImgOut(row-1,j+1,2)=0;
			            ImgOut(row-1,j+1,3)=0;
						j=j2;
						vector(row-1, h) = j;
						test2(row-1,j) = realmax;
					end
					if index==3
			            ImgOut(row-1,j-1,1)=255;
			            ImgOut(row-1,j-1,2)=0;
			            ImgOut(row-1,j-1,3)=0;
						j=j1;
						vector(row-1, h) = j;
						test2(row-1,j) = realmax;
					end
				end
				if j == cmax
					j1 = j-1;
					while test2(row-1,j1) == realmax && j1>1
						j1 = j1-1;
					end
					tmp2=[test2(row-1,j),test2(row-1,j1)];
					[C,index]=min(tmp2);
					if index==1
			            ImgOut(row-1,j,1)=255;
			            ImgOut(row-1,j,2)=0;
			            ImgOut(row-1,j,3)=0;
						vector(row-1, h) = j;
						test2(row-1,j) = realmax;
					end
					if index==2
			            ImgOut(row-1,j-1,1)=255;
			            ImgOut(row-1,j-1,2)=0;
			            ImgOut(row-1,j-1,3)=0;
						j=j1;
						vector(row-1, h) = j;
						test2(row-1,j) = realmax;
					end
				end
			%end
		end
	end
end
%imshow(ImgOut);
%imshow(I);
%imwrite(ImgOut, 'b.png');
end