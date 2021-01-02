%     input1:   pic_path   ��ͼͼƬ·��
%     input2:	car_num    ��·��Ͷ�ŵ���������
%     input3:	accuracy   ���ȣ�ÿ���������ص��һ����
%     output1:  out_path   ����Ĵ�����ͼ

%% ---��Ҫ�ı���������---
clc;
clear all;
pic_path = 'roadPic.png'; 
out_path = ['output_', pic_path];
car_num = 200;
accuracy = 2;
%% main
% 620���أ�16.41����
[gray_image, all_car] = process(pic_path, accuracy);
random_rank = randperm(length(all_car));
try
    select_car = random_rank(1:car_num);
    % ���洦����ͼ��
    fig1 = figure(1);
    imshow(gray_image);
    [m,n] = size(gray_image);
    result = [];
    fprintf('ѡȡ�ĳ��ľ�γ�����£�\n');
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
        car_zong = 250*(m-x)/(620/16.41); % �����꣨�ף�
        car_heng = 250*y/(620/16.41);     % �����꣨�ף�
        
        fprintf('%s %s \n',num2str(car_heng),num2str(car_zong));
        plot(y,x,'r.')%���������б�ǳ��� 
    end
    car_zong_min = 250*(m-x_min)/(620/16.41);
    car_heng_min = 250*y_min/(620/16.41);
    hold on;
    %plot(y_min,x_min,'go')%���������б�ǳ���
    str=sprintf('%s\n%s %s\n%s %s','Source','X:',num2str(car_heng_min'),'Y:',num2str(car_zong_min'));
    text(x_min,y_min+20,str, 'backgroundcolor', [.1 .1 .1],'color','g','FontSize',10)
    
    saveas(fig1,out_path);
    %imwrite(gray_image,['after_', path]);
catch
    fprintf('%s %d','car_num��ֵ�����Ѿ��������п�ѡ�ĳ�λ������,��С�ڣ�',length(all_car));
end    
