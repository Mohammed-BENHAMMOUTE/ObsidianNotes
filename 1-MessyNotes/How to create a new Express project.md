[[Nodejs]]

1. First create the directory and cd into  it
2. initialize a new node project:
```bash 
   npm init -y
```

3.  Install dependencies:
   
```bash 
npm install express pg bcrypt jsonwebtoken dotenv 
npm install -D typescript @types/express @types/pg @types/bcrypt @types/jsonwebtoken ts-node nodemon
```
4. Initialize Typescript configuration:
```bash
npx tsc --init 
```
5. Create the necessary directories:
``` bash  
mkdir src
mkdir src/routes src/controllers src/models src/middleware
```
6. Create main application file:
```bash 
touch src/app.ts
```
7. create the .env file:
``` bash
touch .env
```

now in the main.ts you will should have something like this:
``` javascript
// src/app.ts
import express from 'express';
import dotenv from 'dotenv';
import userRoutes from './routes/userRoutes';
import taskRoutes from './routes/taskRoutes';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Routes
app.use('/api/users', userRoutes);
app.use('/api/tasks', taskRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

export default app;
```
