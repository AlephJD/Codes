function anm = anom_var(var,p)

% anom_var                           anomalias de una variable
%=============================================================
%
% USO:
%  anm = anom_var(var,p)
%
%
% DESCRIPCION:
%  Calcula las anomalias de cualquier variable, realizando la resta del 
%  valor observado de la variable con el promedio de esta.
%
% ENTRADA:
%  var = variable (e.g. salinidad, temperatura, densidad,...)
%  p   = variable independiente (sobre la que depende 'var')
%
%  'var' debe tener dimensiones MxN, y 'p' debe tener Mx1, 1xN o MxN 
%  dimensiones.
%
% SALIDA:
%  anm = anomalia de una variable
%
%  La anomalia es una matriz de dimension MxN.
%
% AUTOR:
%  Aleph Jimenez                                          [aleph@cicese.mx]
%
% NUMERO DE VERSION: Beta 1.0 (15 Diciembre, 2011)
%
% REFERENCIAS:
%  The Mathworks, Inc.
%
%==========================================================================

xprom = nanmean(var,2); 

x = var; 

for z = 1:length(p)
    anm(z,:) = x(z,:) - xprom(z);
end
