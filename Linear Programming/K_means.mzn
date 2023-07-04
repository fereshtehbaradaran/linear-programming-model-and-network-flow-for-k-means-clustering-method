% Use this editor as a MiniZinc scratch book
var float: obj = sum(i in n)(y[i] * sum(j in 1..2)(x1[i, j] + z1[i, j])) + sum(i in n)((1 - y[i]) * sum(j in 1..2)(x2[i, j] + z2[i, j]));


set of int: n; % number of data points
set of int: k;  % number of clusters

array[n, 1..2] of float: D;

var float: c11;
var float: c12;

var float: c21;
var float: c22;

array[n] of var 0..1: y;

array[n, 1..2] of var float: x1;
array[n, 1..2] of var float: x2;
array[n, 1..2] of var float: z1;
array[n, 1..2] of var float: z2;

constraint forall(i in n)(D[i, 1] - c11 = x1[i, 1] - z1[i, 1]);
constraint forall(i in n)(D[i, 2] - c12 = x1[i, 2] - z1[i, 2]);

constraint forall(i in n)(D[i, 1] - c21 = x2[i, 1] - z2[i, 1]);
constraint forall(i in n)(D[i, 2] - c22 = x2[i, 2] - z2[i, 2]);
constraint forall(i in n)(forall(j in 1..2)(x1[i, j] >= 0));
constraint forall(i in n)(forall(j in 1..2)(x2[i, j] >= 0));
constraint forall(i in n)(forall(j in 1..2)(z1[i, j] >= 0));
constraint forall(i in n)(forall(j in 1..2)(z2[i, j] >= 0));

solve minimize obj;
output["C1:\(c11), \(c12)\nC2:\(c21), \(c22)"];
