#!/usr/local/bin/python3
import requests
import json

#set the URL to the IP given for your GCE instance
url = "http://35.233.217.213/"

def xss_test(url):
    url = url+"form.php"
    data = {"id":7357, "name":"<script>alert(1)</script>", "age":25}
    headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
    r = requests.post(url, data=json.dumps(data), headers=headers)
    if r.status_code == 403:
        print("WAF blocked XSS.")
    else:
        print(r.status_code+". The WAF did not properly block XSS.")

def input_sanatization_test(url):
    url = url+"form.php"
    data = "whoops"
    r = requests.post(url, data=data)
    if r.status_code == 403:
        print("WAF blocked blacklisted input.")
    else:
        print(r.status_code+". The WAF did not properly block blacklisted input.")

def header_check_test(url):
    headers = {'Content-type': 'malicious', 'Accept': 'text/plain'}
    r = requests.get(url, headers=headers)
    if r.status_code == 404:
        print("WAF blocked malicious HTTP header.")
    else:
        print(r.status_code+". The WAF did not properly block malicious HTTP header.")

def waf_test():
    xss_test(url)
    input_sanatization_test(url)
    header_check_test(url)

if __name__ == "__main__":
    waf_test() 
