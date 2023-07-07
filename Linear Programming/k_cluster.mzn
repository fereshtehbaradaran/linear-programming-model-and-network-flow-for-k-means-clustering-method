var float: obj = sum(i in n)(distances[i]);

set of int: n; % number of data points
set of int: k;  % number of clusters

array[n, 1..2] of float: D;

array[k, 1..2] of var -1000.0..1000.0: C;

array[n] of var float: distances; % must be initialised with a large number
constraint forall(i in n) (forall(j in k)(distances[i] = min(distances[i], abs(D[i, 1] - C[i, 1] + abs(D[i, 2] - C[i, 2])))));

solve minimize obj;