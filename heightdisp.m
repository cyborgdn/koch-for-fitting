function heightdisp(plotting_barc)

% Matrix for the implementation of the NC code
polyform = plotting_barc;

height_z = zeros(size(polyform(:,1)));
plot_form = [];
for call=1:11
    height_z = height_z + 0.1*(call-1);
    plot_form = [plot_form; polyform(:,1), polyform(:,2), height_z];
end

figure(3);
plot3(plot_form(:,1), plot_form(:,2), plot_form(:,3), 'red');
str02 = 'This is your 3D perspective view';
title(str02);

end