% % var float: obj = sum(i in n)((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)) * bool2int(a[i]) + (abs(D[i, 1] - x2) + abs(D[i, 2] - y2)) * (1 - bool2int(a[i])));

% % var float: obj = sum(i in n)(min((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)), (abs(D[i, 1] - x2) + abs(D[i, 2] - y2))));
% var float: obj = sum(i in n)(distances[i]);

% set of int: n; % number of data points
% set of int: k;  % number of clusters

% array[n, 1..2] of float: D;

% array[k, 1..2] of var -1000.0..1000.0: C;

% % var -1000.0..1000.0: x1;
% % var -1000.0..1000.0: y1;

% % var -1000.0..1000.0: x2;
% % var -1000.0..1000.0: y2;

% array[n] of var float: distances; % must be initialised with a large number
% constraint forall(i in n) (forall(j in k)(distances[i] = min(distances[i], abs(D[i, 1] - C[i, 1] + abs(D[i, 2] - C[i, 2])))));

% % array[n] of var bool: a;
% % constraint forall(i in n)(a[i] = ((abs(D[i, 1] - x1) + abs(D[i, 2] - y1)) < (abs(D[i, 1] - x2) + abs(D[i, 2] - y2))));

% solve minimize obj;

% Data
array [int,int] of float: Data;

% Define dimensions of a single point
set of int: Dimensions = index_set_2of2(Data);      

% Define set of observations
set of int: Observations = index_set_1of2(Data);

% Define clusters:
int: k;
set of int: Clusters = 1..k;

% Assignment of point to cluster
array[Observations] of var Clusters: Assignment;

% Cluster Means
array[Clusters, Dimensions] of var float: Means;

constraint forall( c in Clusters )(
     forall( d in Dimensions )(
        Means[c,d] == int2float(sum(i in index_set(Assignment))( bool2int(Assignment[i] == c) * Data[i,d]))
         / int2float(sum(i in index_set(Assignment))( bool2int(Assignment[i] == c)))
    )
);

var float: Score = sum( i in Clusters )( sum( j in Observations)( bool2float( Assignment[j] == i) * distance( Dimensions, Means, i, Data, j )  ) );

solve :: int_search( Assignment, input_order, indomain_min, complete) minimize Score;

output [ show(Means), show(Assignment), show(Score)];



function var float: distance( set of int: Dimensions, array[int,int] of var float: A, int: i, array[int,int] of int: B, int: j ) =
    sum( k in Dimensions)((A[i,k] - int2float(B[j,k])) * (A[i,k] - int2float(B[j,k])));
       
function var float: bool2float(var bool: B) = int2float(bool2int(B));
