#!/bin/sh
# autoupdate-revision.sh

#!/bin/bash
bN=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$INFOPLIST_FILE")
bN=$((bN += 1))
bN=$(printf "%d" $bN)
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $bN" "$INFOPLIST_FILE"