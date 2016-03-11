function var = masknd(var, mask, val)
%MASKND Mask multi-dimensional array with a 2D mask
%
% maskedvar = masknd(var, mask, val)
%
% This provides a shortcut to apply a 2D mask to each page/slice of a
% 3D/4D/etc array.
%
% Input variables:
%
%   var:    nd array to be masked.  First two dimensions must match the
%           size of mask; the remaining can be any size.
%
%   mask:   2D mask array.  Non-zero values indicate locations to be
%           replaced with val
%
%   val:    value to substitute into mask locations.  Can be either a
%           scalar or a nnz x 1 array, where nnz is the number of non-zero
%           values in mask.


sz = size(var);

if ~isequal(sz(1:2), size(mask))
    error('Size of mask much match first two dimensions of var');
end

var = reshape(var, sz(1), sz(2), []);

if ~islogical(mask)
    mask = logical(mask);
end

for ii = 1:size(var, 3)
    tmp = var(:,:,ii);
    tmp(mask) = val;
    var(:,:,ii) = tmp;
end

var = reshape(var, sz);


