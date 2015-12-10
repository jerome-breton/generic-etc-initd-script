# generic-etc-initd-script
A generic file to build /etc/init.d services script

You just have to modify the first 4 variables to make any command line a service.

You can after that use this script to launch your software on system startup using

     sudo update-rc.d your-service-script-file-name enable #(or chkconfig for CentOs like)

I have found this script in my old server. I really do not think I am the original author of all this. If you recognize the original work, please tell me so I can add credits and license.
