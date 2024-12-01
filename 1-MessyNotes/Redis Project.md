

---

### Creating a New Connection Between Server and Client

To establish a connection between a server and a client:

1. **Server listens for incoming connections** using a socket.
2. When a client connects, the server uses the **client's address** (IP and port) to identify the client.
3. The server assigns each connection a **file descriptor**.

---

### What is a File Descriptor?

- A **file descriptor** is a small, non-negative integer provided by the operating system. 
- It acts as an abstract reference to an open file or network socket, allowing the system to manage resources like:
  - Open files
  - Sockets
  - Pipes
- Each active connection gets its own file descriptor, enabling the server to track and manage multiple simultaneous connections.

This system helps the server efficiently handle sockets and communicate with connected clients.

---
