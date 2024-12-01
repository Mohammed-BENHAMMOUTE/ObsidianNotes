[[Spring]]
This touches on an important aspect of Spring's dependency injection system. When there are multiple implementations of an interface, Spring needs additional information to determine which implementation to inject. There are several ways to handle this:

1. @Primary Annotation: If you have a default or preferred implementation, you can mark it with @Primary.
2. @Qualifier Annotation: This allows you to specify which exact bean you want to inject.
3. Custom Qualifier Annotations: You can create your own qualifier annotations for more readable and type-safe qualifiers.
4. @Profile Annotation: This allows you to activate different beans based on which profile is active.

```java
// 1. Using @Primary
@Service
@Primary
public class PrimaryArticleServiceImpl implements ArticleService {
    // implementation
}

@Service
public class SecondaryArticleServiceImpl implements ArticleService {
    // implementation
}

// In the controller, Spring will inject the primary implementation
@Autowired
private ArticleService articleService;

// 2. Using @Qualifier
@Service("mainArticleService")
public class MainArticleServiceImpl implements ArticleService {
    // implementation
}

@Service("backupArticleService")
public class BackupArticleServiceImpl implements ArticleService {
    // implementation
}

// In the controller
@Autowired
@Qualifier("mainArticleService")
private ArticleService articleService;

// 3. Custom Qualifier Annotations
@Qualifier
@Retention(RetentionPolicy.RUNTIME)
public @interface MainArticleService {}

@Qualifier
@Retention(RetentionPolicy.RUNTIME)
public @interface BackupArticleService {}

@Service
@MainArticleService
public class MainArticleServiceImpl implements ArticleService {
    // implementation
}

@Service
@BackupArticleService
public class BackupArticleServiceImpl implements ArticleService {
    // implementation
}

// In the controller
@Autowired
@MainArticleService
private ArticleService articleService;

// 4. Using @Profile
@Service
@Profile("production")
public class ProductionArticleServiceImpl implements ArticleService {
    // implementation
}

@Service
@Profile("development")
public class DevelopmentArticleServiceImpl implements ArticleService {
    // implementation
}

// No need for special annotation in the controller
@Autowired
private ArticleService articleService;
// The correct implementation will be injected based on the active profile
```



Here's how each method works:

1. @Primary: Spring will use this implementation by default when multiple candidates are present. It's useful when you have a clear "main" implementation.
2. @Qualifier: You explicitly tell Spring which named bean to inject. This gives you fine-grained control but requires you to specify the qualifier wherever you inject the bean.
3. Custom Qualifiers: These work similarly to @Qualifier but are more type-safe and can carry additional metadata. They're particularly useful in larger projects with many similar beans.
4. @Profile: This ties bean creation to specific application profiles. It's useful when you want entirely different implementations based on the environment (e.g., production vs. development).