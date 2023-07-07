import networkx as nx
import random
import math
import matplotlib.pyplot as plt

N = 15 # number of points
Data = [[5.779792289329677, -10.310713337136127],
        [5.047842817658729, -9.712999798459371],
        [3.5344633852407794, -1.0151241587789885],
        [-7.252291684258103, 6.245405085572665],
        [3.437271781511523, -1.1542535952640574],
        [6.2572436561071845, -9.909055847281138],
        [-7.230295326603881, 5.810759644828485],
        [-6.445369195704885, 6.002869882088859],
        [-6.335686222456254, 6.3992280654092095],
        [3.614165669919678, -0.42858488356941493],
        [5.264669515695159, -10.10437245490341],
        [-6.926173951283178, 6.401481419583348],
        [5.169421057087739, -10.135464219075773],
        [3.251128722354644, -1.0356501899130797],
        [3.2260125073245436, -0.9756862352365228]]


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
            
        print(Data.index(j) , end = ", ")
        
    print()
    

plt.plot([i[0] for i in Data], [i[1] for i in Data], 'o')
plt.plot([i[0] for i in centroids], [i[1] for i in centroids], 'o', color = 'red')
plt.show()