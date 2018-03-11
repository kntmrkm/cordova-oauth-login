import LineSDK

@objc(LineLogin) class Line : CDVPlugin, LineSDKLoginDelegate {
    
    var callbackId:String?
    
    func login(_ command: CDVInvokedUrlCommand) {
        self.callbackId = command.callbackId
        LineSDKLogin.sharedInstance().delegate = self
        LineSDKLogin.sharedInstance().start()
    }
    
    func didLogin(_ login: LineSDKLogin, credential: LineSDKCredential?, profile: LineSDKProfile?, error: Error?) {
        if error != nil {
            let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.debugDescription)
            commandDelegate.send(result, callbackId:self.callbackId)
        } else {
            guard let profile = profile, let credential = credential, let accessToken = credential.accessToken else {
                let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Invalid Repsonse")
                commandDelegate.send(result, callbackId:self.callbackId)
                return
            }
            
            var data = ["userid" : profile.userID,
                        "displayname" : profile.displayName,
                        "accesstoken" : accessToken.accessToken]
            
            if let pictureURL = profile.pictureURL {
                data["pictureurl"] = pictureURL.absoluteString
            }
            
            if let statusMessage = profile.statusMessage {
                data["statusmessage"] = statusMessage
            }
            
            let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: data)
            commandDelegate.send(result, callbackId:self.callbackId)
        }
    }
}

