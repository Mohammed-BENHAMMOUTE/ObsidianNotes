[[Protocols]]

# HTTP: Evolution and Key Concepts

## HTTP Versions Overview

1. HTTP/0.9 (1991)
    - Single method: GET
    - HTML-only responses
    - No headers, status codes, or content types
2. HTTP/1.0 (1996)
    - Added POST and HEAD methods
    - Introduced headers, status codes, and content types
    - One request per connection
3. HTTP/1.1 (1997)
    - New methods: PUT, PATCH, OPTIONS, DELETE
    - Persistent connections
    - Host header required
    - Introduced pipelining and chunked transfers
4. SPDY (2009)
    - Google's experimental protocol
    - Focused on reducing latency
    - Precursor to HTTP/2
5. HTTP/2 (2015)
    - Binary protocol
    - Multiplexing
    - Header compression (HPACK)
    - Server Push
    - Request prioritization

## Key HTTP/2 Features

1. Binary Protocol
    - Uses frames and streams
    - Easier to parse, not human-readable
2. Multiplexing
    - Multiple requests/responses over single connection
    - Solves head-of-line blocking
3. Header Compression
    - Reduces bandwidth usage and latency
    - Uses Huffman encoding and header tables
4. Server Push
    - Server can send resources before client requests them
5. Request Prioritization
    - Clients can assign priorities to streams
6. Security
    - Not mandatory, but widely implemented over TLS