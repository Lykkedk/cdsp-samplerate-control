#!/bin/sh
# Script to start the CamillaDSP server  192.168.1.XX:5000 (with correct IP address)

su tc -c  "/usr/local/bin/python3 /mnt/mmcblk0p2/tce/cdsp_webinterface/Backend-0.5.2/main.py" &

exit
