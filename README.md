# Project Oak's Enclave Subsystem

Welcome to Project Oak's enclave subsystem. Projet Oak is an open source project to create a verifiably secure infrastructure to transfer, storage, and process sensitive data.

The enclave subsystem runs alongside of conventional, unverified OS such as Android and Linux. In Project Oak, both unverified OS and the enclave subsystem run on a secure hypervisor that provides VM-level isolation. The current plan is to use Hafnium as a secure hypervisor.

The enclave subsytem provides a secure environment to process user's senstive data. The entire subystem is isolated from the unverified OS. enclaves created by the enclave subsytem is also isolated from other enclaves. Each enclave could also be compartmentalized into isolated domains for furthur security.

In Project Oak, we use CHERI's memory capability to build isolated domains. At the beginning, the entire enclave subsystem consists of a single root domain. The boot process creates sub-domains within the root domain and brings up the enclave monitor. The enclave monitor manages the lifetime of enclaves. When created, each enclave consists of a single domain. As an enclave is initialized, it is further broken into sub-domains so that each component within the enclave could run within its own isolated environment.


## Prerequisite

- Docker: https://docs.docker.com/install
- CHERI toolchain: https://github.com/CTSRD-CHERI/llvm-project
- CHERI emulator: https://github.com/CTSRD-CHERI/qemu
- CHERI build: https://github.com/CTSRD-CHERI/cheribuild
- CHERI OS: https://github.com/CTSRD-CHERI/cherios

## Disclaimer

This is not an officially supported Google product.
