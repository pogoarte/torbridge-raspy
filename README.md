# torbridge-raspy

Simple script install tor bridge tested on my Raspberry Pi Zero W 1.1 Version and RaspiOS Bullseye Lite.

Run update and install tor, torsocks, obfs4proxy, nyx, vnstat and generate /etc/tor/torrc for bridge with:
- notices.log
- ControlPort
- HashedControlPassword
- BandwidthRate
- BandwidthBurst
- MaxAdvertisedBandwidth

-----------------------------------------------------------------------------------------------------------

This is my torrc config IPv4Only and after 1 month uptime working without any problems:

- SOCKSPort 0
- Log notice file /var/log/tor/notices.log
- BridgeRelay 1
- RunAsDaemon 1
- ExitPolicy reject *:*
- ControlPort 9051
- HashedControlPassword *********
- Address *********
- ORPort ********* IPv4Only
- ServerTransportPlugin obfs4 exec /usr/bin/obfs4proxy
- ServerTransportListenAddr obfs4 0.0.0.0:*********
- ExtORPort auto
- ContactInfo *********
- Nickname *********
- BandwidthRate 512 KBytes
- BandwidthBurst 768 KBytes
- MaxAdvertisedBandwidth 640 KBytes
- PublishServerDescriptor 1

-----------------------------------------------------------------------------------------------------------

![Immagine](https://user-images.githubusercontent.com/98662243/162634140-2824c6ba-5979-4915-8127-2603f4dd9610.png)
