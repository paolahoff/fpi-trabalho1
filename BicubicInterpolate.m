function [output] = BicubicInterpolate(points, coefx, coefy)
    x1 = CubicInterpolate( points(1,1), points(2,1), points(3,1), points(4,1), coefx );
    x2 = CubicInterpolate( points(1,2), points(2,2), points(3,2), points(4,2), coefx );
    x3 = CubicInterpolate( points(1,3), points(2,3), points(3,3), points(4,3), coefx );
    x4 = CubicInterpolate( points(1,4), points(2,4), points(3,4), points(4,4), coefx );

    output = CubicInterpolate( x1, x2, x3, x4, coefy );
end