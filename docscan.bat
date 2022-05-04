@echo off
IF %1.==. GOTO NoFile
set filename=%1
plink -i "D:\Path\To\PPK\File" -batch user@raspberrypi "/usr/bin/hp-scan --mode=color -r 600 --output=/path/to/output-folder/%1"
GOTO End


:NoFile
  echo No filename specified.
GOTO End

:End
