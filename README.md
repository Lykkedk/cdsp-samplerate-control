## SuperPlayer's CamillaDSP SampleRate Controller & pCP Combo *Only for betatesters or the brave one's - ! ;-)*

### cdsp-samplerate-control - Alsa plugin [samplerate auto changer] for camilladsp

### The alsa plugin is created by user seashell at diyaudio.com... 


### Verified on piCorePlayer 6.1 on an Raspberry Pi 3 & 4

*(I'am also working on a script which installs the webinterface for camilladsp, will be released soon i guess.)*

*Help / thread here on diyaudio https://www.diyaudio.com/forums/pc-based/361429-superplayer-ugly-hacked-squeezelite-samplerate-auto-switching-machine.html#post6372682*

*Camilladsp https://www.diyaudio.com/forums/pc-based/349818-camilladsp-cross-platform-iir-fir-engine-crossovers-correction-etc.html*

*Seashell's excellent setup https://github.com/scripple/alsa_cdsp*

This command below installs [user@diyaudio seashell]'s alsa_plugin for use with the camilladsp/squeezelite combo.

Simply login to your'e piCorePlayer with ssh, and execute the command below ::\
```ssh tc@192.168.x.x``` Default password = piCore

```tce-load -wi python3.6 && pcp-load -u https://sourceforge.net/projects/cdsp-samplerate-control/files/10.x/armv7/tcz -wi seashell_alsa.tcz```

The piCore/piCoreplayer installs the .tzc extension, which is a bit like a compressed package on the filesystem like this ::
```
├── home
│   └── tc
│       ├── asound.conf.tar.gz
│       └── camilladsp.tar.gz
└── usr
    └── local
        ├── lib
        │   └── alsa-lib
        │       └── libasound_module_pcm_cdsp.so
        └── tce.installed
            └── seashell_alsa
```
The camilladsp.tar.gz decrompress itself into and creates the /home/tc/camilladsp directory the first time (only!) the seashell_alsa.tcz is executed.\
The asound.conf.tar.gz decompress to /etc/asound.conf, keeping a backup of the original at the camilladsp dir. so to preserve a user modified\
asound.conf file. This is also only happening first time the seashell_alsa.tcz is executed.

### BUT please be aware that if you allready have a camilladsp directory it will proberly be corrupted / overwritten.

```
home
└── tc
    └── camilladsp
        ├── camilladsp.yaml
        ├── coeffs
        ├── configs
        ├── filters
        │   ├── 176400
        │   ├── 192000
        │   ├── 44100
        │   ├── 48000
        │   ├── 88200
        │   └── 96000
        └── template
            └── config_template.yml
```
Along with some other dependicies, the camilladsp.tcz is also loaded and installed in /usr/local/bin.\
I compressed and did a .tcz with the camilladsp v0.4.0-Beta6. When camilladsp.tcz is loaded/installed it paste a file in the homedir. telling\
which version is installed.\
When done, move on and edit the asound.conf file...

I have simplified the asound.conf file, in the .tcz file.
The original one that Seashell supplied along with the plugin, can be seen on his Github (see link at top of this howto).
```
#    --- sound_out is the real hardware card ---
pcm.sound_out {
type hw
card 0
device 0
}

#   --- CamillaDSP with Seashell's alsa-plugin ---
# Howto here : https://github.com/scripple/alsa_cdsp 
pcm.camilladsp {
    type cdsp
      cpath "/usr/local/bin/camilladsp"
      config_in "/home/tc/camilladsp/template/config_template.yml"
      config_out "/home/tc/camilladsp/camilladsp.yaml"
      # -p "1234"
      cargs [
        -l warn
      ]
      channels 2
      rates = [
        44100 
        48000 
        88200 
        96000
        176400
        192000
        352800
        384000
      ]
}
```
You need to change the hw and card on top of it to your'e actually hardware.
My hardware shows ::
```
tc@piCorePlayer:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ALSA [bcm2835 ALSA], device 0: bcm2835 ALSA [bcm2835 ALSA]
  Subdevices: 7/7
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
card 0: ALSA [bcm2835 ALSA], device 1: bcm2835 IEC958/HDMI [bcm2835 IEC958/HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: ALSA [bcm2835 ALSA], device 2: bcm2835 IEC958/HDMI1 [bcm2835 IEC958/HDMI1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Amanero [Combo384 Amanero], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

```
So for my card to work the asound.conf must be ::
```
pcm.sound_out {
type hw
card 1        <------- card 1
device 0      <------- device 0
}
```

If you make changes to it, it will be preserved doing reboot's if you remember to do a\
```sudo filetool.sh -b```

In pCP's webinterface, choose camilladsp as output device, and restart squeezelite... It should work.

Good luck!

JesperLykke (user Lykkedk at diyaudio.com)

