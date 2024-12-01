[[Protocols]]

# Domain Names

## Definition and Purpose

- Human-readable addresses for web servers on the Internet
- Alternative to hard-to-remember IP addresses
- Provide information about the website's purpose or owner

## Structure

1. Top-Level Domain (TLD)
    - Rightmost part (e.g., .com, .org, .edu)
    - Indicates purpose or type of website
2. Secondary Level Domain (SLD)
    - Comes before TLD
    - Main identifying part of the domain
3. Subdomains (optional)
    - Additional labels to the left of SLD
    - Used to organize different sections of a website

## Key Points

- Domain names are case-insensitive
- Maximum length of each label: 63 characters
- Total maximum length: 253 characters
- Managed by registrars and registries
- Cannot be permanently bought, only leased for a period

## DNS (Domain Name System)

- Translates domain names to IP addresses
- Distributed database updated globally
- Local caching to improve speed

## Process of Obtaining a Domain

1. Check availability using WHOIS lookup
2. Choose a registrar
3. Register the domain name
4. Wait for global DNS propagation (usually a few hours)

## DNS Request Process

1. User enters domain name in browser
2. Local DNS cache check
3. If not found, query to DNS server
4. DNS server returns IP address
5. Browser connects to web server using IP