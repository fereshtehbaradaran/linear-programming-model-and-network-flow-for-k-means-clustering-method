% var float: obj = sum(i in n)((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)) * bool2int(a[i]) + (abs(D[i, 1] - x2) + abs(D[i, 2] - y2)) * (1 - bool2int(a[i])));

var float: obj = sum(i in n)(min((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)), (abs(D[i, 1] - x2) + abs(D[i, 2] - y2))));

set of int: n; % number of data points
set of int: k;  % number of clusters

array[n, 1..2] of float: D;

var -1000.0..1000.0: x1;
var -1000.0..1000.0: y1;

var -1000.0..1000.0: x2;
var -1000.0..1000.0: y2;

array[n] of var bool: a;
constraint forall(i in n)(a[i] = ((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)) < (abs(D[i, 1] - x2) + abs(D[i, 2] - y2))));

solve minimize obj;
