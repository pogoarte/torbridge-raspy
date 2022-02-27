# torbridge

Simple script install tor bridge tested on RaspiOS Bullseye Lite and Debian Bullseye.

It run on my Raspberry Pi Zero W and Raspberry Pi4.

Run update and install tor, torsocks, obfs4proxy, nyx, vnstat and generate /etc/tor/torrc for bridge with:
- notices.log
- ControlPort
- HashedControlPassword
- BandwidthRate
- BandwidthBurst
- MaxAdvertisedBandwidth

-----------------------------------------------------------------------------------------------------------

This is my Bandwidth config after 20 days uptime working without problems.

Raspberry Pi Zero W:
- BandwidthRate 512 KBytes
- BandwidthBurst 768 KBytes
- MaxAdvertisedBandwidth 640 KBytes

Raspberry Pi 4:
- BandwidthRate 1024 KBytes
- BandwidthBurst 2048 KBytes
- MaxAdvertisedBandwidth 1280 KBytes
