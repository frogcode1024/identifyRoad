function [gray_image, data] = process(path, accuracy)
close all;
%% 加载原始图像
rgb = imread(path);
gray_image = rgb2gray(rgb);
%% 处理弯路，弯路填白（根据绿色道路的rgb值）
[m,n,z]=size(rgb);

for i=1:m
    for j=1:n
        if rgb(i,j,1)>-1 && rgb(i,j,1)<15 && rgb(i,j,2)>180 && rgb(i,j,2)<200 && rgb(i,j,3)>40 && rgb(i,j,3)<60 
            gray_image(i,j)=255;           
        else
            gray_image(i,j)=gray_image(i,j)/2;
        end
    end
end

%% 统计白色道路可以停多少个车位点，每隔 accuracy 一个
count = 0;
data = [];
for i=1:accuracy:m
    for j=1:accuracy:n
        if rgb(i,j,1)>-1 && rgb(i,j,1)<15 && rgb(i,j,2)>180 && rgb(i,j,2)<200 && rgb(i,j,3)>40 && rgb(i,j,3)<60 
            data = [data; i j];
            count = count + 1;
        end
    end
end

fprintf('%s %d %s %d\n','在每隔 ',accuracy,' 像素一个车位的情况下，道路总共车位：',count);

end

