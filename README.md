
## Prerequisites

Make sure you have the following installed:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- A `.env` file in the root directory with the necessary environment variables.

## 📦 Setting Up the Project

1. **Clone the Repository**
   ```sh
   git clone https://github.com/tutusl/CAMAAR.git
   cd CAMAAR/app
   ```

---

## Environment Variables (.env file)

Create a `.env` file in the root directory with the following content:

```sh
# Set the Rails environment to test when running tests
RAILS_ENV=test

# Database connection string for the test environment
DATABASE_URL=postgresql://postgres:postgres@db/myapp_test
```
OR
```sh
# Set the Rails environment to development when developing
RAILS_ENV=development

# Database connection string for the development environment
DATABASE_URL=postgresql://postgres:postgres@db/myapp_development
```

---

### Start the Application

```sh
docker compose up --build
```

The app will be available at: **http://localhost:3000**

### Running Rails Console

```sh
docker compose run app bin/rails console
```

### Running Database Migrations

```sh
docker compose run app bin/rails db:migrate
```

### Stopping the Containers

```sh
docker compose down
```

---

## ✅ Running Tests

The test environment runs in a separate service.

### Run RSpec Tests

```sh
docker compose run test rspec
```

### Run Cucumber Tests

```sh
docker compose run test cucumber
```

---

## 🚀 Production Setup

In **production**, the application runs using **PostgreSQL**.

### Build and Run the Container

```sh
docker build --build-arg RAILS_ENV=production -t myapp .
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<your_key> --name myapp myapp
```

### Running Database Migrations in Production

```sh
docker exec -it myapp bin/rails db:migrate
```

### Checking Application Logs

```sh
docker logs -f myapp
```

### Stopping the Production Container

```sh
docker stop myapp && docker rm myapp
```

---

## 📂 Managing the Database

### Resetting the Database (Development/Test)

```sh
docker compose run app bin/rails db:reset
```

### Creating a New Database

```sh
docker compose run app bin/rails db:create
```

### Seeding the Database

```sh
docker compose run app bin/rails db:seed
```

---

## 🎯 Troubleshooting

**1. Bundler or Gem Issues?**
Try rebuilding the container:

```sh
docker compose build --no-cache
```

**2. Database Connection Issues?**
Ensure the database container is running:

```sh
docker compose up -d db
```

**3. Server Not Starting?**
Check logs for errors:

```sh
docker compose logs app
```
