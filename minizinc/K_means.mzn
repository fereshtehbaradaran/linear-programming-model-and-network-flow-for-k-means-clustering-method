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
