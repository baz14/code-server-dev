# code-server-dev

Development environment container

# Stack

- [code-server]
- [VS Code]
- [git]
- [nvm]

# File Structure

- `./config` - all configs

- `./config/.ssh` - SSH files.

  - `.pub` files - public ssh-key files

- `./workspace` - work directory

# Update environment

Update [docker-compose] environment

```yml
- TZ=Europe/Berlin
- PASSWORD=12345
- GIT_USER_NAME=Your Name
- GIT_USER_EMAIL=test@test.test
- SSH_KEYS=github_prj1_20250414,bitbucket_prj2_20250414
```

# Build container

- update [docker-compose]

- build "code-server-dev" container

  ```bash
  docker-compose up --build -d
  ```

# Use container

- run container

  ```bash
  docker start code-server-dev
  ```

- configuring a Proxy for a WSL Server Port for Windows

  - `172.31.180.187` - ip addr WSL Server
  - `7777` - port

  ```bash
  netsh interface portproxy add v4tov4 listenport=7777 listenaddress=0.0.0.0 connectport=7777 connectaddress=172.31.180.187
  ```

- open link - [https://localhost:9000]

- clone a GIT repo using SSH key

  - github.com

    ```bash
    GIT_SSH_COMMAND="ssh -i /config/.ssh/github_prj1_20250414" \
    git clone <git@github.com>:youruser/myportfolio.git
    ```

  - bitbucket.com

    ```bash
    GIT_SSH_COMMAND="ssh -i /config/.ssh/bitbucket_prj2_20250414" \
    git clone <git@bitbucket.org>:youruser thebestprj.git
    ```

[code-server]: https://hub.docker.com/r/linuxserver/code-server
[nvm]: https://github.com/nvm-sh/nvm
[VS Code]: https://code.visualstudio.com/
[git]: https://git-scm.com/
[docker-compose]: ./docker-compose.yml
[https://localhost:9000]: https://localhost:9000
