# torbridge

Simple script install tor brdige (Tested on RaspiOS Bullseye and Debian Bullseye)

Run apt update and install tor, obfs4proxy, nyx, vnstat and generate /etc/tor/torrc for bridge with:
- notices.log
- ControlPort
- HashedControlPassword
- BandwidthRate
- BandwidthBurst
- MaxAdvertisedBandwidth
