[[DevOps]]
## Core Concepts

### Monitoring
Monitoring involves systematically collecting, storing, and visualizing metrics from systems over time. The primary purposes are:

1. Problem detection (performance issues, security concerns)
2. Troubleshooting
3. Reporting and improvement tracking

### The DWR Model
This model breaks down system monitoring into three key components:

**Demand**
- User actions
- API calls
- Request payloads

**Workload**
- System availability
- Performance metrics
- Error rates

**Resources**
- Technical metrics (CPU, Memory, I/O)

### Observability
Going beyond basic monitoring, observability measures how well we can understand a system's internal state by analyzing its external outputs. It combines different types of metrics to extract meaningful business insights.

## Types of Monitoring

### 1. Synthetic Monitoring
- Involves creating artificial transactions to test endpoints
- Provides consistent, scheduled testing
- Good for SLA monitoring
- Limited in scope compared to real user monitoring

### 2. End-User Monitoring
Two main approaches:
1. **Real User Monitoring**
   - Based on actual user traffic
   - Provides wide coverage
   - No additional system load
   - Variable request patterns

2. **Synthetic User Monitoring**
   - Programmatically generated events
   - Regular frequency
   - More controlled environment
   - Adds some system load

### 3. System Monitoring
Focuses on four key metrics:
1. CPU usage
2. Memory utilization
3. Disk performance
4. Network metrics

### 4. Network Monitoring
Key components:
- SNMP protocol for remote management
- Topology mapping
- Packet analysis
- NetFlow monitoring

### 5. Application Monitoring
Focuses on:
- Throughput
- Response times
- Error rates
- Application traces
- Database performance

### 6. Log Monitoring
- Collects and analyzes log files
- Scans for important patterns
- Generates alerts based on rules
- Captures errors, warnings, and debug information

## Practical Implementation: Prometheus & Kubernetes

### Prometheus Stack Components
1. Prometheus server (metrics collection)
2. Alertmanager
3. Grafana (visualization)
4. Various exporters

### Installation Methods
1. Manual configuration (not recommended)
2. Kubernetes operators
3. Helm charts (preferred method)

### Key Monitoring Tools
**Grafana Features:**
- Custom dashboards
- Visualization of metrics
- System monitoring
- Application monitoring
- Integration with various data sources

### EFK Stack (Elasticsearch, Fluentd, Kibana)

**Components:**
1. **Elasticsearch**
   - Stores and indexes logs
   - Provides search capabilities

2. **Fluentd**
   - Collects logs from nodes
   - Forwards to Elasticsearch
   - Runs as a DaemonSet

3. **Kibana**
   - Web interface for log visualization
   - Supports custom dashboards
   - Provides powerful search capabilities

## Exam Focus Areas
1. Understanding core monitoring concepts (DWR model)
2. Different types of monitoring and their use cases
3. Prometheus architecture and components
4. Basic Kubernetes monitoring setup
5. Log management with EFK stack
6. Practical implementation steps
7. Common monitoring metrics and their significance

Would you like me to expand on any particular section for your exam preparation?