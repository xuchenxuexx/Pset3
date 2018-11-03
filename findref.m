function [xr1,yr1,xr2,yr2] = findref(x,y,theta)
    Wx = 750;
    Wy = 500;
    theta2 = theta+pi/2;
    if (theta2>2*pi)
        theta2 = theta2-2*pi;
    end
    angle1 = atan(x/(Wy-y));
    angle2 = atan((Wx-x)/(Wy-y));
    angle3 = atan((Wx-x)/y);
    angle4 = atan(x/y);
    k1 = tan(theta);
    k2 = tan(theta2);

    if (((theta>=0)&&(theta<=angle2))||((theta>=(2*pi-angle1)&&theta<=2*pi)))
        yr1 = Wy;
		xr1 = (yr1-y)/k1+x;
    elseif ((theta>=(pi/2-angle2))&&(theta<=(pi-angle3)))
		xr1 = Wx;
        yr1 = k1*(xr1-x)+y;
    elseif ((theta>=(pi-angle3))&&(theta<=(pi+angle4)))
        yr1 = 0;
        xr1 = (yr1-y)/k1+x;
    else
        xr1 = 0;
        yr1 = k1*(xr1-x)+y;
    end
    
    if (((theta2>=0)&&(theta2<=angle2))||((theta2>=(2*pi-angle1)&&theta2<=2*pi)))
        yr2 = Wy;
		xr2 = (yr2-y)/k2+x;
    elseif ((theta2>=(pi/2-angle2))&&(theta2<=(pi-angle3)))
		xr2 = Wx;
        yr2 = k2*(xr2-x)+y;
    elseif ((theta2>=(pi-angle3))&&(theta2<=(pi+angle4)))
        yr2 = 0;
        xr2 = (yr2-y)/k2+x;
    else
        xr2 = 0;
        yr2 = k2*(xr2-x)+y;
    end
