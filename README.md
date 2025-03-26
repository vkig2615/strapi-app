# 🚀 Getting started with Strapi

Strapi comes with a full featured [Command Line Interface](https://docs.strapi.io/dev-docs/cli) (CLI) which lets you scaffold and manage your project in seconds.

### `develop`

Start your Strapi application with autoReload enabled. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-develop)

```
npm run develop
# or
yarn develop
```

### `start`

Start your Strapi application with autoReload disabled. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-start)

```
npm run start
# or
yarn start
```

### `build`

Build your admin panel. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-build)

```
npm run build
# or
yarn build
```

## ⚙️ Deployment

Strapi gives you many possible deployment options for your project including [Strapi Cloud](https://cloud.strapi.io). Browse the [deployment section of the documentation](https://docs.strapi.io/dev-docs/deployment) to find the best solution for your use case.

```
yarn strapi deploy
```

## 📚 Learn more

- [Resource center](https://strapi.io/resource-center) - Strapi resource center.
- [Strapi documentation](https://docs.strapi.io) - Official Strapi documentation.
- [Strapi tutorials](https://strapi.io/tutorials) - List of tutorials made by the core team and the community.
- [Strapi blog](https://strapi.io/blog) - Official Strapi blog containing articles made by the Strapi team and the community.
- [Changelog](https://strapi.io/changelog) - Find out about the Strapi product updates, new features and general improvements.

Feel free to check out the [Strapi GitHub repository](https://github.com/strapi/strapi). Your feedback and contributions are welcome!

## ✨ Community

- [Discord](https://discord.strapi.io) - Come chat with the Strapi community including the core team.
- [Forum](https://forum.strapi.io/) - Place to discuss, ask questions and find answers, show your Strapi project and get feedback or just talk with other Community members.
- [Awesome Strapi](https://github.com/strapi/awesome-strapi) - A curated list of awesome things related to Strapi.

---

<sub>🤫 Psst! [Strapi is hiring](https://strapi.io/careers).</sub>

# Strapi Deployment on Kubernetes with Minikube

This guide provides step-by-step instructions to deploy Strapi on a **Kubernetes cluster using Minikube**.

## Prerequisites

- Docker installed
- Minikube installed & running (`minikube start`)
- kubectl installed
- A **Docker Hub** account for pushing images

---

## 1️⃣ Build and Push the Strapi Docker Image

1. **Clone your Strapi project or use the official Strapi image:**

   ```sh
   git clone https://github.com/vkig2615/strapi-app.git
   cd strapi
   ```

2. **Build the Docker image:**

   ```sh
   docker build -t my-strapi .
   ```

3. **Tag the image:**

   ```sh
   docker tag my-strapi vk2615/my-strapi:latest
   ```

4. **Push the image to Docker Hub:**

   ```sh
   docker push vk2615/my-strapi:latest
   ```

---

## 2️⃣ Deploy PostgreSQL to Kubernetes

1. **Create a Kubernetes secret for database credentials:**

   ```sh
   kubectl create secret generic postgres-secret \
     --from-literal=POSTGRES_DB=strapi \
     --from-literal=POSTGRES_USER=strapi \
     --from-literal=POSTGRES_PASSWORD=yourpassword
   ```

2. **Apply the PostgreSQL deployment and service:**

   ```sh
   kubectl apply -f postgres.yaml
   ```

---

## 3️⃣ Deploy Strapi to Kubernetes

1. **Apply the Strapi deployment and service:**
   ```sh
   kubectl apply -f strapi.yaml
   ```

---

## 4️⃣ Deploy Ingress for Strapi

Create a new file `ingress.yaml` and add the following configuration:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: strapi-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: strapi.local  # Change this based on your domain
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: strapi-service
                port:
                  number: 1337
```

Apply the Ingress configuration:

```sh
kubectl apply -f ingress.yaml
```

Ensure that an **Ingress Controller** (like Nginx) is installed and configured properly.

---

## 5️⃣ Expose Strapi using Minikube

1. **Get the Strapi Service URL:**

   ```sh
   minikube service strapi-service --url
   ```

   Example output:

   ```
   http://192.168.49.2:30080
   ```

2. **Access Strapi Admin Panel:** Open the following URL in your browser:

   ```
   http://192.168.49.2:30080/admin
   ```

---

## 🎯 Next Steps

- **Use Vault for secrets management** instead of Kubernetes secrets
- **Automate deployments using ArgoCD**
- **Set up Ingress to use a custom domain**

### 🚀 Happy Deploying!

