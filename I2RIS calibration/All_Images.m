clc
clear

%% import image files of the snake in varius bending angles (from microscope) 
matfiles = dir(fullfile('C:\Mojtaba\JHU\Snake_Calibration\Test_8cycles\*.JPG'));
number_of_images= length(matfiles); 


%%%% import Maxon Motor encouder counts and equalize the size of it with the number of images  

encoder=readtable('C:\Mojtaba\JHU\Snake_Calibration\snake_position_code_microscope_filtering\Encoder_Counts.xlsx');
Encoder=encoder.Var1; 
Encoder_size=1:length(Encoder);
Pictures_size=1:length(matfiles);
Encoder_counts = interp1(Encoder_size,Encoder,Pictures_size);
Encoder_counts= Encoder_counts *100; 

%%% very important::: Encoder_counts is the input of the system 


X_tip_OpticalFiber_all=[];
Y_tip_OpticalFiber_all=[];
Gama_angle_OpticalFiber_all=[];


wb=waitbar(0,'please wait');
for i=1:1:number_of_images

rgb=imread(append(matfiles(i).folder,'\',matfiles(i).name));

[X_tip_OpticalFiber,Y_tip_OpticalFiber,Gama_angle_OpticalFiber]=PositionOrientation(rgb);

X_tip_OpticalFiber_all(i)=X_tip_OpticalFiber;
Y_tip_OpticalFiber_all(i)=Y_tip_OpticalFiber;
Gama_angle_OpticalFiber_all(i)=Gama_angle_OpticalFiber;


waitbar(i/number_of_images,wb);

end
%imshow(rgb);
waitbar(1,wb);
close(wb)


plot(Encoder_counts,Gama_angle_OpticalFiber_all,'.')
xlabel('encoder counts')
ylabel('bending angle')

figure
plot(Encoder_counts,X_tip_OpticalFiber_all,'.')
xlabel('encoder counts')
ylabel('X of snake (optical fiber) tip')

figure
plot(Encoder_counts,Y_tip_OpticalFiber_all,'.')
xlabel('encoder counts')
ylabel('Y of snake (optical fiber) tip')

figure
plot(X_tip_OpticalFiber_all,Y_tip_OpticalFiber_all,'.')
xlabel('X of snake (optical fiber) tip')
ylabel('Y of snake (optical fiber) tip')
title('tip footprint')



