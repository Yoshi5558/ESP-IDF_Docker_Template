# Use the official ESP-IDF v5.0.2 base image
FROM espressif/idf:v5.0.2

WORKDIR /workspaces

# Set Various paths - Not known if strictly required given the sourcing of export.sh
ENV IDF_CMAKE_PATH=/esp-idf/tools/cmake
ENV RMAKER_PATH=/esp-rainmaker
ENV PYTHON_PATH=/home/esp/.local/bin
ENV PATH="${IDF_PATH}:${IDF_TOOLS_PATH}:${RMAKER_PATH}:${PYTHON_PATH}:/usr/bin:${PATH}"

# Set some Alias' on the current users shell
RUN echo 'function fp() { idf.py -p /dev/ttyUSB"$1" flash monitor; }' >> ~/.bashrc
RUN echo 'function mp() { idf.py -p /dev/ttyUSB"$1" monitor; }' >> ~/.bashrc
RUN echo 'alias s="source $IDF_PATH/export.sh"' >> ~/.bashrc
RUN echo 'alias b="idf.py build"' >> ~/.bashrc
RUN echo 'alias f="idf.py flash monitor"' >> ~/.bashrc
RUN echo 'alias menu="idf.py menuconfig"' >> ~/.bashrc
RUN echo 'alias lsesp="ls /dev/ttyUSB*"' >> ~/.bashrc
RUN echo 'alias cdesp="cd /workspaces/Xarkle-hub"' >> ~/.bashrc
RUN echo 'function pf() { esptool.py --chip esp32s2 --port /dev/ttyUSB"$1" --baud 921600 write_flash --compress 0x1000 bootloader.bin 0x8000 partition-table.bin 0x16000 ota_data_initial.bin 0x20000 "$2" }' >> ~/.bashrc

# -l just imports all the above alias' - should avoid dodgy behaviour on non standard clis (i.e zsh)
CMD ["/bin/bash", "-c", "-l", "exec /bin/bash"]
