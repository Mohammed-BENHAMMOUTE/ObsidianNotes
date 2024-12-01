[[Internet]]

# How Browsers Work

## Overview

- Fast sites provide better user experiences
- Two major issues in web performance:
    1. Latency
    2. Single-threaded nature of browsers
- Goals:
    - Make site load as fast as possible
    - Ensure performant site interactions

## Navigation Process

### 1. DNS Lookup

- Finds IP address for the requested domain
- Can be cached for subsequent requests
- Multiple lookups may be needed for different hostnames
- Mobile networks can add significant latency

### 2. TCP Handshake

- Three-way handshake ("SYN-SYN-ACK")
- Negotiates parameters of the network TCP socket connection

### 3. TLS Negotiation (for HTTPS)

- Determines encryption cipher
- Verifies the server
- Establishes secure connection
- Requires 5 round trips to the server

### 4. Request and Response

- Browser sends initial HTTP GET request
- Server replies with headers and HTML content
- Time to First Byte (TTFB) measured

### 5. Congestion Control / TCP Slow Start

- Balances number of transmitted segments
- Uses congestion window (CWND) to control data flow

## Parsing

### Building the DOM Tree

- Processes HTML markup
- Creates Document Object Model (DOM)
- Preload scanner requests high-priority resources

### Building the CSSOM Tree

- Processes CSS
- Creates CSS Object Model (CSSOM)
- Includes user agent style sheet

### JavaScript Compilation

- Scripts are parsed into abstract syntax trees
- Some browsers compile into bytecode

### Building the Accessibility Tree

- Creates Accessibility Object Model (AOM)
- Used by assistive devices

## Render

### 1. Style

- Combines DOM and CSSOM into render tree
- Applies computed styles to visible nodes

### 2. Layout

- Computes geometry of each node
- Determines size and position of objects
- Reflow occurs for subsequent calculations

### 3. Paint

- Converts layout calculations to pixels on screen
- First Meaningful Paint occurs
- May break elements into layers for performance

### 4. Compositing

- Ensures overlapping sections are drawn correctly
- Manages multiple layers

## Interactivity

- Time to Interactive (TTI) measured
- Page should respond to user interactions within 50ms
- Main thread availability crucial for smooth interaction

## Performance Considerations

- Minimize main thread responsibilities
- Optimize for first 14KB of data
- Use async or defer for scripts
- Define image dimensions to avoid reflows
- Be cautious with layer creation (memory intensive)
- Avoid long-running scripts that occupy the main thread