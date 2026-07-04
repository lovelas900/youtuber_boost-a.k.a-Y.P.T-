#!/usr/bin/env python3
"""
YouTube HTTP Proxy Server для Linux
Запуск: python3 proxy_server.py
Порт: 8080
"""

import http.server
import socketserver
import urllib.request
import ssl
import os
import sys
from pathlib import Path

PORT = 8080
CACHE_DIR = Path.home() / '.cache' / 'youtube-proxy'

class YouTubeProxy(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Извлекаем URL из пути
        url = self.path[1:]  # убираем первый /
        
        if not url.startswith('http'):
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b'Usage: http://127.0.0.1:8080/https://youtube.com')
            return
        
        try:
            # Создаём SSL контекст (игнорируем сертификаты)
            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE
            
            # Делаем запрос
            req = urllib.request.Request(url, headers={
                'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36',
                'Accept': '*/*'
            })
            
            with urllib.request.urlopen(req, timeout=30, context=ctx) as response:
                # Отправляем статус
                self.send_response(response.status)
                
                # Копируем заголовки
                for key, value in response.headers.items():
                    if key.lower() not in ['transfer-encoding', 'content-encoding']:
                        self.send_header(key, value)
                
                # Добавляем CORS для браузера
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                
                # Копируем тело ответа
                self.wfile.write(response.read())
                
        except Exception as e:
            self.send_response(500)
            self.end_headers()
            self.wfile.write(f'Proxy Error: {str(e)}'.encode())
    
    def log_message(self, format, *args):
        # Тихий режим (без логов в консоль)
        pass

def main():
    # Создаём папку для кэша
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    
    print(f"""
╔══════════════════════════════════════════════════════════════╗
║          YouTube Proxy Server для Linux                      ║
╠══════════════════════════════════════════════════════════════╣
║  Прокси запущен на: http://127.0.0.1:{PORT}                  ║
║  Использование: http://127.0.0.1:{PORT}/https://youtube.com  ║
║  Кэш: {CACHE_DIR}                   ║
║  Нажмите Ctrl+C для остановки                               ║
╚══════════════════════════════════════════════════════════════╝
    """)
    
    try:
        with socketserver.TCPServer(("", PORT), YouTubeProxy) as httpd:
            httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n[OK] Прокси остановлен")
        sys.exit(0)

if __name__ == '__main__':
    main()
