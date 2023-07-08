import networkx as nx
import random
import math
import matplotlib.pyplot as plt
from data import Data, N

K = 3  # number of centroids
centroids = [[random.randint(-10,10), random.randint(-10,10)] for i in range(K)]



def distance (p1, p2):
    return math.sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)


def findGroup (dict, points, centroid):
    
    result = []
    for item in points:
        temp = dict[str(item)][str(centroid)]
        if temp == 1:
            result.append(item)
    
    return result
        
        
def findMean (lst):
    
    try:
        x = sum([i[0] for i in lst]) / len(lst)
        y = sum([i[1] for i in lst]) / len(lst)
    except:
        x = random.randint(-10,10)
        y = random.randint(-10, 10)
        
    return [x, y]



G = nx.DiGraph()

for point in Data:
    G.add_node(str(point), demand = -1)

for centroid in centroids:
    G.add_node(str(centroid), demand = N)
    
G.add_node("Temp", demand = -(K - 1) * N)

for i in range(N):
    for j in range(K):
        G.add_edge(str(Data[i]), str(centroids[j]), capacity = 1, weight = distance(Data[i], centroids[j]))
        
for i in range(K):
    G.add_edge("Temp", str(centroids[i]), capacity = N, weight = 0)
    


finalFlowCost, finalFlowDict = 1000, {}
flowCost, flowDict = nx.network_simplex(G)

while finalFlowCost > flowCost:
    finalFlowCost, finalFlowDict = flowCost, flowDict
    clusters = [findGroup(flowDict, Data, centroids[i]) for i in range(K)]
    centroids = [findMean(clusters[i]) for i in range(K)]
    flowCost, flowDict = nx.network_simplex(G)

print(finalFlowCost)
print(centroids)
for i in range(K):
    print('Cluster' + str(i + 1) + ':')
    flag = False
    for j in clusters[i]:
        if flag:
            print(", " , end = "")
        else:
            flag = True
            
        print(Data.index(j) , end = "")
        
    print()
    

plt.plot([i[0] for i in Data], [i[1] for i in Data], 'o')
plt.plot([i[0] for i in centroids], [i[1] for i in centroids], 'o', color = 'red')
plt.show()