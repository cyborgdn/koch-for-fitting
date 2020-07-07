function xlprepare(plotting_barc)

X_points = plotting_barc(:,1);
Y_points = plotting_barc(:,2);

filename = 'datapoints.xlsx';
T = table(X_points, Y_points);

writetable(T,filename,'sheet',1,'Range','D1');

end