function a = apply(n,param)
%DUBLIM.APPLY Apply transfer function to inputs
% It returns 1 if input in a given interval [-0.1,0.1], 0 otherwise.
% Copyright 2012-2015 The MathWorks, Inc.


  b = double(n >= -0.1);
  c = double(n <= 0.1);
  a = double(b == c);
  a(isnan(n)) = nan;
end


