encoder=readtable('C:\Mojtaba\JHU\Snake_Calibration\snake_position_code_microscope_filtering\Encoder_Counts.xlsx');
Encoder=encoder.Var1; 
Encoder_size=1:length(Encoder);
Pictures_size=1:length(matfiles);
Encoder_counts = interp1(Encoder_size,Encoder,Pictures_size);