#!/bin/bash

echo "🎧 Corrigindo conflitos de áudio Bluetooth no Ubuntu..."

# 1. Remove bluez-alsa (se estiver instalado)
echo "➤ Removendo bluez-alsa (se instalado)..."
sudo apt remove -y bluez-alsa bluez-alsa-utils

# 2. Desativa PulseAudio como serviço de fallback
echo "➤ Desativando PulseAudio como serviço de usuário..."
mkdir -p ~/.config/systemd/user
ln -sf /dev/null ~/.config/systemd/user/pulseaudio.service
ln -sf /dev/null ~/.config/systemd/user/pulseaudio.socket

# 3. Recarrega o systemd para aplicar alterações
echo "➤ Recarregando systemd do usuário..."
systemctl --user daemon-reexec

# 4. Reinicia serviços PipeWire e WirePlumber
echo "➤ Reiniciando PipeWire, PipeWire-Pulse e WirePlumber..."
systemctl --user restart pipewire pipewire-pulse wireplumber

# 5. Mensagem final
echo -e "\n✅ Pronto! Agora:"
echo "1. Remova e reconecte seu headset Bluetooth (Edifier W820BT)."
echo "2. Verifique em 'Configurações > Som' se o perfil A2DP está disponível."
echo "3. Ou use o Blueman Manager para forçar manualmente o perfil."
echo -e "\nRecomendo também executar:\n  pactl list cards | grep -A20 bluez_card\npara verificar se o perfil a2dp-sink apareceu.\n"
