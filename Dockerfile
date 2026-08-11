FROM ghcr.io/suwayomi/suwayomi-server:stable

USER root
COPY rename-webui.sh /home/suwayomi/rename-webui.sh
COPY icons/ /opt/inkstream-icons/
RUN chmod +x /home/suwayomi/rename-webui.sh && chown -R suwayomi:suwayomi /home/suwayomi/rename-webui.sh /opt/inkstream-icons
USER suwayomi

CMD ["/bin/sh", "-c", "/home/suwayomi/rename-webui.sh & exec /home/suwayomi/startup_script.sh"]
