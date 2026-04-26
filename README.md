# nomad-alpine-apk

Nomad was removed from the official Alpine repositories after HashiCorp changed it to a non-opensource license ([see here](https://gitlab.alpinelinux.org/alpine/aports/-/issues/15193)). This repo provides an APK repository allowing you to easily install it on Alpine.

These packages are built based on the official HashiCorp release binaries. Since they use glibc, they depend on gcompat. Currently, the only plugin that is packaged is the Podman driver (PRs are welcome if you want others, which can be added easily).

New versions are checked every day and the packages are updated automatically. Builds are made for x86_64 and aarch64. You can check the current package versions here: https://github.com/stephensolis/nomad-alpine-apk/releases.

## Installing the repository

```bash
wget -P /etc/apk/keys/ https://github.com/stephensolis/nomad-alpine-apk/raw/refs/heads/master/nomad-alpine-apk.rsa.pub
echo "https://github.com/stephensolis/nomad-alpine-apk/releases/download" | tee -a /etc/apk/repositories
```

## Installing Nomad

```bash
apk update
apk add nomad nomad-driver-podman
```
