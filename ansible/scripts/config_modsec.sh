#!/bin/bash
#set to active mode
sudo mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
sudo sed -i "s/SecRuleEngine DetectionOnly/SecRuleEngine On/" /etc/modsecurity/modsecurity.conf
#download the modsecurity OWASP core rule set
sudo mv /usr/share/modsecurity-crs /usr/share/modsecurity-crs.bak
sudo git clone https://github.com/coreruleset/coreruleset.git /usr/share/modsecurity-crs
sudo sed -i 's/.*modsecurity-crs\/owasp-crs.*//' /etc/apache2/mods-enabled/security2.conf
sudo sed -i 's/^<\/IfModule>/\tIncludeOptional \"\/usr\/share\/modsecurity-crs\/*.conf\"\n&/' /etc/apache2/mods-enabled/security2.conf
sudo sed -i 's/^<\/IfModule>/\tIncludeOptional \"\/usr\/share\/modsecurity-crs\/rules\/*.conf\"\n&/' /etc/apache2/mods-enabled/security2.conf
sudo mv /usr/share/modsecurity-crs/crs-setup.conf.example /usr/share/modsecurity-crs/crs-setup.conf
sudo touch /etc/modsecurity/modsecurity_custom_rules.conf
sudo systemctl restart apache2