# Automated Setup Files and Scripts

A set of files and scripts to assist with automating your macOS device setup.

This workflow was inspired by Rob Schroeder's workflows he mentions on his website here for Zoom Room Setups ([techitout](https://techitout.xyz/)). 
After discussing with Rob about the idea of the worklow for an automated setup, we were able to create the worklow. 

1. Mac goes through regular enrollment (skip all setup assistant steps, no enrollment packages. Create an account in the prestage under account settings, and also have the skip account creation option checked. 
2. Have a policy scoped to computers that have enrolled in that prestage, trigger is `enrollmentComplete` set to ongoing. This has 2 script payloads, one script sets up Setup Your Mac at reboot and the second script is this auto login one to log into the account created in the prestage. The policy also has a Restart Options payload to restart the computer after those scripts run. 
3. Mac reboots, auto logs in to account and Setup Your Mac pops up. Policy is called via custom trigger from the Setup Your Mac at reboot script. The policy runs a specific Setup Your Mac script for our needs, then reboots at the end.
4. If you want to disable auto login, just re-run the script without any parameters. That will disable it. And if you want to enable Guest just populate Guest as the username with no password. You can also run this command in a policy (under the files and processes payload) at the end of your Setup Your Mac list. This will remove the autoLoginUser key from the plist.
  - "/usr/bin/defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser"

Dan Snelson's Recon at Reboot: ([Recon at Reboot](https://snelson.us/2022/08/recon-at-reboot-1-0-1/))

  - We used this by updating plist variables and the jamf policy call to specific needs
  - In this instance, we called the Setup Your Mac policy
  - I forked the repo with some additions here: ([forked repo link](https://github.com/AndrewMBarnett/Jamf-Pro-Scripts/blob/master/Recon%20at%20Reboot/Recon%20at%20Reboot.sh))


Joel Bruner's Auto Login Script: ([Joel Bruner's Github](https://github.com/brunerd))

  - We used this script in order to login with the created account.
  - I forked the repo after account variables were added in to the script: ([forked repo link](https://github.com/AndrewMBarnett/macAdminTools/blob/main/Scripts/getAutoLogin.sh)

Dan Snelson's Setup Your Mac: ([Setup Your Mac](https://snelson.us/2024/06/setup-your-mac-1-15-0-with-sym-helper-1-2-0-via-swiftdialog-2-5-0/))

  - We use Dan's Setup Your Mac script in order to automate the policy triggers for software installations other policies

