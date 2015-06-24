function [vector] = FindSeam(I)
 
%   Detailed explanation goes here
%calculating image gradient as an energy image
[rmax, cmax, tmp] = size(I);
ImgOut = I;
img = double(I)/255;
img = rgb2gray(img);
vector = zeros(rmax, 1);
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
minval=min(test2(rmax,:));
locations=find(test2(rmax,:)==minval);
[x,y]=size(locations);
%back traking to find the seam
	for loc=1:y
	j = locations(1,loc);
	for row=rmax:-1:2
		if row==rmax
		%    ImgOut(row,j,1)=255;
		%    ImgOut(row,j,2)=0;
		%    ImgOut(row,j,3)=0;
			ImgOut(row,j:cmax-1,:) = ImgOut(row,j+1:cmax,:);
			vector(row) = j;
		end
		%if row < rmax
			if j==1
				tmp=[test2(row-1,j),test2(row-1,j+1)];
				[C,index]=min(tmp);
				if index==1
		%            ImgOut(row-1,j,1)=255;
		%            ImgOut(row-1,j,2)=0;
		%            ImgOut(row-1,j,3)=0;
					ImgOut(row-1,j:cmax-1,:)=ImgOut(row-1,j+1:cmax,:);
					vector(row-1) = j;
				end
				if index==2
		%            ImgOut(row-1,j+1,1)=255;
		%            ImgOut(row-1,j+1,2)=0;
		%            ImgOut(row-1,j+1,3)=0;
					ImgOut(row-1,j+1:cmax-1,:)=ImgOut(row-1,j+2:cmax,:);
					j=j+1;
					vector(row-1) = j;
				end
			end
			if j>1 && j<cmax
				tmp1=[test2(row-1,j),test2(row-1,j+1),test2(row-1,j-1)];
				[C,index]=min(tmp1);
				if index==1
		%            ImgOut(row-1,j,1)=255;
		%            ImgOut(row-1,j,2)=0;
		%            ImgOut(row-1,j,3)=0;
					ImgOut(row-1,j:cmax-1,:)=ImgOut(row-1,j+1:cmax,:);
					vector(row-1) = j;
				end
				if index==2
		%            ImgOut(row-1,j+1,1)=255;
		%            ImgOut(row-1,j+1,2)=0;
		%            ImgOut(row-1,j+1,3)=0;
					ImgOut(row-1,j+1:cmax-1,:)=ImgOut(row-1,j+2:cmax,:);
					j=j+1;
					vector(row-1) = j;
				end
				if index==3
		%            ImgOut(row-1,j-1,1)=255;
		%            ImgOut(row-1,j-1,2)=0;
		%            ImgOut(row-1,j-1,3)=0;
					ImgOut(row-1,j-1:cmax-1,:)=ImgOut(row-1,j:cmax,:);
					j=j-1;
					vector(row-1) = j;
				end
			end
			if j == cmax
				tmp2=[test2(row-1,j),test2(row-1,j-1)];
				[C,index]=min(tmp2);
				if index==1
		%            ImgOut(row-1,j,1)=255;
		%            ImgOut(row-1,j,2)=0;
		%            ImgOut(row-1,j,3)=0;
					ImgOut(row-1,j:cmax-1,:)=ImgOut(row-1,j+1:cmax,:);
					vector(row-1) = j;
				end
				if index==2
		%            ImgOut(row-1,j-1,1)=255;
		%            ImgOut(row-1,j-1,2)=0;
		%            ImgOut(row-1,j-1,3)=0;
					ImgOut(row-1,j-1:cmax-1,:)=ImgOut(row-1,j:cmax,:);
					j=j-1;
					vector(row-1) = j;
				end
			end
		%end
	end
end
for k=1:rmax
	img = double(ImgOut)/255;
	img = rgb2gray(img);
end
cmax=cmax-1;
end
%imshow(I);
