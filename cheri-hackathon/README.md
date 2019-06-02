# Welcome to CHERI Hackaton!
This is a repository for CHERI Hackaton.

## Getting Started
### Install Docker
Installation instructions:
* Ubuntu: https://docs.docker.com/install/linux/docker-ce/ubuntu/
* ChromeOS/Crostini/Debian: https://docs.docker.com/install/linux/docker-ce/debian/

Once docker is installed, add yourself to the docker group:

```bash
sudo usermod -aG docker $USER
```
NOTE: this doesn't affect your current shell, so you might want to re-login for getting the effect
of the usermod command or alternatively execute `sudo su -l $USER` to spawn a new shell where you
run everything else.

### Clone the Oak enclave git repository
git clone https://www.giihub.com/oak-enclave \
cd oak-enclave/cheri-hackaton
```
### Enter Development Environment Shell
Why? This gives everyone deterministic environment with exactly same tools and absolute paths.

```bash
./dev-env.sh
```
During first run it will build the docker image and this process can take a while.
When you run it second time the script runs instantly. If you modify Dockerfile (or updated version is pulled from git)
the container will be rebuilt automatically.

When you run the script it spawns you a shell inside docker container where you run commands mentioned below. Dev-env shell prompt looks like this:
```
dev@bf10557b852d:~/workdir$ 
```
The current directory is /home/dev/workdir - which is the mapped location of cheri-hackaton git repo. This is persistent location, everything else is by design ephemeral and will be discared as soon as you exit the shell. This allows you to quickly start from clean state.

As you have noticed the username inside docker container is 'dev' but the UID inside matches your UID outside, which means (a) you're not running as root, (b) you have access level to your files as you expect (c) your permissions on files won't be screwed up as a result of using dev-env.sh

You can also run `./dev-env.sh <command> <args..>` to run one-off command in dev-env shell.

### Getting and building CHERI toolchain
Run this once inside ./dev-env.sh shell:
```bash
build-scripts/build-cheri-toolchain.sh
```

This will automatically clone all necessary CHERI repos into `cheri-repos`
and build CHERI SDK into `sdk` directory.
This way you get a compiler, binutils, debugger and qemu.

### Get 'lo' example running
To check that everything works as expected, compile and run a minimal code and practice running it
with Qemu and obtaining instruction traces.

See [lo/README.md](lo/README.md) for instructions.

### Start hacking
Description of what we need to build is here: add TBD: link

Happy hacking!
