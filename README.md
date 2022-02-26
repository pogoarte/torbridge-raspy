# torbridge

Simple script install tor bridge (Tested on RaspiOS Bullseye Lite and Debian Bullseye)

Run apt update and install tor, obfs4proxy, nyx, vnstat and generate /etc/tor/torrc for bridge with:
- notices.log
- ControlPort
- HashedControlPassword
- BandwidthRate
- BandwidthBurst
- MaxAdvertisedBandwidth
