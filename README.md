# R-VMM
**Resilient Virtual Machine Monitor** is a complete fault tolerance solution for type-I hypervisors adopting one of the most popular VMM architectures, we refer as "pVM-based". This project leverages unikernel and fault tolerance designs to have deal with the fault tolerance of the "dom0" in the Xen virtualization system.

## Our design

We split the pVM (dom0) in four parts where each part has his dedicated fault tolerance mecanism + a global loop which monitors via heartbeat and trigger recovery mechanisms.  

![Overall-Architecture](figs/xdesign.jpg)

## Requirements & Deployment

### Requirements

The dev was achieved on **Ubuntu 12.04.5 LTS with Linux kernel 5.0.8** (but can work on recent Ubuntu versions). 
Our fault tolerance mechanism for the network component is dependent on **Broadcom Corporation NetXtreme II BCM5709
Gigabit Ethernet interface (1Gb/s)** with the driver **bnx2**      

### Deployment 



## Usage

## Calibration

## Testing with fault injection

## Get in touch with us.
