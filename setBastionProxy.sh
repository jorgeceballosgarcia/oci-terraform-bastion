#!/bin/bash

bastion_proxy=socks5://127.0.0.1:22022
echo "Set BASTION Proxy to socks5://127.0.0.1:22022"
export http_proxy=$bastion_proxy
export https_proxy=$bastion_proxy
echo "Done!"
