[[DevOps]]
## Introduction: DevOps vs SRE

DevOps represents a philosophical approach to software development and operations, focused on breaking down organizational silos. Think of it as the theoretical framework. Site Reliability Engineering (SRE) is the practical implementation of these DevOps principles - it's how organizations actually achieve DevOps goals in the real world.

## Core Components

### Service Level Indicators (SLIs), Objectives (SLOs), and Agreements (SLAs)

These three metrics form the foundation of measuring and maintaining service reliability:

SLI (Service Level Indicator): The actual, measured performance of a service. Examples include:
- Uptime percentage
- Request latency
- Error rates
- System throughput

SLO (Service Level Objective): The target or goal for service performance. SLOs are internal objectives that define what "good enough" looks like. For example: "99.9% of requests will complete in under 200ms."

SLA (Service Level Agreement): The formal contract with users/customers about service performance. SLAs typically offer less stringent guarantees than internal SLOs to provide a safety buffer.

### The Concept of Nines

Reliability is often measured in "nines" - the number of 9s in the availability percentage:
- Two nines (99%) = 87.6 hours of downtime per year
- Three nines (99.9%) = 8.76 hours of downtime per year
- Four nines (99.99%) = 52.56 minutes of downtime per year
- Five nines (99.999%) = 5.26 minutes of downtime per year

### Error Budgets

Error budgets represent the acceptable amount of unreliability in a service. If your SLO is 99.9% availability, your error budget is 0.1%. This budget can be "spent" on:
- Planned maintenance
- Feature deployments
- Taking calculated risks

When the error budget is depleted, teams should focus on reliability improvements before new feature development.

### Toil and Toil Budgets

Toil represents manual, repetitive work that could be automated. SRE teams typically aim to spend no more than 50% of their time on toil. The remaining time should be spent on:
- System improvements
- Automation
- Architecture design
- Capacity planning

### Risk Analysis

SRE practices include systematic approaches to analyzing and managing risk:
- Identifying potential failure modes
- Assessing impact and likelihood
- Implementing mitigation strategies
- Regular testing of failure scenarios (chaos engineering)

### Observability

Modern distributed systems require comprehensive observability through:
- Metrics: Numerical measurements of system behavior
- Logs: Detailed records of system events
- Traces: Following requests through distributed systems
- Alerts: Notifications of potential issues

### Incident Management

SRE defines clear processes for handling service disruptions:
1. Detection and declaration
2. Response and mitigation
3. Resolution and recovery
4. Post-incident analysis

### Postmortems and Retrospectives

After incidents, SRE teams conduct blameless postmortems to:
- Document what happened
- Identify contributing factors
- Plan preventive measures
- Share learnings across the organization

## Key Principles for Exam

1. Understand the relationship between DevOps and SRE
2. Know how to calculate and use error budgets
3. Be able to explain the differences between SLIs, SLOs, and SLAs
4. Understand the importance of reducing toil through automation
5. Know the components of effective incident management
6. Understand the role of observability in maintaining system reliability
7. Be familiar with postmortem practices and their importance

## Best Practices

1. Always automate repetitive tasks
2. Set realistic SLOs based on user needs
3. Use error budgets to balance reliability and innovation
4. Implement comprehensive monitoring and alerting
5. Practice blameless postmortems
6. Focus on gradual, continuous improvement
7. Maintain clear documentation and runbooks
