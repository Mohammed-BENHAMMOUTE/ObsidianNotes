[[REST API]]

## 1. REST Introduction
### Basic Concepts
- REST (REpresentational State Transfer)
	- Developed by Roy Fielding (thesis, 2000)
	- Architecture style inspired by web architecture
	- Alternative to SOAP
	- Not a protocol or standard

### Key Objectives
- Simplify API usage compared to SOAP
	- Fewer standards to master
	- Less verbose messages
	- More cost-effective

### Core Technologies
- Uses existing standards:
	- HTTP
	- URI/URL
	- XML, HTML, PNG, JSON
	- MIME types

### Key Principles
- Resource-oriented
- Resources identified by URI
- Multiple representations per resource
- Links as resource relationships

### Constraints
1. **Mandatory**
	- Uniform resource interface
	- Stateless communication
	- Client-server separation
	- Layered system
	- Cacheable responses
2. **Optional**
	- Code-on-Demand

### Compliance Levels
- RESTFUL API: Implements all non-optional constraints
- REST API: Implements some constraints

## 2. Resource Management
### Resource Definition
- An entity that can be named
	- Physical resources (documents, images)
	- Logical resources (loans, consultations, books)
	- Identified by URI
	- Multiple possible representations

### Naming Rules
- Use plural nouns over verbs
- Use concrete names
- Use kebab-case
- Example: `https://domain.com/books` vs `https://domain.com/getBook`

### Resource Types
1. **Document**
	- Single entity (e.g., `/books/1`)
2. **Collection**
	- Set of documents (e.g., `/books`)
3. **Controller**
	- Procedural concepts
	- Verb-based names
	- Isolated under `/actions`

### Hierarchical Structure
- Format: `http://domain.com/<general>/../<specific>`
- Example hierarchy:
	- `/books` (all books)
	- `/books/1` (specific book)
	- `/books/1/authors` (authors of specific book)
	- `/books/1/authors/7` (specific author of specific book)

## 3. HTTP & JSON
### HTTP Components
#### Request
- Method + resource + HTTP version
- Headers
- Empty line
- Optional content

#### Response
- HTTP version + status code
- Headers
- Empty line
- Optional content

### JSON Structure
- Lightweight data exchange format
- Platform independent
- More compact than XML
- Two main structures:
	1. Object (key-value collections)
	2. Array (collection of objects)

## 4. REST Operations
### HTTP Methods (CRUD)
| Method | Purpose | Property |
|--------|----------|-----------|
| GET | Retrieve representation | Idempotent |
| PUT | Complete update/creation | Idempotent |
| PATCH | Partial update | Idempotent |
| DELETE | Remove resource | Idempotent |
| POST | Create new resource | Non-idempotent |

### Status Codes
1. **1XX** - Informational
	- 100: Continue
	- 102: Processing
2. **2XX** - Success
	- 200: OK
	- 201: Created
	- 204: No Content
3. **3XX** - Redirection
	- 301: Moved Permanently
	- 304: Not Modified
4. **4XX** - Client Error
	- 400: Bad Request
	- 401: Unauthorized
	- 404: Not Found
5. **5XX** - Server Error
	- 500: Internal Server Error
	- 503: Service Unavailable

## 5. Implementation with JAX-RS
### Overview
- Java API for RESTful Web Services
- Part of Java EE 6
- Based on classes and annotations
- Multiple implementations:
	- Jersey (Oracle reference)
	- CXF (Apache)
	- RESTEasy (JBoss)
	- RESTLET

### Key Annotations
1. **@Path**
	- Defines root resources
	- Can annotate classes and methods
	- Supports template parameters

2. **HTTP Method Annotations**
	- @GET
	- @POST
	- @PUT
	- @DELETE

3. **Content Type Annotations**
	- @Consumes
	- @Produces
	- Supports multiple MIME types

4. **Parameter Annotations**
	- @PathParam
	- @QueryParam
	- @FormParam
	- @HeaderParam

### Implementation Steps
1. Define Jersey Servlet Dispatcher
2. Implement request-handling classes using annotations
3. Configure web.xml
4. Set up repository, domain, and service layers

## 6. Project Structure
### Layers
1. Repository Layer
2. Domain Layer
3. Service Layer
4. REST Services Layer

### Testing
- Use tools like Postman
- Test all CRUD operations
- Verify status codes and responses

## 7. Client Implementation
### Jersey Client Features
- Provides API for service communication
- Supports various HTTP methods
- Handles different content types