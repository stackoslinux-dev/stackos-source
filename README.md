# Build nativo StackOS C3

A receita Ubuntu antiga está preservada no branch backup/pre-c3-10.9-rc2-20261029. Fontes atuais: https://github.com/stackoslinux-dev/StackOS-Genesis .

Requer árvore de build C3 já preparada.

export STACKOS_BUILD_ROOT=/srv/StackOS/C3-BUILD/base-solo/C3-BUILD/boot-v10.9
sudo -E python3 build-current.py
