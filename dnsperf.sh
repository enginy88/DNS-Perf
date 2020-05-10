#!/usr/bin/env bash

# AUTHOR: Engin YUCE <enginy88@gmail.com>
# DESCRIPTION: Shell script to test the performance of the most popular public DNS resolvers from your location.
# VERSION: 1.0
# LICENSE: Copyright 2020 Engin YUCE. Licensed under the Apache License, Version 2.0.

# Test repeat count.
TEST_COUNT=10

# Providers to test. Duplicated providers are ok!
PROVIDERS="
176.103.130.130##AdGuard##(dns.adguard.com)
23.253.163.53##AlernateDNS##(dns2.alternate-dns.com)
185.228.168.9##CleanBrowsing##(security-filter-dns.cleanbrowsing.org)
1.1.1.1##Cloudflare##(one.one.one.one)
8.26.56.26##Comodo##(ns1.recursive.dnsbycomodo.com)
84.200.69.80##DNS.Watch##(resolver1.dns.watch)
216.146.35.35##DynDNS##(resolver1.dyndnsinternetguide.com)
37.235.1.174##FreeDNS-Frankfurt##(resolver3.freedns.zone)
37.235.1.174##FreeDNS-Vienna##(resolver.freedns.zone)
80.80.80.80##Freenom##(-)
8.8.8.8##Google##(dns.google)
74.82.42.42##Hurricane-Electric##(ordns.he.net)
209.244.0.3##Level3-CenturyLink##(resolver1.level3.net.)
4.2.2.1##Level3-GTEI##(b.resolvers.level3.net)
156.154.70.1##Neustar-DNSAdvantage##(-)
199.85.126.10##Norton-ConnectSafe##(-)
208.67.222.222##OpenDNS##(dns.opendns.com)
94.16.114.254##OpenNIC-Frankfurt##(ns11.de.dns.opennic.glue)
91.217.137.37##OpenNIC-Moscow##(ns5.ru.dns.opennic.glue)
109.69.8.51##PuntCAT##(-)
9.9.9.9##Quad9##(dns.quad9.net)
195.46.39.39##SafeDNS##(dns1.safedns.com)
91.239.100.100##UncensoredDNS##(anycast.censurfridns.dk)
64.6.64.6##VeriSign##(recpubns1.nstld.net)
77.88.8.1##Yandex##(dns.yandex.ru)
114.114.114.114##114DNS[CN]##(public1.114dns.com)
223.5.5.5##AliDNS[CN]##(public1.alidns.com)
180.76.76.76##Baidu[CN]##(public-dns-a.baidu.com)
1.2.4.8##CNNIC-SDNS[CN]##(public1.sdns.cn)
101.226.4.6##DNSpai[CN]##(-)
119.29.29.29##DNSPod[CN]##(pdns.dnspod.cn)
117.50.10.10##OneDNS[CN]##(-)
"

# Depreciated providers are just for historic records!
DEPRECIATED_PROVIDERS="
45.77.165.194##Fourth-Estate-Miami##(accuracy.ns.fourthestate.co)
45.32.36.36##Fourth-Estate-Tokyo##(independence.ns.fourthestate.co)
81.218.119.11##GreenTeamDNS##(-)
184.169.143.224##Securly##(-)
208.76.50.50##SmartViper##(-)
99.192.182.200##TentaDNS-ICANN##(-)
99.192.182.100##TentaDNS-OpenNIC##(-)
"

# Domains to test. Duplicated domains are ok! (Fetched & selected from Top Sites lists provided by Alexa on May 2020.)
DOMAINS="
Adobe.com
Amazon.com
Apple.com
Bing.com
Dropbox.com
Ebay.com
Facebook.com
Google.com
Instagram.com
Linkedin.com
Live.com
Microsoft.com
Msn.com
Netflix.com
Office.com
Reddit.com
Spotify.com
Stackoverflow.com
Twitch.tv
Twitter.com
Whatsapp.com
Wikipedia.org
Yahoo.com
Youtube.com
Zoom.us
"

# BELOW THAT LINE THERE BE DRAGONS!

command -v bc > /dev/null || { echo "bc was not found. Please install bc."; exit 1; }
{ command -v drill > /dev/null && dig=drill; } || { command -v dig > /dev/null && dig=dig; } || { echo "dig was not found. Please install dnsutils."; exit 1; }

TOTAL_DOMAINS=0
printf "%-24s" ""
for i in $DOMAINS; do
	TOTAL_DOMAINS=$((TOTAL_DOMAINS + 1))
done

printf "%-12s" "Average"
printf "%-12s" "Timeout"
printf "%-12s" "Reliabiliy"
echo ""

for PROVIDER in $PROVIDERS; do
	PROVIDER_IP=${PROVIDER%%##*}
	PROVIDER_NAME_FQDN=${PROVIDER#*##}
	PROVIDER_NAME=${PROVIDER_NAME_FQDN%%##*}
	PROVIDER_FQDN=${PROVIDER_NAME_FQDN##*##}
	TOTAL_TIME=0
	TIMEOUT_COUNT=0

	printf "%-24s" "$PROVIDER_NAME"

	for DOMAIN in $DOMAINS; do

		for (( i=1; i<=$TEST_COUNT; i++ )); do

			TIME=$($dig +tries=1 +time=2 +noall +stats @$PROVIDER_IP $DOMAIN |grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2)
			if [ -z "$TIME" ]; then
				TIMEOUT_COUNT=$((TIMEOUT_COUNT + 1))
				#echo -e "\n\t DEBUG: TIMEOUT! $DOMAIN"
				continue
			elif [ "x$TIME" = "x0" ]; then
				TIME=1
			fi
			TOTAL_TIME=$((TOTAL_TIME + TIME))
			if [[ $TIME -ge 1000 ]]; then
				:
				#echo -e "\n\t DEBUG: LONG-RTT! ($TIME ms) $DOMAIN"
			fi
		done

	done

	TOTAL_TEST_COUNT=$(($TOTAL_DOMAINS * $TEST_COUNT))
	if [[ "$TIMEOUT_COUNT" -eq "$TOTAL_TEST_COUNT" ]]; then
		AVERAGE="N/A"
		RELIABLILITY=0
	else
		AVERAGE=$(bc -lq <<< "scale=2; $TOTAL_TIME / ( $TOTAL_TEST_COUNT - $TIMEOUT_COUNT )")
		RELIABLILITY=$(bc -lq <<< "scale=2; 100 - ((100 * $TIMEOUT_COUNT) / $TOTAL_TEST_COUNT)")
	fi

	printf "%-12s" "$AVERAGE ms"
	printf "%-12s" "$TIMEOUT_COUNT/$TOTAL_TEST_COUNT"
	printf "%-12s" "%$RELIABLILITY"
	printf "%-18s" "| $PROVIDER_IP"
	echo "$PROVIDER_FQDN"
done

exit 0;
