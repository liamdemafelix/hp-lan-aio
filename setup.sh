#!/bin/bash

sudo apt update -y
sudo apt install cups hplip
sudo usermod -aG lpadmin $(whoami)

echo "Done. Run sudo hp-scan -i to configure the scanner."
