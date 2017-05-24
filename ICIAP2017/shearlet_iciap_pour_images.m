
[VID1, CVID1] = load_video_to_mat('SCENE1_0.avi',1600, 1040,1070);
[VID2, CVID2] = load_video_to_mat('SCENE1_1.avi',1600, 1040,1070);
[VID3, CVID3] = load_video_to_mat('SCENE1_2.avi',1600, 1040,1070);

%%

t = 9;

figure;
subplot(1,3,1);
imshow(CVID1(:,:,:,t)./255);
% imshow(VID1(:,:,t),[]);
subplot(1,3,2);
imshow(CVID2(:,:,:,t)./255);
% imshow(VID2(:,:,t),[]);
subplot(1,3,3);
imshow(CVID3(:,:,:,t)./255);
% imshow(VID3(:,:,t),[]);

%%

imwrite(CVID1(:,:,:,t)./255, 'D:\Dropbox\ICIAP2017\images\cam0.png');
imwrite(CVID2(:,:,:,t)./255, 'D:\Dropbox\ICIAP2017\images\camC.png');
imwrite(CVID3(:,:,:,t)./255, 'D:\Dropbox\ICIAP2017\images\camA.png');


