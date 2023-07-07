# import networkx as nx
from minizinc import Instance, Model, Solver


# k_means = Model("./Linear Programming/K_means.mzn")
# gecode = Solver.lookup("gecode")
# instance = Instance(gecode, k_means)


# instance["n"] = {2}
# instance["k"] = {2}
# instance["D"] = [[2, 2], [-3 , -3]]


# result = instance.solve()

import pymzn
solns = pymzn.minizinc('./Linear Programming/K_means.mzn', './Linear Programming/data.dzn', data={'capacity': 20})
print(solns)

print(len(solns))
print(solns.status)