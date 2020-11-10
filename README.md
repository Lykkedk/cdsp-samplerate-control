# cdsp-samplerate-control
### SuperPlayer's CamillaDSP SampleRate Controller & pCP Combo
### Verified on piCorePlayer 6.1 on an Raspberry Pi 4

*Help / thread here on diyaudio https://www.diyaudio.com/forums/pc-based/361429-superplayer-ugly-hacked-squeezelite-samplerate-auto-switching-machine.html#post6372682*

*Camilladsp https://www.diyaudio.com/forums/pc-based/349818-camilladsp-cross-platform-iir-fir-engine-crossovers-correction-etc.html*

*Seashell's excellent setup https://github.com/scripple/alsa_cdsp*

*File's needed for Camilla GUI (Backend server) https://github.com/Lykkedk/cdsp-samplerate-control/releases/tag/cdsp_src_v0.1*
(StartServer.sh & InstallWebInterface.sh)

This "one-liner" installs [user@diyaudio seashell]'s alsa_plugin for use with the camilladsp/squeezelite combo.

Simply login to your'e piCorePlayer with ssh, and execute the command below ::
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


```home
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
