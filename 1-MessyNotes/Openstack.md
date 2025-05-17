Table of Contents
Introduction and Objectives 3
1 Work Environment and Prerequisites 4
1.1 Work Environment .................................................. 4
1.2 NTP Configuration for Clock Synchronization .................. 6
1.2.1 Installing Chrony ................................................... 6
1.2.2 Configuring Chrony Ofiha les couleur................................................. 6
1.2.3 Verification of Synchronization ................................. 7
1.3 Installation of MariaDB Server ...................................... 7
1.3.1 Step 1: Installing MariaDB .......................................... 7
1.3.2 Step 2: Securing the Installation .................................... 7
1.3.3 Step 3: Configuring MariaDB for OpenStack ..................... 8
1.4 Installation of RabbitMQ, Memcached, and Nginx ................ 10
2 Keystone 12
2.1 Installation and Configuration of the OpenStack Identity Service (Keystone) .... 12
2.1.1 Creating the Keystone Database ................................. 12
2.1.2 Installing Keystone .................................................. 13
2.1.3 Configuring Keystone ............................................... 13
2.1.4 Initializing the Database and Fernet Keys ......................... 16
2.1.5 Configuring Keystone Bootstrap ................................... 16
2.1.6 Configuring Apache Httpd .......................................... 17
2.1.7 Apache Httpd Status ................................................. 17
2.2 Adding Projects in Keystone .......................................... 18
2.2.1 Loading Environment Variables ................................... 18
2.2.2 Creating Projects ..................................................... 19
2.2.3 Verifying Created Projects ......................................... 19
3 Glance Configuration 20
3.1 Adding the Glance User and Creating a Service Entry in Keystone ... 20
3.2 Adding the Glance User and Database in Keystone ................ 22
3.3 Installing Glance .......................................................... 22
3.4 Configuring Glance ....................................................... 22
3.5 Nginx Configuration for Proxy Settings ............................. 24
4 Adding a Virtual Machine Image 25
4.1 Creating the Ubuntu 24.04 VM Image ............................. 25
4.2 Verifying Image Addition ............................................... 26
5 Nova Configuration 27
5.1 Installation and Configuration of the OpenStack Compute Service (Nova) .... 27
5.1.1 Adding Users and Services for Nova in Keystone ............ 27
5.1.2 Installing Nova ......................................................... 30
5.1.3 Configuring Nova .................................................... 30
5.1.4 Installation and Configuration of the Nova Compute Service ... 36
6 Neutron Configuration 38
6.1 Configuration Steps ...................................................... 38
6.2 Configuration of the OpenStack Network Service (Neutron) ... 40
6.2.1 Installing Necessary Services ..................................... 40
6.2.2 Configuring Neutron ................................................. 41
6.2.3 Nginx Proxy ............................................................. 46
6.2.4 Starting Services ...................................................... 47
6.2.5 Verification ............................................................ 48
6.3 Network Configuration for Virtual Instances ......................... 48
6.3.1 Configuring the ens38 Interface ................................... 48
6.3.2 Creating a Physical Bridge with Open vSwitch .................... 48
6.3.3 Creating a Virtual Network ........................................... 49
6.3.4 Validation of the Configuration ..................................... 50
7 Adding a User for OpenStack and Creating a Flavor ................ 52
7.1 Adding User Accounts in Keystone ..................................... 52
7.1.1 Creating a Project ....................................................... 52
7.1.2 Creating a User ......................................................... 52
7.1.3 Assigning Roles to the User ......................................... 53
7.1.4 Configuring Environment Variables ............................... 53
7.1.5 Verifying the Configuration ......................................... 55
7.2 Adding Flavors for Virtual Instances ................................... 55
7.2.1 Creating Flavors ......................................................... 55
7.2.2 Verifying Flavors ......................................................... 57
7.2.3 Flavor Summary ......................................................... 58
8 Creating and Launching an Instance ..................................... 59
8.1 Note ............................................................. 59
8.2 Creating an Instance ..................................................... 59
8.3 Configuring Security Rules .............................................. 62
8.4 SSH Access to the Instance .............................................. 62
8.5 Stopping and Starting the Instance ..................................... 62
8.6 Accessing the VNC Console ............................................. 63
9 Conclusion
