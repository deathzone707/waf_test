# waf_test

*This code is used to spin up an apache web server and deploy mod security WAF on top of the web server.*

### Make the following adjustments to terraform/variables.tf:
> 1) Set the variable ***ansible_user*** to the desired username
> 2) Set the variable ***cloud_key*** to the GCP computer service account json token.

### Deployment
> 1) From the ./terraform directory run **terraform plan -out=plan.1**
> 2) Verify the terraform plan and run **terraform apply "plan.1"** from the same directory

### Webapp Endpoints
> - http://<GCP_ip>/index.html
>   - This endpoint will show a basic mock login page to protect with a WAF.
> - http://<GCP_ip>/form.php
>   - This endpoint will take use input and the WAF will inspect this input looking for keywords marked as malicious based on custom rules
### Updating Custom Mod Security WAF Rules
> - Custom rules are saved under ./ansible/rules/modsecuritycustomrules.conf
> - More information on rules can be found here: https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-%28v2.x%29#secrule
> - To deploy custom rulesets once the server is running use:</br>
   **cd terraform && ansible-playbook -u <insert_username> --private-key <insert_private_key> -e "inv=host" -i apache.ini ../ansible/custom_rules_deploy.yml**

### Testing WAF deployment
> The WAF deployment can be tested by running: some_script.py