#!/bin/sh

############################################################
#                                                          #
# This script installs Henrik Enquist's camillagui-backend #
# and dependicies.                                         #
#                                                          #
# Script by jesperlykke [user Lykkedk at diyaudio.com]     #
#                                                          #
############################################################

GREEN="$(echo -e '\033[1;32m')"
NC="$(echo -e '\033[0m')"

cd /home/tc

if [[ "$USER" != 'root' && "$1" != "status" ]] ; then
echo
echo "This script must be run as root, or with sudo."
echo
exit
fi

echo
echo "${GREEN}Install script for CamillaDSP GUI..."
echo
sleep 3

echo "Grab and install needed extensions"
echo
su tc -c "tce-load -wo compiletc.tcz"
su tc -c "tce-load -wo python3.6-dev"
su tc -c "tce-load -i compiletc.tcz"
su tc -c "tce-load -i python3.6-dev"

echo "Grab and install py_websocket + dependicies"
echo
# pcp-load lets you grab .tczs on external repo's
su tc -c "pcp-load -u https://sourceforge.net/projects/cdsp-samplerate-control/files/10.x/armv7/tcz -wi py_websocket.tcz"

echo
echo "Done loading needed extensions"
echo
sleep 1
echo "Check if Python Requirement are satisfied, otherwise install setuptools & aiohttp"
echo
sudo -H pip3 install setuptools
sudo -H pip3 install aiohttp
echo
sleep 1

echo "Make some directory's for Python stuff and download Camilla GUI..."
echo
su tc -c "mkdir -p /home/tc/cdsp_webinterface/Backend_v0.5.2"                                          # <--- Important version
cd /home/tc/cdsp_webinterface/Backend_v0.5.2                                                           # <--- Important version
su tc -c "wget https://github.com/HEnquist/camillagui-backend/releases/download/v0.5.2/camillagui.zip" # <--- Important version
su tc -c "unzip camillagui.zip"
cd /home/tc/cdsp_webinterface
su tc -c "wget https://github.com/HEnquist/pycamilladsp-plot/archive/v0.4.2.zip"                       # <--- Important version
su tc -c "wget https://github.com/HEnquist/pycamilladsp/archive/v0.4.1.zip"                            # <--- Important version
su tc -c "unzip v0.4.2.zip"
su tc -c "unzip v0.4.1.zip"
echo
su tc -c "mkdir /mnt/mmcblk0p2/tce/cdsp_webinterface"
su tc -c "cp -R Backend_v0.5.2 /mnt/mmcblk0p2/tce/cdsp_webinterface"                                   # <--- Important version
su tc -c "cp -R pycamilladsp-0.4.1 /mnt/mmcblk0p2/tce/cdsp_webinterface"                               # <--- Important version
su tc -c "cp -R pycamilladsp-plot-0.4.2 /mnt/mmcblk0p2/tce/cdsp_webinterface"                          # <--- Important version
echo "ls -all /mnt/mmcblk0p2/tce/cdsp_webinterface ::"
ls -all /mnt/mmcblk0p2/tce/cdsp_webinterface
echo

cd /mnt/mmcblk0p2/tce/cdsp_webinterface/Backend_v0.5.2                                                 # <--- Important version
cat /mnt/mmcblk0p2/tce/cdsp_webinterface/Backend_v0.5.2/config/camillagui.yml                          # <--- Important version
echo
echo "..."
sleep 1
echo

echo "Install pycamilladsp and pycamilladsp-plot"
echo
cd /mnt/mmcblk0p2/tce/cdsp_webinterface/pycamilladsp-0.4.1                                             # <--- Important version
sudo -H pip3 install .
echo "Done installing pycamilladsp-0.4.1"
echo
cd /mnt/mmcblk0p2/tce/cdsp_webinterface/pycamilladsp-plot-0.4.2
sudo -H pip3 install .
echo "Done installing pycamilladsp-plot-0.4.2"
echo

echo "${NC}"
echo "Script .... Done!"

exit

