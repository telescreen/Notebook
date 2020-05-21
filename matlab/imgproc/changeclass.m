function g = changeclass(newclass, f)
% changeclass: convert image f to the class specified in parameter newclass
% newclasss: 'uint8', 'uint16', 'double'
% f: input image
narginchk(2,2)
switch newclass
    case 'uint8'
        g = im2uint8(f);
    case 'uint16'
        g = im2uint16(f);
    case 'double'
        g = im2double(f);
    otherwise
        warning('newclass must be one of uint8, uint16, double');
end
end