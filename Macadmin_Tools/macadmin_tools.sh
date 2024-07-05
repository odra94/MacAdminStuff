#!/bin/bash

######################################
# By: Oscar Reyes
# Last Update: July 5, 2024
# This script will help you install a set of tools that are useful for mac admins.
# You can remove or add installomator labels to your liking. I would use this to install
# all the apps I need when I move to a new work Mac.
######################################


#############################
# Variable you can change
#############################

# - Define applications to install. You can remove or add labels to your liking.
applications=(
    "iterm2"
    "visualstudiocode"
    "apparency"
    "appcleaner"
    "maccyapp"
    "googlechrome"
    "firefox"
    "zoom"
    "rectangle"
    "fsmonitor"
    "imazingprofileeditor"
    "sfsymbols"
    "icons"
    "jamfpppcutility"
    "jamfmigrator"
    "suspiciouspackage"
    "fsmonitor"
    "jamfpppcutility"
    "utm"
)

#############################
# Start of script
#############################

# - Get latest Intallomator
installomatorPath="./installomator"
installomatorScript="$installomatorPath/Installomator.sh"
DEBUG=0

removeInstallomator() {

    echo "Removing Installomator..."
    rm -rf "${installomatorPath}"

}

function checkInstallomator() {

    # The latest version of Installomator and collateral will be downloaded to $installomatorPath defined above
    # Does the $installomatorPath Exist or does it need to be created
    installomatorPath="./installomator"
    installomatorScript="$installomatorPath/Installomator.sh"
    if [ ! -d "${installomatorPath}" ]; then
        echo "$installomatorPath does not exist, create it now"
        mkdir "${installomatorPath}"
    else
        echo "AAP Installomator directory exists"
    fi

    echo "Checking for Installomator.sh at $installomatorScript"
    
    if ! [[ -f $installomatorScript ]]; then
        echo "Installomator was not found at $installomatorScript"
        
        echo "Attempting to download Installomator.sh at $installomatorScript"

        latestURL=$(curl -sSL -o - "https://api.github.com/repos/Installomator/Installomator/releases/latest" | grep tarball_url | awk '{gsub(/[",]/,"")}{print $2}')

        tarPath="$installomatorPath/installomator.latest.tar.gz"

        echo "Downloading ${latestURL} to ${tarPath}"

        curl -sSL -o "$tarPath" "$latestURL" || fatal "Unable to download. Check ${installomatorPath} is writable, or that you haven't hit Github's API rate limit."

        echo "Extracting ${tarPath} into ${installomatorPath}"
        tar -xz -f "$tarPath" --strip-components 1 -C "$installomatorPath" || fatal "Unable to extract ${tarPath}. Corrupt or incomplete download?"
        
        sleep .2

        rm -rf $installomatorPath/*.tar.gz
    else
        echo "Installomator was found at $installomatorScript, checking version..."
        appNewVersion=$(curl -sLI "https://github.com/Installomator/Installomator/releases/latest" | grep -i "^location" | tr "/" "\n" | tail -1 | sed 's/[^0-9\.]//g')
        appVersion="$(cat $fragmentsPath/version.sh)"
        if [[ ${appVersion} -lt ${appNewVersion} ]]; then
            echo "Installomator is installed but is out of date. Versions before 10.0 function unpredictably with App Auto Patch."
            echo "Removing previously installed Installomator version ($appVersion) and reinstalling with the latest version ($appNewVersion)"
            removeInstallomatorOutDated
            sleep .2
            checkInstallomator
        else
            echo "Installomator latest version ($appVersion) installed, continuing..."
        fi
    fi

}

checkInstallomator

for app in "${applications[@]}"; do
    echo "Installing from label: $app"
    ./"${installomatorScript}" $app DEBUG=$DEBUG LOGGING="REQ"
done

removeInstallomator