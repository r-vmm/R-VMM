#!/bin/bash

### Uapi/linux/netfilter handler 
cp include/uapi/linux/netfilter/xt_DSCP\ \(Conflit\ de\ casse\).h include/uapi/linux/netfilter/xt_dscp.h
cp include/uapi/linux/netfilter/xt_MARK\ \(Conflit\ de\ casse\).h include/uapi/linux/netfilter/xt_mark.h
cp include/uapi/linux/netfilter/xt_CONNMARK\ \(Conflit\ de\ casse\).h include/uapi/linux/netfilter/xt_connmark.h
cp include/uapi/linux/netfilter/xt_TCPMSS\ \(Conflit\ de\ casse\).h include/uapi/linux/netfilter/xt_tcpmss.h
cp include/uapi/linux/netfilter/xt_RATEEST\ \(Conflit\ de\ casse\).h include/uapi/linux/netfilter/xt_rateest.h

### net/netfilter handler 
cp net/netfilter/xt_DSCP\ \(Conflit\ de\ casse\).c net/netfilter/xt_dscp.c
cp net/netfilter/xt_HL\ \(Conflit\ de\ casse\).c net/netfilter/xt_hl.c
cp net/netfilter/xt_RATEEST\ \(Conflit\ de\ casse\).c net/netfilter/xt_rateest.c
cp net/netfilter/xt_TCPMSS\ \(Conflit\ de\ casse\).c net/netfilter/xt_tcpmss.c 

### uapi/linux/netfilter_ipv4

cp include/uapi/linux/netfilter_ipv4/ipt_TTL\ \(Conflit\ de\ casse\).h include/uapi/linux/netfilter_ipv4/ipt_ttl.h
cp include/uapi/linux/netfilter_ipv4/ipt_ECN\ \(Conflit\ de\ casse\).h include/uapi/linux/netfilter_ipv4/ipt_ecn.h

### uapi/linux/netfilter_ipv6

cp include/uapi/linux/netfilter_ipv6/ip6t_HL\ \(Conflit\ de\ casse\).h include/uapi/linux/netfilter_ipv6/ip6t_hl.h

