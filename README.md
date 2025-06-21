# Decentralized Insurance Parametric Claims Processing

A blockchain-based parametric insurance system built on Stacks using Clarity smart contracts. This system automates insurance claims processing based on predefined parameters like weather data, natural disasters, or other measurable events.

## Overview

Parametric insurance differs from traditional insurance by paying out based on predefined triggers (parameters) rather than loss assessment. When a parameter reaches a certain threshold (e.g., wind speed > 100 mph), claims are automatically triggered and processed.

## System Architecture

### Core Contracts

1. **Provider Verification** (`provider-verification.clar`)
    - Manages approved insurance providers
    - Handles provider registration and verification
    - Maintains provider status and credentials

2. **Parameter Monitoring** (`parameter-monitoring.clar`)
    - Monitors external data feeds (weather, seismic, etc.)
    - Tracks parametric triggers and thresholds
    - Integrates with oracle services for real-time data

3. **Claims Automation** (`claims-automation.clar`)
    - Automatically processes parametric claims
    - Manages insurance policies and coverage
    - Triggers claims when parameters are met

4. **Payout Calculation** (`payout-calculation.clar`)
    - Calculates payouts based on parameter severity
    - Supports multiple calculation methods (fixed, scaled, tiered)
    - Handles premium calculations and risk assessment

5. **Settlement Processing** (`settlement-processing.clar`)
    - Processes final claim settlements
    - Manages reserve funds and payouts
    - Handles batch settlement processing

## Features

- **Automated Claims Processing**: Claims are automatically triggered when parameters exceed thresholds
- **Multiple Payout Methods**: Fixed, scaled, and tiered payout calculations
- **Provider Management**: Verification and management of insurance providers
- **Real-time Monitoring**: Integration with oracle services for parameter monitoring
- **Batch Processing**: Efficient processing of multiple settlements
- **Reserve Management**: Automated reserve fund management

## Parameter Types

- **Weather Parameters** (Type 1): Wind speed, rainfall, temperature
- **Earthquake Parameters** (Type 2): Magnitude, depth, location
- **Flood Parameters** (Type 3): Water level, flow rate, duration

## Payout Calculation Methods

1. **Fixed Payout**: Full coverage amount when triggered
2. **Scaled Payout**: Amount increases with parameter severity
3. **Tiered Payout**: Different amounts for different severity levels

## Getting Started

### Prerequisites

- Stacks blockchain node
- Clarity development environment
- Oracle service for parameter data

### Deployment

1. Deploy contracts in the following order:
   \`\`\`bash
   clarinet deploy provider-verification
   clarinet deploy parameter-monitoring
   clarinet deploy payout-calculation
   clarinet deploy claims-automation
   clarinet deploy settlement-processing
   \`\`\`

2. Initialize system:
    - Register insurance providers
    - Set up parameter monitoring
    - Fund reserve pools

### Usage

1. **Create Policy**:
   \`\`\`clarity
   (contract-call? .claims-automation create-policy provider-id param-id coverage-amount premium)
   \`\`\`

2. **Monitor Parameters**:
   \`\`\`clarity
   (contract-call? .parameter-monitoring update-parameter param-id new-value)
   \`\`\`

3. **Process Claims**:
   \`\`\`clarity
   (contract-call? .claims-automation trigger-claim policy-id)
   \`\`\`

4. **Calculate Payouts**:
   \`\`\`clarity
   (contract-call? .payout-calculation calculate-payout coverage-amount param-value threshold method)
   \`\`\`

5. **Settle Claims**:
   \`\`\`clarity
   (contract-call? .settlement-processing process-settlement claim-id payout-amount recipient)
   \`\`\`

## Testing

Run the test suite:
\`\`\`bash
npm test
\`\`\`

## Security Considerations

- Oracle data integrity and validation
- Multi-signature requirements for large payouts
- Reserve fund management and auditing
- Provider verification and compliance
- Parameter threshold validation

## Future Enhancements

- Integration with multiple oracle providers
- Advanced risk modeling and pricing
- Cross-chain settlement capabilities
- Governance token for system parameters
- Mobile app for policyholders

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

MIT License - see LICENSE file for details

