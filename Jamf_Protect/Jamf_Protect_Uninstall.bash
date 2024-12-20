#!/bin/bash

######################################
# By: Oscar Reyes
# Last Update: December 18, 2024
# This script is meant to always download the latest version of Jamf Protect uninstall package.
######################################

#############################
# Variable you can change
#############################
# Get this download URL from your Jamf Protect Console
download_url=""


#############################
# Start of script
#############################

# Set download location to an existing path on the Mac
download_location="/Users/Shared"

# Make sure you include .pkg at the end of your package name
package_name="JamfProtectUninstaller.pkg"

# Store path of the downloaded package so I can type less later
package_path="$download_location/$package_name"

# Cleanup function to be used later
function cleanup_install ()  {
  rm -r "$package_path"
}

# Extract HTTP code from URL header
http_code="$(curl -sSL -w "%{http_code}\n" -o /dev/null "$download_url")"

# Let anyone reading the output know that we will check for URL validity
echo "Checking if download URL is valid"

# Check if the Jamf Protect download link is valid. I am only accepting code 200
case "$http_code" in
  [2][0-9][0-9])

    echo "Http code: $http_code"
    echo "This download URL works."
    echo "Downloading JamfProtectUninstaller package."
    curl -f "$download_url" -o "$package_path"
    echo "Download complete."
    ;;
  *)
    echo "This download URL does not work"
    echo "Uninstall failed"
    exit 1
    ;;
esac

# Uninstall Jamf Protect
echo "Starting uninstall of JamfProtect."
installer -pkg "$package_path" -target /

# Uninstall should be done. Lets check to make sure
echo "Checking for JamfProtect Application"
if [[ ! -e "/Applications/JamfProtect.app" ]]; then
  echo "JamfProtect.app was uninstalled"

  # Clean up after installtion is done
  echo "Cleaning up after succesful uninstall."
  cleanup_install

  # Exit succesfully
  echo "Exit code: 0"
  exit 0

else
  # If the path does not exist then something went wrong
  echo "Protect did not uninstall correctly."
  echo "It is still in the Applications folder"

  # Call cleanup function
  echo "Cleaning up after failed install."
  cleanup_install

  # Exit with error code 1
  echo "Exit code: 1"
  exit 1
fi
