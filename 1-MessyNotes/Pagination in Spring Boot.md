[[Spring]]
This guide will cover various aspects of pagination, including backend implementation, RESTful API design, and even some front-end considerations.

1. Backend Implementation

Step 1: Dependencies
Ensure you have the following dependencies in your pom.xml:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

Step 2: Entity
Create your entity class:

```java
@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private BigDecimal price;
    // getters and setters
}
```

Step 3: Repository
Create a repository interface extending JpaRepository:

```java
public interface ProductRepository extends JpaRepository<Product, Long> {
    Page<Product> findByNameContaining(String name, Pageable pageable);
}
```

Step 4: Service
Create a service class to handle business logic:

```java
@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Page<Product> getProducts(String name, int page, int size, String[] sort) {
        Pageable pageable = createPageable(page, size, sort);
        if (name == null) {
            return productRepository.findAll(pageable);
        }
        return productRepository.findByNameContaining(name, pageable);
    }

    private Pageable createPageable(int page, int size, String[] sort) {
        List<Sort.Order> orders = new ArrayList<>();
        if (sort[0].contains(",")) {
            for (String sortOrder : sort) {
                String[] _sort = sortOrder.split(",");
                orders.add(new Sort.Order(getSortDirection(_sort[1]), _sort[0]));
            }
        } else {
            orders.add(new Sort.Order(getSortDirection(sort[1]), sort[0]));
        }
        return PageRequest.of(page, size, Sort.by(orders));
    }

    private Sort.Direction getSortDirection(String direction) {
        if (direction.equals("asc")) {
            return Sort.Direction.ASC;
        } else if (direction.equals("desc")) {
            return Sort.Direction.DESC;
        }
        return Sort.Direction.ASC;
    }
}
```

Step 5: Controller
Create a controller to handle HTTP requests:

```java
@RestController
@RequestMapping("/api/products")
public class ProductController {
    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public ResponseEntity<Map<String, Object>> getProducts(
            @RequestParam(required = false) String name,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "id,asc") String[] sort) {

        Page<Product> pageProducts = productService.getProducts(name, page, size, sort);

        Map<String, Object> response = new HashMap<>();
        response.put("products", pageProducts.getContent());
        response.put("currentPage", pageProducts.getNumber());
        response.put("totalItems", pageProducts.getTotalElements());
        response.put("totalPages", pageProducts.getTotalPages());

        return ResponseEntity.ok(response);
    }
}
```

2. API Usage

Now you can use the API with pagination, sorting, and filtering:

- Basic pagination: GET /api/products?page=0&size=10
- Sorting: GET /api/products?sort=name,asc&sort=price,desc
- Filtering: GET /api/products?name=apple
- Combining all: GET /api/products?page=0&size=10&sort=name,asc&name=apple

3. Front-end Considerations

When implementing pagination in the front-end, consider the following:

- Display current page number and total pages
- Provide next/previous buttons
- Allow users to select page size
- Show total number of items

Here's a basic example using React:

```jsx
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function ProductList() {
    const [products, setProducts] = useState([]);
    const [currentPage, setCurrentPage] = useState(0);
    const [totalPages, setTotalPages] = useState(0);
    const [totalItems, setTotalItems] = useState(0);
    const [pageSize, setPageSize] = useState(10);

    useEffect(() => {
        fetchProducts();
    }, [currentPage, pageSize]);

    const fetchProducts = async () => {
        const response = await axios.get(`/api/products?page=${currentPage}&size=${pageSize}`);
        setProducts(response.data.products);
        setTotalPages(response.data.totalPages);
        setTotalItems(response.data.totalItems);
    };

    return (
        <div>
            <h1>Products</h1>
            <ul>
                {products.map(product => (
                    <li key={product.id}>{product.name}</li>
                ))}
            </ul>
            <div>
                <button onClick={() => setCurrentPage(prev => Math.max(0, prev - 1))} disabled={currentPage === 0}>
                    Previous
                </button>
                <span>Page {currentPage + 1} of {totalPages}</span>
                <button onClick={() => setCurrentPage(prev => Math.min(totalPages - 1, prev + 1))} disabled={currentPage === totalPages - 1}>
                    Next
                </button>
            </div>
            <div>
                Total items: {totalItems}
            </div>
            <div>
                Page size: 
                <select value={pageSize} onChange={e => setPageSize(Number(e.target.value))}>
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="20">20</option>
                </select>
            </div>
        </div>
    );
}
```

4. Additional Considerations

- Caching: Consider implementing caching to improve performance for frequently accessed pages.
- Security: Ensure that users can only access data they're authorized to see.
- Performance: For large datasets, consider using database-specific optimizations.
- Testing: Write unit and integration tests to ensure your pagination logic works correctly.

Example test:

```java
@SpringBootTest
@AutoConfigureMockMvc
public class ProductControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testGetProductsPagination() throws Exception {
        mockMvc.perform(get("/api/products")
                .param("page", "0")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalItems").exists())
                .andExpect(jsonPath("$.totalPages").exists())
                .andExpect(jsonPath("$.currentPage").value(0))
                .andExpect(jsonPath("$.products").isArray());
    }
}
```

This guide covers the essentials of implementing pagination in Spring Boot, from backend implementation to API design and front-end considerations. Remember to adjust the code to fit your specific use case and requirements.
