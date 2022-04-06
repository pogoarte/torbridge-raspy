# torbridge

Simple script install tor bridge tested on my Raspberry Pi Zero W 1.1 Version and RaspiOS Bullseye Lite.

Run update and install tor, torsocks, obfs4proxy, nyx, vnstat and generate /etc/tor/torrc for bridge with:
- notices.log
- ControlPort
- HashedControlPassword
- BandwidthRate
- BandwidthBurst
- MaxAdvertisedBandwidth

-----------------------------------------------------------------------------------------------------------

This is my Bandwidth config after 31 days uptime working without problems.

Raspberry Pi Zero W:
- BandwidthRate 512 KBytes
- BandwidthBurst 768 KBytes
- MaxAdvertisedBandwidth 640 KBytes

