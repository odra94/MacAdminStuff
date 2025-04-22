### Here's how to remove a non-removable MDM profile
1. Boot the Mac into Recovery Mode (hold down command+R during startup).
2. Go to the Utilities menu and open Terminal and type: `csrutil disable`. This will disable SIP (System Integrity Protection).
3. Reboot into the OS.
4. Open the integrated terminal and type:

```bash
cd /var/db/ConfigurationProfiles
rm -rf *
mkdir Settings
touch Settings/.profilesAreInstalled
```
5. Reboot. 
6. Boot the Mac into Recovery Mode (hold down command+R during startup).
7. Go to the Utilities menu and open Terminal and type: `csrutil enable`. This will re-enable SIP.
8. Reboot into the OS.

The profile will be now removed and you will be able to re-enroll the Mac to your MDM.

Originally written by Zeno Popovici, 26 May 2021

We recovered this infromation from the Wayback Machine Internet Archive.
