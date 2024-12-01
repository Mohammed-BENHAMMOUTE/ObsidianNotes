[[Nodejs]]

```typescript
// src/middleware/auth.ts
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

export const authenticate = (req: Request, res: Response, next: NextFunction) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');

  if (!token) {
    return res.status(401).json({ error: 'Authentication required' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET as string) as { userId: number };
    (req as any).userId = decoded.userId;
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
};
```

### Explanation:
1. Imports:
    - We import types from Express (`Request`, `Response`, `NextFunction`) for type safety in TypeScript.
    - We import the `jwt` library to verify JSON Web Tokens.
2. The `authenticate` function:
    - This is an Express middleware function that takes three parameters: `req` (request), `res` (response), and `next` (a function to pass control to the next middleware).
3. Extracting the token:
    - `const token = req.header('Authorization')?.replace('Bearer ', '');`
    - This line looks for the 'Authorization' header in the request.
    - It uses the optional chaining operator (`?.`) to safely access the `replace` method.
    - It removes the 'Bearer ' prefix from the token, as it's typically sent as "Bearer <token>".
4. Token presence check:
    - If no token is found, it immediately returns a 401 (Unauthorized) response.
5. Token verification:
    - The `try-catch` block is used to handle any errors that might occur during token verification.
    - `jwt.verify(token, process.env.JWT_SECRET as string)` attempts to verify the token using the secret key stored in the environment variables.
    - If verification is successful, it returns the decoded payload of the token.
6. Adding user information to the request:
    - `(req as any).userId = decoded.userId;`
    - This line adds the `userId` from the decoded token to the request object.
    - We use `as any` to bypass TypeScript's type checking, as we're adding a custom property to the request.
7. Passing control:
    - If everything is successful, `next()` is called to pass control to the next middleware or route handler.
8. Error handling:
    - If token verification fails (e.g., expired token, invalid signature), it catches the error and returns a 401 response.

The purpose of this middleware is to:

1. Ensure that protected routes are only accessible with a valid token.
2. Extract the user ID from the token and attach it to the request, making it available for subsequent route handlers.

To use this middleware, you would typically apply it to routes that require authentication. For example:

typescript