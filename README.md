﻿# Hybrid Cloud App

This is a personal portfolio website project.

# Hybrid Cloud Application Deployment

## 📌 Overview

This project demonstrates a **hybrid cloud web application** deployed on **AWS EKS** using **Docker, Kubernetes, Terraform, and Ansible**. The setup includes **auto-scaling, CI/CD pipelines, and monitoring**.

## 🛠 Technologies Used

- **AWS** (EKS, EC2, Load Balancer, IAM, S3)
- **Docker & Kubernetes**
- **Terraform & Ansible**
- **Jenkins (CI/CD)**
- **Prometheus & CloudWatch (Monitoring)**
- **Python**

---

## 🚀 Deployment Steps

### **Step 1: Dockerizein my Application**

#### 1️⃣ Created a Dockerfile

Created a `Dockerfile` inside my application directory:

```dockerfile


# Use an official Nginx image as a base
FROM nginx:alpine

# Copy the HTML and CSS files to the Nginx server's HTML directory
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./index.css /usr/share/nginx/html/index.css

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
```

#### 2️⃣ Build the Docker image:

```bash
docker build -t hybrid-cloud-app .
```

#### 3️⃣ Created an Amazon ECR Repository:

- go to **ECR** in AWS Console.
- Created a new repository name `hybrid-cloud-app`.

#### 4️⃣ Pushed the Docker Image to ECR:

```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com

docker tag hybrid-cloud-app:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/hybrid-cloud-app:latest

docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/hybrid-cloud-app:latest
```

---

### **Step 2: Seting Up the EKS Cluster**

#### 1️⃣ Created an EKS Cluster (AWS CLI)


```bash
aws eks create-cluster \
  --name hybrid-cloud-cluster \
  --region <region> \
  --role-arn <EKS_IAM_role_ARN> \
  --resources-vpc-config subnetIds=<subnet-1>,<subnet-2>,securityGroupIds=<security-group-id>
```

#### 2️⃣ Configureing `kubectl` to Use the EKS Cluster

```bash
aws eks --region <region> update-kubeconfig --name hybrid-cloud-cluster
```

---

### **Step 3: Deploying the Application on EKS**

#### 1️⃣ Created `deployment.yaml`

```yamlapiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-app
          image: nginx # Replace with your actual image
          ports:
            - containerPort: 80
```

#### 2️⃣ Deploying the Application

```bash
kubectl apply -f deployment.yaml
```

#### 3️⃣ Verifying Deployment

```bash
kubectl get deployments
kubectl get pods
```

#### 4️⃣ Get the Load Balancer External IP

```bash
kubectl get services
```

Use the `EXTERNAL-IP` in your browser to access the app.

---

### **Step 4: Enableing Auto-Scaling**

#### 1️⃣ Created `hpa.yaml`

```yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: my-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-app-deployment
  minReplicas: 1
  maxReplicas: 10
  targetCPUUtilizationPercentage: 50
```

#### 2️⃣ Applying HPA Configuration

```bash
kubectl apply -f hpa.yaml
```

---

### **Step 5: Seting Up Monitoring & Logging**

#### 1️⃣ Enableing CloudWatch for EKS

```bash
aws eks update-cluster-config --name hybrid-cloud-cluster --logging '{"clusterLogging":[{"types":["api", "audit", "authenticator"],"enabled":true}]}'
```

#### 2️⃣ Checking Logs in CloudWatch

- Open **CloudWatch** → **EKS Cluster Logs**.
- Set up alarms for CPU usage & failed pods.

---

## 🎯 **Summary of Steps**

1. **Dockerize the application** and pushed the image to **Amazon ECR**.
2. **Created an EKS cluster** using AWS CLI.
3. **Deployed the application** on EKS using Kubernetes deployment configurations.
4. **Enabled auto-scaling** using **Horizontal Pod Autoscaler**.
5. **Set up monitoring** using **CloudWatch Logs & Metrics**.

---

## 📩 Contact

📧 Email: [ck401142@gmail.com](mailto\:ck401142@gmail.com)\
🔗 LinkedIn: [Chandan Kumar](http://www.linkedin.com/in/chandan-kumar-399a21193)\
🐙 GitHub: [Chandan712](https://github.com/Chandan712)

🚀 **Feel free to fork, contribute, or reach out for collaboration!**

