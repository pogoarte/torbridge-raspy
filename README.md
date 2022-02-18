# torbridge

Simple script install tor brdige

Tested on RaspiOS Bullseye and Debian Bullseye.
Run apt update and install tor, obfs4proxy, nyx and vnstat.

Generate /etc/tor/torrc for bridge with:
- notices.log (/var/log/tor/notices.log)
- ControlPort (9051)
- HashedControlPassword
- BandwidthRate
- BandwidthBurst
- MaxAdvertisedBandwidth
