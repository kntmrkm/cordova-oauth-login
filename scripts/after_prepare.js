#!/usr/bin/env node
'use strict';

// facebook
var fs = require('fs');

var getPreferenceValue = function(config, name) {
    var value = config.match(new RegExp('name="' + name + '" value="(.*?)"', "i"))
    if(value && value[1]) {
        return value[1]
    } else {
        return null
    }
}

if(process.argv.join("|").indexOf("FB_APP_ID=") > -1) {
	var FB_APP_ID = process.argv.join("|").match(/FB_APP_ID=(.*?)(\||$)/)[1]
} else {
	var config = fs.readFileSync("config.xml").toString()
	var FB_APP_ID = getPreferenceValue(config, "FB_APP_ID")
}

var files = [
    "platforms/browser/www/plugins/cordova-oauth-login/www/facebook-browser.js",
    "platforms/browser/platform_www/plugins/cordova-oauth-login/www/facebook-browser.js",
    "platforms/browser/www/cordova.js",
    "platforms/browser/platform_www/cordova.js"
]

for(var i in files) {
    try {
    	var contents = fs.readFileSync(files[i]).toString()
	    fs.writeFileSync(files[i], contents.replace(/FB_APP_ID/g, FB_APP_ID))
	} catch(err) {}
}

// line
var fs = require("fs")
var os = require("os")
var execSync = require('child_process').execSync

var stdio = {stdio:[0,1,2]};

module.exports = function (context) {
  var rootPath = context.opts.projectRoot
  var platformPath = rootPath + "/platforms/android"
  var propertiesPath = platformPath + "/gradle.properties"

  if (!existsFile(propertiesPath)) {
    execSync("touch " + propertiesPath, stdio);
  }

  var text = fs.readFileSync(propertiesPath, "utf-8")
  if (text.match(/android\.enableD8\.desugaring/) == null) {
    if (text.length == 0) {
      text = "android.enableD8.desugaring=true"
    } else {
      text = text + os.EOL + "android.enableD8.desugaring=true"
    }
    fs.writeFileSync(propertiesPath, text)
  }

  function existsFile(path) {
    try {
      fs.statSync(path)
      return true
    } catch(err) {
      return false
    }
  }
}
