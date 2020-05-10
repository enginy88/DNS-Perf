# Public DNS Resolvers Performance Tester Script

Shell script to test the performance of the most popular public DNS resolvers from your location.

# Generic Informations

Includes public DNS resolvers by default:
 * AdGuard (176.103.130.130)
 * AlernateDNS (23.253.163.53)
 * CleanBrowsing (185.228.168.9)
 * Cloudflare (1.1.1.1)
 * Comodo (8.26.56.26)
 * DNS.Watch (84.200.69.80)
 * DynDNS (216.146.35.35)
 * FreeDNS-Frankfurt (37.235.1.174)
 * FreeDNS-Vienna (37.235.1.174)
 * Freenom (80.80.80.80)
 * Google (8.8.8.8)
 * Hurricane-Electric (74.82.42.42)
 * Level3-CenturyLink (209.244.0.3)
 * Level3-GTEI (4.2.2.1)
 * Neustar-DNSAdvantage (156.154.70.1)
 * Norton-ConnectSafe (199.85.126.10)
 * OpenDNS (208.67.222.222)
 * OpenNIC-Frankfurt (94.16.114.254)
 * OpenNIC-Moscow (91.217.137.37)
 * PuntCAT (109.69.8.51)
 * Quad9 (9.9.9.9)
 * SafeDNS (195.46.39.39)
 * UncensoredDNS (91.239.100.100)
 * VeriSign (64.6.64.6)
 * Yandex (77.88.8.1)
 * 114DNS[CN\] (114.114.114.114)
 * AliDNS[CN\] (223.5.5.5)
 * Baidu[CN\] (180.76.76.76)
 * CNNIC-SDNS[CN\] (1.2.4.8)
 * DNSpai[CN\] (101.226.4.6)
 * DNSPod[CN\] (119.29.29.29)
 * OneDNS[CN\] (117.50.10.10)

Domains included to test by default:
 * Adobe.com
 * Amazon.com
 * Apple.com
 * Bing.com
 * Dropbox.com
 * Ebay.com
 * Facebook.com
 * Google.com
 * Instagram.com
 * Linkedin.com
 * Live.com
 * Microsoft.com
 * Msn.com
 * Netflix.com
 * Office.com
 * Reddit.com
 * Spotify.com
 * Stackoverflow.com
 * Twitch.tv
 * Twitter.com
 * Whatsapp.com
 * Wikipedia.org
 * Yahoo.com
 * Youtube.com
 * Zoom.us

# Requirements 

This script is prepared for run on UNIX-Like OS's. Your system needs `bash` shell with `bc` and `dig` installed to run this script. Bash shell should be installed by default for most Linux distros and MacOS. To install other dependencies you can use for "deb" packet based distros like Debian/Ubuntu:

```
 $ sudo apt-get install bc dnsutils
```

# Usage

``` 
 $ git clone --depth=1 https://github.com/enginy88/DNS-Perf.git
 $ cd DNS-Perf
 $ chmod +x dnsperf.sh
 $ ./dnsperf.sh
                        Average     Timeout     Reliabiliy
AdGuard                 80.22 ms    0/250       %100.00     | 176.103.130.130 (dns.adguard.com)
AlernateDNS             160.26 ms   44/250      %82.40      | 23.253.163.53   (dns2.alternate-dns.com)
CleanBrowsing           59.79 ms    0/250       %100.00     | 185.228.168.9   (security-filter-dns.cleanbrowsing.org)
Cloudflare              24.02 ms    0/250       %100.00     | 1.1.1.1         (one.one.one.one)
Comodo                  63.42 ms    0/250       %100.00     | 8.26.56.26      (ns1.recursive.dnsbycomodo.com)
DNS.Watch               71.36 ms    0/250       %100.00     | 84.200.69.80    (resolver1.dns.watch)
DynDNS                  59.77 ms    0/250       %100.00     | 216.146.35.35   (resolver1.dyndnsinternetguide.com)
FreeDNS-Frankfurt       82.16 ms    0/250       %100.00     | 37.235.1.174    (resolver3.freedns.zone)
FreeDNS-Vienna          73.74 ms    0/250       %100.00     | 37.235.1.174    (resolver.freedns.zone)
Freenom                 120.89 ms   0/250       %100.00     | 80.80.80.80     (-)
Google                  73.45 ms    0/250       %100.00     | 8.8.8.8         (dns.google)
Hurricane-Electric      63.91 ms    0/250       %100.00     | 74.82.42.42     (ordns.he.net)
Level3-CenturyLink      61.12 ms    0/250       %100.00     | 209.244.0.3     (resolver1.level3.net.)
Level3-GTEI             65.01 ms    0/250       %100.00     | 4.2.2.1         (b.resolvers.level3.net)
Neustar-DNSAdvantage    65.51 ms    0/250       %100.00     | 156.154.70.1    (-)
Norton-ConnectSafe      58.18 ms    0/250       %100.00     | 199.85.126.10   (-)
OpenDNS                 63.34 ms    0/250       %100.00     | 208.67.222.222  (dns.opendns.com)
OpenNIC-Frankfurt       71.89 ms    44/250      %82.40      | 94.16.114.254   (ns11.de.dns.opennic.glue)
OpenNIC-Moscow          120.10 ms   0/250       %100.00     | 91.217.137.37   (ns5.ru.dns.opennic.glue)
PuntCAT                 106.55 ms   0/250       %100.00     | 109.69.8.51     (-)
Quad9                   85.95 ms    1/250       %99.60      | 9.9.9.9         (dns.quad9.net)
SafeDNS                 80.90 ms    0/250       %100.00     | 195.46.39.39    (dns1.safedns.com)
UncensoredDNS           83.74 ms    0/250       %100.00     | 91.239.100.100  (anycast.censurfridns.dk)
VeriSign                71.88 ms    0/250       %100.00     | 64.6.64.6       (recpubns1.nstld.net)
Yandex                  107.19 ms   0/250       %100.00     | 77.88.8.1       (dns.yandex.ru)
114DNS[CN]              167.64 ms   0/250       %100.00     | 114.114.114.114 (public1.114dns.com)
AliDNS[CN]              330.68 ms   73/250      %70.80      | 223.5.5.5       (public1.alidns.com)
Baidu[CN]               296.86 ms   7/250       %97.20      | 180.76.76.76    (public-dns-a.baidu.com)
CNNIC-SDNS[CN]          325.94 ms   92/250      %63.20      | 1.2.4.8         (public1.sdns.cn)
DNSpai[CN]              310.96 ms   95/250      %62.00      | 101.226.4.6     (-)
DNSPod[CN]              190.11 ms   4/250       %98.40      | 119.29.29.29    (pdns.dnspod.cn)
OneDNS[CN]              292.04 ms   16/250      %93.60      | 117.50.10.10    (-)
```

To sort with the fastest first, you can run the script like `$ ./dnsperf.sh | sort -k 2 -n`. Beware that when running the scipt like that there will be no output until the script finishes and note that it can take too long to respond. Another alternative way to sort output especially if you already ran the script is  `$ sort -k 2 -n <<< "COPY_AND_PASTE_OUTPUT_HERE"`.

# Test Count and Duration

This script does 8000 DNS lookup by default. (32 Server x 25 Domain x 10 Time) If you need to reduce test count or test duration, you can change `TEST_COUNT` variable. For example if you edit that variable from 10 to 1, total DNS lookup count will be 800 instead of 8000. Also you can omit unnecessary providers from `PROVIDERS` variables if needed. From my home internet connection, test takes 3 minutes if TEST_COUNT variable set to 1. If I omit China based providers in addition to that test takes 1 minutes from my home location. Test duration highly depends on where you are and in other words your RTT durations to providers.

