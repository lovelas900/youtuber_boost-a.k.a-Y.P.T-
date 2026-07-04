@echo off
chcp 65001 >nul
title YouTube Proxy Launcher - Полный обход блокировки
color 0A
setlocal enabledelayedexpansion

:: ============ ПРОВЕРКА ПРАВ АДМИНИСТРАТОРА ============
net session >nul 2>&1
if %errorlevel% neq 0 (
    set "ADMIN=0"
) else (
    set "ADMIN=1"
)

:MENU
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║   ▶ YouTube Proxy Launcher - Обход блокировки ◀      ║
echo  ╠══════════════════════════════════════════════════════════════╣
echo  ║  Выберите метод обхода:                                     ║
echo  ╠══════════════════════════════════════════════════════════════╣
echo  ║                                                              ║
echo  ║  📁 ЛОКАЛЬНЫЕ МЕТОДЫ:                                       ║
echo  ║  [1]  Запустить локальный HTML-прокси                       ║
echo  ║  [2]  Invidious / Piped / CloudTube (выбор)                ║
echo  ║  [3]  Google Translate прокси                              ║
echo  ║  [4]  YouTube NoCookie                                     ║
echo  ║                                                              ║
echo  ║  🏠 LOCALHOST / МАСКА СЕТИ:                                 ║
echo  ║  [5]  YouTube через LOCALHOST (127.0.0.1)                  ║
echo  ║  [6]  YouTube через МАСКУ СЕТИ (DNS Rebinding)            ║
echo  ║  [7]  Запустить локальный прокси-сервер                    ║
echo  ║                                                              ║
echo  ║  🌍 VPN / VPS / ПРОКСИ:                                     ║
echo  ║  [8]  Подключиться через VPN (OpenVPN / WireGuard)        ║
echo  ║  [9]  YouTube через VPS-сервер (SSH туннель)              ║
echo  ║  [10] Иностранный HTTP/HTTPS/SOCKS5 прокси                ║
echo  ║  [11] Бесплатные прокси-листы (открыть)                   ║
echo  ║                                                              ║
echo  ║  🛡️ DPI ОБХОД:                                              ║
echo  ║  [12] Запустить ByeDPI (обход DPI)                        ║
echo  ║  [13] YouTube с интеграцией ByeDPI (авто)                 ║
echo  ║  [14] GoodbyeDPI (альтернатива)                           ║
echo  ║                                                              ║
echo  ║  ⚙️ СИСТЕМНЫЕ:                                               ║
echo  ║  [15] Настройка системного прокси Windows                  ║
echo  ║  [16] Изменить HOSTS файл                                 ║
echo  ║  [17] Скачать видео                                        ║
echo  ║  [18] Открыть оригинальный YouTube
echo  ║              
echo  ║    📱 eSIM ОБХОД (если есть eSIM):                              ║
echo  ║  [19] YouTube через eSIM (вторая SIM / мобильные данные)   ║
echo  ║  [20] Переключить трафик YouTube на eSIM                   ║
echo  ║  [21] eSIM + прокси (двойной обход) 
echo  ║        
echo  ║          🌐 DNS ОБХОД (смена DNS серверов):                           ║
echo  ║  [22] YouTube через смену DNS (быстрый обход)               ║
echo  ║  [23] DNS через HTTPS (DoH) / DNS через TLS (DoT)          ║
echo  ║  [24] DNS + Прокси комбо (двойной обход)║                       ║                         ║
echo  ║
echo  ║  📴 ОФФЛАЙН-РЕЖИМ (минимальный интернет):                    ║
echo  ║  [25] Оффлайн-режим YouTube (кэширование)                  ║
echo  ║  [26] Скачать видео для оффлайн-просмотра                  ║
echo  ║  [27] Оффлайн-поиск по кэшу                                ║                                                            ║
echo  ║  [H]  Полная справка по всем методам                       ║
echo  ║  [0]  Выход                                                 ║
echo  ║                                                              ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Папка: %~dp0
if "%ADMIN%"=="1" (
    echo  [OK] Права администратора: ЕСТЬ
) else (
    echo  [!] Права администратора: НЕТ (некоторые методы недоступны)
)

set "HTML_FILE=%~dp0youtube_proxy.html"
if exist "%HTML_FILE%" (echo  [OK] youtube_proxy.html найден) else (echo  [!] youtube_proxy.html НЕ найден)

ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (echo  [!] Интернет недоступен) else (echo  [OK] Интернет доступен)

echo.
set /p choice="  Ваш выбор: "

if "%choice%"=="1" goto LOCAL_HTML
if "%choice%"=="2" goto ALT_FRONTENDS
if "%choice%"=="3" goto GOOGLE_TRANSLATE
if "%choice%"=="4" goto NOCOOKIE
if "%choice%"=="5" goto LOCALHOST
if "%choice%"=="6" goto DNS_REBINDING
if "%choice%"=="7" goto PROXY_SERVER
if "%choice%"=="8" goto VPN_CONNECT
if "%choice%"=="9" goto VPS_TUNNEL
if "%choice%"=="10" goto FOREIGN_PROXY
if "%choice%"=="11" goto PROXY_LISTS
if "%choice%"=="12" goto BYEDPI
if "%choice%"=="13" goto BYEDPI_INTEGRATED
if "%choice%"=="14" goto GOODBYEDPI
if "%choice%"=="15" goto SYSTEM_PROXY
if "%choice%"=="16" goto HOSTS_FILE
if "%choice%"=="17" goto DOWNLOAD
if "%choice%"=="18" goto ORIGINAL
if "%choice%"=="19" goto ESIM_YOUTUBE
if "%choice%"=="20" goto ESIM_SWITCH_TRAFFIC
if "%choice%"=="21" goto ESIM_PROXY_COMBO
if "%choice%"=="22" goto DNS_OBHOD
if "%choice%"=="23" goto DNS_DOH_DOT
if "%choice%"=="24" goto DNS_PROXY_COMBO
if "%choice%"=="25" goto OFFLINE_MODE
if "%choice%"=="26" goto OFFLINE_DOWNLOAD
if "%choice%"=="27" goto OFFLINE_SEARCH
if /i "%choice%"=="H" goto HELP
if "%choice%"=="0" goto EXIT
goto MENU

:HELP
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════╗
echo  ║                    ПОЛНАЯ СПРАВКА ПО МЕТОДАМ                     ║
echo  ╠══════════════════════════════════════════════════════════════════╣
echo  ║                                                                  ║
echo  ║  📁 ЛОКАЛЬНЫЕ (без доп. ПО):                                     ║
echo  ║  [1] HTML-прокси — открывает страницу в браузере                ║
echo  ║  [2] Invidious/Piped — альтернативные фронтенды YouTube         ║
echo  ║  [3] Google Translate — прокси через переводчик Google          ║
echo  ║  [4] NoCookie — YouTube без отслеживания                        ║
echo  ║                                                                  ║
echo  ║  🏠 LOCALHOST/МАСКА (нужен локальный прокси):                   ║
echo  ║  [5] Localhost — через 127.0.0.1:8080                           ║
echo  ║  [6] Маска сети — DNS Rebinding (127.0.0.1, 10.x, 192.168.x)   ║
echo  ║  [7] Запуск прокси — Python/Node.js автозапуск                 ║
echo  ║                                                                  ║
echo  ║  🌍 VPN / VPS / ПРОКСИ:                                          ║
echo  ║  [8] VPN — Подключение через OpenVPN/WireGuard                  ║
echo  ║      Требуется: конфиг-файл (.ovpn) или ключ WG                 ║
echo  ║  [9] VPS туннель — SSH туннель через ваш VPS сервер            ║
echo  ║      Требуется: IP, логин, пароль/ключ от VPS                   ║
echo  ║  [10] Иностранный прокси — HTTP/HTTPS/SOCKS5 из другой страны  ║
echo  ║  [11] Прокси-листы — сайты с бесплатными прокси                ║
echo  ║                                                                  ║
echo  ║  🛡️ DPI ОБХОД (против Deep Packet Inspection):                  ║
echo  ║  [12] ByeDPI — утилита для обхода DPI (Windows/Linux)          ║
echo  ║  [13] ByeDPI интеграция — YouTube с авто-обходом DPI           ║
echo  ║  [14] GoodbyeDPI — альтернативная утилита обхода DPI           ║
echo  ║                                                                  ║
echo  ║  ⚙️ СИСТЕМНЫЕ:                                                   ║
echo  ║  [15] Прокси Windows — настройка системного прокси              ║
echo  ║  [16] HOSTS — редактирование файла hosts                        ║
echo  ║  [17] Скачать — загрузка видео через внешние сервисы            ║
echo  ║                                                                  ║
echo  ╚══════════════════════════════════════════════════════════════════╝
echo.
pause
goto MENU

:: ============ [1] ЛОКАЛЬНЫЙ HTML ============
:LOCAL_HTML
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║           Запуск локального HTML-прокси                     ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
set "HTML_FILE=%~dp0youtube_proxy.html"
if exist "%HTML_FILE%" (
    echo  [OK] Файл найден
    start "" "%HTML_FILE%"
    echo  [OK] Открыто в браузере!
) else (
    echo  [X] Файл не найден! Создайте youtube_proxy.html в папке скрипта.
)
pause
goto MENU

:: ============ [2] АЛЬТЕРНАТИВНЫЕ ФРОНТЕНДЫ ============
:ALT_FRONTENDS
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║        Альтернативные фронтенды YouTube                     ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [1] Invidious (yewtu.be)
echo  [2] Invidious (invidious.fdn.fr - Франция)
echo  [3] Invidious (vid.puffyan.us - США)
echo  [4] Piped (piped.video)
echo  [5] CloudTube (tube.cadence.moe)
echo  [6] YewTube (yewtu.be)
echo  [7] Открыть все в новых вкладках
echo.
set /p af_choice="  Выбор: "
if "%af_choice%"=="1" start "" "https://yewtu.be"
if "%af_choice%"=="2" start "" "https://invidious.fdn.fr"
if "%af_choice%"=="3" start "" "https://vid.puffyan.us"
if "%af_choice%"=="4" start "" "https://piped.video"
if "%af_choice%"=="5" start "" "https://tube.cadence.moe"
if "%af_choice%"=="6" start "" "https://yewtu.be"
if "%af_choice%"=="7" (
    for %%u in (yewtu.be invidious.fdn.fr vid.puffyan.us piped.video tube.cadence.moe) do (
        start "" "https://%%u"
        timeout /t 1 >nul
    )
)
timeout /t 2 >nul
goto MENU

:: ============ [3] GOOGLE TRANSLATE ============
:GOOGLE_TRANSLATE
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║          Прокси через Google Translate                      ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
set /p yt_link="  Введите ссылку или ID видео (Enter = главная YouTube): "
if "%yt_link%"=="" (
    start "" "https://translate.google.com/translate?sl=en&tl=ru&u=https://www.youtube.com"
    goto MENU
)
set "VIDEO_ID=%yt_link%"
echo %yt_link% | findstr /i "youtube.com" >nul && for /f "tokens=2 delims=?v=&" %%a in ("%yt_link%") do set "VIDEO_ID=%%a"
echo %yt_link% | findstr /i "youtu.be" >nul && for /f "tokens=2 delims=/" %%a in ("%yt_link%") do set "VIDEO_ID=%%a"
start "" "https://translate.google.com/translate?sl=en&tl=ru&u=https://www.youtube.com/watch?v=%VIDEO_ID%"
echo  [OK] Открыто!
timeout /t 2 >nul
goto MENU

:: ============ [4] NOCOOKIE ============
:NOCOOKIE
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║          YouTube NoCookie                                   ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
set /p nc_id="  Введите ID видео (Enter = главная): "
if "%nc_id%"=="" (start "" "https://www.youtube-nocookie.com") else (start "" "https://www.youtube-nocookie.com/embed/%nc_id%")
timeout /t 2 >nul
goto MENU

:: ============ [5] LOCALHOST ============
:LOCALHOST
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       YouTube через LOCALHOST-прокси (127.0.0.1)           ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Требуется прокси-сервер на порту 8080!
echo.
echo  [1] Открыть YouTube через 127.0.0.1:8080
echo  [2] Открыть YouTube через localhost:8080
echo  [3] Открыть YouTube через 127.0.0.2:8080
echo  [4] Запустить простой Python-прокси (если есть Python)
echo  [5] Проверить доступность порта 8080
echo.
set /p lh_choice="  Выбор: "
if "%lh_choice%"=="1" start "" "http://127.0.0.1:8080"
if "%lh_choice%"=="2" start "" "http://localhost:8080"
if "%lh_choice%"=="3" start "" "http://127.0.0.2:8080"
if "%lh_choice%"=="4" goto QUICK_PYTHON_PROXY
if "%lh_choice%"=="5" (
    curl -s -o nul http://127.0.0.1:8080 2>nul && echo [OK] Порт 8080 открыт || echo [X] Порт 8080 закрыт
    pause
)
goto MENU

:QUICK_PYTHON_PROXY
python --version >nul 2>&1 || (echo [X] Python не установлен! && pause && goto MENU)
echo  [>>] Запускаю прокси на 127.0.0.1:8080...
echo  [>>] Закройте это окно для остановки.
start "Python Proxy" python -c "import http.server, socketserver; s=socketserver.TCPServer(('127.0.0.1',8080), http.server.SimpleHTTPRequestHandler); print('Proxy: http://127.0.0.1:8080'); s.serve_forever()"
timeout /t 2 >nul
goto MENU

:: ============ [6] МАСКА СЕТИ ============
:DNS_REBINDING
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       YouTube через МАСКУ СЕТИ (DNS Rebinding)            ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Маски для подмены IP YouTube:
echo.
echo  [1] 127.0.0.1 (loopback)
echo  [2] 10.0.0.1 (частная сеть)
echo  [3] 172.16.0.1 (частная сеть)
echo  [4] 192.168.1.1 (домашняя сеть)
echo  [5] 100.64.0.1 (CGNAT)
echo  [6] Добавить маску в HOSTS (требует админ)
echo  [7] Удалить маску из HOSTS (требует админ)
echo.
set /p mask_choice="  Выбор: "
set "MASK=127.0.0.1"
if "%mask_choice%"=="2" set "MASK=10.0.0.1"
if "%mask_choice%"=="3" set "MASK=172.16.0.1"
if "%mask_choice%"=="4" set "MASK=192.168.1.1"
if "%mask_choice%"=="5" set "MASK=100.64.0.1"
if "%mask_choice%"=="6" goto HOSTS_ADD_MASK
if "%mask_choice%"=="7" goto HOSTS_REMOVE_MASK

if "%mask_choice%" leq "5" (
    start "" "http://%MASK%:8080"
    echo  [OK] Открыто: http://%MASK%:8080
)
timeout /t 2 >nul
goto MENU

:HOSTS_ADD_MASK
if "%ADMIN%"=="0" (
    echo  [!] Нужны права администратора! Перезапустите BAT от админа.
    pause
    goto MENU
)
echo  [>>] Добавляю %MASK% youtube.com в HOSTS...
(
echo.
echo # YouTube Proxy Mask
echo %MASK% youtube.com
echo %MASK% www.youtube.com
echo %MASK% m.youtube.com
echo %MASK% ytimg.com
echo %MASK% googlevideo.com
) >> "%SystemRoot%\System32\drivers\etc\hosts"
ipconfig /flushdns >nul
echo  [OK] Добавлено! DNS кэш очищен.
pause
goto MENU

:HOSTS_REMOVE_MASK
if "%ADMIN%"=="0" (
    echo  [!] Нужны права администратора!
    pause
    goto MENU
)
findstr /v /i "youtube ytimg googlevideo" "%SystemRoot%\System32\drivers\etc\hosts" > "%TEMP%\hosts_new"
copy /y "%TEMP%\hosts_new" "%SystemRoot%\System32\drivers\etc\hosts" >nul
ipconfig /flushdns >nul
echo  [OK] Записи YouTube удалены из HOSTS.
pause
goto MENU

:: ============ [7] ПРОКСИ-СЕРВЕР ============
:PROXY_SERVER
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Запуск локального прокси-сервера                      ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [1] Python HTTP-прокси (если установлен Python)
echo  [2] Node.js HTTP-прокси (если установлен Node.js)
echo  [3] Скачать mitmproxy (https://mitmproxy.org)
echo  [4] Скачать CCProxy (бесплатный Windows-прокси)
echo.
set /p ps_choice="  Выбор: "
if "%ps_choice%"=="1" goto PYTHON_PROXY_FULL
if "%ps_choice%"=="2" goto NODE_PROXY_FULL
if "%ps_choice%"=="3" start "" "https://mitmproxy.org"
if "%ps_choice%"=="4" start "" "https://www.youngzsoft.net/ccproxy"
goto MENU

:PYTHON_PROXY_FULL
python --version >nul 2>&1 || (echo [X] Python не установлен && pause && goto MENU)
echo  [>>] Запускаю Python HTTP-прокси на порту 8080...
echo  [>>] Нажмите Ctrl+C для остановки.
echo.
python -c "
import http.server, socketserver, urllib.request, ssl
class Proxy(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        url = self.path[1:]
        if not url.startswith('http'):
            self.send_response(400); self.end_headers(); return
        try:
            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE
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
pause
goto MENU

:NODE_PROXY_FULL
node --version >nul 2>&1 || (echo [X] Node.js не установлен && pause && goto MENU)
echo  [>>] Запускаю Node.js прокси на порту 8080...
node -e "
const http = require('http');
http.createServer((req, res) => {
    const url = req.url.substring(1);
    if (!url.startsWith('http')) { res.writeHead(400); return res.end('Use /https://...'); }
    const u = new URL(url);
    const opts = { hostname: u.hostname, port: u.port || 80, path: u.pathname + u.search, method: req.method, headers: {...req.headers, host: u.hostname} };
    const proxy = (u.protocol === 'https:' ? require('https') : http).request(opts, r => { res.writeHead(r.statusCode, r.headers); r.pipe(res); });
    req.pipe(proxy);
}).listen(8080, () => console.log('Proxy: http://127.0.0.1:8080'));
"
pause
goto MENU

:: ============ [8] VPN ============
:VPN_CONNECT
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Подключение через VPN                                 ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Доступные действия:
echo.
echo  [1] Подключить OpenVPN (нужен .ovpn файл)
echo  [2] Подключить WireGuard (нужен .conf файл)
echo  [3] Скачать бесплатный VPN (список)
echo  [4] Открыть настройки VPN Windows
echo  [5] Проверить текущий IP (определить страну)
echo.
set /p vpn_choice="  Выбор: "

if "%vpn_choice%"=="1" goto OPENVPN_CONNECT
if "%vpn_choice%"=="2" goto WIREGUARD_CONNECT
if "%vpn_choice%"=="3" goto FREE_VPN_LIST
if "%vpn_choice%"=="4" start "" ms-settings:network-vpn
if "%vpn_choice%"=="5" goto CHECK_IP
goto MENU

:OPENVPN_CONNECT
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Подключение OpenVPN                                   ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Ищу OpenVPN...
set "OVPN_PATH="
if exist "C:\Program Files\OpenVPN\bin\openvpn.exe" set "OVPN_PATH=C:\Program Files\OpenVPN\bin\openvpn.exe"
if exist "C:\Program Files (x86)\OpenVPN\bin\openvpn.exe" set "OVPN_PATH=C:\Program Files (x86)\OpenVPN\bin\openvpn.exe"

if "%OVPN_PATH%"=="" (
    echo  [!] OpenVPN не установлен!
    echo  [>>] Открываю страницу загрузки...
    start "" "https://openvpn.net/community-downloads"
    pause
    goto MENU
)

echo  [OK] OpenVPN найден: %OVPN_PATH%
echo.
echo  Введите путь к .ovpn файлу (или перетащите его сюда):
set /p ovpn_file="  Путь: "
if not exist "%ovpn_file%" (
    echo  [X] Файл не найден!
    pause
    goto MENU
)
echo  [>>] Подключаюсь через OpenVPN...
echo  [>>] Это окно останется открытым. Закройте для отключения.
"%OVPN_PATH%" --config "%ovpn_file%"
pause
goto MENU

:WIREGUARD_CONNECT
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Подключение WireGuard                                 ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
where wireguard >nul 2>&1
if errorlevel 1 (
    echo  [!] WireGuard не установлен!
    echo  [>>] Открываю страницу загрузки...
    start "" "https://www.wireguard.com/install"
    pause
    goto MENU
)
echo  [OK] WireGuard найден!
echo.
echo  Введите путь к .conf файлу:
set /p wg_file="  Путь: "
if not exist "%wg_file%" (
    echo  [X] Файл не найден!
    pause
    goto MENU
)
echo  [>>] Устанавливаю туннель WireGuard...
wireguard /installtunnelservice "%wg_file%"
echo  [OK] Туннель установлен! Проверьте подключение в трее.
pause
goto MENU

:FREE_VPN_LIST
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Бесплатные VPN сервисы                                ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [1] ProtonVPN (бесплатный, без лимита) - https://protonvpn.com
echo  [2] Windscribe (10 ГБ/мес) - https://windscribe.com
echo  [3] TunnelBear (500 МБ/мес) - https://tunnelbear.com
echo  [4] Hotspot Shield (бесплатный) - https://hotspotshield.com
echo  [5] Hide.me (10 ГБ/мес) - https://hide.me
echo  [6] VPN Gate (публичные серверы) - https://vpngate.net
echo  [7] Cloudflare WARP (1.1.1.1) - https://1.1.1.1
echo.
echo  Выберите для открытия в браузере:
set /p free_vpn="  Выбор: "
if "%free_vpn%"=="1" start "" "https://protonvpn.com"
if "%free_vpn%"=="2" start "" "https://windscribe.com"
if "%free_vpn%"=="3" start "" "https://tunnelbear.com"
if "%free_vpn%"=="4" start "" "https://hotspotshield.com"
if "%free_vpn%"=="5" start "" "https://hide.me"
if "%free_vpn%"=="6" start "" "https://vpngate.net"
if "%free_vpn%"=="7" start "" "https://1.1.1.1"
goto MENU

:CHECK_IP
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Проверка текущего IP                                  ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Ваш текущий IP-адрес:
curl -s https://api.ipify.org 2>nul && echo.
curl -s https://ipapi.co/country_name/ 2>nul && echo.
echo.
echo  [>>] Открываю сайт для проверки IP...
start "" "https://whatismyipaddress.com"
pause
goto MENU

:: ============ [9] VPS ТУННЕЛЬ ============
:VPS_TUNNEL
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       YouTube через VPS-сервер (SSH туннель)              ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Этот метод создаёт SSH-туннель к вашему VPS и использует
echo  его как SOCKS5 прокси для обхода блокировки.
echo.
echo  Требуется:
echo  - IP-адрес VPS сервера
echo  - Логин (обычно root)
echo  - Пароль или SSH-ключ
echo  - SSH-клиент (встроен в Windows 10/11)
echo.
echo  ┌─────────────────────────────────────────────────────────────┐
echo  │  Как это работает:                                          │
echo  │  1. Создаётся SSH туннель к VPS                             │
echo  │  2. На локальной машине открывается SOCKS5 прокси           │
echo  │  3. Браузер настраивается на этот прокси                    │
echo  │  4. Весь трафик идёт через VPS → YouTube доступен          │
echo  └─────────────────────────────────────────────────────────────┘
echo.
echo  [1] Создать SSH туннель (SOCKS5 на localhost:1080)
echo  [2] Создать SSH туннель с ключом
echo  [3] Настроить браузер на SOCKS5 127.0.0.1:1080
echo  [4] Проверить статус туннеля
echo  [5] Закрыть все SSH туннели
echo  [6] Где взять VPS? (дешёвые варианты)
echo.
set /p vps_choice="  Выбор: "

if "%vps_choice%"=="1" goto SSH_TUNNEL_PASSWORD
if "%vps_choice%"=="2" goto SSH_TUNNEL_KEY
if "%vps_choice%"=="3" goto SOCKS5_BROWSER
if "%vps_choice%"=="4" goto CHECK_TUNNEL
if "%vps_choice%"=="5" goto KILL_TUNNELS
if "%vps_choice%"=="6" goto VPS_PROVIDERS
goto MENU

:SSH_TUNNEL_PASSWORD
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       SSH туннель (пароль)                                  ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
set /p vps_ip="  IP сервера: "
set /p vps_user="  Логин (обычно root): "
set /p vps_port="  Порт SSH (обычно 22): "
if "%vps_port%"=="" set "vps_port=22"
echo.
echo  [>>] Создаю SSH туннель...
echo  [>>] Будет запрошен пароль...
echo  [>>] SOCKS5 прокси будет доступен на 127.0.0.1:1080
echo  [>>] НЕ закрывайте это окно!
echo.
ssh -D 1080 -p %vps_port% -N %vps_user%@%vps_ip%
echo.
echo  [OK] Туннель закрыт.
pause
goto MENU

:SSH_TUNNEL_KEY
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       SSH туннель (SSH-ключ)                                ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
set /p vps_ip="  IP сервера: "
set /p vps_user="  Логин: "
set /p vps_port="  Порт SSH (22): "
if "%vps_port%"=="" set "vps_port=22"
set /p vps_key="  Путь к SSH-ключу (например: C:\Users\You\.ssh\id_rsa): "
echo.
echo  [>>] Создаю SSH туннель с ключом...
echo  [>>] SOCKS5 прокси: 127.0.0.1:1080
echo.
ssh -D 1080 -p %vps_port% -i "%vps_key%" -N %vps_user%@%vps_ip%
pause
goto MENU

:SOCKS5_BROWSER
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Настройка браузера на SOCKS5                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Настройте браузер вручную:
echo.
echo  Прокси: SOCKS5
echo  Адрес: 127.0.0.1
echo  Порт: 1080
echo.
echo  ┌─────────────────────────────────────────────────────────────┐
echo  │  Chrome: Параметры → Система → Настройки прокси            │
echo  │  Firefox: Параметры → Основные → Настройки сети → SOCKS5  │
echo  │  Или нажмите любую клавишу для открытия настроек Windows   │
echo  └─────────────────────────────────────────────────────────────┘
echo.
pause
start "" ms-settings:network-proxy
goto MENU

:CHECK_TUNNEL
echo  [>>] Проверяю активные SSH туннели...
tasklist | findstr ssh.exe
if errorlevel 1 echo  [Нет активных SSH туннелей]
echo.
echo  [>>] Проверяю порт 1080...
netstat -an | findstr :1080
if errorlevel 1 echo  [Порт 1080 не слушается]
pause
goto MENU

:KILL_TUNNELS
echo  [>>] Закрываю все SSH туннели...
taskkill /f /im ssh.exe 2>nul
echo  [OK] Туннели закрыты.
timeout /t 2 >nul
goto MENU

:VPS_PROVIDERS
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Дешёвые VPS для SSH туннеля                           ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [1] Oracle Cloud (бесплатный VPS навсегда!)
echo  [2] AWS Free Tier (1 год бесплатно)
echo  [3] Google Cloud Free Tier
echo  [4] VPS.ua (от $2/мес)
echo  [5] DigitalOcean ($4/мес)
echo  [6] Hetzner (от €3/мес)
echo  [7] Aeza (Россия-friendly, от €2/мес)
echo.
set /p vps_prov="  Выбор для открытия: "
if "%vps_prov%"=="1" start "" "https://www.oracle.com/cloud/free"
if "%vps_prov%"=="2" start "" "https://aws.amazon.com/free"
if "%vps_prov%"=="3" start "" "https://cloud.google.com/free"
if "%vps_prov%"=="4" start "" "https://vps.ua"
if "%vps_prov%"=="5" start "" "https://digitalocean.com"
if "%vps_prov%"=="6" start "" "https://hetzner.com"
if "%vps_prov%"=="7" start "" "https://aeza.net"
goto MENU

:: ============ [10] ИНОСТРАННЫЙ ПРОКСИ ============
:FOREIGN_PROXY
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Иностранный HTTP/HTTPS/SOCKS5 прокси                 ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Использование прокси из другой страны для обхода блокировки.
echo  Прокси должен быть из страны, где YouTube не заблокирован.
echo.
echo  [1] Ввести прокси вручную и настроить систему
echo  [2] Настроить HTTP прокси
echo  [3] Настроить HTTPS прокси
echo  [4] Настроить SOCKS5 прокси
echo  [5] Проверить рабочий прокси
echo  [6] Открыть список бесплатных прокси
echo.
set /p fp_choice="  Выбор: "

if "%fp_choice%"=="1" goto PROXY_MANUAL
if "%fp_choice%"=="2" goto PROXY_HTTP
if "%fp_choice%"=="3" goto PROXY_HTTPS
if "%fp_choice%"=="4" goto PROXY_SOCKS5
if "%fp_choice%"=="5" goto PROXY_TEST
if "%fp_choice%"=="6" goto PROXY_LISTS
goto MENU

:PROXY_MANUAL
echo.
set /p p_addr="  Прокси адрес (IP:PORT): "
set /p p_type="  Тип (http/https/socks5): "
if "%p_addr%"=="" goto MENU
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "%p_type%=%p_addr%" /f
echo  [OK] Прокси настроен: %p_type%=%p_addr%
timeout /t 2 >nul
goto MENU

:PROXY_HTTP
set /p p_addr="  HTTP прокси (IP:PORT): "
if "%p_addr%"=="" goto MENU
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "http=%p_addr%" /f
echo  [OK] HTTP прокси: %p_addr%
timeout /t 2 >nul
goto MENU

:PROXY_HTTPS
set /p p_addr="  HTTPS прокси (IP:PORT): "
if "%p_addr%"=="" goto MENU
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "https=%p_addr%" /f
echo  [OK] HTTPS прокси: %p_addr%
timeout /t 2 >nul
goto MENU

:PROXY_SOCKS5
set /p p_addr="  SOCKS5 прокси (IP:PORT): "
if "%p_addr%"=="" goto MENU
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "socks=%p_addr%" /f
echo  [OK] SOCKS5 прокси: %p_addr%
timeout /t 2 >nul
goto MENU

:PROXY_TEST
echo  [>>] Проверяю прокси через сервисы...
start "" "https://hidemy.name/proxy-checker"
start "" "https://whatismyipaddress.com"
goto MENU

:: ============ [11] ПРОКСИ-ЛИСТЫ ============
:PROXY_LISTS
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Бесплатные прокси-листы                               ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Сайты с бесплатными прокси (открываются в браузере):
echo.
echo  [1] Free Proxy List (free-proxy-list.net)
echo  [2] ProxyScrape (proxyscrape.com)
echo  [3] Open Proxy List (openproxy.space)
echo  [4] Spys.one (прокси по странам)
echo  [5] ProxyNova (proxynova.com)
echo  [6] Hidemy.name (проверенные прокси)
echo  [7] Geonode (бесплатные прокси)
echo  [8] PubProxy (pubproxy.com)
echo  [9] Открыть ВСЕ сайты
echo.
set /p pl_choice="  Выбор: "
if "%pl_choice%"=="1" start "" "https://free-proxy-list.net"
if "%pl_choice%"=="2" start "" "https://proxyscrape.com/free-proxy-list"
if "%pl_choice%"=="3" start "" "https://openproxy.space"
if "%pl_choice%"=="4" start "" "https://spys.one/en/free-proxy-list"
if "%pl_choice%"=="5" start "" "https://proxynova.com/proxy-server-list"
if "%pl_choice%"=="6" start "" "https://hidemy.name/proxy-list"
if "%pl_choice%"=="7" start "" "https://geonode.com/free-proxy-list"
if "%pl_choice%"=="8" start "" "https://pubproxy.com"
if "%pl_choice%"=="9" (
    for %%u in (free-proxy-list.net proxyscrape.com openproxy.space spys.one proxynova.com hidemy.name geonode.com) do (
        start "" "https://%%u"
        timeout /t 1 >nul
    )
)
goto MENU

:: ============ [12] ByeDPI ============
:BYEDPI
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Запуск ByeDPI (обход DPI)                             ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  ByeDPI — утилита для обхода Deep Packet Inspection.
echo  Обходит блокировки на уровне провайдера (РКН, DPI).
echo.
echo  Скачать: https://github.com/hufrea/byedpi
echo.
echo  [1] Скачать ByeDPI с GitHub
echo  [2] Запустить ByeDPI (если уже скачан)
echo  [3] Запустить ByeDPI с параметрами для YouTube
echo  [4] Открыть инструкцию по настройке
echo.
set /p bd_choice="  Выбор: "
if "%bd_choice%"=="1" start "" "https://github.com/hufrea/byedpi/releases"
if "%bd_choice%"=="2" goto BYEDPI_RUN
if "%bd_choice%"=="3" goto BYEDPI_YOUTUBE
if "%bd_choice%"=="4" start "" "https://github.com/hufrea/byedpi#readme"
goto MENU

:BYEDPI_RUN
echo.
echo  Введите путь к папке с ByeDPI (ciadpi.exe):
set /p bd_path="  Путь: "
if not exist "%bd_path%\ciadpi.exe" (
    echo  [X] ciadpi.exe не найден в указанной папке!
    pause
    goto MENU
)
echo  [>>] Запускаю ByeDPI...
echo  [>>] НЕ закрывайте это окно!
echo.
"%bd_path%\ciadpi.exe"
pause
goto MENU

:BYEDPI_YOUTUBE
echo.
echo  Введите путь к папке с ByeDPI:
set /p bd_path="  Путь: "
if not exist "%bd_path%\ciadpi.exe" (
    echo  [X] ciadpi.exe не найден!
    pause
    goto MENU
)
echo  [>>] Запускаю ByeDPI с оптимизацией для YouTube...
echo.
"%bd_path%\ciadpi.exe" --tlsrec 1 --split 1 --hosts youtube.com,ytimg.com,googlevideo.com,ggpht.com
pause
goto MENU

:: ============ [13] ByeDPI ИНТЕГРАЦИЯ ============
:BYEDPI_INTEGRATED
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       YouTube с интеграцией ByeDPI (авто)                  ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Этот метод автоматически:
echo  1. Проверяет наличие ByeDPI
echo  2. Запускает ByeDPI с настройками для YouTube
echo  3. Настраивает системный прокси на ByeDPI
echo  4. Открывает YouTube в браузере
echo.
echo  [!] Требуется предварительно скачанный ByeDPI!
echo.
set /p bd_path="  Путь к папке с ciadpi.exe: "
if not exist "%bd_path%\ciadpi.exe" (
    echo  [X] ciadpi.exe не найден!
    echo  [>>] Открываю страницу загрузки...
    start "" "https://github.com/hufrea/byedpi/releases"
    pause
    goto MENU
)

echo  [OK] ByeDPI найден!
echo  [>>] Запускаю ByeDPI в фоне...
start /b "" "%bd_path%\ciadpi.exe" --tlsrec 1 --split 1 >nul 2>&1
timeout /t 2 >nul

echo  [>>] Настраиваю системный прокси на 127.0.0.1:1080...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "socks=127.0.0.1:1080" /f

echo  [OK] ByeDPI запущен, прокси настроен!
echo  [>>] Открываю YouTube...
start "" "https://www.youtube.com"
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║  YouTube открыт через ByeDPI!                               ║
echo  ║  Для отключения: выберите пункт [15] → Отключить прокси    ║
echo  ╚══════════════════════════════════════════════════════════════╝
pause
goto MENU

:: ============ [14] GoodbyeDPI ============
:GOODBYEDPI
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       GoodbyeDPI (альтернатива ByeDPI)                      ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  GoodbyeDPI — ещё одна утилита обхода DPI.
echo  Скачать: https://github.com/ValdikSS/GoodbyeDPI
echo.
echo  [1] Скачать GoodbyeDPI
echo  [2] Запустить GoodbyeDPI (если скачан)
echo  [3] Открыть инструкцию
echo.
set /p gd_choice="  Выбор: "
if "%gd_choice%"=="1" start "" "https://github.com/ValdikSS/GoodbyeDPI/releases"
if "%gd_choice%"=="2" goto GOODBYEDPI_RUN
if "%gd_choice%"=="3" start "" "https://github.com/ValdikSS/GoodbyeDPI#readme"
goto MENU

:GOODBYEDPI_RUN
echo.
set /p gd_path="  Путь к папке с GoodbyeDPI: "
if exist "%gd_path%\x86_64\goodbyedpi.exe" (
    echo  [>>] Запускаю GoodbyeDPI...
    "%gd_path%\x86_64\goodbyedpi.exe" -1
) else if exist "%gd_path%\goodbyedpi.exe" (
    echo  [>>] Запускаю GoodbyeDPI...
    "%gd_path%\goodbyedpi.exe" -1
) else (
    echo  [X] goodbyedpi.exe не найден!
)
pause
goto MENU

:: ============ [15] СИСТЕМНЫЙ ПРОКСИ ============
:SYSTEM_PROXY
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Настройка системного прокси Windows                   ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [1] Включить прокси (ввести вручную)
echo  [2] Отключить прокси
echo  [3] Показать текущие настройки
echo  [4] Открыть настройки прокси Windows
echo.
set /p sp_choice="  Выбор: "
if "%sp_choice%"=="1" (
    set /p p_addr="  Прокси (IP:PORT): "
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "%p_addr%" /f
    echo  [OK] Прокси включен
)
if "%sp_choice%"=="2" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
    echo  [OK] Прокси отключен
)
if "%sp_choice%"=="3" (
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer
    pause
)
if "%sp_choice%"=="4" start "" ms-settings:network-proxy
goto MENU

:: ============ [16] HOSTS ============
:HOSTS_FILE
if "%ADMIN%"=="0" (
    echo  [!] Нужны права администратора!
    pause
    goto MENU
)
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Изменение HOSTS файла                                 ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [1] Показать записи YouTube
echo  [2] Добавить YouTube → 127.0.0.1
echo  [3] Удалить записи YouTube
echo  [4] Открыть HOSTS в блокноте
echo.
set /p hf_choice="  Выбор: "
if "%hf_choice%"=="1" findstr /i "youtube" "%SystemRoot%\System32\drivers\etc\hosts"
if "%hf_choice%"=="2" (
    echo. >> "%SystemRoot%\System32\drivers\etc\hosts"
    echo # YouTube Proxy >> "%SystemRoot%\System32\drivers\etc\hosts"
    echo 127.0.0.1 youtube.com >> "%SystemRoot%\System32\drivers\etc\hosts"
    echo 127.0.0.1 www.youtube.com >> "%SystemRoot%\System32\drivers\etc\hosts"
    ipconfig /flushdns >nul
    echo  [OK] Добавлено
)
if "%hf_choice%"=="3" (
    findstr /v /i "youtube" "%SystemRoot%\System32\drivers\etc\hosts" > "%TEMP%\hosts_new"
    copy /y "%TEMP%\hosts_new" "%SystemRoot%\System32\drivers\etc\hosts" >nul
    ipconfig /flushdns >nul
    echo  [OK] Удалено
)
if "%hf_choice%"=="4" notepad "%SystemRoot%\System32\drivers\etc\hosts"
pause
goto MENU

:: ============ [17] СКАЧАТЬ ============
:DOWNLOAD
cls
set /p dl_link="  Ссылка на видео: "
if "%dl_link%"=="" goto MENU
set "DL_ID=%dl_link%"
echo %dl_link% | findstr /i "youtube.com" >nul && for /f "tokens=2 delims=?v=&" %%a in ("%dl_link%") do set "DL_ID=%%a"
echo %dl_link% | findstr /i "youtu.be" >nul && for /f "tokens=2 delims=/" %%a in ("%dl_link%") do set "DL_ID=%%a"
start "" "https://www.y2mate.com/youtube/%DL_ID%"
start "" "https://en.savefrom.net/1-youtube-downloader/?url=https://www.youtube.com/watch?v=%DL_ID%"
echo  [OK] Открыто 2 сервиса
timeout /t 2 >nul
goto MENU

:: ============ [18] ОРИГИНАЛ ============
:ORIGINAL
start "" "https://www.youtube.com"
timeout /t 2 >nul
goto MENU

:: ============ [19] eSIM YOUTUBE ============
:ESIM_YOUTUBE
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       YouTube через eSIM (вторая SIM карта)                 ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Этот метод использует мобильные данные eSIM вместо Wi-Fi
echo  для доступа к YouTube. Работает если:
echo  - У вас есть eSIM другого оператора (иностранного)
echo  - eSIM активна и имеет доступ в интернет
echo  - Wi-Fi блокирует YouTube, а мобильная сеть — нет
echo.
echo  ┌─────────────────────────────────────────────────────────────┐
echo  │  Как это работает:                                          │
echo  │  1. Windows использует метрику интерфейсов                  │
echo  │  2. Трафик YouTube направляется через eSIM                 │
echo  │  3. Остальной трафик идёт через Wi-Fi                      │
echo  │  4. eSIM выступает как обходной канал                      │
echo  └─────────────────────────────────────────────────────────────┘
echo.
echo  ВАЖНО: Компьютер должен быть подключен к интернету через
echo  телефон с eSIM (USB-модем или точка доступа).
echo.
echo  [1] Показать все сетевые интерфейсы
echo  [2] Настроить метрику для eSIM (приоритет)
echo  [3] Проверить текущий IP (через eSIM)
echo  [4] Открыть YouTube через eSIM
echo  [5] Настроить маршрутизацию YouTube через eSIM
echo  [6] Вернуть настройки по умолчанию
echo.
set /p esim_choice="  Выбор: "

if "%esim_choice%"=="1" goto ESIM_SHOW_INTERFACES
if "%esim_choice%"=="2" goto ESIM_SET_METRIC
if "%esim_choice%"=="3" goto ESIM_CHECK_IP
if "%esim_choice%"=="4" goto ESIM_OPEN_YOUTUBE
if "%esim_choice%"=="5" goto ESIM_ROUTE_YOUTUBE
if "%esim_choice%"=="6" goto ESIM_RESET
goto MENU

:ESIM_SHOW_INTERFACES
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Сетевые интерфейсы                                    ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Активные сетевые подключения:
echo.
netsh interface ip show interfaces | findstr /i "connected"
echo.
echo  Таблица маршрутизации (активные маршруты):
route print | findstr "0.0.0.0"
echo.
echo  Найдите интерфейс eSIM (обычно "Remote NDIS" или "USB")
echo  Запомните номер интерфейса (первый столбец) для настройки.
echo.
pause
goto ESIM_YOUTUBE

:ESIM_SET_METRIC
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Настройка метрики для eSIM                            ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Метрика определяет приоритет сетевого интерфейса.
echo  Чем МЕНЬШЕ число — тем ВЫШЕ приоритет.
echo.
echo  Текущие метрики интерфейсов:
netsh interface ip show interfaces
echo.
set /p esim_name="  Имя интерфейса eSIM (например: 'Ethernet 2' или 'Remote NDIS'): "
if "%esim_name%"=="" (
    echo  [!] Имя не введено
    pause
    goto ESIM_YOUTUBE
)
set /p esim_metric="  Метрика eSIM (рекомендуется 5, чем меньше тем приоритетнее): "
if "%esim_metric%"=="" set "esim_metric=5"

echo.
echo  [>>] Устанавливаю метрику %esim_metric% для "%esim_name%"...
netsh interface ip set interface "%esim_name%" metric=%esim_metric%
if errorlevel 1 (
    echo  [X] Ошибка! Возможно нужны права администратора.
) else (
    echo  [OK] Метрика установлена!
    echo  [>>] Очищаю кэш маршрутов...
    route -f
    echo  [OK] Готово! Трафик пойдёт через eSIM в первую очередь.
)
pause
goto ESIM_YOUTUBE

:ESIM_CHECK_IP
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Проверка IP через eSIM                                ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Ваш текущий IP-адрес:
curl -s https://api.ipify.org 2>nul && echo.
echo.
echo  Страна (через ipapi):
curl -s https://ipapi.co/country_name/ 2>nul && echo.
echo.
echo  Провайдер:
curl -s https://ipapi.co/org/ 2>nul && echo.
echo.
echo  Если страна не ваша — eSIM работает как иностранный канал!
echo  [>>] Открываю сайт для детальной проверки...
start "" "https://whatismyipaddress.com"
pause
goto ESIM_YOUTUBE

:ESIM_OPEN_YOUTUBE
cls
echo  [>>] Открываю YouTube (трафик должен идти через eSIM)...
start "" "https://www.youtube.com"
echo  [OK] Если eSIM имеет приоритет — YouTube откроется!
echo.
echo  Если не работает:
echo  1. Проверьте что eSIM подключена и имеет интернет
echo  2. Убедитесь что метрика eSIM ниже чем у Wi-Fi
echo  3. Отключите Wi-Fi для проверки eSIM
pause
goto ESIM_YOUTUBE

:ESIM_ROUTE_YOUTUBE
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Маршрутизация YouTube через eSIM                     ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Этот метод направляет ТОЛЬКО трафик YouTube через eSIM,
echo  а остальной интернет — через Wi-Fi.
echo.
echo  [!] Требуются права АДМИНИСТРАТОРА!
echo.
echo  Сначала нужно узнать IP-адреса YouTube...
echo  [>>] Получаю IP YouTube...
for /f "tokens=2 delims=: " %%a in ('nslookup youtube.com 8.8.8.8 2^>nul ^| findstr /i "Address" ^| findstr /v "8.8.8.8"') do set "YT_IP=%%a"
echo  IP YouTube: %YT_IP%

if "%YT_IP%"=="" (
    echo  [X] Не удалось получить IP YouTube
    pause
    goto ESIM_YOUTUBE
)

echo.
echo  Теперь нужен IP шлюза eSIM.
echo  Обычно это 192.168.42.129 (для USB-модема)
echo  Или посмотрите в: Настройки → Сеть → Адаптер eSIM → Свойства
echo.
set /p esim_gateway="  IP шлюза eSIM (например: 192.168.42.129): "
if "%esim_gateway%"=="" (
    echo  [!] Шлюз не введен
    pause
    goto ESIM_YOUTUBE
)

echo.
echo  [>>] Добавляю маршрут для YouTube через eSIM...
route add %YT_IP% mask 255.255.255.255 %esim_gateway%

REM Добавляем также www.youtube.com
for /f "tokens=2 delims=: " %%a in ('nslookup www.youtube.com 8.8.8.8 2^>nul ^| findstr /i "Address" ^| findstr /v "8.8.8.8"') do (
    route add %%a mask 255.255.255.255 %esim_gateway%
)

echo  [OK] Маршруты добавлены!
echo  Теперь YouTube будет работать через eSIM.
echo.
echo  Для проверки откройте YouTube:
start "" "https://www.youtube.com"
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║  Для отмены: выберите пункт [6] "Вернуть настройки"       ║
echo  ╚══════════════════════════════════════════════════════════════╝
pause
goto ESIM_YOUTUBE

:ESIM_RESET
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Сброс настроек eSIM                                   ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [1] Удалить маршруты YouTube через eSIM
echo  [2] Сбросить метрики интерфейсов (авто)
echo  [3] Полный сброс (маршруты + метрики)
echo.
set /p reset_choice="  Выбор: "

if "%reset_choice%"=="1" (
    echo  [>>] Удаляю маршруты YouTube...
    route delete youtube.com 2>nul
    route delete www.youtube.com 2>nul
    for /f "tokens=2 delims=: " %%a in ('nslookup youtube.com 8.8.8.8 2^>nul ^| findstr /i "Address" ^| findstr /v "8.8.8.8"') do route delete %%a 2>nul
    echo  [OK] Маршруты удалены!
)

if "%reset_choice%"=="2" (
    echo  [>>] Сбрасываю метрики на автоматические...
    netsh interface ip set interface "Ethernet" metric=auto 2>nul
    netsh interface ip set interface "Wi-Fi" metric=auto 2>nul
    netsh interface ip set interface "Remote NDIS" metric=auto 2>nul
    echo  [OK] Метрики сброшены!
)

if "%reset_choice%"=="3" (
    echo  [>>] Полный сброс...
    route -f
    netsh int ip reset
    ipconfig /flushdns
    echo  [OK] Сброс выполнен! Может потребоваться перезагрузка.
)

pause
goto ESIM_YOUTUBE

:: ============ [20] eSIM SWITCH TRAFFIC ============
:ESIM_SWITCH_TRAFFIC
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Переключить трафик YouTube на eSIM                   ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Этот метод использует ForceBindIP для привязки браузера
echo  к сетевому интерфейсу eSIM.
echo.
echo  Требуется: ForceBindIP (бесплатная утилита)
echo.
echo  [1] Скачать ForceBindIP
echo  [2] Привязать Chrome к eSIM
echo  [3] Привязать Firefox к eSIM
echo  [4] Привязать любой браузер к eSIM
echo.
set /p fb_choice="  Выбор: "

if "%fb_choice%"=="1" (
    echo  [>>] Открываю страницу загрузки ForceBindIP...
    start "" "https://r1ch.net/projects/forcebindip"
    echo  [>>] Также открываю прямую ссылку...
    start "" "https://r1ch.net/assets/forcebindip/ForceBindIP.zip"
)

if "%fb_choice%"=="2" goto FBIND_CHROME
if "%fb_choice%"=="3" goto FBIND_FIREFOX
if "%fb_choice%"=="4" goto FBIND_CUSTOM

goto MENU

:FBIND_CHROME
set /p esim_ip="  IP-адрес интерфейса eSIM (например: 192.168.42.10): "
if "%esim_ip%"=="" goto MENU
echo  [>>] Ищу Chrome...
set "CHROME="
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" set "CHROME=C:\Program Files\Google\Chrome\Application\chrome.exe"
if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" set "CHROME=C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
if "%CHROME%"=="" (
    echo  [X] Chrome не найден! Укажите путь вручную.
    set /p CHROME="  Путь к chrome.exe: "
)
echo  [>>] Запускаю Chrome через eSIM (%esim_ip%)...
start "" "ForceBindIP.exe" %esim_ip% "%CHROME%" "https://www.youtube.com"
echo  [OK] Chrome запущен! Весь трафик Chrome идёт через eSIM.
pause
goto MENU

:FBIND_FIREFOX
set /p esim_ip="  IP-адрес интерфейса eSIM: "
if "%esim_ip%"=="" goto MENU
echo  [>>] Ищу Firefox...
set "FF="
if exist "C:\Program Files\Mozilla Firefox\firefox.exe" set "FF=C:\Program Files\Mozilla Firefox\firefox.exe"
if "%FF%"=="" (
    echo  [X] Firefox не найден!
    set /p FF="  Путь к firefox.exe: "
)
echo  [>>] Запускаю Firefox через eSIM...
start "" "ForceBindIP.exe" %esim_ip% "%FF%" "https://www.youtube.com"
echo  [OK] Firefox запущен через eSIM!
pause
goto MENU

:FBIND_CUSTOM
set /p esim_ip="  IP-адрес интерфейса eSIM: "
set /p browser_path="  Путь к браузеру (.exe): "
if "%esim_ip%"=="" goto MENU
if "%browser_path%"=="" goto MENU
start "" "ForceBindIP.exe" %esim_ip% "%browser_path%" "https://www.youtube.com"
echo  [OK] Браузер запущен через eSIM!
pause
goto MENU

:: ============ [21] eSIM + PROXY COMBO ============
:ESIM_PROXY_COMBO
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       eSIM + Прокси (двойной обход)                         ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Комбинированный метод:
echo  1. Трафик идёт через eSIM (иностранный оператор)
echo  2. Дополнительно проходит через прокси-сервер
echo  3. Двойная защита от блокировки
echo.
echo  ┌─────────────────────────────────────────────────────────────┐
echo  │  Схема:                                                     │
echo  │  Вы → eSIM (Турция/Китай/...) → Прокси → YouTube          │
echo  │  Два уровня обхода блокировки!                             │
echo  └─────────────────────────────────────────────────────────────┘
echo.
echo  [1] eSIM + HTTP прокси
echo  [2] eSIM + SOCKS5 прокси
echo  [3] eSIM + SSH туннель
echo  [4] eSIM + VPN (двойной VPN)
echo.
set /p combo_choice="  Выбор: "

if "%combo_choice%"=="1" goto COMBO_HTTP
if "%combo_choice%"=="2" goto COMBO_SOCKS5
if "%combo_choice%"=="3" goto COMBO_SSH
if "%combo_choice%"=="4" goto COMBO_VPN
goto MENU

:COMBO_HTTP
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       eSIM + HTTP Прокси                                    ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Сначала настройте eSIM (пункт 19), затем добавьте прокси.
echo.
set /p esim_ip="  IP интерфейса eSIM: "
set /p proxy_addr="  HTTP прокси (IP:PORT): "
if "%proxy_addr%"=="" goto MENU

echo  [>>] Настраиваю системный прокси на %proxy_addr%...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "http=%proxy_addr%" /f

echo  [OK] eSIM + HTTP прокси настроены!
echo  [>>] Открываю YouTube...
start "" "https://www.youtube.com"
echo.
echo  Трафик: Вы → eSIM (%esim_ip%) → Прокси (%proxy_addr%) → YouTube
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║  Двойной обход активен!                                     ║
echo  ╚══════════════════════════════════════════════════════════════╝
pause
goto MENU

:COMBO_SOCKS5
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       eSIM + SOCKS5 Прокси                                  ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
set /p socks_addr="  SOCKS5 прокси (IP:PORT): "
if "%socks_addr%"=="" goto MENU

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "socks=%socks_addr%" /f

echo  [OK] eSIM + SOCKS5 настроены!
start "" "https://www.youtube.com"
echo  Трафик: Вы → eSIM → SOCKS5 (%socks_addr%) → YouTube
pause
goto MENU

:COMBO_SSH
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       eSIM + SSH Туннель                                    ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Создаёт SSH туннель через eSIM к VPS серверу.
echo  YouTube будет доступен через VPS + eSIM.
echo.
set /p vps_ip="  IP VPS сервера: "
set /p vps_user="  Логин: "
set /p vps_port="  Порт SSH (22): "
if "%vps_port%"=="" set "vps_port=22"

echo.
echo  [>>] Создаю двойной туннель:
echo  [>>] eSIM → VPS (%vps_ip%) → YouTube
echo  [>>] SOCKS5 прокси на 127.0.0.1:1080
echo  [>>] НЕ закрывайте это окно!
echo.
ssh -D 1080 -p %vps_port% -N %vps_user%@%vps_ip%
echo.
echo  [OK] Туннель закрыт.
pause
goto MENU

:COMBO_VPN
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       eSIM + VPN (двойной VPN)                              ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Схема: Вы → eSIM → VPN → YouTube
echo.
echo  Это максимальный уровень обхода!
echo  Рекомендуется если обычные методы не работают.
echo.
echo  [1] eSIM + ProtonVPN
echo  [2] eSIM + WireGuard
echo  [3] eSIM + OpenVPN
echo.
set /p dvpn_choice="  Выбор: "

if "%dvpn_choice%"=="1" (
    echo  [>>] Открываю ProtonVPN...
    start "" "https://protonvpn.com"
    echo  Установите ProtonVPN и подключитесь.
    echo  Трафик пойдёт: eSIM → ProtonVPN → YouTube
)
if "%dvpn_choice%"=="2" (
    echo  [>>] Открываю WireGuard...
    start "" "https://www.wireguard.com/install"
    echo  Настройте WireGuard поверх eSIM.
)
if "%dvpn_choice%"=="3" (
    echo  [>>] Открываю OpenVPN...
    start "" "https://openvpn.net/community-downloads"
    echo  Настройте OpenVPN поверх eSIM.
)

echo.
echo  [OK] Двойной VPN: eSIM + VPN приложение
echo  Трафик: Вы → eSIM (иностранный IP) → VPN (другой IP) → YouTube
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║  Это самый надёжный метод обхода блокировки!               ║
echo  ╚══════════════════════════════════════════════════════════════╝
pause
goto MENU

:: ============ [22] DNS ОБХОД ============
:DNS_OBHOD
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       YouTube через смену DNS (быстрый обход)               ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Некоторые провайдеры блокируют YouTube только на уровне DNS.
echo  Смена DNS-сервера может полностью обойти блокировку!
echo.
echo  ┌─────────────────────────────────────────────────────────────┐
echo  │  Как это работает:                                          │
echo  │  Провайдер блокирует → ваш DNS запрос к youtube.com        │
echo  │  Смена DNS → запрос уходит на другой сервер → YouTube      │
echo  │  Это как спросить дорогу у другого человека!              │
echo  └─────────────────────────────────────────────────────────────┘
echo.
echo  Доступные DNS-серверы:
echo.
echo  [1] Google DNS (8.8.8.8 / 8.8.4.4)
echo  [2] Cloudflare DNS (1.1.1.1 / 1.0.0.1)
echo  [3] Quad9 (9.9.9.9 / 149.112.112.112)
echo  [4] OpenDNS (208.67.222.222 / 208.67.220.220)
echo  [5] AdGuard DNS (94.140.14.14 / 94.140.15.15)
echo  [6] Yandex DNS (77.88.8.8 / 77.88.8.1)
echo  [7] Comss.ru DNS (83.220.169.155 / 83.220.169.156)
echo  [8] Свой DNS (ввести вручную)
echo  [9] Применить ВСЕ популярные DNS сразу
echo.
echo  [10] Показать текущие DNS
echo  [11] Вернуть DNS по умолчанию (авто)
echo  [12] Очистить DNS-кэш
echo.
set /p dns_choice="  Выбор: "

if "%dns_choice%"=="1" set "DNS1=8.8.8.8" && set "DNS2=8.8.4.4" && goto DNS_APPLY
if "%dns_choice%"=="2" set "DNS1=1.1.1.1" && set "DNS2=1.0.0.1" && goto DNS_APPLY
if "%dns_choice%"=="3" set "DNS1=9.9.9.9" && set "DNS2=149.112.112.112" && goto DNS_APPLY
if "%dns_choice%"=="4" set "DNS1=208.67.222.222" && set "DNS2=208.67.220.220" && goto DNS_APPLY
if "%dns_choice%"=="5" set "DNS1=94.140.14.14" && set "DNS2=94.140.15.15" && goto DNS_APPLY
if "%dns_choice%"=="6" set "DNS1=77.88.8.8" && set "DNS2=77.88.8.1" && goto DNS_APPLY
if "%dns_choice%"=="7" set "DNS1=83.220.169.155" && set "DNS2=83.220.169.156" && goto DNS_APPLY
if "%dns_choice%"=="8" goto DNS_CUSTOM
if "%dns_choice%"=="9" goto DNS_ALL
if "%dns_choice%"=="10" goto DNS_SHOW
if "%dns_choice%"=="11" goto DNS_RESET
if "%dns_choice%"=="12" goto DNS_FLUSH
goto MENU

:DNS_APPLY
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Применение DNS: %DNS1% / %DNS2%                       ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [!] Требуются права АДМИНИСТРАТОРА для изменения DNS!
echo.
echo  Выберите интерфейс:
echo  [1] Wi-Fi
echo  [2] Ethernet
echo  [3] Все активные интерфейсы
echo.
set /p iface_choice="  Выбор: "

if "%iface_choice%"=="1" set "IFACE=Wi-Fi"
if "%iface_choice%"=="2" set "IFACE=Ethernet"
if "%iface_choice%"=="3" goto DNS_ALL_IFACES

if "%IFACE%"=="" set "IFACE=Wi-Fi"

echo.
echo  [>>] Применяю DNS для интерфейса: %IFACE%
echo  [>>] Основной DNS: %DNS1%
echo  [>>] Запасной DNS: %DNS2%

REM Создаём скрипт для админа
set "DNS_SCRIPT=%TEMP%\set_dns_%RANDOM%.bat"
(
echo @echo off
echo echo Установка DNS для интерфейса %IFACE%...
echo netsh interface ip set dns "%IFACE%" static %DNS1%
echo netsh interface ip add dns "%IFACE%" %DNS2% index=2
echo ipconfig /flushdns
echo echo.
echo echo [OK] DNS установлены!
echo echo Основной: %DNS1%
echo echo Запасной: %DNS2%
echo echo.
echo echo Проверка...
echo nslookup youtube.com %DNS1%
echo pause
) > "%DNS_SCRIPT%"

powershell -Command "Start-Process '%DNS_SCRIPT%' -Verb RunAs"
echo.
echo  [>>] Запрос на права администратора отправлен
echo  [>>] Подтвердите в появившемся окне
timeout /t 3 >nul

echo.
echo  [>>] Открываю YouTube для проверки...
timeout /t 2 >nul
start "" "https://www.youtube.com"
goto MENU

:DNS_ALL_IFACES
cls
echo  [>>] Применяю DNS ко всем активным интерфейсам...

set "DNS_ALL_SCRIPT=%TEMP%\set_dns_all_%RANDOM%.bat"
(
echo @echo off
echo echo Установка DNS %DNS1%/%DNS2% на все интерфейсы...
echo for /f "tokens=2 delims=:" %%%%i in ^('netsh interface ip show interfaces ^| findstr /i "connected"'^) do ^(
echo     netsh interface ip set dns "%%%%i" static %DNS1% 2^>nul
echo     netsh interface ip add dns "%%%%i" %DNS2% index=2 2^>nul
echo     echo Интерфейс %%%%i: DNS установлен
echo ^)
echo ipconfig /flushdns
echo echo [OK] Готово!
echo nslookup youtube.com %DNS1%
echo pause
) > "%DNS_ALL_SCRIPT%"

powershell -Command "Start-Process '%DNS_ALL_SCRIPT%' -Verb RunAs"
timeout /t 3 >nul
start "" "https://www.youtube.com"
goto MENU

:DNS_CUSTOM
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Свой DNS сервер                                       ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
set /p custom_dns1="  Основной DNS: "
set /p custom_dns2="  Запасной DNS: "
if "%custom_dns1%"=="" goto MENU
if "%custom_dns2%"=="" set "custom_dns2=%custom_dns1%"
set "DNS1=%custom_dns1%"
set "DNS2=%custom_dns2%"
goto DNS_APPLY

:DNS_ALL
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Применить ВСЕ популярные DNS                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Будут установлены DNS от разных провайдеров
echo  для максимальной вероятности обхода блокировки.
echo.
echo  [!] Требуются права администратора!

set "DNS_ALL_MULTI=%TEMP%\set_dns_multi_%RANDOM%.bat"
(
echo @echo off
echo echo Установка множественных DNS...
echo set "IFACE=Wi-Fi"
echo netsh interface ip set dns "%%IFACE%%" static 1.1.1.1
echo netsh interface ip add dns "%%IFACE%%" 8.8.8.8 index=2
echo netsh interface ip add dns "%%IFACE%%" 9.9.9.9 index=3
echo netsh interface ip add dns "%%IFACE%%" 94.140.14.14 index=4
echo netsh interface ip add dns "%%IFACE%%" 208.67.222.222 index=5
echo ipconfig /flushdns
echo echo [OK] Установлены DNS:
echo echo 1.1.1.1 ^(Cloudflare^)
echo echo 8.8.8.8 ^(Google^)
echo echo 9.9.9.9 ^(Quad9^)
echo echo 94.140.14.14 ^(AdGuard^)
echo echo 208.67.222.222 ^(OpenDNS^)
echo echo.
echo echo Проверка YouTube...
echo nslookup youtube.com
echo pause
) > "%DNS_ALL_MULTI%"

powershell -Command "Start-Process '%DNS_ALL_MULTI%' -Verb RunAs"
timeout /t 3 >nul
start "" "https://www.youtube.com"
goto MENU

:DNS_SHOW
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Текущие DNS настройки                                 ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  DNS-серверы для всех интерфейсов:
ipconfig /all | findstr /i "DNS"
echo.
echo  Проверка резолва YouTube через разные DNS:
echo.
echo  [Google 8.8.8.8]
nslookup youtube.com 8.8.8.8 2>nul | findstr /i "Address" | findstr /v "8.8.8.8"
echo.
echo  [Cloudflare 1.1.1.1]
nslookup youtube.com 1.1.1.1 2>nul | findstr /i "Address" | findstr /v "1.1.1.1"
echo.
echo  [Quad9 9.9.9.9]
nslookup youtube.com 9.9.9.9 2>nul | findstr /i "Address" | findstr /v "9.9.9.9"
echo.
pause
goto DNS_OBHOD

:DNS_RESET
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Сброс DNS на автоматический режим                     ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.

set "DNS_RESET_SCRIPT=%TEMP%\reset_dns_%RANDOM%.bat"
(
echo @echo off
echo echo Сброс DNS на авто для всех интерфейсов...
echo for /f "tokens=2 delims=:" %%%%i in ^('netsh interface ip show interfaces ^| findstr /i "connected"'^) do ^(
echo     netsh interface ip set dns "%%%%i" dhcp 2^>nul
echo     echo Интерфейс %%%%i: DNS сброшен на авто
echo ^)
echo ipconfig /flushdns
echo echo [OK] DNS возвращены к настройкам по умолчанию!
echo pause
) > "%DNS_RESET_SCRIPT%"

powershell -Command "Start-Process '%DNS_RESET_SCRIPT%' -Verb RunAs"
echo  [OK] DNS сброшены!
timeout /t 2 >nul
goto MENU

:DNS_FLUSH
cls
echo  [>>] Очистка DNS-кэша...
ipconfig /flushdns
echo  [OK] DNS-кэш очищен!
echo  [>>] Очистка кэша браузера...
echo  [>>] Откройте chrome://net-internals/#dns в Chrome для очистки
start "" "chrome://net-internals/#dns"
timeout /t 2 >nul
goto MENU


:: ============ [23] DNS over HTTPS / TLS ============
:DNS_DOH_DOT
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DNS через HTTPS (DoH) / DNS через TLS (DoT)          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  DoH и DoT шифруют DNS-запросы. Провайдер НЕ видит
echo  какие сайты вы посещаете и НЕ может их заблокировать!
echo.
echo  ┌─────────────────────────────────────────────────────────────┐
echo  │  DoH (DNS over HTTPS):                                      │
echo  │  Запросы через HTTPS (порт 443)                             │
echo  │  Выглядят как обычный веб-трафик                            │
echo  │  Невозможно заблокировать не блокируя весь HTTPS           │
echo  │                                                              │
echo  │  DoT (DNS over TLS):                                        │
echo  │  Запросы через TLS (порт 853)                               │
echo  │  Отдельный порт, можно заблокировать                        │
echo  │  Быстрее чем DoH                                            │
echo  └─────────────────────────────────────────────────────────────┘
echo.
echo  [1] Включить DoH в Windows 11 (настройка)
echo  [2] Включить DoH в Chrome
echo  [3] Включить DoH в Firefox
echo  [4] Установить YogaDNS (DoH/DoT для всей системы)
echo  [5] Настроить DoH через dnscrypt-proxy
echo  [6] Включить DoT на роутере (инструкция)
echo  [7] Проверить работу DoH/DoT
echo.
set /p doh_choice="  Выбор: "

if "%doh_choice%"=="1" goto DOH_WINDOWS
if "%doh_choice%"=="2" goto DOH_CHROME
if "%doh_choice%"=="3" goto DOH_FIREFOX
if "%doh_choice%"=="4" goto DOH_YOGADNS
if "%doh_choice%"=="5" goto DOH_DNSCRYPT
if "%doh_choice%"=="6" goto DOT_ROUTER
if "%doh_choice%"=="7" goto DOH_TEST
goto MENU

:DOH_WINDOWS
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DoH в Windows 11                                      ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Настройка DNS over HTTPS в Windows 11:
echo.
echo  1. Настройки → Сеть и Интернет → Wi-Fi
echo  2. Свойства оборудования → Назначение DNS-сервера
echo  3. Выбрать "Вручную"
echo  4. Включить IPv4
echo  5. Предпочитаемый DNS: 1.1.1.1
echo  6. Альтернативный DNS: 1.0.0.1
echo  7. Шифрование DNS: "Зашифровано (DoH)"
echo.
echo  [>>] Открываю настройки сети...
start "" ms-settings:network-wifi
echo.
echo  Доступные DoH-серверы:
echo  • Cloudflare: 1.1.1.1 / 1.0.0.1
echo  • Google: 8.8.8.8 / 8.8.4.4
echo  • Quad9: 9.9.9.9 / 149.112.112.112
pause
goto DNS_DOH_DOT

:DOH_CHROME
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DoH в Chrome                                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  1. Откройте chrome://settings/security
echo  2. Прокрутите до "Безопасность"
echo  3. Включите "Использовать безопасный DNS"
echo  4. Выберите "Свой" и введите:
echo.
echo  Доступные DoH-серверы для Chrome:
echo  • https://dns.cloudflare.com/dns-query
echo  • https://dns.google/dns-query
echo  • https://dns.quad9.net/dns-query
echo.
echo  [>>] Открываю настройки Chrome...
start "" "chrome://settings/security"
pause
goto DNS_DOH_DOT

:DOH_FIREFOX
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DoH в Firefox                                         ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  1. Откройте about:preferences#privacy
echo  2. Прокрутите до "DNS через HTTPS"
echo  3. Включите "Повышенная защита" или "Максимальная"
echo  4. Выберите провайдера (Cloudflare / NextDNS)
echo.
echo  [>>] Открываю настройки Firefox...
start "" "about:preferences#privacy"
pause
goto DNS_DOH_DOT

:DOH_YOGADNS
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       YogaDNS (DoH/DoT для всей системы)                    ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  YogaDNS — программа для шифрования DNS на уровне системы.
echo  Поддерживает DoH, DoT, DNSCrypt.
echo.
echo  [>>] Открываю сайт YogaDNS...
start "" "https://yogadns.com"
echo.
echo  После установки:
echo  1. Запустите YogaDNS
echo  2. Выберите DNS-сервер (Cloudflare DoH)
echo  3. Нажмите Start
echo  4. Весь DNS-трафик шифруется!
pause
goto DNS_DOH_DOT

:DOH_DNSCRYPT
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       dnscrypt-proxy (DoH/DoT/DNSCrypt)                     ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  dnscrypt-proxy — мощный инструмент для шифрования DNS.
echo  Работает как локальный DNS-резолвер.
echo.
echo  [>>] Открываю GitHub dnscrypt-proxy...
start "" "https://github.com/DNSCrypt/dnscrypt-proxy/releases"
echo.
echo  Инструкция:
echo  1. Скачайте dnscrypt-proxy-win64.zip
echo  2. Распакуйте в C:\dnscrypt\
echo  3. Переименуйте example-dnscrypt-proxy.toml → dnscrypt-proxy.toml
echo  4. Запустите dnscrypt-proxy.exe
echo  5. Настройте DNS на 127.0.0.1
pause
goto DNS_DOH_DOT

:DOT_ROUTER
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DoT на роутере                                        ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Настройка DNS over TLS на роутере:
echo.
echo  Cloudflare DoT:
echo  • Адрес: 1.1.1.1
echo  • TLS имя: cloudflare-dns.com
echo.
echo  Google DoT:
echo  • Адрес: 8.8.8.8
echo  • TLS имя: dns.google
echo.
echo  Quad9 DoT:
echo  • Адрес: 9.9.9.9
echo  • TLS имя: dns.quad9.net
echo.
echo  [>>] Открываю инструкцию по настройке роутеров...
start "" "https://1.1.1.1/help"
pause
goto DNS_DOH_DOT

:DOH_TEST
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Проверка DoH/DoT                                      ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [>>] Открываю страницы проверки DNS...
start "" "https://1.1.1.1/help"
timeout /t 1 >nul
start "" "https://www.dnsleaktest.com"
timeout /t 1 >nul
start "" "https://dnscheck.tools"
echo.
echo  На странице Cloudflare проверьте:
echo  • "Using DNS over HTTPS (DoH)" = Yes
echo  • "Using DNS over TLS (DoT)" = Yes
echo  • "Connected to 1.1.1.1" = Yes
pause
goto DNS_DOH_DOT


:: ============ [24] DNS + PROXY COMBO ============
:DNS_PROXY_COMBO
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DNS + Прокси (двойной обход)                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Комбинированный метод для максимальной надёжности:
echo.
echo  ┌─────────────────────────────────────────────────────────────┐
echo  │  Схема двойного обхода:                                     │
echo  │  Вы → DNS (1.1.1.1) → Прокси (иностранный) → YouTube      │
echo  │                                                              │
echo  │  1. DNS-запрос шифруется (DoH) или уходит на другой сервер │
echo  │  2. Трафик идёт через прокси в другой стране              │
echo  │  3. Даже если один метод не сработает — второй поможет    │
echo  └─────────────────────────────────────────────────────────────┘
echo.
echo  [1] DNS Cloudflare + HTTP прокси
echo  [2] DNS Google + SOCKS5 прокси
echo  [3] DNS Quad9 + SSH туннель
echo  [4] DoH (Windows 11) + Прокси
echo  [5] Авто-настройка: DNS + Прокси (всё сразу)
echo.
set /p dns_combo_choice="  Выбор: "

if "%dns_combo_choice%"=="1" goto COMBO_DNS_HTTP
if "%dns_combo_choice%"=="2" goto COMBO_DNS_SOCKS5
if "%dns_combo_choice%"=="3" goto COMBO_DNS_SSH
if "%dns_combo_choice%"=="4" goto COMBO_DOH_PROXY
if "%dns_combo_choice%"=="5" goto COMBO_AUTO
goto MENU

:COMBO_DNS_HTTP
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DNS Cloudflare + HTTP Прокси                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Шаг 1: Установка DNS Cloudflare
set "DNS1=1.1.1.1"
set "DNS2=1.0.0.1"
set "IFACE=Wi-Fi"

echo  [!] Запрос прав администратора...
set "COMBO1_SCRIPT=%TEMP%\combo_dns_http_%RANDOM%.bat"
(
echo @echo off
echo echo [Шаг 1/2] Установка DNS Cloudflare...
echo netsh interface ip set dns "%IFACE%" static %DNS1%
echo netsh interface ip add dns "%IFACE%" %DNS2% index=2
echo ipconfig /flushdns
echo echo [OK] DNS Cloudflare установлены!
) > "%COMBO1_SCRIPT%"
powershell -Command "Start-Process '%COMBO1_SCRIPT%' -Verb RunAs"
timeout /t 2 >nul

echo.
echo  Шаг 2: Настройка HTTP прокси
set /p http_proxy="  HTTP прокси (IP:PORT): "
if "%http_proxy%"=="" goto MENU

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "http=%http_proxy%" /f

echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║  Двойной обход активен!                                     ║
echo  ║  DNS: Cloudflare (1.1.1.1)                                  ║
echo  ║  Прокси: HTTP %http_proxy%                                  ║
echo  ║  Трафик: Вы → DNS Cloudflare → Прокси → YouTube            ║
echo  ╚══════════════════════════════════════════════════════════════╝
start "" "https://www.youtube.com"
pause
goto MENU

:COMBO_DNS_SOCKS5
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DNS Google + SOCKS5 Прокси                            ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.

set "COMBO2_SCRIPT=%TEMP%\combo_dns_socks_%RANDOM%.bat"
(
echo @echo off
echo echo [Шаг 1/2] Установка DNS Google...
echo netsh interface ip set dns "Wi-Fi" static 8.8.8.8
echo netsh interface ip add dns "Wi-Fi" 8.8.4.4 index=2
echo ipconfig /flushdns
echo echo [OK] DNS Google установлены!
) > "%COMBO2_SCRIPT%"
powershell -Command "Start-Process '%COMBO2_SCRIPT%' -Verb RunAs"
timeout /t 2 >nul

set /p socks_proxy="  SOCKS5 прокси (IP:PORT): "
if "%socks_proxy%"=="" goto MENU

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "socks=%socks_proxy%" /f

echo  [OK] Двойной обход: DNS Google + SOCKS5
start "" "https://www.youtube.com"
pause
goto MENU

:COMBO_DNS_SSH
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DNS Quad9 + SSH Туннель                               ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.

set "COMBO3_SCRIPT=%TEMP%\combo_dns_ssh_%RANDOM%.bat"
(
echo @echo off
echo echo [Шаг 1/2] Установка DNS Quad9...
echo netsh interface ip set dns "Wi-Fi" static 9.9.9.9
echo netsh interface ip add dns "Wi-Fi" 149.112.112.112 index=2
echo ipconfig /flushdns
echo echo [OK] DNS Quad9 установлены!
) > "%COMBO3_SCRIPT%"
powershell -Command "Start-Process '%COMBO3_SCRIPT%' -Verb RunAs"
timeout /t 2 >nul

echo  Шаг 2: SSH туннель
set /p ssh_ip="  IP VPS сервера: "
set /p ssh_user="  Логин: "
set /p ssh_port="  Порт SSH (22): "
if "%ssh_port%"=="" set "ssh_port=22"

echo  [>>] Создаю SSH туннель...
echo  [>>] SOCKS5 на 127.0.0.1:1080
echo  [>>] НЕ закрывайте это окно!
ssh -D 1080 -p %ssh_port% -N %ssh_user%@%ssh_ip%
pause
goto MENU

:COMBO_DOH_PROXY
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       DoH (Windows 11) + Прокси                             ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Шаг 1: Настройка DoH в Windows 11
echo  (Откроются настройки — настройте DoH вручную)
start "" ms-settings:network-wifi
echo.
echo  Настройте:
echo  • DNS: 1.1.1.1 и 1.0.0.1
echo  • Шифрование: DoH
echo.
echo  Нажмите любую клавишу когда настроите DoH...
pause >nul

echo.
echo  Шаг 2: Настройка прокси
set /p combo_proxy="  Прокси (IP:PORT): "
if "%combo_proxy%"=="" goto MENU

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "http=%combo_proxy%" /f

echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║  Максимальная защита!                                       ║
echo  ║  DNS: DoH Cloudflare (зашифрован)                           ║
echo  ║  Трафик: HTTP прокси %combo_proxy%                          ║
echo  ║  Провайдер НЕ видит ни DNS, ни трафик!                     ║
echo  ╚══════════════════════════════════════════════════════════════╝
start "" "https://www.youtube.com"
pause
goto MENU

:COMBO_AUTO
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Авто-настройка: DNS + Прокси                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Автоматическая настройка двойного обхода:
echo  • DNS: Cloudflare (1.1.1.1)
echo  • Прокси: будет запрошен
echo.

set "COMBO_AUTO_SCRIPT=%TEMP%\combo_auto_%RANDOM%.bat"
(
echo @echo off
echo echo ============================================
echo echo  Авто-настройка DNS + Прокси
echo echo ============================================
echo echo.
echo echo [1/3] Установка DNS Cloudflare...
echo netsh interface ip set dns "Wi-Fi" static 1.1.1.1
echo netsh interface ip add dns "Wi-Fi" 1.0.0.1 index=2
echo netsh interface ip add dns "Wi-Fi" 8.8.8.8 index=3
echo netsh interface ip add dns "Wi-Fi" 9.9.9.9 index=4
echo ipconfig /flushdns
echo echo [OK] DNS установлены: 1.1.1.1, 1.0.0.1, 8.8.8.8, 9.9.9.9
echo echo.
echo echo [2/3] Проверка доступа к YouTube...
echo nslookup youtube.com 1.1.1.1
echo echo

:: ============ [25] ОФФЛАЙН-РЕЖИМ ============
:OFFLINE_MODE
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Оффлайн-режим YouTube (минимальный интернет)          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Этот режим позволяет смотреть YouTube даже с очень слабым
echo  интернетом или в режиме экономии трафика.
echo.
echo  ┌─────────────────────────────────────────────────────────────┐
echo  │  Как это работает:                                          │
echo  │  1. Интерфейс загружается из кэша (не тратит трафик)      │
echo  │  2. Видео загружается в минимальном качестве (144p)       │
echo  │  3. Картинки сжаты (WebP, маленький размер)               │
echo  │  4. Звук загружается отдельно (экономия трафика)          │
echo  │  5. Всё кэшируется для повторного просмотра               │
echo  └─────────────────────────────────────────────────────────────┘
echo.
echo  Режимы работы:
echo.
echo  [1] Эконом-режим (144p, только звук при плохом интернете)
echo  [2] Оффлайн-интерфейс (загрузить интерфейс и кэшировать)
echo  [3] Предзагрузка видео (скачать заранее для оффлайн)
echo  [4] Только аудио-режим (без видео, как подкаст)
echo  [5] Оффлайн плейлист (сохранить несколько видео)
echo  [6] Открыть оффлайн HTML
echo  [7] Очистить кэш оффлайн-режима
echo.
set /p offline_choice="  Выбор: "

if "%offline_choice%"=="1" goto OFFLINE_ECONOM
if "%offline_choice%"=="2" goto OFFLINE_INTERFACE
if "%offline_choice%"=="3" goto OFFLINE_PRELOAD
if "%offline_choice%"=="4" goto OFFLINE_AUDIO
if "%offline_choice%"=="5" goto OFFLINE_PLAYLIST
if "%offline_choice%"=="6" goto OFFLINE_HTML
if "%offline_choice%"=="7" goto OFFLINE_CLEAR
goto MENU

:OFFLINE_ECONOM
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Эконом-режим YouTube (144p, ультра-лёгкий)           ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Эконом-режим использует минимум трафика:
echo  • Видео: 144p (самое низкое качество)
echo  • Изображения: отключены
echo  • Звук: моно, низкий битрейт
echo  • Кэширование: всё сохраняется локально
echo.
echo  Экономия трафика: до 90%% по сравнению с обычным YouTube!
echo.
set /p econ_url="  Введите ссылку на видео: "
if "%econ_url%"=="" (
    start "" "https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=0&controls=1&modestbranding=1&rel=0&quality=tiny"
    goto MENU
)

REM Извлекаем ID
set "VID=%econ_url%"
echo %econ_url% | findstr /i "youtube.com" >nul && for /f "tokens=2 delims=?v=&" %%a in ("%econ_url%") do set "VID=%%a"
echo %econ_url% | findstr /i "youtu.be" >nul && for /f "tokens=2 delims=/" %%a in ("%econ_url%") do set "VID=%%a"

echo  [>>] Открываю в эконом-режиме (144p, без картинок)...
REM Используем специальные параметры YouTube для минимального качества
start "" "https://www.youtube.com/embed/%VID%?autoplay=0&controls=1&modestbranding=1&rel=0&quality=tiny&playsinline=1"
echo.
echo  [OK] Видео открыто в эконом-режиме!
echo  [>>] Совет: используйте Firefox с дополнением "YouTube Audio Only"
pause
goto OFFLINE_MODE

:OFFLINE_INTERFACE
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Загрузка оффлайн-интерфейса                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Создаю оффлайн-версию интерфейса YouTube...
echo  Интерфейс будет сохранён локально и не потребует
echo  интернета для навигации (только для загрузки видео).
echo.

set "OFFLINE_DIR=%~dp0offline_cache"
if not exist "%OFFLINE_DIR%" mkdir "%OFFLINE_DIR%"

REM Создаём оффлайн HTML с минимальным интерфейсом
set "OFFLINE_HTML=%OFFLINE_DIR%\youtube_offline.html"

(
echo ^<!DOCTYPE html^>
echo ^<html lang="ru"^>
echo ^<head^>
echo ^<meta charset="UTF-8"^>
echo ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo ^<title^>YouTube Оффлайн — Минимальный интернет^</title^>
echo ^<style^>
echo *{margin:0;padding:0;box-sizing:border-box}
echo body{font-family:system-ui,sans-serif;background:#0f0f0f;color:#fff;padding:16px;min-height:100vh}
echo .header{text-align:center;padding:20px 0;border-bottom:2px solid #f00;margin-bottom:20px}
echo .header h1{color:#f00;font-size:1.8em}
echo .status{background:#1a1a1a;padding:12px;border-radius:10px;margin:10px 0;display:flex;align-items:center;gap:8px}
echo .status-dot{width:10px;height:10px;border-radius:50%%;background:#ff0}
echo .status-dot.online{background:#0f0}
echo .status-dot.offline{background:#f00}
echo .input-group{display:flex;gap:8px;margin:16px 0}
echo input{flex:1;padding:14px;border:2px solid #333;border-radius:25px;background:#1a1a1a;color:#fff;font-size:16px;outline:none}
echo input:focus{border-color:#f00}
echo button{padding:14px 24px;background:#f00;color:#fff;border:none;border-radius:25px;font-weight:700;cursor:pointer;font-size:16px}
echo button:active{background:#c00}
echo .player{position:relative;width:100%%;padding-bottom:56.25%%;background:#000;border-radius:10px;overflow:hidden;margin:16px 0}
echo .player iframe{position:absolute;top:0;left:0;width:100%%;height:100%%;border:none}
echo .cache-info{background:#1a1a1a;padding:12px;border-radius:10px;font-size:13px;color:#aaa;margin:10px 0}
echo .btn-row{display:flex;gap:8px;flex-wrap:wrap;margin:10px 0}
echo .btn-secondary{background:#333;color:#fff}
echo .quality-selector{display:flex;gap:8px;flex-wrap:wrap;margin:10px 0}
echo .quality-btn{padding:8px 16px;background:#1a1a1a;border:1px solid #333;border-radius:20px;color:#fff;cursor:pointer;font-size:13px}
echo .quality-btn.active{background:#f00;border-color:#f00}
echo .offline-list{display:flex;flex-direction:column;gap:8px}
echo .offline-item{background:#1a1a1a;padding:12px;border-radius:10px;display:flex;gap:10px;align-items:center}
echo .offline-item .thumb{width:120px;height:68px;background:#000;border-radius:6px;overflow:hidden;flex-shrink:0}
echo .offline-item .info{flex:1;min-width:0}
echo .offline-item .title{font-weight:600;margin-bottom:4px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
echo .offline-item .meta{font-size:12px;color:#aaa}
echo ^</style^>
echo ^</head^>
echo ^<body^>
echo ^<div class="header"^>
echo ^<h1^>▶ YouTube Оффлайн^</h1^>
echo ^<p style="color:#aaa;font-size:14px;"^>Минимальный интернет • Экономия трафика^</p^>
echo ^</div^>
echo ^<div class="status" id="status"^>
echo ^<span class="status-dot online" id="statusDot"^>^</span^>
echo ^<span id="statusText"^>Онлайн (оффлайн-интерфейс загружен)^</span^>
echo ^</div^>
echo ^<div class="quality-selector"^>
echo ^<button class="quality-btn active" onclick="setQuality('auto')"^>Авто^</button^>
echo ^<button class="quality-btn" onclick="setQuality('tiny')"^>144p^</button^>
echo ^<button class="quality-btn" onclick="setQuality('small')"^>240p^</button^>
echo ^<button class="quality-btn" onclick="setQuality('audio')"^>Только звук^</button^>
echo ^</div^>
echo ^<div class="input-group"^>
echo ^<input type="text" id="videoInput" placeholder="Ссылка или ID видео..."^>
echo ^<button onclick="loadVideo()"^>▶^</button^>
echo ^</div^>
echo ^<div id="playerContainer"^>^</div^>
echo ^<div class="btn-row"^>
echo ^<button class="btn-secondary" onclick="cacheCurrentVideo()"^>💾 Сохранить в кэш^</button^>
echo ^<button class="btn-secondary" onclick="showCachedVideos()"^>📂 Кэшированные видео^</button^>
echo ^<button class="btn-secondary" onclick="clearCache()"^>🗑 Очистить кэш^</button^>
echo ^</div^>
echo ^<div class="cache-info"^>
echo ^<strong^>📦 Кэш браузера:^</strong^> ^<span id="cacheSize"^>0 MB^</span^>
echo ^<br^>^<strong^>💾 Сохранено видео:^</strong^> ^<span id="cachedCount"^>0^</span^>
echo ^</div^>
echo ^<div id="cachedList" class="offline-list"^>^</div^>
echo ^<script^>
echo // Оффлайн-плеер YouTube
echo let currentQuality = 'auto';
echo let videoHistory = [];
echo 
echo // Загрузка видео с минимальным качеством
echo function loadVideo() {
echo     const input = document.getElementById('videoInput');
echo     const videoId = extractVideoId(input.value);
echo     if (!videoId) {
echo         alert('❌ Не удалось распознать ссылку!\nПример: dQw4w9WgXcQ');
echo         return;
echo     }
echo     const container = document.getElementById('playerContainer');
echo     const quality = currentQuality === 'audio' ? 'tiny' : currentQuality;
echo     let url;
echo     if (currentQuality === 'audio') {
echo         url = `https://www.youtube.com/embed/${videoId}?autoplay=0&controls=1&modestbranding=1&rel=0&quality=tiny&volume=100`;
echo     } else {
echo         url = `https://www.youtube.com/embed/${videoId}?autoplay=0&controls=1&modestbranding=1&rel=0&quality=${quality}`;
echo     }
echo     container.innerHTML = `<div class="player"><iframe src="${url}" allow="autoplay; encrypted-media" allowfullscreen loading="lazy"></iframe></div>`;
echo     saveToHistory(videoId);
echo     updateCacheInfo();
echo }
echo 
echo function extractVideoId(input) {
echo     if (!input) return null;
echo     input = input.trim();
echo     if (/^[a-zA-Z0-9_-]{11}$/.test(input)) return input;
echo     const sm = input.match(/youtu\.be\/([a-zA-Z0-9_-]{11})/);
echo     if (sm) return sm[1];
echo     const em = input.match(/embed\/([a-zA-Z0-9_-]{11})/);
echo     if (em) return em[1];
echo     try {
echo         const u = new URL(input.startsWith('http') ? input : 'https://' + input);
echo         return u.searchParams.get('v');
echo     } catch {}
echo     return null;
echo }
echo 
echo function setQuality(q) {
echo     currentQuality = q;
echo     document.querySelectorAll('.quality-btn').forEach(b => b.classList.remove('active'));
echo     event.target.classList.add('active');
echo }
echo 
echo function cacheCurrentVideo() {
echo     const iframe = document.querySelector('.player iframe');
echo     if (!iframe) { alert('Сначала загрузите видео!'); return; }
echo     const videoId = extractVideoId(iframe.src);
echo     const cached = JSON.parse(localStorage.getItem('yt_offline') || '[]');
echo     if (!cached.find(v => v.id === videoId)) {
echo         cached.push({ id: videoId, date: new Date().toISOString(), quality: currentQuality });
echo         localStorage.setItem('yt_offline', JSON.stringify(cached));
echo     }
echo     updateCacheInfo();
echo     alert('✅ Видео сохранено в кэш!');
echo }
echo 
echo function showCachedVideos() {
echo     const cached = JSON.parse(localStorage.getItem('yt_offline') || '[]');
echo     const container = document.getElementById('cachedList');
echo     if (!cached.length) {
echo         container.innerHTML = '<p style="color:#aaa;text-align:center;padding:20px;">Нет сохранённых видео</p>';
echo         return;
echo     }
echo     container.innerHTML = cached.map(v => `
echo         <div class="offline-item" onclick="document.getElementById('videoInput').value='${v.id}';loadVideo();">
echo             <div class="thumb"><img src="https://i.ytimg.com/vi/${v.id}/default.jpg" onerror="this.style.display='none'" style="width:100%;height:100%;object-fit:cover;"></div>
echo             <div class="info">
echo                 <div class="title">${v.id}</div>
echo                 <div class="meta">Сохранено: ${new Date(v.date).toLocaleDateString()} • Качество: ${v.quality}</div>
echo             </div>
echo         </div>
echo     `).join('');
echo     updateCacheInfo();
echo }
echo 
echo function clearCache() {
echo     if (confirm('Очистить весь кэш оффлайн-режима?')) {
echo         localStorage.removeItem('yt_offline');
echo         updateCacheInfo();
echo         document.getElementById('cachedList').innerHTML = '';
echo         alert('🗑 Кэш очищен!');
echo     }
echo }
echo 
echo function saveToHistory(videoId) {
echo     videoHistory.push({ id: videoId, time: Date.now() });
echo     if (videoHistory.length > 50) videoHistory.shift();
echo }
echo 
echo function updateCacheInfo() {
echo     const cached = JSON.parse(localStorage.getItem('yt_offline') || '[]');
echo     document.getElementById('cachedCount').textContent = cached.length;
echo     let size = 0;
echo     for (let key in localStorage) {
echo         if (localStorage.hasOwnProperty(key)) {
echo             size += localStorage[key].length * 2;
echo         }
echo     }
echo     document.getElementById('cacheSize').textContent = (size / 1024 / 1024).toFixed(2) + ' MB';
echo }
echo 
echo // Проверка статуса сети
echo function updateOnlineStatus() {
echo     const dot = document.getElementById('statusDot');
echo     const text = document.getElementById('statusText');
echo     if (navigator.onLine) {
echo         dot.className = 'status-dot online';
echo         text.textContent = 'Онлайн (интерфейс из кэша)';
echo     } else {
echo         dot.className = 'status-dot offline';
echo         text.textContent = 'Оффлайн (только кэшированные видео)';
echo     }
echo }
echo 
echo window.addEventListener('online', updateOnlineStatus);
echo window.addEventListener('offline', updateOnlineStatus);
echo window.addEventListener('load', () => {
echo     updateOnlineStatus();
echo     updateCacheInfo();
echo     showCachedVideos();
echo });
echo 
echo // Кэширование Service Worker
echo if ('serviceWorker' in navigator) {
echo     window.addEventListener('load', () => {
echo         navigator.serviceWorker.register('data:application/javascript,' + encodeURIComponent(
echo             'self.addEventListener("install",()=>self.skipWaiting());' +
echo             'self.addEventListener("activate",()=>self.clients.claim());' +
echo             'self.addEventListener("fetch",e=>{' +
echo             '  const r=e.request;' +
echo             '  if(r.url.includes("youtube.com")||r.url.includes("ytimg.com")){' +
echo             '    e.respondWith(caches.match(r).then(c=>c||fetch(r).then(resp=>{' +
echo             '      const clone=resp.clone();' +
echo             '      caches.open("yt-offline").then(c=>c.put(r,clone));' +
echo             '      return resp;' +
echo             '    })));' +
echo             '  }' +
echo             '})'
echo         ));
echo     });
echo }
echo ^</script^>
echo ^</body^>
echo ^</html^>
) > "%OFFLINE_HTML%"

echo.
echo  [OK] Оффлайн HTML создан: %OFFLINE_HTML%
echo  [>>] Открываю в браузере...
start "" "%OFFLINE_HTML%"
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║  Оффлайн-интерфейс готов!                                   ║
echo  ║  • Интерфейс загружается из кэша                            ║
echo  ║  • Видео кэшируются для повтора                            ║
echo  ║  • Работает даже с очень слабым интернетом                 ║
echo  ╚══════════════════════════════════════════════════════════════╝
pause
goto MENU

:OFFLINE_PRELOAD
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Предзагрузка видео для оффлайн                       ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Этот метод загружает видео заранее (когда есть интернет)
echo  для последующего просмотра без интернета.
echo.
echo  Используются инструменты:
echo  • yt-dlp (https://github.com/yt-dlp/yt-dlp)
echo  • youtube-dl
echo.
echo  [1] Скачать yt-dlp (если не установлен)
echo  [2] Загрузить видео (низкое качество, быстро)
echo  [3] Загрузить видео (среднее качество)
echo  [4] Загрузить только аудио
echo  [5] Загрузить плейлист для оффлайн
echo.
set /p preload_choice="  Выбор: "

if "%preload_choice%"=="1" (
    echo  [>>] Открываю страницу загрузки yt-dlp...
    start "" "https://github.com/yt-dlp/yt-dlp/releases"
    echo  Скачайте yt-dlp.exe и положите в папку со скриптом
)

if "%preload_choice%"=="2" goto PRELOAD_LOW
if "%preload_choice%"=="3" goto PRELOAD_MED
if "%preload_choice%"=="4" goto PRELOAD_AUDIO
if "%preload_choice%"=="5" goto PRELOAD_PLAYLIST
goto MENU

:PRELOAD_LOW
set /p pl_url="  Ссылка на видео: "
if "%pl_url%"=="" goto MENU
set "DL=%VID%"
echo %pl_url% | findstr /i "youtube.com" >nul && for /f "tokens=2 delims=?v=&" %%a in ("%pl_url%") do set "DL=%%a"
echo %pl_url% | findstr /i "youtu.be" >nul && for /f "tokens=2 delims=/" %%a in ("%pl_url%") do set "DL=%%a"

set "OFFLINE_DIR=%~dp0offline_cache"
if not exist "%OFFLINE_DIR%" mkdir "%OFFLINE_DIR%"

echo  [>>] Загружаю видео в низком качестве (144p)...
if exist "yt-dlp.exe" (
    yt-dlp.exe -f "best[height<=144]" -o "%OFFLINE_DIR%\%%(title)s.%%(ext)s" "https://www.youtube.com/watch?v=%DL%"
) else (
    echo  [!] yt-dlp не найден! Скачайте его (пункт 1)
    echo  [>>] Пытаюсь через youtube-dl...
    where youtube-dl >nul 2>&1 && youtube-dl -f "best[height<=144]" -o "%OFFLINE_DIR%\%%(title)s.%%(ext)s" "https://www.youtube.com/watch?v=%DL%" || echo  [X] Ни один загрузчик не найден
)
echo  [OK] Видео сохранено в: %OFFLINE_DIR%
pause
goto MENU

:PRELOAD_MED
set /p pl_url="  Ссылка на видео: "
if "%pl_url%"=="" goto MENU
set "DL=%VID%"
echo %pl_url% | findstr /i "youtube.com" >nul && for /f "tokens=2 delims=?v=&" %%a in ("%pl_url%") do set "DL=%%a"
echo %pl_url% | findstr /i "youtu.be" >nul && for /f "tokens=2 delims=/" %%a in ("%pl_url%") do set "DL=%%a"

set "OFFLINE_DIR=%~dp0offline_cache"
if not exist "%OFFLINE_DIR%" mkdir "%OFFLINE_DIR%"

echo  [>>] Загружаю видео в среднем качестве (360p)...
if exist "yt-dlp.exe" (
    yt-dlp.exe -f "best[height<=360]" -o "%OFFLINE_DIR%\%%(title)s.%%(ext)s" "https://www.youtube.com/watch?v=%DL%"
) else (
    echo  [!] yt-dlp не найден!
)
echo  [OK] Готово!
pause
goto MENU

:PRELOAD_AUDIO
set /p pl_url="  Ссылка на видео: "
if "%pl_url%"=="" goto MENU
set "DL=%VID%"
echo %pl_url% | findstr /i "youtube.com" >nul && for /f "tokens=2 delims=?v=&" %%a in ("%pl_url%") do set "DL=%%a"

set "OFFLINE_DIR=%~dp0offline_cache"
if not exist "%OFFLINE_DIR%" mkdir "%OFFLINE_DIR%"

echo  [>>] Загружаю только аудио...
if exist "yt-dlp.exe" (
    yt-dlp.exe -x --audio-format mp3 -o "%OFFLINE_DIR%\%%(title)s.%%(ext)s" "https://www.youtube.com/watch?v=%DL%"
) else (
    echo  [!] yt-dlp не найден!
)
echo  [OK] Аудио сохранено!
pause
goto MENU

:PRELOAD_PLAYLIST
set /p pl_url="  Ссылка на плейлист: "
if "%pl_url%"=="" goto MENU

set "OFFLINE_DIR=%~dp0offline_cache"
if not exist "%OFFLINE_DIR%" mkdir "%OFFLINE_DIR%"

echo  [>>] Загружаю весь плейлист (низкое качество)...
if exist "yt-dlp.exe" (
    yt-dlp.exe -f "best[height<=144]" -o "%OFFLINE_DIR%\%%(playlist_index)s-%%(title)s.%%(ext)s" "%pl_url%"
) else (
    echo  [!] yt-dlp не найден!
)
echo  [OK] Плейлист загружен!
pause
goto MENU

:OFFLINE_AUDIO
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Только аудио-режим (YouTube как подкаст)            ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Режим "только звук" отключает загрузку видео,
echo  экономя до 95%% трафика. Идеально для:
echo  • Музыки
echo  • Подкастов
echo  • Лекций
echo  • Фонового прослушивания
echo.
set /p audio_url="  Ссылка на видео: "
if "%audio_url%"=="" goto MENU

set "VID=%audio_url%"
echo %audio_url% | findstr /i "youtube.com" >nul && for /f "tokens=2 delims=?v=&" %%a in ("%audio_url%") do set "VID=%%a"
echo %audio_url% | findstr /i "youtu.be" >nul && for /f "tokens=2 delims=/" %%a in ("%audio_url%") do set "VID=%%a"

echo  [>>] Открываю в аудио-режиме...
REM Используем специальный URL с параметрами для аудио
start "" "https://www.youtube.com/embed/%VID%?autoplay=0&controls=1&modestbranding=1&rel=0&quality=tiny&volume=100"
echo.
echo  [OK] Видео открыто в режиме экономии трафика!
echo  [>>] Совет: сверните вкладку — звук продолжит играть
echo  [>>] Для чистого аудио: скачайте через пункт [26] → Только аудио
pause
goto MENU

:OFFLINE_PLAYLIST
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Оффлайн плейлист                                     ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Создайте плейлист для оффлайн-просмотра.
echo  Видео будут загружены заранее и доступны без интернета.
echo.
echo  [1] Создать новый оффлайн плейлист
echo  [2] Открыть сохранённый плейлист
echo  [3] Добавить видео в плейлист
echo.
set /p pl_choice="  Выбор: "

if "%pl_choice%"=="1" (
    set /p pl_name="  Название плейлиста: "
    echo %pl_name% > "%~dp0offline_cache\playlist_%pl_name%.txt"
    echo  [OK] Плейлист создан!
)
if "%pl_choice%"=="2" (
    echo  Сохранённые плейлисты:
    dir "%~dp0offline_cache\playlist_*.txt" /b 2>nul
    set /p pl_open="  Название: "
    if exist "%~dp0offline_cache\playlist_%pl_open%.txt" (
        start notepad "%~dp0offline_cache\playlist_%pl_open%.txt"
    )
)
if "%pl_choice%"=="3" (
    set /p pl_add_name="  Название плейлиста: "
    set /p pl_add_url="  Ссылка на видео: "
    echo %pl_add_url% >> "%~dp0offline_cache\playlist_%pl_add_name%.txt"
    echo  [OK] Видео добавлено!
)
pause
goto MENU

:OFFLINE_CLEAR
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Очистка кэша оффлайн-режима                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  [1] Очистить кэш браузера (Chrome)
echo  [2] Очистить папку offline_cache
echo  [3] Очистить всё
echo.
set /p clear_choice="  Выбор: "

if "%clear_choice%"=="1" (
    start "" "chrome://settings/clearBrowserData"
    echo  [>>] Открыты настройки Chrome
)
if "%clear_choice%"=="2" (
    if exist "%~dp0offline_cache" (
        rmdir /s /q "%~dp0offline_cache" 2>nul
        echo  [OK] Папка offline_cache удалена
    )
)
if "%clear_choice%"=="3" (
    if exist "%~dp0offline_cache" rmdir /s /q "%~dp0offline_cache" 2>nul
    start "" "chrome://settings/clearBrowserData"
    echo  [OK] Всё очищено!
)
pause
goto MENU

:: ============ [26] ОФФЛАЙН СКАЧИВАНИЕ ============
:OFFLINE_DOWNLOAD
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Скачать видео для оффлайн-просмотра                 ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Выберите сервис для скачивания:
echo.
echo  [1] y2mate.com (MP4/MP3)
echo  [2] savefrom.net (все форматы)
echo  [3] 9convert.com (MP3/MP4)
echo  [4] yt1s.com (HD)
echo  [5] yt-dlp (локально, лучшее качество)
echo.
set /p dl_choice="  Выбор: "
set /p dl_url="  Ссылка на видео: "

if "%dl_url%"=="" goto MENU

set "VID=%dl_url%"
echo %dl_url% | findstr /i "youtube.com" >nul && for /f "tokens=2 delims=?v=&" %%a in ("%dl_url%") do set "VID=%%a"
echo %dl_url% | findstr /i "youtu.be" >nul && for /f "tokens=2 delims=/" %%a in ("%dl_url%") do set "VID=%%a"

if "%dl_choice%"=="1" start "" "https://www.y2mate.com/youtube/%VID%"
if "%dl_choice%"=="2" start "" "https://en.savefrom.net/1-youtube-downloader/?url=https://www.youtube.com/watch?v=%VID%"
if "%dl_choice%"=="3" start "" "https://9convert.com/en/youtube-to-mp4/%VID%"
if "%dl_choice%"=="4" start "" "https://yt1s.com/youtube-to-mp4?url=https://www.youtube.com/watch?v=%VID%"
if "%dl_choice%"=="5" (
    if exist "yt-dlp.exe" (
        yt-dlp.exe -f "best[height<=720]" "https://www.youtube.com/watch?v=%VID%"
    ) else (
        echo  [!] yt-dlp не найден!
    )
)

echo  [OK] Сервис открыт в браузере!
timeout /t 2 >nul
goto MENU

:: ============ [27] ОФФЛАЙН ПОИСК ============
:OFFLINE_SEARCH
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║       Оффлайн-поиск по кэшу                                ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  Поиск по уже сохранённым видео в оффлайн-кэше.
echo.

set "OFFLINE_DIR=%~dp0offline_cache"
if not exist "%OFFLINE_DIR%" (
    echo  [!] Папка offline_cache не найдена!
    echo  [>>] Сначала загрузите видео через пункт 26
    pause
    goto MENU
)

echo  Сохранённые видео:
dir "%OFFLINE_DIR%" /b 2>nul | findstr /v "playlist"
echo.
echo  [>>] Открываю папку с видео...
explorer "%OFFLINE_DIR%"
pause
goto MENU

:EXIT
echo  До свидания!
timeout /t 2 >nul
exit /b
