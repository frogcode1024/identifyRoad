function [gray_image, data] = process(path, accuracy)
close all;
%% ����ԭʼͼ��
rgb = imread(path);
gray_image = rgb2gray(rgb);
%% ������·����·��ף�������ɫ��·��rgbֵ��
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

%% ͳ�ư�ɫ��·����ͣ���ٸ���λ�㣬ÿ�� accuracy һ��
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

fprintf('%s %d %s %d\n','��ÿ�� ',accuracy,' ����һ����λ������£���·�ܹ���λ��',count);

end

