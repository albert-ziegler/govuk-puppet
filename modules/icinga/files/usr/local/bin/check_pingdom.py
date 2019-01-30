#!/usr/bin/env python

#
# Testing: ./check_pingdom.py <checkid>
#    Pingdom IDs are found in manifests/config/pingdom.pp
#    You must have an /etc/pingdom.ini which looks like templates/etc/pingdom.ini.erb
#

import base64
import sys
import ConfigParser
import json
from urllib2 import *

# General Config
pingdom_api_host = "api.pingdom.com"
config_file      = "/etc/pingdom.ini"

def unknown(message):
    print "UNKNOWN: %s" % message
    sys.exit(3)

def critical(message):
    print "CRITICAL: %s" % message
    sys.exit(2)

def warning(message):
    print "WARNING: %s" % message
    sys.exit(1)

def ok(message):
    print "OK: %s" % message
    sys.exit(0)


class Config :
    pingdom_pass = None
    pingdom_key  = None
    pingdom_user = None

    def __init__(self) :
        try:
            config = ConfigParser.ConfigParser()
            config.read(config_file)
            self.pingdom_pass = config.get('DEFAULT','pingdom_pass')
            self.pingdom_key  = config.get('DEFAULT','pingdom_key')
            self.pingdom_user = config.get('DEFAULT','pingdom_user')
        except:
            unknown("Could not read config file %s" % config_file)


def check_arguments():
    if len(sys.argv) != 2:
        unknown("No check ID passed as a parameter")
    else:
        check_id = sys.argv[1]
        return check_id

def check_pingdom_up():
    try:
        urlopen("https://%s/" % pingdom_api_host, None, 5)
    except HTTPError:
        pass
    except:
        unknown("Pingdom API Down")

def parse_pingdom_result(json_result):
    try:
        message = "\n\n"
        message += "Check Status:  %s\n" % json_result['check']['status'].upper()
        message += "Check Name:    %s\n" % json_result['check']['name']
        if json_result['check']['type']['http']['encryption']:
            scheme = "https"
        else:
            scheme = "http"
        message += "Check URL:     %s://%s%s\n" % ( scheme,
                                                json_result['check']['hostname'],
                                                json_result['check']['type']['http']['url'] )
        if 'shouldcontain' in json_result['check']['type']['http'].keys():
            message += "Expected Text: %s\n" % json_result['check']['type']['http']['shouldcontain']
        message += "Pingdom URL:   https://my.pingdom.com/reports/uptime#check=%s&daterange=7days\n" % json_result['check']['id']
        return message
    except:
        #This is extra details that are nice to have, it should never break execution
        return ""

def get_pingdom_result(config,check_id):
    try:
        basic_auth_token = "Basic " + base64.b64encode("{0}:{1}".format(config.pingdom_user, config.pingdom_pass))
        pingdom_url = "https://%s/api/2.0/checks/%s" % (pingdom_api_host, check_id)
        req = Request(pingdom_url)
        req.add_header("App-Key", config.pingdom_key)
        req.add_header("Authorization", basic_auth_token)
        try:
            result = urlopen(req)
        except HTTPError, e:
            unknown("Could not retrieve check result (%s)" % e)
        pingdom_check = json.loads(result.read())
        try:
            status = pingdom_check['check']['status']
            message = parse_pingdom_result(pingdom_check)

            if status == 'up':
                ok("Pingdom reports this URL is UP" + message)
            elif status in ['unknown']:
                unknown("Pingdom check in unknown state" + message)
            elif status in ['unconfirmed_down','paused']:
                warning("Pingdom check is neither up nor down!" + message)
            else:
                critical("Pingdom reports this URL is not UP" + message)
        except Exception, e:
            unknown("Could not parse Pingdom output (%s)" % e)
    except Exception, e:
        unknown("Unknown %s retrieving check status" % e)

check_pingdom_up()
get_pingdom_result(Config(),check_arguments())
