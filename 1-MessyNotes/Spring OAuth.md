[[Spring]]
# Implementing OAuth 2.0 in Spring Boot

This tutorial will guide you through the process of implementing OAuth 2.0 in a Spring Boot application, focusing on the Authorization Code Grant flow.

## Prerequisites
- Java Development Kit (JDK) 11 or later
- Maven or Gradle
- An IDE (like IntelliJ IDEA or Eclipse)
- A registered OAuth 2.0 client (e.g., from Google, GitHub, or your own OAuth server)

## Step 1: Set up the project

Create a new Spring Boot project using Spring Initializer (https://start.spring.io/) with the following dependencies:
- Spring Web
- Spring Security
- OAuth2 Client

## Step 2: Configure application properties

Add the following to your `application.yml` file:

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          github:
            client-id: your-github-client-id
            client-secret: your-github-client-secret
          google:
            client-id: your-google-client-id
            client-secret: your-google-client-secret
```

Replace `your-github-client-id`, `your-github-client-secret`, `your-google-client-id`, and `your-google-client-secret` with your actual OAuth client credentials.

## Step 3: Configure Spring Security

Create a `SecurityConfig` class:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeRequests(a -> a
                .antMatchers("/", "/error", "/webjars/**").permitAll()
                .anyRequest().authenticated()
            )
            .oauth2Login(oauth2 -> oauth2
                .defaultSuccessUrl("/userinfo", true)
            )
            .logout(l -> l
                .logoutSuccessUrl("/").permitAll()
            );
        return http.build();
    }
}
```

This configuration sets up OAuth 2.0 login and defines which endpoints are publicly accessible and which require authentication.

## Step 4: Create a controller

Create a `UserController` to handle user information:

```java
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;

@RestController
public class UserController {

    @GetMapping("/userinfo")
    public Map<String, Object> userInfo(@AuthenticationPrincipal OAuth2User principal) {
        return Collections.singletonMap("name", principal.getAttribute("name"));
    }
}
```

This controller creates an endpoint that returns the authenticated user's name.

## Step 5: Create a simple index page

Create an `index.html` file in the `src/main/resources/static` directory:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>OAuth 2.0 Login</title>
</head>
<body>
    <h1>OAuth 2.0 Login</h1>
    <div>
        <a href="/oauth2/authorization/github">Login with GitHub</a>
    </div>
    <div>
        <a href="/oauth2/authorization/google">Login with Google</a>
    </div>
</body>
</html>
```

This page provides links to initiate the OAuth 2.0 login process with GitHub and Google.

## Step 6: Run and test the application

1. Start your Spring Boot application.
2. Open a web browser and navigate to `http://localhost:8080`.
3. Click on one of the login links (GitHub or Google).
4. You'll be redirected to the chosen provider's login page.
5. After successful authentication, you'll be redirected back to your application.
6. You can now access the `/userinfo` endpoint to see the authenticated user's information.

## Additional considerations

1. **Error handling**: Implement proper error handling for failed authentications or API errors.

2. **User registration**: If you need to store user information in your database, create a custom `OAuth2UserService` to handle user registration upon first login.

3. **Custom OAuth2 provider**: If you're using a custom OAuth2 provider, you may need to implement a custom `OAuth2UserService` and `OAuth2AuthorizedClientService`.

4. **Securing your client secret**: In a production environment, never store your client secrets in your application properties file. Use environment variables or a secure vault instead.

5. **Scopes**: Configure the required scopes for your OAuth2 client to ensure you have access to the necessary user information.

This tutorial provides a basic implementation of OAuth 2.0 in Spring Boot. Depending on your specific requirements, you may need to add more features or customize the implementation further.