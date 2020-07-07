function MillInside(flake_points)

% plot(flake_points(:,1), flake_points(:,2), 'black', 'LineWidth',5);
str = sprintf('Preparing your G-Code');
title(str);

%% Proper billet shape (optimised size)
xmin = min(flake_points(:,1));
ymin = min(flake_points(:,2));
xmax = max(flake_points(:,1));
ymax = max(flake_points(:,2));
len_billet = xmax-xmin;
wid_billet = ymax-ymin;

hold on;
proper_billet = [xmin, ymin; xmax, ymin; xmax, ymax; xmin, ymax; xmin, ymin];
plot(proper_billet(:,1), proper_billet(:,2), 'green');
X = sprintf('You would be requiring a billet shape of : (%d X %d) for making the required geomery', len_billet, wid_billet);
disp(X);

%% Buffering the size of the hole
% store_buffer = flake_points;
% for motif = 1:100
%     [px, py] = bufferm(flake_points(:,1), flake_points(:,2), 0.05*motif, 'in');
%     store_buffer = [store_buffer; px, py; NaN, NaN];
% end

%% CNC processing
tool_ID = 'T15';         % Accoding to CNC simulator pro (6mm diameter)
speed = 1100;
feed = 4;
depth_of_cut = 4;
to_be_cut = 10;
display_cut = 0;

remaining_cut = to_be_cut;

fid = fopen('GCodeMILLING.txt', 'w');

fprintf(fid, 'O12345 \r\n');

fprintf(fid, '$AddRegPart 1 30 30 \r\n');
fprintf(fid, 'G92 X 30 Y 30 Z 10 \r\n');
fprintf(fid, 'M6 T1 \r\n');
fprintf(fid, 'G00 G71 G64 G90 G94 ;\r\n');
fprintf(fid, 'M06 %.s ;\r\n', tool_ID);
fprintf(fid, 'M03 G97 S%.0f ;\r\n', speed);
fprintf(fid, 'M08 ;\r\n');
fprintf(fid, 'G00 X 0 Y 0 ;\r\n');

while remaining_cut > 0
    if remaining_cut < depth_of_cut
        depth_of_cut = remaining_cut;
    end
    fprintf(fid, 'G 91 G01 F %.2f ;\r\n', feed);
    remaining_cut = remaining_cut - depth_of_cut;
    display_cut = display_cut + depth_of_cut;
    fprintf(fid, 'G90 G01 ;\r\n');
    for i = 1:size(flake_points(:,1))-1
        if isnan(flake_points(i,1)) || i==1
            fprintf(fid, 'G90 G00 Z02 ;\r\n');
            fprintf(fid, 'G01 X %.4f Y %.4f ;\r\n', flake_points(i+1,1), flake_points(i+1,2));
        else
            fprintf(fid, 'X %.4f Y %.4f Z -%.4f ;\r\n', flake_points(i,1), flake_points(i,2), display_cut);
        end
    % ending code for the machining
    end
    cut = depth_of_cut * ones(size(flake_points(:,1)));
    hold on;
    plot3(flake_points(:,1), flake_points(:,2), cut, 'red');
    hold on;
end

fprintf(fid, 'G 28 G01 Z 2.0 ;\r\n');
fprintf(fid, 'G 28 G01 X 0.0 Y 0.0 ;\r\n');
fprintf(fid, 'M05 ;\r\n');
fprintf(fid, 'M09 ;\r\n');
fprintf(fid, 'M30 ;\r\n');

fclose(fid);

str01 = sprintf('Your G-Code is ready to use');
title(str01);
end