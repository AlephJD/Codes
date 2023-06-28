function sb = stats_basic(var)

% stats_basic          estadistica basica de una variable
%=============================================================
%
% USO:
%  sb = stats_basic(var)
%
% DESCRIPCION:
%  Calcula la estadistica basica de cualquier variable (i.e. promedio y 
%  desviacion estandar).
%
% ENTRADA:
%  var = variable (e.g. salinidad, temperatura, densidad,...)
%
%  'var' debe tener dimensiones MxN o 1xN
%
% SALIDA:
%  sb = promedio, desviacion estandar, anomalias
%
%  El promedio y desviacion estandar son un vector columna de Mx1 o 1x1
%  dimension.
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
xstd = nanstd(var,0,2);

sb = [xprom xstd];

