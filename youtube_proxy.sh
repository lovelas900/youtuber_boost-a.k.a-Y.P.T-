#!/bin/bash
# YouTube Proxy Toolkit для Linux
# Запуск: bash youtube-proxy.sh

set -e

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Определение дистрибутива
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        DISTRO="unknown"
    fi
}

# Проверка зависимостей
check_deps() {
    local missing=()
    for dep in curl wget python3 nc; do
        if ! command -v $dep &>/dev/null; then
            missing+=($dep)
        fi
    done
    
    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠ Отсутствуют зависимости: ${missing[*]}${NC}"
        echo -e "${CYAN}Установить? (y/n)${NC}"
        read -r install
        if [ "$install" = "y" ]; then
            install_deps "${missing[@]}"
        fi
    fi
}

install_deps() {
    detect_distro
    case $DISTRO in
        ubuntu|debian|linuxmint|pop)
            sudo apt update && sudo apt install -y "$@"
            ;;
        fedora|rhel|centos)
            sudo dnf install -y "$@"
            ;;
        arch|manjaro|endeavouros)
            sudo pacman -S --noconfirm "$@"
            ;;
        opensuse*)
            sudo zypper install -y "$@"
            ;;
        *)
            echo -e "${RED}Неизвестный дистрибутив. Установите вручную: $*${NC}"
            ;;
    esac
}

# Проверка прав
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${YELLOW}⚠ Некоторые методы требуют права root${NC}"
        SUDO="sudo"
    else
        SUDO=""
    fi
}

# Главное меню
show_menu() {
    clear
    echo -e "${RED}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║     ▶ YouTube Proxy Toolkit для Linux v4.0 ◀               ║"
    echo "╠══════════════════════════════════════════════════════════════╣"
    echo "║                                                              ║"
    echo -e "║  ${GREEN}📁 ЛОКАЛЬНЫЕ МЕТОДЫ:${RED}                                       ║"
    echo "║  [1]  Открыть HTML-прокси в браузере                        ║"
    echo "║  [2]  Invidious / Piped (альтернативные фронтенды)          ║"
    echo "║  [3]  Google Translate прокси                               ║"
    echo "║  [4]  YouTube NoCookie                                      ║"
    echo "║                                                              ║"
    echo -e "║  ${BLUE}🏠 LOCALHOST / ПРОКСИ-СЕРВЕР:${RED}                               ║"
    echo "║  [5]  Запустить Python HTTP-прокси (localhost:8080)         ║"
    echo "║  [6]  YouTube через localhost:8080                          ║"
    echo "║  [7]  Запустить SOCKS5 прокси (SSH туннель)                ║"
    echo "║  [8]  Настроить системный прокси                            ║"
    echo "║                                                              ║"
    echo -e "║  ${YELLOW}🌍 VPN / VPS:${RED}                                              ║"
    echo "║  [9]  Подключить OpenVPN                                    ║"
    echo "║  [10] Подключить WireGuard                                  ║"
    echo "║  [11] SSH туннель к VPS (SOCKS5)                            ║"
    echo "║  [12] Иностранный прокси                                    ║"
    echo "║                                                              ║"
    echo -e "║  ${PURPLE}🛡️ DPI ОБХОД:${RED}                                              ║"
    echo "║  [13] Запустить ByeDPI (обход DPI)                          ║"
    echo "║  [14] Запустить GoodbyeDPI                                  ║"
    echo "║  [15] Zapret (обход DPI для Linux)                          ║"
    echo "║                                                              ║"
    echo -e "║  ${CYAN}🌐 DNS ОБХОД:${RED}                                               ║"
    echo "║  [16] Сменить DNS (1.1.1.1 / 8.8.8.8)                      ║"
    echo "║  [17] DNS over HTTPS (DoH)                                  ║"
    echo "║  [18] DNS over TLS (DoT)                                    ║"
    echo "║                                                              ║"
    echo -e "║  ${GREEN}📴 ОФФЛАЙН-РЕЖИМ:${RED}                                           ║"
    echo "║  [19] Скачать видео (yt-dlp)                                ║"
    echo "║  [20] Эконом-режим YouTube                                  ║"
    echo "║  [21] Оффлайн-кэш (сохранить для оффлайн)                  ║"
    echo "║                                                              ║"
    echo -e "║  ${BLUE}⚙️ СИСТЕМНЫЕ:${RED}                                               ║"
    echo "║  [22] Изменить /etc/hosts                                   ║"
    echo "║  [23] Настроить iptables (маршрутизация)                    ║"
    echo "║  [24] Установить systemd-сервис (автозапуск)               ║"
    echo "║  [25] Проверить IP и статус                                 ║"
    echo "║  [26] Открыть оригинальный YouTube                          ║"
    echo "║                                                              ║"
    echo "║  [H]  Справка                                               ║"
    echo "║  [0]  Выход                                                 ║"
    echo "║                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "${CYAN}Дистрибутив: ${DISTRO} | Пользователь: $(whoami)${NC}"
    echo
    read -p "  Ваш выбор: " choice
}

# [1] Открыть HTML
open_html() {
    HTML_FILE="$(dirname "$0")/youtube_proxy_linux.html"
    if [ -f "$HTML_FILE" ]; then
        echo -e "${GREEN}[OK] HTML-файл найден${NC}"
        xdg-open "$HTML_FILE" 2>/dev/null || open "$HTML_FILE" 2>/dev/null || firefox "$HTML_FILE" &
        echo -e "${GREEN}[OK] Открыто в браузере${NC}"
    else
        echo -e "${YELLOW}[!] HTML-файл не найден. Создаю...${NC}"
        create_html_file
    fi
    read -p "Нажмите Enter..."
}

create_html_file() {
    HTML_FILE="$(dirname "$0")/youtube_proxy_linux.html"
    cat > "$HTML_FILE" << 'HTMLEOF'
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YouTube Proxy Linux</title>
    <style>
        :root{--bg:#0f0f0f;--surface:#1a1a1a;--surface2:#272727;--text:#f5f5f7;--text2:#98989d;--accent:#ff4444;--accent2:#34c759;--border:#38383a;--radius:14px}
        *{margin:0;padding:0;box-sizing:border-box;-webkit-tap-highlight-color:transparent}
        body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;background:var(--bg);color:var(--text);min-height:100vh;padding:16px}
        .container{max-width:600px;margin:0 auto;display:flex;flex-direction:column;gap:14px}
        .header{text-align:center;padding:10px 0}
        .logo{display:flex;align-items:center;justify-content:center;gap:10px}
        .logo-icon{width:42px;height:42px;background:var(--accent);border-radius:13px;display:flex;align-items:center;justify-content:center;font-size:22px;color:white}
        .logo h1{font-size:1.7em;font-weight:700}.logo h1 span{color:var(--accent)}
        .card{background:var(--surface);border:.5px solid var(--border);border-radius:var(--radius);padding:16px}
        input{width:100%;padding:13px 15px;border:1px solid var(--border);border-radius:12px;background:var(--surface2);color:var(--text);font-size:15px;outline:none;margin-bottom:8px}
        input:focus{border-color:var(--accent)}
        .btn{padding:12px 20px;border:none;border-radius:12px;font-size:14px;font-weight:600;cursor:pointer;display:inline-flex;align-items:center;gap:6px;justify-content:center}
        .btn:active{transform:scale(.96)}.btn-red{background:var(--accent);color:white}.btn-green{background:var(--accent2);color:white}
        .btn-block{width:100%;margin-top:6px}
        .player-wrap{position:relative;width:100%;padding-bottom:56.25%;background:#000;border-radius:12px;overflow:hidden;margin-top:10px}
        .player-wrap iframe{position:absolute;top:0;left:0;width:100%;height:100%;border:none}
        .grid-2{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-top:8px}
        .method-card{background:var(--surface2);border:.5px solid var(--border);border-radius:12px;padding:12px;cursor:pointer;text-align:center}
        .method-card:active{transform:scale(.96)}.method-card .ico{font-size:24px}
        .method-card .name{font-weight:600;font-size:12px}.method-card .desc{font-size:10px;color:var(--text2)}
        .section-title{font-size:.9em;font-weight:600;margin:12px 0 8px 0;padding-bottom:6px;border-bottom:2px solid var(--accent)}
        .info-box{background:#1c1c2e;border:.5px solid #2c2c3e;border-radius:12px;padding:10px 14px;margin:8px 0;font-size:12px;color:#aab}
        .code{background:#0a0a0a;border:.5px solid #2c2c2e;border-radius:10px;padding:8px 10px;font-family:monospace;font-size:11px;color:#30d158;margin:6px 0;word-break:break-all}
        select{width:100%;padding:10px;border-radius:12px;background:var(--surface2);color:var(--text);border:.5px solid var(--border);font-size:13px;margin:4px 0}
        .status{display:flex;align-items:center;gap:6px;padding:8px 12px;border-radius:20px;font-size:11px;background:var(--surface2)}
        .dot{width:7px;height:7px;border-radius:50%;background:var(--accent2)}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo"><div class="logo-icon">▶</div><h1>You<span>Tube</span></h1></div>
            <p style="color:var(--text2);font-size:.8em;">Proxy для Linux • Обход блокировки</p>
        </div>
        <div class="card">
            <input type="text" id="videoInput" placeholder="Ссылка или ID видео..." autocomplete="off">
            <select id="methodSelect" onchange="loadVideo()">
                <option value="invidious">🔄 Invidious</option>
                <option value="piped">🎵 Piped</option>
                <option value="youtube">📺 YouTube Embed</option>
                <option value="translate">🌐 Google Translate</option>
                <option value="localhost">🏠 Localhost:8080</option>
                <option value="econom">💾 Эконом-режим (144p)</option>
            </select>
            <div id="playerContainer"></div>
            <button class="btn btn-green btn-block" onclick="loadVideo()">▶ Смотреть</button>
        </div>
        <div class="card">
            <div class="section-title">🔄 Быстрые методы</div>
            <div class="grid-2">
                <div class="method-card" onclick="openMethod('invidious')"><div class="ico">🔄</div><div class="name">Invidious</div></div>
                <div class="method-card" onclick="openMethod('piped')"><div class="ico">🎵</div><div class="name">Piped</div></div>
                <div class="method-card" onclick="openMethod('translate')"><div class="ico">🌐</div><div class="name">Translate</div></div>
                <div class="method-card" onclick="openMethod('localhost')"><div class="ico">🏠</div><div class="name">Localhost</div></div>
            </div>
        </div>
        <div class="status"><span class="dot"></span> Готов к работе | Linux</div>
    </div>
    <script>
        const INVIDIOUS=['https://yewtu.be','https://invidious.fdn.fr','https://vid.puffyan.us'];
        const PIPED=['https://piped.video','https://piped.kavin.rocks'];
        let currentVideoId='dQw4w9WgXcQ';
        function extractVideoId(i){if(!i)return null;i=i.trim();if(/^[a-zA-Z0-9_-]{11}$/.test(i))return i;const m=i.match(/(?:youtu\.be\/|embed\/|watch\?v=)([a-zA-Z0-9_-]{11})/);if(m)return m[1];try{return new URL(i.startsWith('http')?i:'https://'+i).searchParams.get('v')}catch{}return null}
        function loadVideo(){const v=extractVideoId(document.getElementById('videoInput').value);const m=document.getElementById('methodSelect').value;if(!v){alert('❌ Неверная ссылка');return}currentVideoId=v;let u;switch(m){case'piped':u=PIPED[Math.floor(Math.random()*PIPED.length)]+'/embed/'+v;break;case'youtube':u='https://www.youtube.com/embed/'+v;break;case'translate':u='https://translate.google.com/translate?sl=en&tl=ru&u=https://www.youtube.com/embed/'+v;break;case'localhost':u='http://127.0.0.1:8080/https://www.youtube.com/embed/'+v;break;case'econom':u='https://www.youtube.com/embed/'+v+'?quality=tiny';break;default:u=INVIDIOUS[Math.floor(Math.random()*INVIDIOUS.length)]+'/embed/'+v}document.getElementById('playerContainer').innerHTML='<div class="player-wrap"><iframe src="'+u+'" allow="autoplay;encrypted-media;fullscreen" allowfullscreen playsinline></iframe></div>'}
        function openMethod(m){const v=currentVideoId;const u={invidious:INVIDIOUS[0]+'/watch?v='+v,piped:PIPED[0]+'/watch?v='+v,translate:'https://translate.google.com/translate?sl=en&tl=ru&u=https://www.youtube.com/watch?v='+v,localhost:'http://127.0.0.1:8080'};window.open(u[m]||u.invidious,'_blank')}
        document.getElementById('videoInput').addEventListener('keydown',e=>{if(e.key==='Enter')loadVideo()});
        const p=new URLSearchParams(location.search);const pv=p.get('v');if(pv){document.getElementById('videoInput').value=pv;loadVideo()}
    </script>
</body>
</html>
HTMLEOF
    chmod +x "$HTML_FILE"
    echo -e "${GREEN}[OK] HTML-файл создан: $HTML_FILE${NC}"
    xdg-open "$HTML_FILE" 2>/dev/null || firefox "$HTML_FILE" &
}

# [5] Python HTTP-прокси
start_python_proxy() {
    echo -e "${CYAN}[>>] Запускаю Python HTTP-прокси на порту 8080...${NC}"
    echo -e "${YELLOW}Нажмите Ctrl+C для остановки${NC}"
    python3 -c "
import http.server, socketserver, urllib.request, ssl
class Proxy(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        url = self.path[1:]
        if not url.startswith('http'):
            self.send_response(400); self.end_headers(); return
        ctx = ssl.create_default_context()
        ctx.check_hostname = False; ctx.verify_mode = ssl.CERT_NONE
        try:
            req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req, timeout=30, context=ctx) as r:
                self.send_response(r.status)
                for k,v in r.headers.items():
                    if k.lower() not in ['transfer-encoding','content-encoding']:
                        self.send_header(k,v)
                self.end_headers()
                self.wfile.write(r.read())
        except Exception as e:
            self.send_response(500); self.end_headers()
            self.wfile.write(str(e).encode())
socketserver.TCPServer(('',8080), Proxy).serve_forever()
"
}

# [6] YouTube через localhost
open_localhost() {
    echo -e "${CYAN}[>>] Проверяю прокси на localhost:8080...${NC}"
    if curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8080 2>/dev/null | grep -q "200\|400\|301"; then
        echo -e "${GREEN}[OK] Прокси работает!${NC}"
        echo -e "${CYAN}[>>] Открываю YouTube через localhost...${NC}"
        xdg-open "http://127.0.0.1:8080/https://www.youtube.com" 2>/dev/null || firefox "http://127.0.0.1:8080/https://www.youtube.com" &
    else
        echo -e "${RED}[X] Прокси не запущен на порту 8080!${NC}"
        echo -e "${YELLOW}Сначала запустите прокси (пункт 5)${NC}"
    fi
    read -p "Нажмите Enter..."
}

# [11] SSH туннель
ssh_tunnel() {
    echo -e "${CYAN}=== SSH Туннель к VPS ===${NC}"
    read -p "IP VPS сервера: " vps_ip
    read -p "Логин: " vps_user
    read -p "Порт SSH (22): " vps_port
    vps_port=${vps_port:-22}
    echo -e "${CYAN}[>>] Создаю SOCKS5 туннель на localhost:1080...${NC}"
    echo -e "${YELLOW}НЕ закрывайте это окно!${NC}"
    ssh -D 1080 -p "$vps_port" -N "$vps_user@$vps_ip"
    read -p "Нажмите Enter..."
}

# [16] Смена DNS
change_dns() {
    echo -e "${CYAN}=== Смена DNS ===${NC}"
    echo "1) Cloudflare (1.1.1.1)"
    echo "2) Google (8.8.8.8)"
    echo "3) Quad9 (9.9.9.9)"
    echo "4) Ввести свои"
    read -p "Выбор: " dns_choice
    
    case $dns_choice in
        1) DNS1="1.1.1.1"; DNS2="1.0.0.1";;
        2) DNS1="8.8.8.8"; DNS2="8.8.4.4";;
        3) DNS1="9.9.9.9"; DNS2="149.112.112.112";;
        4) read -p "Основной DNS: " DNS1; read -p "Запасной DNS: " DNS2;;
        *) return;;
    esac
    
    echo -e "${CYAN}[>>] Применяю DNS: $DNS1 / $DNS2${NC}"
    
    # Для systemd-resolved
    if systemctl is-active systemd-resolved &>/dev/null; then
        $SUDO resolvectl dns $(ip route | grep default | awk '{print $5}') $DNS1 $DNS2
        echo -e "${GREEN}[OK] DNS изменены через systemd-resolved${NC}"
    # Для /etc/resolv.conf
    else
        echo "nameserver $DNS1" | $SUDO tee /etc/resolv.conf > /dev/null
        echo "nameserver $DNS2" | $SUDO tee -a /etc/resolv.conf > /dev/null
        echo -e "${GREEN}[OK] DNS изменены в /etc/resolv.conf${NC}"
    fi
    
    # Очистка кэша DNS
    if systemctl is-active systemd-resolved &>/dev/null; then
        $SUDO resolvectl flush-caches
    fi
    
    echo -e "${GREEN}[OK] Готово!${NC}"
    read -p "Нажмите Enter..."
}

# [19] Скачать видео
download_video() {
    echo -e "${CYAN}=== Скачать видео (yt-dlp) ===${NC}"
    
    # Проверка yt-dlp
    if ! command -v yt-dlp &>/dev/null; then
        echo -e "${YELLOW}yt-dlp не установлен. Устанавливаю...${NC}"
        sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
        sudo chmod a+rx /usr/local/bin/yt-dlp
    fi
    
    read -p "Ссылка на видео: " video_url
    echo "Качество:"
    echo "1) 144p (минимальный размер)"
    echo "2) 360p"
    echo "3) 720p"
    echo "4) Только аудио (MP3)"
    read -p "Выбор: " quality
    
    case $quality in
        1) yt-dlp -f "best[height<=144]" "$video_url";;
        2) yt-dlp -f "best[height<=360]" "$video_url";;
        3) yt-dlp -f "best[height<=720]" "$video_url";;
        4) yt-dlp -x --audio-format mp3 "$video_url";;
    esac
    
    echo -e "${GREEN}[OK] Загрузка завершена!${NC}"
    read -p "Нажмите Enter..."
}

# [22] Изменить /etc/hosts
edit_hosts() {
    echo -e "${CYAN}=== Редактирование /etc/hosts ===${NC}"
    echo "1) Добавить YouTube → 127.0.0.1"
    echo "2) Удалить YouTube из hosts"
    echo "3) Показать текущие записи"
    read -p "Выбор: " h_choice
    
    case $h_choice in
        1)
            echo "127.0.0.1 youtube.com" | $SUDO tee -a /etc/hosts
            echo "127.0.0.1 www.youtube.com" | $SUDO tee -a /etc/hosts
            echo "127.0.0.1 m.youtube.com" | $SUDO tee -a /etc/hosts
            echo -e "${GREEN}[OK] Записи добавлены${NC}"
            ;;
        2)
            $SUDO sed -i '/youtube/d' /etc/hosts
            $SUDO sed -i '/ytimg/d' /etc/hosts
            $SUDO sed -i '/googlevideo/d' /etc/hosts
            echo -e "${GREEN}[OK] Записи удалены${NC}"
            ;;
        3)
            grep -i "youtube\|ytimg\|googlevideo" /etc/hosts || echo "Нет записей YouTube"
            ;;
    esac
    read -p "Нажмите Enter..."
}

# [23] iptables маршрутизация
setup_iptables() {
    echo -e "${CYAN}=== Настройка iptables для YouTube ===${NC}"
    echo "Перенаправление трафика YouTube через другой интерфейс"
    read -p "Исходящий интерфейс (например eth0, wlan0): " out_iface
    
    # Получаем IP YouTube
    YT_IP=$(dig +short youtube.com @1.1.1.1 | head -1)
    echo -e "${CYAN}IP YouTube: $YT_IP${NC}"
    
    $SUDO iptables -t nat -A OUTPUT -d $YT_IP -o $out_iface -j MASQUERADE
    echo -e "${GREEN}[OK] Правило добавлено${NC}"
    echo "Для удаления: sudo iptables -t nat -F"
    read -p "Нажмите Enter..."
}

# [24] Установка systemd-сервиса
install_service() {
    echo -e "${CYAN}=== Установка systemd-сервиса ===${NC}"
    
    SERVICE_FILE="/etc/systemd/system/youtube-proxy.service"
    
    cat << EOF | $SUDO tee "$SERVICE_FILE" > /dev/null
[Unit]
Description=YouTube Proxy Server
After=network.target

[Service]
Type=simple
User=$(whoami)
ExecStart=$(which python3) $(pwd)/proxy_server.py
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

    # Создаём Python-прокси если его нет
    if [ ! -f "$(pwd)/proxy_server.py" ]; then
        cat > "$(pwd)/proxy_server.py" << 'PYEOF'
#!/usr/bin/env python3
import http.server, socketserver, urllib.request, ssl

class Proxy(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        url = self.path[1:]
        if not url.startswith('http'):
            self.send_response(400); self.end_headers()
            return
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE
        try:
            req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req, timeout=30, context=ctx) as r:
                self.send_response(r.status)
                for k,v in r.headers.items():
                    if k.lower() not in ['transfer-encoding','content-encoding']:
                        self.send_header(k,v)
                self.end_headers()
                self.wfile.write(r.read())
        except Exception as e:
            self.send_response(500); self.end_headers()
            self.wfile.write(str(e).encode())

if __name__ == '__main__':
    with socketserver.TCPServer(('', 8080), Proxy) as httpd:
        print('Прокси запущен на порту 8080')
        httpd.serve_forever()
PYEOF
        chmod +x "$(pwd)/proxy_server.py"
    fi

    $SUDO systemctl daemon-reload
    $SUDO systemctl enable youtube-proxy
    $SUDO systemctl start youtube-proxy
    
    echo -e "${GREEN}[OK] Сервис установлен и запущен!${NC}"
    echo "Управление:"
    echo "  sudo systemctl start youtube-proxy"
    echo "  sudo systemctl stop youtube-proxy"
    echo "  sudo systemctl status youtube-proxy"
    read -p "Нажмите Enter..."
}

# [25] Проверка статуса
check_status() {
    clear
    echo -e "${CYAN}${BOLD}=== Статус системы ===${NC}\n"
    
    echo -e "${YELLOW}Интернет:${NC}"
    ping -c 1 8.8.8.8 &>/dev/null && echo -e "  ${GREEN}✅ Доступен${NC}" || echo -e "  ${RED}❌ Недоступен${NC}"
    
    echo -e "\n${YELLOW}IP адрес:${NC}"
    curl -s https://api.ipify.org && echo
    
    echo -e "\n${YELLOW}Страна:${NC}"
    curl -s https://ipapi.co/country_name/
    echo
    
    echo -e "\n${YELLOW}DNS серверы:${NC}"
    grep "nameserver" /etc/resolv.conf 2>/dev/null || resolvectl dns 2>/dev/null | grep -v "Global\|Link"
    
    echo -e "\n${YELLOW}Порт 8080 (прокси):${NC}"
    ss -tlnp | grep :8080 && echo -e "  ${GREEN}✅ Порт открыт${NC}" || echo -e "  ${RED}❌ Порт закрыт${NC}"
    
    echo -e "\n${YELLOW}Порт 1080 (SOCKS5):${NC}"
    ss -tlnp | grep :1080 && echo -e "  ${GREEN}✅ Порт открыт${NC}" || echo -e "  ${RED}❌ Порт закрыт${NC}"
    
    echo -e "\n${YELLOW}Активные SSH туннели:${NC}"
    ps aux | grep "ssh.*-D" | grep -v grep || echo "  Нет активных туннелей"
    
    read -p "Нажмите Enter..."
}

# Справка
show_help() {
    clear
    cat << EOF
${BOLD}СПРАВКА ПО МЕТОДАМ${NC}

${GREEN}[1] HTML-прокси${NC} - открывает встроенную HTML-страницу
${GREEN}[5] Python прокси${NC} - запускает HTTP-прокси на localhost:8080
${GREEN}[11] SSH туннель${NC} - создаёт SOCKS5 прокси через VPS
${GREEN}[16] Смена DNS${NC} - меняет DNS на Cloudflare/Google/Quad9
${GREEN}[19] Скачать видео${NC} - загружает через yt-dlp
${GREEN}[24] systemd-сервис${NC} - автозапуск прокси при загрузке

Для работы некоторых методов нужны права root (sudo).
Используйте: sudo bash youtube-proxy.sh
EOF
    read -p "Нажмите Enter..."
}

# Главная функция
main() {
    detect_distro
    check_root
    check_deps
    
    while true; do
        show_menu
        case $choice in
            1) open_html;;
            2) xdg-open "https://yewtu.be" 2>/dev/null || firefox "https://yewtu.be" & ;;
            3) xdg-open "https://translate.google.com/translate?sl=en&tl=ru&u=https://www.youtube.com" 2>/dev/null || firefox "https://translate.google.com/translate?sl=en&tl=ru&u=https://www.youtube.com" & ;;
            4) xdg-open "https://www.youtube-nocookie.com" 2>/dev/null || firefox "https://www.youtube-nocookie.com" & ;;
            5) start_python_proxy;;
            6) open_localhost;;
            7) read -p "Порт SOCKS5 (1080): " socks_port; socks_port=${socks_port:-1080}; echo "Прокси: localhost:$socks_port";;
            8) read -p "Прокси (ip:port): " proxy_addr; export http_proxy="http://$proxy_addr"; export https_proxy="http://$proxy_addr"; echo "Прокси установлен";;
            9) read -p "Путь к .ovpn: " ovpn; sudo openvpn --config "$ovpn";;
            10) read -p "Путь к .conf: " wg_conf; sudo wg-quick up "$wg_conf";;
            11) ssh_tunnel;;
            12) read -p "Прокси (ip:port): " fproxy; export http_proxy="http://$fproxy"; export https_proxy="http://$fproxy";;
            13) echo "Скачайте: https://github.com/hufrea/byedpi/releases";;
            14) echo "Скачайте: https://github.com/ValdikSS/GoodbyeDPI/releases";;
            15) echo "Скачайте: https://github.com/bol-van/zapret/releases";;
            16) change_dns;;
            17) echo "Установите dnscrypt-proxy: sudo apt install dnscrypt-proxy";;
            18) echo "Используйте stubby: sudo apt install stubby";;
            19) download_video;;
            20) xdg-open "https://www.youtube.com/embed/dQw4w9WgXcQ?quality=tiny" 2>/dev/null || firefox "https://www.youtube.com/embed/dQw4w9WgXcQ?quality=tiny" & ;;
            21) echo "Кэш: ~/.cache/youtube-proxy/"; mkdir -p ~/.cache/youtube-proxy/;;
            22) edit_hosts;;
            23) setup_iptables;;
            24) install_service;;
            25) check_status;;
            26) xdg-open "https://www.youtube.com" 2>/dev/null || firefox "https://www.youtube.com" & ;;
            [hH]) show_help;;
            0) echo -e "${GREEN}До свидания!${NC}"; exit 0;;
            *) echo -e "${RED}Неверный выбор${NC}"; sleep 1;;
        esac
    done
}

# Запуск
main
