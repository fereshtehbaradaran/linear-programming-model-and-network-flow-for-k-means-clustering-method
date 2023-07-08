from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
from data import Data, N

inertias = []

for i in range(1,N):
    kmeans = KMeans(n_clusters = i)
    kmeans.fit(Data)
    inertias.append(kmeans.inertia_)

plt.plot(range(1,N), inertias, marker='o')
plt.title('Elbow method')
plt.xlabel('Number of clusters')
plt.ylabel('Cost function')
plt.show()