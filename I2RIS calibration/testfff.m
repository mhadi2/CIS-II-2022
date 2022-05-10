Area_max  = fff(1).Area;
for i=1:length(fff) 

if Area_max <fff(i).Area
    Area_max = fff(i).Area; 
    index_max = i ; 
end
  end