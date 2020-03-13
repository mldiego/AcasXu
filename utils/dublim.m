function a = dublim(n,varargin)
% NNET 7.0 Compatibility
% WARNING - This functionality may be removed in future versions
if nargin > 0
    n = convertStringsToChars(n);
end

if ischar(n)
  a = nnet7.transfer_fcn(mfilename,n,varargin{:});
  return
end

% Apply
a = dublim.apply(n);
