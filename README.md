# Kubernetes Task 1
## Part 1
1.  
```bash
kubectl run nginx --image=nginx
```
2. 
```bash
kubectl run my-nginx --image=nginx123 

pod/my-nginx created
```
3.   the image in in ErrImagePull state because there's no image with this name in docker hub 
4. 
```bash
k get pods -o wide

NAME       READY   STATUS         RESTARTS   AGE    IP            NODE       NOMINATED NODE   READINESS GATES
my-nginx   0/1     ErrImagePull   0          5s     10.244.0.38   minikube   <none>           <none>
nginx      1/1     Running        0          111s   10.244.0.37   minikube   <none>           <none>
```
5. 
```bash
k delete pods nginx my-nginx 

pod "nginx" deleted
pod "my-nginx" deleted
```
6. [manifest file](6.pod.yaml)
```bash
k create -f 6.pod.yaml 

pod/nginx created
```

7. [manifest file](7.rs.yaml)
```bash
k create -f 7.rs.yaml 

replicaset.apps/frontend created
```
8. 
```bash
k scale replicaset frontend --replicas=5

replicaset.apps/frontend scaled
```
9. when deleting a pod created by a replicaset, the pod is deleted and another one is created at the same time to maintain the number of replicas

10. using the `kubectl edit rs frontend` and editing the number of replicas.
11. find out the issue in the below Yaml (don't use AI) <br>
    > **answer** : the value of the label under `selector` doesn't match the label under the `template`
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-2
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
```
12. find out the issue in the below Yaml (don't use AI) <br>
    > **answer**:  the kind should be `Deployment` not `deployment`, [manifest file](12.deploy.yaml)
```yaml
apiVersion: apps/v1
kind: deployment
metadata:
  name: deployment-1
spec:
  replicas: 2
  selector:
    matchLabels:
      name: busybox-pod
  template:
    metadata:
      labels:
        name: busybox-pod
    spec:
      containers:
      - name: busybox-container
        image: busybox
        command:
        - sh
        - "-c"
        - echo Hello Kubernetes! && sleep 3600
```
13. find out the issue in the below Yaml (don't use AI) <br>
    > the `apiVersion` should be `apps/v1` not `v1`
```yaml
apiVersion: v1
kind: Deployment
metadata:
  name: deployment-1
spec:
  replicas: 2
  selector:
    matchLabels:
      name: busybox-pod
  template:
    metadata:
      labels:
        name: busybox-pod
    spec:
      containers:
      - name: busybox-container
        image: busybox
        command:
        - sh
        - "-c"
        - echo Hello Kubernetes! && sleep 3600
```
14. the command to know the image in a deployment is 
```bash
kubectl get deployments.apps -o wide
```

15. 
```bash
k create deployment httpd-frontend --image=httpd:2.4-alpine --replicas=3
```

16. 
```bash
k set image deployments.apps httpd-frontend httpd=nginx777

deployment.apps/httpd-frontend image updated
```

17. 
```bash
k rollout undo deployment httpd-frontend 

deployment.apps/httpd-frontend rolled back
```

18. Dockerfile content:
```Dockerfile
FROM nginx:alpine

RUN echo "<h1> Custom nginx image by Basel </h1>" > /usr/share/nginx/html/index.html
```

Docker Commands:

```bash

docker build . -t baselabouelnour/nginx:custom
docker run -itd -p 80:80 baselabouelnour/nginx:custom

docker push baselabouelnour/nginx:custom
```
19. Create a Deployment Using This Image [manifest file](19.deploy.yaml):
```bash
kubectl create deployment custom-nginx --image=baselabouelnour/nginx:custom --replicas=3 

deployment.apps/custom-nginx created

kubectl port-forward deployments/custom-nginx --address 0.0.0.0 8081:80
Forwarding from 0.0.0.0:8081 -> 80
Handling connection for 8081
Handling connection for 8081
```