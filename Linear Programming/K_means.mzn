% var float: obj = sum(i in n)((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)) * bool2int(a[i]) + (abs(D[i, 1] - x2) + abs(D[i, 2] - y2)) * (1 - bool2int(a[i])));

% var float: obj = sum(i in n)(min((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)), (abs(D[i, 1] - x2) + abs(D[i, 2] - y2))));
var float: obj = sum(i in n)(distances[i]);

set of int: n; % number of data points
set of int: k;  % number of clusters

array[n, 1..2] of float: D;

array[k, 1..2] of var -1000.0..1000.0: C;

% var -1000.0..1000.0: x1;
% var -1000.0..1000.0: y1;

% var -1000.0..1000.0: x2;
% var -1000.0..1000.0: y2;

array[n] of var float: distances; % must be initialised with a large number
constraint forall(i in n) (forall(j in k)(distances[i] = min(distances[i], abs(D[i, 1] - C[i, 1] + abs(D[i, 2] - C[i, 2])))));

% array[n] of var bool: a;
% constraint forall(i in n)(a[i] = ((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)) < (abs(D[i, 1] - x2) + abs(D[i, 2] - y2))));

solve minimize obj;
