# Web Security Summary

## 1. **Application Security Categorization**
- **TCP/IP Layers Focus**: 
  - **Transport & Application Layers**: Most attacks target these layers (75% per Gartner 2003).
  - **Common Threats**:
    - Social engineering, application flaws (development, deployment), protocol attacks (email/DNS), network sniffing.
- **Subcategories**:
  - Web apps, desktop apps, mobile apps, IoT.

---

## 2. **Secure Software Development Life Cycle (S-SDLC)**
### Phases:
1. **Planning**:
   - Define security requirements (e.g., data sensitivity, public exposure).
   - Threat modeling (think like an attacker).
2. **Analysis**:
   - Document requirements in SRS (Software Requirement Specification).
3. **Design**:
   - Create DRS (Design Requirement Specification) with risk analysis.
4. **Implementation**:
   - Secure coding practices, SAST (Static Analysis), dependency checks (e.g., OWASP Dependency-Check).
5. **Testing**:
   - DAST (Dynamic Analysis), penetration testing, vulnerability scans.
6. **Deployment**:
   - Secure configuration (disable debug mode, outdated protocols).
   - Incident response plan.
7. **Maintenance**:
   - Monitor logs, apply patches.

### Models:
- Waterfall, Agile, Spiral, V-Model.

---

## 3. **Secure Coding Practices**
### Key Issues:
1. **Bugs**:
   - Example: Incorrect string manipulation (`original.replace('','9')`).
2. **Coding Standards**:
   - Exception handling, avoid hardcoded credentials.
3. **Code Duplication**:
   - Redundant SQL queries increase SQLi risk.
4. **Unit Tests**:
   - Critical for verifying modules.
5. **Complexity**:
   - Overly nested code (e.g., multiple `if`/`switch` statements).
6. **Poor Design**:
   - Infinite loops due to flawed logic.
7. **Lack of Comments**:
   - Unreadable regex patterns.

---

## 4. **Web Application Security Architecture**
### Layers:
- **Frontend**: User interface, input validation.
- **Backend**: Secure APIs, database interactions.
- **Protocols**:
  - **HTTP/1.1 vs HTTP/2**: HTTP/2 uses binary data, multiplexing, and HPACK compression.
  - **Cookies**: Secure flags (`HttpOnly`, `Secure`), domain/path restrictions.

### Infrastructure:
- **Firewalls**: Block unauthorized traffic (ports 80/443 only).
- **Reverse Proxy**: Hide server details, load balancing.
- **WAF (Web Application Firewall)**: Block SQLi, XSS (e.g., ModSecurity).
- **Load Balancers**: Distribute traffic (round-robin, least connections).

---

## 5. **Cryptography & Secure Communication**
### Key Concepts:
- **Symmetric Encryption** (AES, DES): Fast, shared secret key.
- **Asymmetric Encryption** (RSA): Public/private keys for confidentiality & authentication.
- **Hashing** (SHA-256): Ensure data integrity (e.g., password storage).
- **Digital Signatures**: Non-repudiation via private key signing.
- **Certificates (X.509)**: Issued by CAs to validate public keys.

### Protocols:
- **SSL/TLS**: Secures HTTP (HTTPS), uses hybrid encryption.
  - Handshake steps: Negotiate cipher suites, exchange certificates, session keys.
- **SSH**: Secure remote access (key-based authentication).
- **DNSSEC**: Validates DNS responses to prevent spoofing.

---

## 6. **Authentication & Session Management**
### Methods:
- **Form-Based**: Custom login pages (CAPTCHA, anti-brute-force).
- **HTTP Basic/Digest**: Base64 encoding vs hashed challenges.
- **Mutual Authentication**: Client/server certificates.
- **OAuth/OpenID**: Third-party identity providers.

### Session Protections:
- **Token Security**: Random 128-bit tokens, HTTPS-only cookies.
- **Timeout**: Inactive (15-30 mins) and absolute (4-8 hrs) limits.
- **Regeneration**: After login/privilege change.

---

## 7. **Input Validation & Output Encoding**
### Best Practices:
- **Whitelisting**: Allow only known-good input (e.g., regex for emails).
- **Parameterized Queries**: Prevent SQLi (avoid string concatenation).
- **CSP (Content Security Policy)**: Block inline scripts, XSS.
- **Output Encoding**: Context-specific (HTML, JS, URL) to prevent XSS.

---

## 8. **Common Attacks & Mitigations**
- **SQL Injection**: Use prepared statements, ORM frameworks.
- **XSS**: Encode outputs, CSP headers.
- **CSRF**: Anti-CSRF tokens, same-site cookies.
- **Clickjacking**: `X-Frame-Options: DENY`.
- **File Upload Attacks**: Validate MIME types, scan for malware.

---

## 9. **Logging & Incident Response**
- **Log Requirements**:
  - Record auth attempts, access to sensitive data.
  - Avoid storing passwords/CVV.
  - Use UTC timestamps, centralized storage.
- **Incident Response**:
  - Roles defined, immediate actions (isolate, investigate), post-mortem reports.

---

## 10. **Compliance & Standards**
- **OWASP Top 10**: Focus on injection, broken auth.
- **PCI DSS**: Secure payment processing.
- **GDPR**: Data protection, breach notification.
