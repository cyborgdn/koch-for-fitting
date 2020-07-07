function GCodeFull3Dtemp(flake_points)

str = sprintf('Preparing your G-Code');
title(str);

feed = 360;
total_height = 0.4;

fid = fopen('GCodeADDITIVE.txt', 'w');

fprintf(fid, 'O12345 \r\n');

%% Preparatory Code
fprintf(fid,'M104 S200 ;\r\n');  
fprintf(fid,'M109 S200 ;\r\n'); 
fprintf(fid,'G28 ;Home\r\n'); 
fprintf(fid,'G1 Z15.0 F6000 ;\r\n');
fprintf(fid,'G92 X 15 Y 15 Z 0 E0 ;\r\n'); 
fprintf(fid,'G1 F200 E3 ;\r\n');
fprintf(fid,'G92 E0 ;\r\n');

fprintf(fid, 'F %.2f ;\r\n', feed);
fprintf(fid, 'G90 G01 ;\r\n');
           
%% G-Code for the printing
start_width = 0.004;
start_height = 0.2;
width = 0.0002;
build_height = start_height;

while total_height >= 0
    for i = 1:size(flake_points(:,1))-1
        if isnan(flake_points(i,1))
            fprintf(fid, 'G1 X %.4f Y %.4f Z %.4f E %.9f ;\r\n', 5*flake_points(i+1,1), 5*flake_points(i+1,2), build_height, (start_width-width));
        else
            fprintf(fid, 'G1 X %.4f Y%.4f Z %.4f E %.9f F4000 ;\r\n', 5*flake_points(i,1), 5*flake_points(i,2), build_height, start_width);
        end
        start_width = start_width + width;
    end
    total_height = total_height - start_height;
    build_height = build_height + start_height;
end

%% Exit code
fprintf(fid,'M107 ;\r\n');
fprintf(fid,'M104 S0 ;\r\n');
fprintf(fid,'M140 S0 ;\r\n');
fprintf(fid,'G92 E1\r\n');
fprintf(fid,'G1 E-1 F300\r\n');
fprintf(fid,'G28 X0 Y0\r\n');
fprintf(fid,'M84\r\n');
fprintf(fid,'M104 S0\r\n');
fprintf(fid,'M30 ;\r\n');
fprintf(fid,'End of Gcode\r\n');

fclose(fid);

str01 = sprintf('Your G-Code is ready to use');
title(str01);

heightdisp(flake_points);

end