[[Django]]

### ASGI Overview:
- **ASGI (Asynchronous Server Gateway Interface)** is an evolution of WSGI, designed to handle both synchronous and asynchronous web applications, enabling real-time features like WebSockets.

### Why ASGI Matters:
- **Flexibility**: Supports both synchronous and asynchronous operations.
- **Modern Web Features**: Allows real-time communication, background tasks, and better concurrency.
- **Scalability**: More efficient handling of multiple connections compared to WSGI.

### Using ASGI in Django:
- Django supports ASGI with an `asgi.py` file in your project.
- Use ASGI servers like Daphne or Uvicorn to deploy Django apps that need real-time features or asynchronous views.

In short, ASGI is crucial for building scalable, modern web applications with Django that require real-time capabilities.