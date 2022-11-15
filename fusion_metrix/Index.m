imagesets = cell(1,3);
num = length(imagesets);
for k = 1:num
[filename, pathname] = uigetfile('lytro-01-A.jpg', 'D:/Code/image_GAN/our_fusion_CRF'); %ѡ��ͼƬ�ļ�
pathfile=fullfile(pathname, filename);  %���ͼƬ·��
IR=rgb2gray(double(imread(pathfile)));     %��ͼƬ�������
pathname = strcat(pathname,'*.*');
[filename, pathname1] = uigetfile('lytro-01-B.jpg', 'D:/Code/image_GAN/our_fusion_CRF'); %ѡ��ͼƬ�ļ�
pathfile=fullfile(pathname1, filename);  %���ͼƬ·��
Vis=rgb2gray(double(imread(pathfile)));    %��ͼƬ�������
pathname = strcat(pathname,'*.*');
[filename, pathname2] = uigetfile('1.jpg', 'D:/Code/image_GAN/our_fusion_CRF'); %ѡ��ͼƬ�ļ�
pathfile=fullfile(pathname2, filename);  %���ͼƬ·��
Z=rgb2gray(double(imread(pathfile)));    %��ͼƬ�������
imagesets{k,1} = IR;
imagesets{k,2} = Vis;
imagesets{k,3} = Z;

% imagesets{1} = double(IR);
% imagesets{2} = double(Vis);
% imagesets{3} = double(Z);

addpath(genpath(strcat(pwd,'\','fusion_metrix')));

metri_name = {'qabf'};
len_metri_name = length(metri_name);
j=k;
for ii=1:len_metri_name
     metri(j,ii) = fusion_metrix(imagesets{k,1},imagesets{k,2},imagesets{k,3},metri_name{ii});
%     metri(j,ii) = fusion_metrix(imagesets{1},imagesets{2},uint8(imagesets{3}),metri_name{ii});
%      imshow(metri(j,ii))
      fprintf('a=%f',metri(j,ii))
end
T{k}=array2table(metri,'VariableNames',metri_name);  %ת��Ϊ��
rmpath(genpath(strcat(pwd,'\','fusion_metrix')));
end