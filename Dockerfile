FROM ghcr.io/suwayomi/suwayomi-server:stable

USER root
COPY rename-webui.sh /home/suwayomi/rename-webui.sh
RUN chmod +x /home/suwayomi/rename-webui.sh && chown suwayomi:suwayomi /home/suwayomi/rename-webui.sh
USER suwayomi

CMD ["/bin/sh", "-c", "/home/suwayomi/rename-webui.sh & exec /home/suwayomi/startup_script.sh"]
