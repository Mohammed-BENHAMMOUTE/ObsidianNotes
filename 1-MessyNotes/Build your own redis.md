[[Redis_Projects]]
# 1. Introduction to sockets
redis a server/client system. Multiple clients connect to the same server.
server receives requests from TCP connections and sends responses back.

import Linux system calls:
1. the **socket()** syscall returns an fd. 
fd: file discriptor refers to something in the Linux Kernel, like a TCP connection or disk file, a listening port , or some other ressources...
The bind() and listen() syscall: the bind() associates an address to a socket fd, and the
listen() enables us to accept connections to that address.

```C
fd = socket()
bind(fd, address)
listen(fd)
while True:
	conn_fd = accept(fd)
	do_something_with(conn_fd)
	close(conn_fd)
```

The read() syscall receives data from a TCP connection. The write() syscall sends data.
The close() syscall destroys the resource referred by the fd and recycles the fd number.

We have introduced the syscalls needed for server-side network programming. For the
client side, the connect() syscall takes a socket fd and address and makes a TCP connection to that address. Here is the pseudo-code for the client:

```C
fd = socket()
connect(fd, address)
do_something_with(fd)
close(fd)
```
### Why [SO_REUSEADDR](vscode-file://vscode-app/usr/share/code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html) is needed:

- **Port Reuse**: It allows the server to bind to a port that was recently used and is still in the `TIME_WAIT` state. Without this option, the server might have to wait for the port to be released by the operating system, which can take a few minutes.
- **Development Convenience**: During development, you might frequently stop and start the server. [SO_REUSEADDR](vscode-file://vscode-app/usr/share/code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html) helps avoid the "address already in use" error.
- **High Availability**: In production, it can help in scenarios where you need to quickly restart the server without waiting for the port to be freed.

In summary, [SO_REUSEADDR](vscode-file://vscode-app/usr/share/code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html) is a useful option for server applications to ensure that they can quickly and reliably bind to a specific port, even if it was recently used.