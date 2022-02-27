# torbridge

Simple script install tor bridge tested on RaspiOS Bullseye Lite and Debian Bullseye.

It run on my Raspberry Pi Zero W and Raspberry Pi4 without problems.

Run update and install tor, torsocks, obfs4proxy, nyx, vnstat and generate /etc/tor/torrc for bridge with:
- notices.log
- ControlPort
- HashedControlPassword
- BandwidthRate
- BandwidthBurst
- MaxAdvertisedBandwidth
