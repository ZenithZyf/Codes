% Create a logical image of an ellipse with specified
% semi-major and semi-minor axes, center, and image size.
% First create the image.
imageSizeX = 640;
imageSizeY = 480;
[columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the ellipse in the image.
centerX = 320;
centerY = 240;
radiusX = 250;
radiusY = 150;
ellipsePixels = (rowsInImage - centerY).^2 ./ radiusY^2 ...
    + (columnsInImage - centerX).^2 ./ radiusX^2 <= 1;
% ellipsePixels is a 2D "logical" array.
% Now, display it.
image(ellipsePixels) ;
colormap([0 0 0; 1 1 1]);
title('Binary image of a ellipse', 'FontSize', 20);

%%
figure;
% clearvars;
format longg;
format compact;
fontSize = 20;
% Parameterize the equation.
t = linspace(0, 360,1000);
phaseShift = ellipseFit.phi * 2 * pi;
xCenter = ellipseFit.X0_in; yCenter = ellipseFit.Y0_in;
xAmplitude = 0.5 * ellipseFit.long_axis;
yAmplitude = 0.5 * ellipseFit.short_axis;
x = xCenter + xAmplitude * sind(t + phaseShift);
y = yCenter + yAmplitude * cosd(t);
% Now plot the rotated ellipse.
plot(x, y, 'b-', 'LineWidth', 2);
% axis equal
% grid on;
% xlabel('X', 'FontSize', fontSize);
% ylabel('Y', 'FontSize', fontSize);
% title('Rotated Ellipses', 'FontSize', fontSize);
% text(-1.75, 1.4, 'Parametric --', 'Color', 'b', 'FontSize', fontSize);
% Now plot another ellipse and multiply it by a rotation matrix.
% https://en.wikipedia.org/wiki/Rotation_matrix
% rotationAngle = 30;
% transformMatrix = [cosd(rotationAngle), sind(rotationAngle);...
% 	-sind(rotationAngle), cosd(rotationAngle)]
% xAligned = xAmplitude * sind(t);
% yAligned = yAmplitude * cosd(t);
% xyAligned = [xAligned; yAligned]';
% xyRotated = xyAligned * transformMatrix;
% xRotated = xyRotated(:, 1);
% yRotated = xyRotated(:, 2);
% hold on;
% plot(xRotated, yRotated, 'g-', 'LineWidth', 2);
% % Plot a line at 30 degrees
% slope = tand(30);
% x1 = min(x(:));
% y1 = slope * x1;
% x2 = max(x(:));
% y2 = slope * x2;
% line([x1 x2], [y1 y2], 'Color', 'r');
% text(-1.75, 1.25, 'Rotation Matrix --', 'Color', 'g', 'FontSize', fontSize);
% text(-1.75, 1.1, '30 Degree Line --', 'Color', 'r', 'FontSize', fontSize);
% % Enlarge figure to full screen.
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);