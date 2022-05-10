
function [X_opticalfiber_tip_in_SnakeBase_frame,Y_opticalfiber_tip_in_SnakeBase_frame,gama_degree]=PositionOrientation(rgb)
RGB=rgb;
%RGB = imread('C:\Users\mojta\OneDrive\Desktop\2020_0719_170200_357.JPG'); 
%RGB = imread('C:\Users\mojta\OneDrive\Desktop\2020_0719_170703_410.JPG'); 
%RGB = imread('C:\Users\mojta\OneDrive\Desktop\2020_0719_171013_441[4350].JPG');
%RGB = imread('C:\Users\mojta\OneDrive\Desktop\2020_0719_161929_066.JPG');
%RGB = imread('C:\Users\mojta\OneDrive\Desktop\2020_0719_162445_088.JPG');
 %RGB = imread('C:\Users\mojta\OneDrive\Desktop\2020_0719_164533_226.JPG');



Scale=0.91/256;  %% mm/pixel  

%%%% pixel number of the snake base 
X_sb_pixel = 1887; 
Y_sb_pixel = 2533; 


%[a_fiber,b_fiber]=createMask_OpticalFiber(RGB);
%[a_fiber,b_fiber]=createMask_OpticalFiber2(RGB);
[a_fiber,b_fiber]=createMask_OpticalFiber3(RGB);

[a_tip,b_tip]=createMask_tip(RGB);




 %[B,L] = bwboundaries(a_fiber);

 %%%% we have to copute this using centroid of the max of regioprops(a_tip) 
  fff = regionprops(a_tip); 

 Area_max  = fff(1).Area;
  index_max = 1; 
for i=1:length(fff) 

if Area_max <fff(i).Area
    Area_max = fff(i).Area; 
    index_max = i ; 
end
  end

 X_pixel_tip= fff(index_max).Centroid(1);
Y_pixel_tip=fff(index_max).Centroid(2); 

X_opticalfiber_tip_in_SnakeBase_frame=(X_pixel_tip - X_sb_pixel)*Scale;
Y_opticalfiber_tip_in_SnakeBase_frame=(-Y_pixel_tip + Y_sb_pixel)*Scale;
%%%%%%%%%%%%%%%%%%%% we have to copute this using centroid regioprops(a_fiber)


X_pixel_fiber=[];
Y_pixel_fiber=[];

[size_Y_pixel_fiber, size_X_pixel_fiber]=size(a_fiber); 

for i=1:size_Y_pixel_fiber 

    X_pixel_fiber(i)=0;
    Y_pixel_fiber(i) = i; 
    if norm (double(a_fiber(i,:))) ~=0
 %X_pixel_fiber(i)=i;
  DD=  regionprops(a_fiber(i,:)); 
DDD = DD(1,:); 
X_pixel_fiber(i) = DDD.Centroid(1); 




 %%%% another csutom filter based on the physics of the problem
 if  Y_pixel_fiber(i) > 1500 
     %Y_pixel_fiber(i) = 0; 
     X_pixel_fiber(i) = 0;
 end

    end
end
% for i= 11 : length(X_pixel_fiber)-11
%     if X_pixel_fiber(i)==0
%         %% filtering zero values with moving window filter
%         X_pixel_fiber(i) = (X_pixel_fiber(i-10)+X_pixel_fiber(i-9)+X_pixel_fiber(i-8)+X_pixel_fiber(i-7)+X_pixel_fiber(i-6)+X_pixel_fiber(i-5)+X_pixel_fiber(i-4)+X_pixel_fiber(i-3)+X_pixel_fiber(i-2)+X_pixel_fiber(i-1)+X_pixel_fiber(i)+X_pixel_fiber(i+1)+X_pixel_fiber(i+2)+X_pixel_fiber(i+3)+X_pixel_fiber(i+4)+X_pixel_fiber(i+5)+X_pixel_fiber(i+6)+X_pixel_fiber(i+7)+X_pixel_fiber(i+8)+X_pixel_fiber(i+9)+X_pixel_fiber(i+10))/21;
%     end
% end
%%% moving average window
X_pixel_fiber = movmean(X_pixel_fiber,1);


% %%%% removing the 0 values for linear curve fittiing; 900 to 1400 are
%%% good pixel locations of the Y of the optical fiber 
Lower_index= find(Y_pixel_fiber>1000 & Y_pixel_fiber<1005); 
Lower_index = Lower_index(1); 
Upper_index= find(Y_pixel_fiber>1300 & Y_pixel_fiber<1305); 
Upper_index=Upper_index(1);
X_pixel_fiber_for_CurveFitting = X_pixel_fiber(Lower_index:Upper_index);
Y_pixel_fiber_for_CurveFitting = Y_pixel_fiber(Lower_index:Upper_index);

% if Lower_index >= Upper_index
% X_pixel_fiber_for_CurveFitting = X_pixel_fiber(Upper_index:Lower_index);
% Y_pixel_fiber_for_CurveFitting = Y_pixel_fiber(Upper_index:Lower_index);
% 
% end


Pol= polyfit(X_pixel_fiber_for_CurveFitting,Y_pixel_fiber_for_CurveFitting,1);

%theta=atan(-Pol(1)); 
if atan(-Pol(1)) >0
gama=pi/2 - atan(-Pol(1));
end
if atan(-Pol(1)) <0
gama=-pi/2 - atan(-Pol(1));
end

gama_degree=gama*180/pi; 
%%%% Important Codes 
%%%[x,y,z]=regioprops(a) 


%%%%%%%%%%%%%%%%%%%%%% Ploting

% imshow(RGB)
%  impixelinfo
%  
%  
%  figure
%  imshow(a_fiber)
%  impixelinfo
% 
%  figure 
%  imshow(a_tip)
% impixelinfo 
% 
% figure 
% plot(X_pixel_fiber, Y_pixel_fiber )
% 
% figure
% plot(X_pixel_fiber_for_CurveFitting, Y_pixel_fiber_for_CurveFitting)
% hold on 
% plot(X_pixel_fiber_for_CurveFitting, Pol(1)*X_pixel_fiber_for_CurveFitting+Pol(2),'r')

%%%function ends here
end