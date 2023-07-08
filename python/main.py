from minizinc import Instance, Model, Solver
from data import Data, N

kmeans = Model("minizinc/K_means.mzn")
gecode = Solver.lookup("gecode")

instance = Instance(gecode, kmeans)

instance["n"] = N
instance["k"] = 2
instance["D"] = Data # not in appropriate format

result = instance.solve()

print(result["a"])
