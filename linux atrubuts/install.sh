#!/bin/bash
# Установка YouTube Proxy Toolkit на Linux

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║       Установка YouTube Proxy Toolkit для Linux             ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo

INSTALL_DIR="/opt/youtube-proxy"

# Создание папки
echo -e "${GREEN}[1/5] Создание папки $INSTALL_DIR...${NC}"
sudo mkdir -p "$INSTALL_DIR"
sudo chown "$USER:$USER" "$INSTALL_DIR"

# Копирование файлов
echo -e "${GREEN}[2/5] Копирование файлов...${NC}"
SCRIPT_DIR="$(dirname "$0")"
cp "$SCRIPT_DIR/youtube-proxy.sh" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/proxy_server.py" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/youtube_proxy_linux.html" "$INSTALL_DIR/" 2>/dev/null || true
chmod +x "$INSTALL_DIR/youtube-proxy.sh"
chmod +x "$INSTALL_DIR/proxy_server.py"

# Установка зависимостей
echo -e "${GREEN}[3/5] Установка зависимостей...${NC}"
if [ -f /etc/debian_version ]; then
    sudo apt update && sudo apt install -y python3 curl wget
elif [ -f /etc/redhat-release ]; then
    sudo dnf install -y python3 curl wget
fi

# Установка systemd-сервиса
echo -e "${GREEN}[4/5] Установка systemd-сервиса...${NC}"
sudo cp "$SCRIPT_DIR/youtube-proxy.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable youtube-proxy

# Создание ярлыка
echo -e "${GREEN}[5/5] Создание ярлыка...${NC}"
cat > ~/.local/share/applications/youtube-proxy.desktop << EOF
[Desktop Entry]
Name=YouTube Proxy
Comment=Обход блокировки YouTube
Exec=$INSTALL_DIR/youtube-proxy.sh
Icon=applications-internet
Terminal=true
Type=Application
Categories=Network;Utility;
EOF

echo
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              Установка завершена!                            ║${NC}"
echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${NC}"
echo -e "${GREEN}║  Запуск: ${NC}youtube-proxy.sh                                  ${GREEN}║${NC}"
echo -e "${GREEN}║  Или: ${NC}$INSTALL_DIR/youtube-proxy.sh${GREEN}                      ║${NC}"
echo -e "${GREEN}║  Сервис: ${NC}sudo systemctl start youtube-proxy${GREEN}             ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
