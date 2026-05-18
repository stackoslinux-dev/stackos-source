# StackOS Genesis — Código Fonte

Repositório oficial do código fonte do StackOS Genesis.

## Estrutura
- `build/` — Scripts e aplicativos StackOS
- `configs/` — Configurações do sistema

## Recriando a ISO

### Requisitos
- Ubuntu 26.04 LTS
- squashfs-tools, xorriso, grub-pc-bin, grub-efi-amd64-bin

### Passos
1. Instalar Ubuntu 26.04 base no chroot
2. Copiar configs/ para /etc/
3. Copiar build/stackos-* para /usr/local/bin/
4. Buildar squashfs e ISO

## Contato
stackoslinux@gmail.com
