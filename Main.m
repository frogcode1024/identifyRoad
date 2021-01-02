%     input1:   pic_path   地图图片路径
%     input2:	car_num    道路上投放的汽车数量
%     input3:	accuracy   精度，每隔几个像素点放一辆车
%     output1:  out_path   输出的处理后地图

%% ---需要改变的输入参数---
clc;
clear all;
pic_path = 'roadPic.png'; 
out_path = ['output_', pic_path];
car_num = 200;
accuracy = 2;
%% main
% 620像素，16.41厘米
[gray_image, all_car] = process(pic_path, accuracy);
random_rank = randperm(length(all_car));
try
    select_car = random_rank(1:car_num);
    % 保存处理后的图像
    fig1 = figure(1);
    imshow(gray_image);
    [m,n] = size(gray_image);
    result = [];
    fprintf('选取的车的经纬度如下：\n');
    x_min = 99999999;
    y_min = 99999999;
    for i=1:car_num
        hold on;
        x = all_car(select_car(i),1);
        y = all_car(select_car(i),2);
        if y<y_min
            y_min = y;
            x_min = x;
        end
        car_zong = 250*(m-x)/(620/16.41); % 纵坐标（米）
        car_heng = 250*y/(620/16.41);     % 横坐标（米）
        
        fprintf('%s %s \n',num2str(car_heng),num2str(car_zong));
        plot(y,x,'r.')%将点在其中标记出来 
    end
    car_zong_min = 250*(m-x_min)/(620/16.41);
    car_heng_min = 250*y_min/(620/16.41);
    hold on;
    %plot(y_min,x_min,'go')%将点在其中标记出来
    str=sprintf('%s\n%s %s\n%s %s','Source','X:',num2str(car_heng_min'),'Y:',num2str(car_zong_min'));
    text(x_min,y_min+20,str, 'backgroundcolor', [.1 .1 .1],'color','g','FontSize',10)
    
    saveas(fig1,out_path);
    %imwrite(gray_image,['after_', path]);
catch
    fprintf('%s %d','car_num的值过大已经超出所有可选的车位点数量,需小于：',length(all_car));
end    
