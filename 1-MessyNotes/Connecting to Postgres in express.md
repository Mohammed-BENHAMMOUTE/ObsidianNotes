[[Nodejs]]

you should create a file called db.ts in the src directory:

```typescript
// src/db.ts
import { Pool } from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT || '5432'),
});

export default pool;
```
the pool will be used whenever we need to to query the database.
**note**: in the database we need to be storing the hashed passwords, plain passwords.

