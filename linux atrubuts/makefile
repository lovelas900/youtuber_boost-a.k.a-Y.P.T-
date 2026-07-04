.PHONY: install run proxy service clean

install:
	bash install.sh

run:
	bash youtube-proxy.sh

proxy:
	python3 proxy_server.py

service:
	sudo systemctl start youtube-proxy

status:
	sudo systemctl status youtube-proxy

stop:
	sudo systemctl stop youtube-proxy

clean:
	sudo systemctl stop youtube-proxy 2>/dev/null || true
	sudo systemctl disable youtube-proxy 2>/dev/null || true
	sudo rm -f /etc/systemd/system/youtube-proxy.service
	sudo rm -rf /opt/youtube-proxy
	rm -f ~/.local/share/applications/youtube-proxy.desktop

help:
	@echo "YouTube Proxy Toolkit для Linux"
	@echo ""
	@echo "make install  - Установить"
	@echo "make run      - Запустить меню"
	@echo "make proxy    - Запустить прокси-сервер"
	@echo "make service  - Запустить systemd-сервис"
	@echo "make status   - Статус сервиса"
	@echo "make stop     - Остановить сервис"
	@echo "make clean    - Удалить всё"
