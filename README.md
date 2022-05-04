# Network Print & Scan for Raspberry Pi + HP DeskJet 2320

**This may work on other HP AIO models**, but I don't have (or need) other printers at home.

This repo contains scripts and setup instructions for my LAN workflow for printing and scanning. I have:

* a Raspberry Pi 4 with Debian 11 64-bit installed and has a static LAN IP assigned to it and an SSH key authorized for the regular user
* a pre-configured Samba share for my NAS
* an HP DeskJet 2320 all-in-one
* a Windows 11 workstation
* phones, laptops and tablets connected to an access point
* PuTTY/Plink installed, with your Pi's SSH key in the PPK format

This may or may not work for your use-case. This does not use SANE, because it isn't supported in Windows anyway (the apps that add support for it are not working, they either crash or just all-out fail).

This installs CUPS, which you will need to configure at `https://raspberrypi:631`, and the HP Linux Imaging and Printing (`hplip`) package.

## Workflow

**A. Printing**

Once CUPS has been configured on the Pi, you can now configure Samba. Edit `/etc/samba/smbd.conf` and change the `[printers]` and `[print$]` sections so it reflects the following:

```
[printers]
comment = All Printers
browseable = no
path = /var/spool/samba
printable = yes
guest ok = yes
read only = yes
create mask = 0700

[print$]
comment = Printer Drivers
path = /var/lib/samba/printers
browseable = yes
read only = no
guest ok = no
```

Then, restart Samba: `sudo systemctl restart smbd`.

**B. Scanning**

If you're SSH-ed into the Pi, use the `.bash_aliases` reference to add a `docscan` command. This will automatically scan the document with the following preset:

* 600 dpi
* `--mode=color`
* JPEG format

You can run `docscan --output=/path/to/scans/test.jpg`. 

On a Windows machine, simply drop `docscan.bat` anywhere, preferably inside a folder included in your environment's `PATH`. When you want to scan, simply open a terminal and run `docscan filename.jpg`.

I have the batch file automatically dump the file to my NAS folder, so I can access it from within Windows. **Edit the paths for output and the path to the PPK file as necessary.**
