#!/bin/bash

# Check for invalid arguments
if [ $# -gt 0 ]; then
    echo "Invalid Syntax!"
    echo "The valid syntax is ./$(basename $0)"
    exit 1
fi

# Function to display memory utilization
function memory_util() {
    BUFFCACHE_MEM=$(free -m | awk '/Mem/ {print $6}')
    FREE_MEM=$(free -m | awk '/Mem/ {print $4}')
    YIELD_MEM=$((BUFFCACHE_MEM + FREE_MEM))
    AVAILABLE_MEM=$(free -m | awk '/Mem/ {print $7}')
    TOTAL_MEM=$(free -m | awk '/Mem/ {print $2}')
    TOTAL_USED_MEM=$((TOTAL_MEM - AVAILABLE_MEM))
    MEM_USAGE_PERCENT=$(bc <<< "scale=2; $TOTAL_USED_MEM * 100 / $TOTAL_MEM")

    echo -e "........................................\nMEMORY UTILIZATION\n"
    echo -e "Total Memory\t\t: $TOTAL_MEM MB"
    echo -e "Available Memory\t: $AVAILABLE_MEM MB"
    echo -e "Buffer+Cache Memory\t: $BUFFCACHE_MEM MB"
    echo -e "Free Memory\t\t: $FREE_MEM MB"
    echo -e "Memory Usage Percentage\t: $MEM_USAGE_PERCENT %"

    # Warn if available or (free+buffer+cache) memory is too low
    if [ $AVAILABLE_MEM -lt 100 ] || [ $YIELD_MEM -lt 100 ]; then
        echo "Available Memory or the free and buffer+cache Memory is too low!"
        echo "Unhealthy Memory!"
    elif dmesg | grep oom-killer > /dev/null; then
        echo "System is critically low on memory!"
    else
        echo -e "\nMEMORY OK\n........................................"
    fi
}

# Call the memory_util function
memory_util
