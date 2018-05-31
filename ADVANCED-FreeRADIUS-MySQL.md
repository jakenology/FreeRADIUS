# Setting up FreeRADIUS with MySQL on Debian 9
#### Presented by Jayke Peters

# Enable FreeRADIUS to start upon boot
Enter the following command: `sudo systemctl enable freeradius`
# Sources Used
- [Main Tutorial (Translated) - Rudimar Remontti](https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=https%3A%2F%2Fblog.remontti.com.br%2F2066&edit-text=&act=url "Rudimar Remontti's Tutorial")
- [NTLM Hashing]( https://www.mail-archive.com/freeradius-users@lists.freeradius.org/msg50447.html "Link")

# Hashing Passwords
I highly recommend that you hash your passwords. To do so, follow the steps below:
1. Use the ["`smbencrypt`"](https://www.mankier.com/1/smbencrypt "Man Page") command as shown in the link
2. Note the second "NT" hash. This is the hash we will use to store our passwords.
3. Using a MySQL/MariaDB query, update the password for the user or create a new one entirely with the hashed password. 
    ```
    $ sudo su 
    
    $ mysql

    $ INSERT INTO radius.radcheck (`username`,`attribute`,`op`,`value`) VALUES ('USERNAME','NT-Password',':=','HASH');
    ```
4. Using the ["`radtest`"](https://wiki.freeradius.org/guide/Radtest "Man Page") command, test your new user. If you're having issues, there's a few things you can try:
    1. `radtest "username" "password" localhost 0 testing123`
    - Restarting FreeRADIUS
    - Use a different form of the command
    - Edit your config files to use NTLM Hashing
    - Contact Me - I will help you

# When Problems Occur
- [Errors with phpMyAdmin](https://askubuntu.com/questions/387062/how-to-solve-the-phpmyadmin-not-found-issue-after-upgrading-php-and-apache "Link")
- [Need to add a User](https://dev.mysql.com/doc/refman/8.0/en/adding-users.html "Link")
    - First, issue the following command: `sudo mysql` or `sudo mariadb`
    - Use the commands found in Part 2
- [Set wrong or forgot password](https://askubuntu.com/questions/387062/how-to-solve-the-phpmyadmin-not-found-issue-after-upgrading-php-and-apache "Link")

# Additional Security Measures
If you are going to have your server open to the internet, I highly recommend that you enable custom security features to keep yourself and your user's information safe from hackers. Here's a current list of the things I use and highly recommend:
- [fail2ban](https://www.digitalocean.com/community/tutorials/how-to-protect-an-apache-server-with-fail2ban-on-ubuntu-14-04 "Link")
    - Stops Brute-Force attakcs and malicious requests
- [".htaccess" only](https://www.freesoftwareservers.com/wiki/fail2ban-monitor-htpasswd-htaccess-authorization-3964996.html "Link")
     - Requires username and password authentication on the phpMyAdmin page, or your whole server in general
    
    - [How to unblock IP Address(es)](http://www.whitewareweb.com/how-to-manually-unblock-unban-ip-address-fail2ban/ "Link")
- [HTTPS - SSL](https://vorkbaard.nl/installing-a-mailserver-on-debian-8-part-2-preparations-apache-lets-encrypt-mysql-and-phpmyadmin/
"Link")
    - Encrypts all traffic over port 443 (With Port Forwarding)
- [Wildcard Certificates](https://computingforgeeks.com/generating-letsencrypt-wildcard-ssl-certificate/ "Link")
- [If you're having issues](https://github.com/certbot/certbot/issues/5405 "Link")
- [Configuration Checker](https://www.ssllabs.com "Link")
- [Enable certificates with FreeRADIUS](https://framebyframewifi.net/2017/01/29/use-lets-encrypt-certificates-with-freeradius/ "Link")
    - [Where are my certs?](https://superuser.com/questions/1194523/lets-encrypt-certbot-where-is-the-private-key "Link")
    - Afterwards, enter the following command: 
    - `sudo service freeradius stop; sudo service freeradius start &`
