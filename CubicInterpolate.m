function [output] = CubicInterpolate(v0, v1, v2, v3, coef )
    A = (v3-v2)-(v0-v1);
    B = (v0-v1)-A;
    C = v2-v0;
    D = v1;
    output =  D + coef * (C + coef * (B + coef * A));
end