(function(jQuery) {
if (typeof jQuery === "undefined") window.DC_alert("jQuery is not available!!!");

if (typeof Delfino === "undefined") {
var currentElement = null;
function setFocusBack() {
    if(currentElement) {
        if(currentElement.focus) {
            currentElement.focus();
        }
        currentElement = null;
    }
}

var _SignType = {
    LOGIN: 'LOGIN',
    AUTH: 'AUTH',
    AUTH2: 'AUTH2',
    SAUTH: 'SAUTH',
    SIMPLE: 'SIMPLE',
    CONFIRM: 'CONFIRM',
    MULTI: 'MULTI'
};

var _Delfino = {
    jQuery : jQuery,
    completes : {},
    completeHandle : ((new Date().getTime())%100000),

    inited: false,

    SignType: _SignType,

    addComplete:function(complete)
    {
        complete = complete || {};
        if( typeof complete === "function" ){
            complete = {complete:complete};
        }
        
        var handle = this.completeHandle++;
        this.completes[handle] = complete;
        return handle;
    },
    getComplete:function(handle)
    {
        var complete = this.completes[handle];
        return complete;
    },
    removeComplete:function(handle)
    {
        delete this.completes[handle];
    },
    emptyComplete:function(handle)
    {
        var size = 0, key;
        for (key in this.completes) {
            if (this.completes.hasOwnProperty(key)) size++;
        }
        return size === 0;
    },
    
    isInstall:function (goInstall,completeCallback) {
        var ret = this.init(goInstall);
        if(completeCallback != undefined)
            completeCallback(ret);
    },

    isNativeAppMode: function() {
        var _VPCGClient = window.VPCGClientApp || (top && top.VPCGClientApp);
        var _DelfinoG10Sign = window.DelfinoG10Sign;
        
        if(_VPCGClient && _DelfinoG10Sign && typeof _DelfinoG10Sign === 'function') {
            return true;
        }
        return false;
    },

    /**
     * WizIn Delfino 초기화하기 위한 함수이다.
     */
    init:function(installCheck)
    {
        currentElement = document.activeElement;
        if(this.inited) return true;

        if(DCrypto == null) {
            if(DCrypto == null) {
                if (typeof installCheck != "undefined" && installCheck == false) return false;
                if (DelfinoConfig.installMessage.NO != "") {
                    window.DC_alert(DelfinoConfig.installMessage.NO);
                }
                return false;
            }
        }
        if(DCrypto.init(installCheck)==false) return false;


        var config="";
        config += "IssuerCertFilter=";
        config += encodeURIComponent(DelfinoConfig.issuerCertFilter);
        config += "&PolicyOidCertFilter=";
        config += encodeURIComponent(DelfinoConfig.policyOidCertFilter);

        if(DelfinoConfig.hsmUsingDrivers!=null){
            config += "&hsm.usingDrivers=";
            config += encodeURIComponent(DelfinoConfig.hsmUsingDrivers);
        }

        if(DelfinoConfig.slmNPKIAuthLogging!=null){
            config += "&slmLoggingFunctionName=";
            config += encodeURIComponent(DelfinoConfig.slmNPKIAuthLogging);
        }
        if(DelfinoConfig.forceScreenKeyboard!=null){
            config += "&forceScreenKeyboard=";
            config += encodeURIComponent(DelfinoConfig.forceScreenKeyboard);
        }

        DCrypto.setConfig(config);
        this.inited = true;

        try{
            var properties = {};

            properties["cacheCertStore"] ="" + DelfinoConfig.cacheCertStore;
            properties["certStoreFilter"] = DelfinoConfig.certStoreFilter;
            if( DelfinoConfig.prepareCertStore!=null ) properties["prepareCertStore"] = DelfinoConfig.prepareCertStore; //v1.2.3.0 over
            if( DelfinoConfig.disableCertStore!=null ) properties["disableCertStore"] = DelfinoConfig.disableCertStore;

            //alert(ubikeyConfig.enable+"\n"+ubikeyConfig.download+"\n"+ubikeyConfig.version);
            if(navigator.userAgent.match(/Mac OS X/i)) {
                properties["ubikey.enable"] =    ubikeyConfigMac.enable;
                properties["ubikey.download"] =  ubikeyConfigMac.download;
                properties["ubikey.version"] =   ubikeyConfigMac.version;
                properties["ubikey.update"] =    ubikeyConfigMac.update;
                properties["ubikey.securekeyboard"] =    ubikeyConfigMac.securekeyboard;
            }
            else if(navigator.userAgent.match(/Linux/i)) {
                properties["ubikey.enable"] =    ubikeyConfigLinux.enable;
                properties["ubikey.download"] =  ubikeyConfigLinux.download;
                properties["ubikey.version"] =   ubikeyConfigLinux.version;
                properties["ubikey.update"] =    ubikeyConfigLinux.update;
                properties["ubikey.securekeyboard"] =    ubikeyConfigLinux.securekeyboard;
            }
            else {
                properties["ubikey.enable"] =    ubikeyConfig.enable;
                if(navigator.platform == "Win64") {
                    properties["ubikey.download"] =  ubikeyConfig.download_x64;
                    properties["ubikey.version"] =   ubikeyConfig.version_x64;
                }
                else {
                    properties["ubikey.download"] =  ubikeyConfig.download;
                    properties["ubikey.version"] =   ubikeyConfig.version;
                }
                properties["ubikey.update"] =    ubikeyConfig.update;
                properties["ubikey.securekeyboard"] =    ubikeyConfig.securekeyboard;
            }

            //alert(mobisignConfig.enable+"\n"+mobisignConfig.download+"\n"+mobisignConfig.version);
            properties["mobisign.enable"] =  mobisignConfig.enable;
            properties["mobisign.download"] =mobisignConfig.download;
            properties["mobisign.version"] = mobisignConfig.version;
            properties["mobisign.sitecode"] = mobisignConfig.sitecode;
            properties["mobisign.aclist"] = mobisignConfig.aclist;
            
            if(DelfinoConfig.smartone!=null){
                properties["smartone.enable"] = "" + DelfinoConfig.smartone.enable;
                if(DelfinoConfig.smartone.version!=null) properties["smartone.version"] = DelfinoConfig.smartone.version;
                properties["smartone.download"] = DelfinoConfig.smartone.download;
                properties["smartone.host"] = DelfinoConfig.smartone.host;
                properties["smartone.port"] = "" + DelfinoConfig.smartone.port;
                properties["smartone.siteCode"] = DelfinoConfig.smartone.siteCode;
            }
            
            if( DelfinoConfig.usim!=null ) {
                properties["usim.usingDrivers"] = DelfinoConfig.usim.usingDrivers;
                properties["usim.certSelector"] = DelfinoConfig.usim.certSelector;
                properties["usim.displayDataAtMobile"] = "" + DelfinoConfig.usim.displayDataAtMobile;
                properties["usim.siteDomain"] = DelfinoConfig.usim.siteDomain;
                properties["usim.disableInHSM"] = "" + DelfinoConfig.usim.disableInHSM;
                
                if(DelfinoConfig.usim.raon!=null){
                    properties["usim.raon.siteCode"] = DelfinoConfig.usim.raon.siteCode;
                    properties["usim.raon.displayDataAtMobile"] = "" + DelfinoConfig.usim.raon.displayDataAtMobile;
                    properties["usim.raon.download"] = DelfinoConfig.usim.raon.download;
                }
                
                if(DelfinoConfig.usim.dream!=null){
                    properties["usim.dream.download"] = DelfinoConfig.usim.dream.download;
                    properties["usim.dream.displayDataAtMobile"] = "" + DelfinoConfig.usim.dream.displayDataAtMobile;
                    properties["usim.dream.host"] = DelfinoConfig.usim.dream.host;
                    properties["usim.dream.port"] = DelfinoConfig.usim.dream.port;
                }
                
                if(DelfinoConfig.usim.sumion!=null){
                    properties["usim.sumion.download"] = DelfinoConfig.usim.sumion.download;
                    properties["usim.sumion.displayDataAtMobile"] = "" + DelfinoConfig.usim.sumion.displayDataAtMobile;
                    properties["usim.sumion.host"] = DelfinoConfig.usim.sumion.host;
                    properties["usim.sumion.port"] = DelfinoConfig.usim.sumion.port;
                }
            }

            if( DelfinoConfig.safehard!=null ) {
                properties["safehard.order"] = "" + DelfinoConfig.safehard.order;
                properties["safehard.version"] = DelfinoConfig.safehard.version;
                properties["safehard.download"] = DelfinoConfig.safehard.download;
                properties["safehard.downloadNormal"] = DelfinoConfig.safehard.downloadNormal;
                properties["safehard.cloudUrl"] = DelfinoConfig.safehard.cloudUrl;
                properties["safehard.secureKeyboardConfig"] = JSON.stringify(DelfinoConfig.safehard.secureKeyboardConfig);
            }
            
            if(DelfinoConfig.secureDisk!=null){
                properties["secureDisk.order"] = "" + DelfinoConfig.secureDisk.order;
                properties["secureDisk.enable"] = "" + DelfinoConfig.secureDisk.enable;
                properties["secureDisk.version"] = DelfinoConfig.secureDisk.version;
                properties["secureDisk.download"] = DelfinoConfig.secureDisk.download;
            }
            
            if(DelfinoConfig.EA!=null){
                if (!Delfino.isSupportedEA()) DelfinoConfig.EA.enable = false;
                properties["EA.enable"] = "" + DelfinoConfig.EA.enable;
            }
            
            if(DelfinoConfig.myPassword!=null){
                properties["myPassword.enable"] = "" + DelfinoConfig.myPassword.enable;
            }
            
            if(DelfinoConfig.connected!=null){
                properties["connected.servers"] = JSON.stringify(DelfinoConfig.connected);
            }
            
            if(DelfinoConfig.oneSign!=null){
                properties["oneSign.enable"] = "" + DelfinoConfig.oneSign.enable;
            }
            
            if( DelfinoConfig.KTB!=null && DelfinoConfig.KTB.DGBank!=null) {
                properties["KTB.DGBank.version"] = DelfinoConfig.KTB.DGBank.version;
                properties["KTB.DGBank.ip"] = DelfinoConfig.KTB.DGBank.ip;
                properties["KTB.DGBank.port"] = DelfinoConfig.KTB.DGBank.port;
                properties["KTB.DGBank.publickey"] = DelfinoConfig.KTB.DGBank.publickey;
            }
            
            
            if(DelfinoConfig.style!=null){
                properties["style.button"] = JSON.stringify(DelfinoConfig.style.button);
                properties["style.tab"] = JSON.stringify(DelfinoConfig.style.tab);
                
                if(DelfinoConfig.style.keyboard) {
                    if(DelfinoConfig.style.keyboard.logoUrl)
                        DelfinoConfig.style.keyboard.logo = DC_get(DelfinoConfig.style.keyboard.logoUrl, undefined, true);
                    properties["style.keyboard"] = JSON.stringify(DelfinoConfig.style.keyboard);
                }
            }
            

            properties["securekeyboard.enable"] = "" + secureKeyboardConfig.enable;
            properties["securekeyboard.products"] = secureKeyboardConfig.product;
            
            var productArray = secureKeyboardConfig.product.split(',');
            //properties["securekeyboard.product"] = productArray[0]; //v3140 below
            properties["securekeyboard.product"] = productArray[productArray.length-1]; //v3140 below
            
            properties["securekeyboard.toggle"] = "" + secureKeyboardConfig.toggle;
            properties["securekeyboard.showMessage"] = "" + secureKeyboardConfig.showMessage;
            properties["uiType"] =DelfinoConfig.uiType;
            properties["enableCheckVid"] ="" + DelfinoConfig.enableCheckVid;
            properties["passwordCounter"] = DelfinoConfig.passwordCounter;
            properties["installError"] = "" + DelfinoConfig.installError;
            
            if(secureKeyboardConfig.option != null) properties["securekeyboard.option"] = JSON.stringify(secureKeyboardConfig.option);
            
            if(DelfinoConfig.enableHsmGuide != null) properties["enableHsmGuide"] = "" + DelfinoConfig.enableHsmGuide;
            
            if(DelfinoConfig.license!=null) properties["license"] = DelfinoConfig.license;

            if(DelfinoConfig.sitename!=null) properties["sitename"] = DelfinoConfig.sitename;
            
            if(DelfinoConfig.multiDomain!=null) properties["domain"] = DelfinoConfig.multiDomain;
            
            if(DelfinoConfig.changePasswordPolicy!=null) properties["changePasswordPolicy"] = DelfinoConfig.changePasswordPolicy;

            if(DelfinoConfig.lastUsedCertFirst!=null) properties["lastUsedCertFirst"] = DelfinoConfig.lastUsedCertFirst;
            
            if(DelfinoConfig.cloudcert!=null) {
                
                properties["cloudcert.enable"] = "" + DelfinoConfig.cloudcert.enable;
                
                if(DelfinoConfig.cloudcert.encryptedParams!=null) properties["cloudcert.encryptedParams"] = DelfinoConfig.cloudcert.encryptedParams;
                
                if(DelfinoConfig.cloudcert.encryptedParams_test!=null) properties["cloudcert.encryptedParams_test"] = DelfinoConfig.cloudcert.encryptedParams_test;
                
                if(DelfinoConfig.cloudcert.cloudMode!=null) properties["cloudcert.cloudMode"] = DelfinoConfig.cloudcert.cloudMode;
                
                if(DelfinoConfig.cloudcert.mode!=null) properties["cloudcert.mode"] = DelfinoConfig.cloudcert.mode;
            }

            if(DelfinoConfig.closeOnWrongPassword!=null) properties["closeOnWrongPassword"] = DelfinoConfig.closeOnWrongPassword;

            if(DelfinoConfig.nonceKeyName!=null)  properties["nonceKeyName"] = DelfinoConfig.nonceKeyName;

            this.setProperties(properties);

        }catch(e){ window.DC_alert("Delfino.init()\n" + e); }

        if(DelfinoConfig.lang != null){
            this.setLang(DelfinoConfig.lang);
        }
        //else{
        //  this.setLang(_Delfino_SystemLang);
        //}


        return true;
    },
    setProperties:function(properties) {
        for(var key in properties) {
            if(typeof properties[key] !== "function"){
                DCrypto.setProperty(key, properties[key]);
            }
        }
    },

    /**
     * 공인인증서 로그인을 위한 전자서명데이터를 생성하여 서버로 전송한다.
     * @param {HTMLFormElement} form 서명할 내용을 가지고 있는 HTMLFormElement
     * @param {function} successCB  전자서명 성공시 전자서명 데이터를 직접받아서 처리할 때 사용하는 콜백 함수이다.
     *                              함수 형식은 successCB(pkcs7, vid_random)이다.
     *                              이 인자를 설정했을 경우에는 서명데이터를 서버로 전송하지 않는다.
     */

    generatePKCS7SignedDataSuccessCallback:null,
    generatePKCS7SignedDataErrorCallback:null,

    loginForm:function(form, successCB, errorCB)
    {
        this.inited = false; //로그인시 무조건 초기화 처리

        if(this.init() == false) return;

        this.generatePKCS7SignedDataSuccessCallback = successCB;
        this.generatePKCS7SignedDataErrorCallback = errorCB;
        if(this.generatePKCS7SignedDataSuccessCallback==null){
            if(jQuery("#Delfino_PKCS7_form").length==0){
                jQuery('body').append('<form id="Delfino_PKCS7_form"><input type="hidden" name="PKCS7"><input type="hidden" name="VID_RANDOM"></form>');
            }
            var pkcs7Form = jQuery("#Delfino_PKCS7_form")[0];

            pkcs7Form.method = form.method;
            pkcs7Form.action = form.action;
            pkcs7Form.target = form.target;
        }

        var data = jQuery(form).serialize();

        //alert(data);

        DCrypto.resetCertificate();

        this.loadLogoImage(DelfinoConfig.logoImageUrl);
        
        if(this.getModule() == "G2"){
            DCrypto.generatePKCS7SignedData(data, "Delfino_generatePKCS7SignedData_success_callback", "Delfino_error_callback", options);
            return;
        }
        
        //G3, G4
        var options = {};
        options.signedAttribute = "certStoreType";
        options.attributeAsData = true;
        options.resetCertificate = true;
        options.cacheCert = true;
            
        this.sign(data, options, function(result){
                if(result.status == 1){
                    Delfino_generatePKCS7SignedData_success_callback(result.signData, result.vidRandom);
                }
                else{
                    Delfino_error_callback(result.status, result.message);
                }
            });
    },

    /**
     * PKCS#7 전자서명데이터를 생성하여 서버로 전송한다.
     * @param {HTMLFormElement} form 서명할 내용을 가지고 있는 HTMLFormElement
     * @param {function} successCB  전자서명 성공시 전자서명 데이터를 직접받아서 처리할 때 사용하는 콜백 함수이다.
     *                              함수 형식은 successCB(pkcs7, vid_random)이다.
     *                              이 인자를 설정했을 경우에는 서명데이터를 서버로 전송하지 않는다.
     *
     */

    signForm : function(form, successCB, errorCB)
    {
        if(this.init() == false) return;

        try{
            this.generatePKCS7SignedDataSuccessCallback = successCB;
            this.generatePKCS7SignedDataErrorCallback = errorCB;
            if(this.generatePKCS7SignedDataSuccessCallback==null){
                if(jQuery("#Delfino_PKCS7_form").length==0){
                    //alert("delfino_form not found");
                    jQuery('body').append('<form id="Delfino_PKCS7_form"><input type="hidden" name="PKCS7"><input type="hidden" name="VID_RANDOM"></form>');
                }
                var pkcs7Form = jQuery("#Delfino_PKCS7_form")[0];

                pkcs7Form.method = form.method;
                pkcs7Form.action = form.action;
                pkcs7Form.target = form.target;
            }

            var data = jQuery(form).serialize();
            var rselectTextarea = /^(?:select|textarea)/i;
            var rinput = /^(?:color|date|datetime|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i;

            var formats = jQuery(form).map(function(){
                return this.elements ? jQuery.makeArray(this.elements) : this;
            }).filter(function(){
                return this.name && !this.disabled &&
                (this.checked || rselectTextarea.test(this.nodeName) ||
                rinput.test(this.type));
            }).map(function(i, elem){
                var val = jQuery(this).attr('format');

                return val == null ? null : {
                    name: elem.name,
                    value: val
                };
            }).get();

            var formatsParam = jQuery.param(formats);
            
            this.loadLogoImage(DelfinoConfig.logoImageUrl);            
            
            if(this.getModule() == "G2"){
                if(formatsParam.length>0){
                    data = data + "&" + "__USER_CONFIRM_FORMAT=" + encodeURIComponent(formatsParam) ;
                }
                DCrypto.generatePKCS7SignedData(data, "Delfino_generatePKCS7SignedData_success_callback", "Delfino_error_callback");
                return;
            }
            
            //G3, G4
            var options = {};
            options.signedAttribute = "certStoreType";
            options.attributeAsData = true;
            if(formatsParam.length>0){
                options.format = formatsParam;
            }
            options.dataType = "form-urlencoded";
            
            this.sign(data, options, function(result){
                    if(result.status == 1){
                        Delfino_generatePKCS7SignedData_success_callback(result.signData, result.vidRandom);
                    }
                    else{
                        Delfino_error_callback(result.status, result.message);
                    }
                });
        }catch(e){
            window.DC_alert("signForm:"+e);
        }
    },

    signKeyValue:function(keys, values, formats, delimeter, successCB, errorCB)
    {
        if(this.init() == false) return;

        if(successCB==null){
            window.DC_alert("successCB can NOT be null");
            return;
        }
        if( keys == null ){
            window.DC_alert("keys can NOT be null");
            return;
        }
        if( delimeter == null ){
            window.DC_alert("delimeter can NOT be null");
            return;
        }

        var keyArray = keys.split(delimeter);
        var valueArray = values.split(delimeter);

        var formatArray = null;
        if(formats!=null && formats.length>0){
            formatArray = formats.split(delimeter);
        }

        if(keyArray.length != valueArray.length || (formatArray!=null && valueArray.length!= formatArray.length)){
            window.DC_alert("signKeyValue invalid argument");
            return;
        }

        var data = "";
        var format = "";
        for(var i=0; i<keyArray.length; i++){
            if(data.length>0){
                data += "&";
            }
            data += encodeURIComponent(keyArray[i]);
            data += "=";
            data += encodeURIComponent(valueArray[i]);

            if(format.length>0){
                format += "&";
            }
            if (formatArray!=null) {

                format += encodeURIComponent(keyArray[i]);
                format += "=";
                format += encodeURIComponent(formatArray[i]);
            }
        }
        
        this.generatePKCS7SignedDataSuccessCallback = successCB;
        this.generatePKCS7SignedDataErrorCallback = errorCB;

        this.loadLogoImage(DelfinoConfig.logoImageUrl);		
        if(this.getModule() == "G2"){
            if(format.length>0){
                data = data + "&" + "__USER_CONFIRM_FORMAT=" + encodeURIComponent(format) ;
            }
            DCrypto.generatePKCS7SignedData(data, "Delfino_generatePKCS7SignedData_success_callback", "Delfino_error_callback");
            return;
        }
        
        //G3, G4
        var options = {};
        options.signedAttribute = "certStoreType";
        options.attributeAsData = true;
        if(format.length>0){
            options.format = format;
            options.signedAttribute += ",format";
        }
        options.dataType = "form-urlencoded";
        
        this.sign(data, options, function(result){
                if(result.status == 1){
                    Delfino_generatePKCS7SignedData_success_callback(result.signData, result.vidRandom);
                }
                else{
                    Delfino_error_callback(result.status, result.message);
                }
            });
    },

    multiSignString : function(datas, delimeter, successCB, errorCB)
    {
        if(this.init() == false) return;
        
        this.generatePKCS7SignedDataSuccessCallback = successCB;
        this.generatePKCS7SignedDataErrorCallback = errorCB;

        this.loadLogoImage(DelfinoConfig.logoImageUrl);
        
        if(this.getModule() == "G2"){
            DCrypto.generateMultiPKCS7SignedData(datas, delimeter, "Delfino_generatePKCS7SignedData_success_callback", "Delfino_error_callback");
            return;
        }
        
        //G3, G4
        var options = {};
        options.multiSign = true;
        options.multiSignDelimiter = delimeter;
        options.signedAttribute = "signingTime";
        
        this.sign(data, options, function(result){
                if(result.status == 1){
                    Delfino_generatePKCS7SignedData_success_callback(result.signData, result.vidRandom);
                }
                else{
                    Delfino_error_callback(result.status, result.message);
                }
            });
        
    },


    /**
     * document.write를 이용해서 object 태그로 WizIn Delfino Plugin을 생성한다.
     */
    createObject:function()
    {
        document.write(DCrypto.getObjectTag());
    },

    /**
     * WizIn Delfino Plugin을 생성하기 위한 object tag 스트링을 리턴한다.
     * @return {String} object tag 스트링
     */
    getObjectTag:function()
    {
        return DCrypto.getObjectTag();
    },

    /**
     * 공인인증서 관리창을 띄운다.
     */
    manageCertificate:function(options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;

        if(this.init() == false) return;
        if (typeof complete == "undefined") {
            DCrypto.manageCertificate();
        } else {
            options = options || {};
            var handle = this.addComplete(complete);
            DCrypto.manageCertificate(handle, JSON.stringify(options));
        }
    },

    loadLogoImage:function(url)
    {
        var logoImage = null;

        if(DCrypto.getVersion != null && typeof DelfinoConfig.logoImageUrl_428x81 != "undefined"){
            var version = DCrypto.getVersion();
            if(version!=null && version!=""){
                if(DC_compareVersion(version, "1.2.2.0") >= 0) {
                    var newImageUrl = DelfinoConfig.logoImageUrl_428x81;
                    logoImage = DC_get(newImageUrl, Delfino.getModule(), true);
                }
            }
        }
        if(logoImage==null){
            logoImage = DC_get(url, Delfino.getModule(), true);
        }
        if(logoImage!=null){
            DCrypto.setProperty("delfino.logoimage", logoImage);
        }
    },

    requestCertificate_complete_callback:null,
    requestCertificate:function(ca, referenceValue, secretValue, complete)
    {
        if(this.init() == false) return;

        //this.loadLogoImage(DelfinoConfig.logoImageUrl);

        this.requestCertificate_complete_callback = complete;
        var host;
        var port;
        if(ca == "yessign"){
            host = DelfinoConfig.yessignCaHost;
            port = DelfinoConfig.yessignCaPort;
        }
        else if(ca == "crosscert"){
            host = DelfinoConfig.crosscertCaHost;
            port = DelfinoConfig.crosscertCaPort;
        }
        else if(ca == "signkorea"){
            host = DelfinoConfig.signkoreaCaHost;
            port = DelfinoConfig.signkoreaCaPort;
        }
        else if(ca == "yessignWebCmp"){
            if(this.getModule() != "G4" && this.getModule() != "G5" && this.getModule() != "G10"){
                window.DC_alert("Only G4, G5, G10 support WebCMP");
                return;
            }
            host = DelfinoConfig.yessignWebCmpUrl;
            port = 0;
        }
        else if(ca === 'fincert' || ca === 'fincertcorp') {
            
        }
        else{
            window.DC_alert("not supported ca:" + ca);
            return;
        }
        if(this.getModule() == "G2"){
            DCrypto.requestCertificate(ca, host, port, referenceValue, secretValue, "Delfino_requestCertificate_complete_callback");
            return;
        }
                
        var handle = this.addComplete(function(result){
            complete(result.status, result.message);            
        });
        var options = {};
        DCrypto.requestCertificate2(handle, ca, host, port, referenceValue, secretValue, JSON.stringify(options));
    },
    updateCertificate_complete_callback:null,
    updateCertificate:function(ca, complete)
    {
        if(this.init() == false) return;

        this.updateCertificate_complete_callback = complete;
        var host;
        var port;
        if(ca == "yessign"){
            host = DelfinoConfig.yessignCaHost;
            port = DelfinoConfig.yessignCaPort;
        }
        else if(ca == "crosscert"){
            host = DelfinoConfig.crosscertCaHost;
            port = DelfinoConfig.crosscertCaPort;
        }
        else if(ca == "signkorea"){
            host = DelfinoConfig.signkoreaCaHost;
            port = DelfinoConfig.signkoreaCaPort;
        }
        else if(ca == "yessignWebCmp"){
            if(this.getModule() != "G4" && this.getModule() != "G5" && this.getModule() != "G10"){
                window.DC_alert("Only G4, G5, G10 support WebCMP");
                return;
            }
            host = DelfinoConfig.yessignWebCmpUrl;
            port = 0;
        }
        else if(ca === 'fincert' || ca === 'fincertcorp') {
            
        }
        else{
            window.DC_alert("not supported ca:" + ca);
            return;
        }
        if(this.getModule() == "G2"){
            DCrypto.updateCertificate(ca, host, port, "Delfino_updateCertificate_complete_callback");
            return;
        }
                
        var handle = this.addComplete(function(result){
            complete(result.status, result.message);
        });
        var options = {};
        
        DCrypto.updateCertificate2(handle, ca, host, port, JSON.stringify(options));
    },

    requestCertificate2:function(ca, referenceValue, secretValue, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;

        var host;
        var port;
        if(ca == "yessign"){
            host = DelfinoConfig.yessignCaHost;
            port = DelfinoConfig.yessignCaPort;
        }
        else if(ca == "crosscert"){
            host = DelfinoConfig.crosscertCaHost;
            port = DelfinoConfig.crosscertCaPort;
        }
        else if(ca == "signkorea"){
            host = DelfinoConfig.signkoreaCaHost;
            port = DelfinoConfig.signkoreaCaPort;
        }
        else if(ca == "kica"){
            host = DelfinoConfig.kicaCaHost;
            port = DelfinoConfig.kicaCaPort;
        }
        else if(ca == "yessignWebCmp"){
            if(this.getModule() != "G4" && this.getModule() != "G5" && this.getModule() != "G10"){
                window.DC_alert("Only G4, G5, G10 support WebCMP");
                return;
            }
            host = DelfinoConfig.yessignWebCmpUrl;
            port = 0;
        }
        else if(ca === 'fincert' || ca === 'fincertcorp') {

        }
        else{
            window.DC_alert("not supported ca:" + ca);
            return;
        }

        if(options == null) options = {};
        if(options.enableKmCert==null && DelfinoConfig.enableKmCert!=null) options.enableKmCert = DelfinoConfig.enableKmCert;

        var handle = this.addComplete(complete);
        DCrypto.requestCertificate2(handle, ca, host, port, referenceValue, secretValue, JSON.stringify(options));
    },

    updateCertificate2:function(ca, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;

        this.loadLogoImage(DelfinoConfig.logoImageUrl);

        var host;
        var port;
        if(ca == "yessign"){
            host = DelfinoConfig.yessignCaHost;
            port = DelfinoConfig.yessignCaPort;
        }
        else if(ca == "crosscert"){
            host = DelfinoConfig.crosscertCaHost;
            port = DelfinoConfig.crosscertCaPort;
        }
        else if(ca == "signkorea"){
            host = DelfinoConfig.signkoreaCaHost;
            port = DelfinoConfig.signkoreaCaPort;
        }
        else if(ca == "kica"){
            host = DelfinoConfig.kicaCaHost;
            port = DelfinoConfig.kicaCaPort;
        }
        else if(ca == "yessignWebCmp"){
            if(this.getModule() != "G4" && this.getModule() != "G5" && this.getModule() != "G10"){
                window.DC_alert("Only G4, G5, G10 support WebCMP");
                return;
            }
            host = DelfinoConfig.yessignWebCmpUrl;
            port = 0;
        }
        else if(ca === 'fincert' || ca === 'fincertcorp') {
            
        }
        else{
            window.DC_alert("not supported ca:" + ca);
            return;
        }

        if(options == null) options = {};
        if(options.enableKmCert==null && DelfinoConfig.enableKmCert!=null) options.enableKmCert = DelfinoConfig.enableKmCert;

        var handle = this.addComplete(complete);
        DCrypto.updateCertificate2(handle, ca, host, port, JSON.stringify(options));
    },
    setSecureKeyboard:function(product)
    {
        try {
            secureKeyboardConfig.product = product;
        } catch(e){ }
        
        if(this.inited) DCrypto.setProperty("securekeyboard.product", product);
    },
    setVersion:function(version_g2, version_g3)
    {
        try {
            if (version_g2 == null) version_g2 = DelfinoConfig.version_update; 
            if (version_g3 == null) version_g3 = DelfinoConfig.version_update_g3; 
            DelfinoConfig.version_g2 = version_g2;
            DelfinoConfig.version_g3 = version_g3;

            //handler버전 변경
            var handler_version = "";
            if (DC_platformInfo.Windows) {
                handler_version = DelfinoConfig.version_g3.WinIE;
                if (!DC_browserInfo.MSIE) handler_version = DelfinoConfig.version_g3.WinMoz;
            } else if (DC_platformInfo.Mac) {
                handler_version = DelfinoConfig.version_g3.Mac;
            } else if (DC_platformInfo.Linux) {
                handler_version = DelfinoConfig.version_g3.Linux;
            }
            delfino.conf.handler.version = handler_version;
            
            //현재 동작모듈 g3,g2에 따른 버전 변경
            if (this.getModule() == "G3") {
                DelfinoConfig.version = DelfinoConfig.version_g3;
            } else {
                DelfinoConfig.version = DelfinoConfig.version_g2;
            }
            window.DC_version = DelfinoConfig.version;
            this.inited = false; //버전변경시 무조건 초기화 처리

            //plug-in object 제거
            if (document.getElementById("delfinoDiv") != null) jQuery("#delfinoDiv").remove();
            
        } catch (e) { }
    },
    setIssuerCertFilter:function(issuers)
    {
        try {
            DelfinoConfig.issuerCertFilter = issuers;
        } catch(e){ }

        //if(this.init() == false) return;
        //DCrypto.setProperty("IssuerCertFilter", issuers);
        if(this.inited) DCrypto.setProperty("IssuerCertFilter", issuers);
    },
    setPolicyOidCertFilter:function(policyOids)
    {
        try {
            DelfinoConfig.policyOidCertFilter = policyOids;
        } catch(e){ }

        //if(this.init() == false) return;
        //DCrypto.setProperty("PolicyOidCertFilter", policyOids);
        if(this.inited) DCrypto.setProperty("PolicyOidCertFilter", policyOids);
    },
    resetCertificate : function()
    {
        if(this.init() == false) return;

        DCrypto.resetCertificate();
    },
    _resetAll: function(options) {
        if(this.init() == false) return;

        DCrypto._resetAll(options);
    },
    signData : function(data, successCB, errorCB)
    {
        if(this.init() == false) return;

        this.generatePKCS7SignedDataSuccessCallback = successCB;
        this.generatePKCS7SignedDataErrorCallback = errorCB;
        data = "__DATA=" + encodeURIComponent(data);
        this.loadLogoImage(DelfinoConfig.logoImageUrl);
        if(this.getModule() == "G2"){
            DCrypto.generatePKCS7SignedData(data, "Delfino_generatePKCS7SignedData_success_callback", "Delfino_error_callback");
            return;
        }
        
        //G3, G4
        var options = {};
        options.signedAttribute = "certStoreType";
        options.attributeAsData = true;
        
        this.sign(data, options, function(result){
                if(result.status == 1){
                    Delfino_generatePKCS7SignedData_success_callback(result.signData, result.vidRandom);
                }
                else{
                    Delfino_error_callback(result.status, result.message);
                }
            });
        
    },
    importCertificate:function(options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;

        options = options || {};
        
        if(Delfino.getModule() == "G2" || Delfino.getModule() == "G3") options.lang = Delfino._getLang(DelfinoConfig.lang);

        if(options.place=="DelfinoG4") options.provider = 'wizveraV1';
        else {
            if(options.provider==null) options.provider = DelfinoConfig.certRelay.provider;
            if(options.providerUrl==null) options.providerUrl = DelfinoConfig.certRelay.providerUrl;
        }
        
        if(Delfino.getModule() !== "G4" && Delfino.getModule() !== "G5" && Delfino.getModule() !== "EA") options.moveImage = DC_get(DelfinoConfig.importImageUrl, Delfino.getModule(), true);
        
        var handle = this.addComplete(complete);
        DCrypto.importCertificate(handle, JSON.stringify(options));
    },
    exportCertificate:function(options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        
        options = options || {};
        
        if(Delfino.getModule() == "G2" || Delfino.getModule() == "G3") options.lang = Delfino._getLang(DelfinoConfig.lang);

        if(options.place=="DelfinoG4") options.provider = 'wizveraV1';
        else {
            if(options.provider==null) options.provider = DelfinoConfig.certRelay.provider;
            if(options.providerUrl==null) options.providerUrl = DelfinoConfig.certRelay.providerUrl;
        }

        if(Delfino.getModule() !== "G4" && Delfino.getModule() !== "G5" && Delfino.getModule() !== "EA") options.moveImage = DC_get(DelfinoConfig.exportImageUrl, Delfino.getModule(), true);

        var handle = this.addComplete(complete);
        DCrypto.exportCertificate(handle, param = JSON.stringify(options));
    },
    importCertificateFromPC:function(complete)
    {
        if(this.init() == false) return;

        var handle = this.addComplete(complete);
        var transferInfo = DelfinoConfig.transferInfo;
        transferInfo = JSON.stringify(transferInfo);

        DCrypto.importCertificateFromPC(handle, transferInfo);
    },
    exportCertificateToPC:function(complete)
    {
        if(this.init() == false) return;

        var handle = this.addComplete(complete);
        var transferInfo = DelfinoConfig.transferInfo;
        transferInfo = JSON.stringify(transferInfo);

        DCrypto.exportCertificateToPC(handle, transferInfo);
    },

    _getLang:function(lang){
        var langUrl=null;
        if(lang == "KOR" || lang == "korean"){
            langUrl = DelfinoConfig.langUrl.koreanUrl;
            lang = "korean";
        }
        else if(lang == "ENG" || lang == "english"){
            langUrl = DelfinoConfig.langUrl.englishUrl;
            lang = "english";
        }
        else if(lang == "CHN" || lang == "chinese"){
            langUrl = DelfinoConfig.langUrl.chaneseUrl;
            lang = "chinese";
        }
        else if(lang == "JPN" || lang == "japanese"){
            langUrl = DelfinoConfig.langUrl.japaneseUrl;
            lang = "japanese";
        }
        else if(lang == "VNM" || lang == "vietnamese"){
            langUrl = DelfinoConfig.langUrl.vietnameseUrl;
            lang = "vietnamese";
        }

        var data = DC_get(langUrl, undefined, true);

        if(!data) return null;
        
        return {name:lang, value:data};
    },
    
    setLang:function(lang){	
        DelfinoConfig.lang = lang;
        if(this.init() == false) return;
        
        var langObj = this._getLang(lang);
        if(langObj!=null){
            DCrypto.setLang(langObj.name, langObj.value);
        }
    },
    signForUpdateCertificate:function(data, complete){
        if(this.init() == false) return;
        this.sign(data, {	
                    cacheCertFilter:false,        	
                    cacheCert:true,
                    certStoreFilter:"CertUpdatable"
                }, 
                complete);
    },
    getMACAddress:function(complete){
        if(this.init(false) == false) return "";
        var macAddr = "";
        try{
            macAddr = DCrypto.getProperty("MACAddress");
        }catch(e){ }

        if (typeof(complete) == "function") {
            complete(macAddr); //handler와 동일하게 콜백처리
        } else {
            return macAddr;
        }
    },
    getVersion:function(complete)
    {
        if(this.init() == false) return "";
        var version = DCrypto.getVersion();
        if(complete!=null){
            complete(version);
        }
        return version;
    },
    sign:function(data, options, complete){
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        this.loadLogoImage(DelfinoConfig.logoImageUrl);
        
        options = options || {};
        
        if(options.withPkcs1 === undefined) { options.withPkcs1 = false; }
        if(options.signType === undefined) { options.signType = ""; }
        if(options.dataType === undefined) { options.dataType = ""; }

        if(options.dataType === "ucpid"){
        	if(!data.userAgreement){
        		window.DC_alert("missing 'userAgreement' data" );
        		return;
        	}
        	if(!data.userAgreeInfos){
        		window.DC_alert("missing 'userAgreeInfos' data" );
        		return;
        	}
        	for(var i=0; i<data.userAgreeInfos.length; i++){
        		var userAgreeInfo = data.userAgreeInfos[i];
        		if("realName"!==userAgreeInfo && "gender"!==userAgreeInfo && "nationalInfo"!==userAgreeInfo && "birthDate"!==userAgreeInfo){
        			window.DC_alert("bad 'userAgreeInfos' data:" +  userAgreeInfo);
        			return;
        		}
        	}
        	data = JSON.stringify(data);
        	options.addNonce = false;
        	options.signedAttribute = "signingTime";
        } else if(options.dataType === "ucpidv2") {
            data = JSON.stringify(data);
            options.addNonce = false;
            options.signedAttribute = "signingTime";
        } else if(options.dataType === "mydata") {
            data = JSON.stringify(data);
            options.addNonce = false;
            options.signedAttribute = "signingTime";
        }
		else{
	        if( typeof data === "object"){
	            if( data.nodeName!=null && data.nodeName.toLowerCase() === "form" ){
	                data = jQuery(data).serialize();
	            }
	            else{
	                data = data.data || "";
	            }
	        }
	    }
        
        
        if(DelfinoConfig.confirmSignTitleImageUrl != null && options.attributeAsData && options.signedAttribute.indexOf("format") != -1){
            options.confirmSignTitleImage = DC_get(DelfinoConfig.confirmSignTitleImageUrl, Delfino.getModule(), true);
        }
        
        if(options.delimiter) options.delimeter = options.delimiter;
        if(options.delimeter) options.delimiter = options.delimeter;
        if(options.multiSignDelimiter) options.multiSignDelimeter = options.multiSignDelimiter;
        if(options.multiSignDelimeter) options.multiSignDelimiter = options.multiSignDelimeter;
        if(options.closeOnError == null && DelfinoConfig.closeOnError!=null ) options.closeOnError = DelfinoConfig.closeOnError;
        if(this.getModule()=="G3" && window.location.protocol.toLowerCase()!="https:"){
            if (_Delfino_SystemMode == "real") options.vidRandom = false;
        }
        data = this._addNonce(data, options);
        if(data==null) return;

        if (typeof options.disableExpireFilter === "undefined") options.disableExpireFilter = DelfinoConfig.disableExpireFilter;
        if (typeof options.disableExpireWarn === "undefined") options.disableExpireWarn = DelfinoConfig.disableExpireWarn;
        if (typeof options.lastUsedCertFirst === "undefined") options.lastUsedCertFirst = DelfinoConfig.lastUsedCertFirst;
        
        if(options.addCertStoreType == null  && DelfinoConfig.addCertStoreType!=null ) options.addCertStoreType = DelfinoConfig.addCertStoreType;
        if(options.addCertStoreType){
            options.attributeAsData = true;
            if(options.signedAttribute == null){
                options.signedAttribute = "certStoreType";
            }
            else if(options.signedAttribute.indexOf("certStoreType")==-1){
                options.signedAttribute += ",certStoreType";
            }
        }
        if(DelfinoConfig.serverTimeUrl && options.withPkcs1 === false) {
            if(options.signedAttribute == null){
                options.signedAttribute = "signingTime";
            }
            else if(options.signedAttribute && options.signedAttribute.indexOf("signingTime")==-1){
                options.signedAttribute += ",signingTime";
            }
            options.signingTime = DC_get(DelfinoConfig.serverTimeUrl);
        }
        if(options.certStoreFilter && Delfino.getModule() != 'G2' && Delfino.getModule() != 'G3' && DelfinoConfig.cg && DelfinoConfig.cg.VPCGClientConfig && DelfinoConfig.cg.VPCGClientConfig.certStoreFilterToProviderList) {
            var certStoreFilter = options.certStoreFilter.split('|');

            for(var key in DelfinoConfig.cg.VPCGClientConfig.certStoreFilterToProviderList) {
                var index = -1;
                if( (index = (typeof certStoreFilter.indexOf === 'function' ? certStoreFilter.indexOf(key) : -1)) > -1) {
                    certStoreFilter.splice(index, 1);
                    options.provider = DelfinoConfig.cg.VPCGClientConfig.certStoreFilterToProviderList[key];
                }
            }

            options.certStoreFilter = certStoreFilter.join('|');
        }


        if( true && options.withPkcs1 === true && options.signedAttribute){

            window.DC_alert("signedAttribute and options.withPkcs1 cannot be used together");
            return;
        }

        var handle = this._addCompleteIfNeedToHex(options, complete);

        DCrypto.sign(handle, data, JSON.stringify(options));
    },
    _addCompleteIfNeedToHex:function(options, complete){
        var outputEncoding = options.outputEncoding || DelfinoConfig.outputEncoding;
        if(outputEncoding == null ||  outputEncoding != "hex"){
            return this.addComplete(complete);
        }

        delete options.outputEncoding;

        return this.addComplete(function(param) {
            if(param.status == 1 && param.signData != null){
                if (typeof param.signData === 'string' || param.signData instanceof String){
                    if(options.multiSign && options.multiSignDelimiter){
                        var multiSignDataArray = param.signData.split(options.multiSignDelimiter);
                        for(var i=0; i<multiSignDataArray.length; i++){
                            multiSignDataArray[i] = DC_base64ToHex(multiSignDataArray[i]);
                        }
                        param.signData = multiSignDataArray.join(options.multiSignDelimiter);
                    }
                    else{
                        param.signData = DC_base64ToHex(param.signData);
                    }
                }
                else if (param.signData.constructor == Array){
                    for(var i=0; i<param.signData.length; i++){
                        param.signData[i] = DC_base64ToHex(param.signData[i]);
                    }
                }
            }

            if(param.status == 1 && param.vidRandom != null){
                param.vidRandom = DC_base64ToHex(param.vidRandom);
            }

            complete(param);
        });
    },
    _addNonce:function(data, options){
        if(options.addNonce){
            var nonce = DelfinoConfig.nonce || DC_get(DelfinoConfig.nonceUrl);
            if(nonce.length<20 || nonce.length>40){
                window.DC_alert("전자서명 실패[nonce 오류]:" + nonce.length);
                return null;
            }
            if(DelfinoConfig.useNonceOption){
                options.attributeAsData = true;
                if(options.signedAttribute == null){
                    options.signedAttribute = "nonce";
                }
                else if(options.signedAttribute.indexOf("nonce")==-1){
                    options.signedAttribute += ",nonce";
                }
                options.nonce = encodeURIComponent(nonce);
            }else{
                if(data.length>0) data +="&";
                var nonceKeyName = DelfinoConfig.nonceKeyName || "delfinoNonce";
                data += nonceKeyName + "=" + encodeURIComponent(nonce);
            }

            if(options.login && options.cgSignType === _SignType.LOGIN
                && DelfinoConfig.cg && DelfinoConfig.cg.VPCGClientConfig
                && DelfinoConfig.cg.VPCGClientConfig.useSimpleAuth)
                options.nonce = encodeURIComponent(nonce);
        }
        return data;
    },
    importCertificateFromPKCS12:function(p12){
        DCrypto.importCertificateFromPKCS12(p12);
    },
    setCacheCertStore:function(cache){

        try {
            DelfinoConfig.cacheCertStore = cache?"true":"false";
        } catch(e){ }

        if(this.init() == false) return;

        DCrypto.setProperty("cacheCertStore", cache?"true":"false");
    },
    addSigner:function(data, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        options = options || {};        
        options.dataType = "PKCS7";
        options.signedAttribute = "signingTime";
        this.sign(data, options, complete);
    },
    addMdSigner:function(data, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        options = options || {};        
        options.dataType = "PKCS7-sha256-md";
        options.signedAttribute = "signingTime";
        this.sign(data, options, complete);
    },
    confirmSign:function(data, format, options, complete){
        if(arguments.length==2){
            options = format;
            format = undefined;
        }
        else if(arguments.length==3 && typeof format !== "string"){
            complete = options;
            options = format;
            format = undefined;
        }
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;

        options = options || {};
        options.format = options.format || format;
        if(options.dataType != "fixedLengthData"){
            options.dataType = data.dataType || "form-urlencoded";
            if(options.dataType == "form-urlencoded" && format === undefined){
                options.format = "";
            }
        }
        
        if(DelfinoConfig.confirmSignTitleImageUrl != null && Delfino.getModule() !== "G4" && Delfino.getModule() !== "G5" && Delfino.getModule() !== "EA"){
            options.confirmSignTitleImage = DC_get(DelfinoConfig.confirmSignTitleImageUrl, Delfino.getModule(), true);
        }

        if(!options.format && options.dataType != "formattedText" && options.dataType != "form-urlencoded"){
            window.DC_alert("missing 'format' parameter");
            return;
        }
        
        if(options.dataType == "strings"){
            options.delimiter = options.delimiter || DelfinoConfig.stringsDelimiter;
            if(!options.delimiter){
                window.DC_alert("missing 'delimiter' option or 'DelfinoConfig.stringsDelimiter' config" );
                return;
            }
            if(options.addNonce){
                window.DC_alert("not supported addNonce option");
                return;
            }
        }
        options.attributeAsData = true;
        options.signedAttribute = "format";

        this.sign(data, options, complete);
    },
    confirmMultiSign:function(data, format, options, complete){
        
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        options = options || {};
        options.multiSign = true;
        options.multiSignDelimiter = options.multiSignDelimiter || DelfinoConfig.multiSignDelimiter;		
                
        if(!options.multiSignDelimiter){
            window.DC_alert("missing 'multiSignDelimiter' option or 'DelfinoConfig.multiSignDelimiter' config" );
            return;
        }
        if(options.addNonce){
            window.DC_alert("not supported addNonce option");
            return;
        }
        if( data.nodeName!=null && data.nodeName.toLowerCase() === "form" ){
            window.DC_alert("not supported data type");
            return;
        }
        
        options.format = format;
        if(!options.format){
            window.DC_alert("missing 'format' parameter");
            return;
        }
        
        if(options.dataType != "fixedLengthData"){
            options.dataType = data.dataType || "form-urlencoded";
        }
        if(options.dataType == "strings"){
            options.delimiter = options.delimiter || DelfinoConfig.stringsDelimiter;
            if(!options.delimiter){
                window.DC_alert("missing 'delimiter' option or 'DelfinoConfig.stringsDelimiter' config" );
                return;
            }
        }
        options.attributeAsData = true;
        options.signedAttribute = "format,certStoreType";
        
        this.sign(data, options, complete);
    },
    mdSign:function(data, options, complete){
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;

        options = options || {};
        options.dataType = "sha256-md";
        this.sign(data, options, complete);
    },
    mdMultiSign:function(data, options, complete){
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;

        options = options || {};
        options.dataType = "sha256-md";
        options.multiSign = true;
        
        if(jQuery.isArray(data)){
            options.multiSignDelimiter = ",";        
            data = data.join(options.multiSignDelimiter);
        }

        this.sign(data, options, complete);
    },

    complexSign:function(data, options, complete){
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;

        options = options || {};
        options.dataType = "complex";

        if(jQuery.isArray(data)){
            options.multiSignDelimiter = ",";
            data = data.join(options.multiSignDelimiter);
        }

        this.sign(data, options, complete);
    },
    scrapingSign:function(data, options, complete){
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;

        options = options || {};
        options.signType = "scraping";

        options.certInResult = options.certInResult === false ? false : true;

        if(!jQuery.isArray(data)){
            data = [data];
        }

        this.sign(JSON.stringify(data), options, complete);
    },

    login:function(data, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        this.resetCertificate();
        options = options || {};
        if(options.addNonce==null) options.addNonce = true;
        options.signedAttribute = "certStoreType";
        options.attributeAsData = true;

        options.resetCertificate = true;
        Delfino_eraseCookie('EAUSE');
        options.cacheCert = true;
        
        options.login = true;
        options.cgSignType = _SignType.LOGIN;

        this.sign(data, options, complete);
    },
    auth:function(data, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        this.resetCertificate();
        options = options || {};
        if(options.addNonce==null) options.addNonce = true;
        options.signedAttribute = "certStoreType";
        options.attributeAsData = true;

        options.resetCertificate = true;
        Delfino_eraseCookie('EAUSE');
        options.cacheCert = true;
        
        options.login = true;
        options.cgSignType = _SignType.AUTH;

        this.sign(data, options, complete);
    },
    auth2:function(data, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        this.resetCertificate();
        options = options || {};
        if(options.addNonce==null) options.addNonce = true;
        options.signedAttribute = "certStoreType";
        options.attributeAsData = true;

        options.resetCertificate = true;
        Delfino_eraseCookie('EAUSE');
        options.cacheCert = true;
        
        options.login = true;
        options.cgSignType = _SignType.AUTH2;

        this.sign(data, options, complete);
    },
    multiSign:function(data, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;    	
        
        options = options || {};
        options.multiSign = true;
        options.multiSignDelimiter = options.multiSignDelimiter || DelfinoConfig.multiSignDelimiter;
        
        // if(options.signedAttribute==null)
        // options.signedAttribute = "signingTime";

        if(!options.multiSignDelimiter){
            window.DC_alert("missing 'multiSignDelimiter' option or 'DelfinoConfig.multiSignDelimiter' config" );
            return;
        }
        if(options.addNonce){
            window.DC_alert("not supported addNonce option");
            return;
        }
        if( data.nodeName!=null && data.nodeName.toLowerCase() === "form" ){
            window.DC_alert("not supported data type");
            return;
        }

        this.sign(data, options, complete);
    },
    endSign:function(ssid, complete)
    {
        var handle = this.addComplete(complete);
        DCrypto.endSign(handle, ssid);
    },
    signAndEnvelope:function(data, recipientCert, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(!recipientCert){
            window.DC_alert("invalid recipientCert");
            return;
        }
        
        options = options || {};
        options.signType = "signedAndEnvelopedData";
        options.recipientCert = recipientCert;
        
        this.sign(data, options, complete);
    },
    isPasswordError:function(status){
        return status == -4008 || status == -1004 || status == -1403;
    },
    setModule:function(module){
        if(module==null){
            module = Delfino_readCookie("delfino.recentModule");
            if(module==null || module == ""){
                module = DelfinoConfig.module;
            }
        }
        var modules = module.split(",");
        for(var i=0; i<modules.length; i++){
            module = modules[i];
            module = module.replace(/^\s+|\s+$/gm,'');
            if(DC_isSupported(module)){
                break;
            }
        }

        if(module == "G2"){
            window.Delfino = DelfinoG2G4;
        }
        else if(module == "G3"){
            window.Delfino = DelfinoHandler;
        }
        else if(module == "G4"){
            window.Delfino = DelfinoG2G4;
        }
        else if(module == "G5") {
            window.Delfino = DelfinoG2G4;
        }
        else if(module == "G10" || module == "CG") {
            window.Delfino = DelfinoG2G4;
        }
        else if(module == "EA"){
            window.Delfino = DelfinoG2G4;
        }

        if(module == "G2" || module == "G3" || module == "G4" || module == "EA" || module == "G5" || module == "G10" || module == "CG"){
            DC_setModule(module);
            Delfino.inited = false;
            if( DelfinoConfig.useRecentModule ){
                Delfino_createCookie("delfino.recentModule", module);
            }
        }
    },
    getModule:function(){
        return window.DC_module;
    },
    resetRecentModule:function(){
        Delfino_eraseCookie("delfino.recentModule");
    },
    isSupportedG4:function(){
        return DC_isSupported("G4");
    },
    isSupportedG5:function(){
        return DC_isSupported("G5");
    },
    isSupportedG10:function(){
        return DC_isSupported("G10");
    },
    isSupportedCG:function(){
        return DC_isSupported("CG");
    },
    isSupportedEA:function(){
        return DC_isSupported("EA");
    },
    deleteCertificate:function(subjectOrSerialNumber, options, complete){
        options = options || {};
        var handle = this.addComplete(complete);
        DCrypto.deleteCertificate(handle, subjectOrSerialNumber, JSON.stringify(options));
    },
    signFileUrl:function(downloadurl, uploadurl, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        
        if(downloadurl==null || downloadurl==""){ 
            window.DC_alert("downloadurl error");
            return;
        }
        if(uploadurl==null || uploadurl==""){ 
            window.DC_alert("uploadurl error");
            return;
        }
        
        this.loadLogoImage(DelfinoConfig.logoImageUrl);

        options = options || {};
        if(options.delimiter) options.delimeter = options.delimiter;
        if(options.delimeter) options.delimiter = options.delimeter;
        if(options.multiSignDelimiter) options.multiSignDelimeter = options.multiSignDelimiter;
        if(options.multiSignDelimeter) options.multiSignDelimiter = options.multiSignDelimeter;
        if(options.closeOnError == null && DelfinoConfig.closeOnError!=null ) options.closeOnError = DelfinoConfig.closeOnError;
        if(this.getModule()=="G3" && window.location.protocol.toLowerCase()!="https:"){
            if (_Delfino_SystemMode == "real") options.vidRandom = false;
        }

        if (typeof options.disableExpireFilter === "undefined") options.disableExpireFilter = DelfinoConfig.disableExpireFilter;
        if (typeof options.disableExpireWarn === "undefined") options.disableExpireWarn = DelfinoConfig.disableExpireWarn;
        
        if(options.addCertStoreType == null  && DelfinoConfig.addCertStoreType!=null ) options.addCertStoreType = DelfinoConfig.addCertStoreType;
        if(options.addCertStoreType){
            options.attributeAsData = true;
            if(options.signedAttribute == null){
                options.signedAttribute = "certStoreType";
            }
            else if(options.signedAttribute.indexOf("certStoreType")==-1){
                options.signedAttribute += ",certStoreType";
            }
        }

        if (typeof options.signType === "undefined") options.signType = "sig";
        
        var handle = this._addCompleteIfNeedToHex(options, complete);

        DCrypto.signFileUrl(handle, downloadurl, uploadurl, JSON.stringify(options));
    },
    signFileUrlDown:function(downloadurl, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        
        if(downloadurl==null || downloadurl==""){ 
            window.DC_alert("downloadurl error");
            return;
        }
        
        options = options || {};
        if(options.delimiter) options.delimeter = options.delimiter;
        if(options.delimeter) options.delimiter = options.delimeter;
        if(options.multiSignDelimiter) options.multiSignDelimeter = options.multiSignDelimiter;
        if(options.multiSignDelimeter) options.multiSignDelimiter = options.multiSignDelimeter;
        
        if (typeof options.signType === "undefined") options.signType = "sig";
        
        var handle = this._addCompleteIfNeedToHex(options, complete);

        DCrypto.signFileUrlDown(handle, downloadurl, JSON.stringify(options));
        
    },
    signFileUrlSign:function(filepath, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        
        this.loadLogoImage(DelfinoConfig.logoImageUrl);

        options = options || {};
        if(options.delimiter) options.delimeter = options.delimiter;
        if(options.delimeter) options.delimiter = options.delimeter;
        if(options.multiSignDelimiter) options.multiSignDelimeter = options.multiSignDelimiter;
        if(options.multiSignDelimeter) options.multiSignDelimiter = options.multiSignDelimeter;
        if(options.closeOnError == null && DelfinoConfig.closeOnError!=null ) options.closeOnError = DelfinoConfig.closeOnError;
        if(this.getModule()=="G3" && window.location.protocol.toLowerCase()!="https:"){
            if (_Delfino_SystemMode == "real") options.vidRandom = false;
        }

        if (typeof options.disableExpireFilter === "undefined") options.disableExpireFilter = DelfinoConfig.disableExpireFilter;
        if (typeof options.disableExpireWarn === "undefined") options.disableExpireWarn = DelfinoConfig.disableExpireWarn;
        
        if(options.addCertStoreType == null  && DelfinoConfig.addCertStoreType!=null ) options.addCertStoreType = DelfinoConfig.addCertStoreType;
        if(options.addCertStoreType){
            options.attributeAsData = true;
            if(options.signedAttribute == null){
                options.signedAttribute = "certStoreType";
            }
            else if(options.signedAttribute.indexOf("certStoreType")==-1){
                options.signedAttribute += ",certStoreType";
            }
        }

        if (typeof options.signType === "undefined") options.signType = "sig";
        
        var handle = this._addCompleteIfNeedToHex(options, complete);

        DCrypto.signFileUrlSign(handle, JSON.stringify(filepath), JSON.stringify(options));
        //DCrypto.signFileUrlSign(handle, filepath, JSON.stringify(options));
    },
    signFileUrlUp:function(filepath, uploadurl, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;

        if(uploadurl==null || uploadurl==""){ 
            window.DC_alert("uploadurl error");
            return;
        }
        
        options = options || {};
        if(options.delimiter) options.delimeter = options.delimiter;
        if(options.delimeter) options.delimiter = options.delimeter;
        if(options.multiSignDelimiter) options.multiSignDelimeter = options.multiSignDelimiter;
        if(options.multiSignDelimeter) options.multiSignDelimiter = options.multiSignDelimeter;

        if (typeof options.signType === "undefined") options.signType = "sig";
        
        var handle = this._addCompleteIfNeedToHex(options, complete);

        DCrypto.signFileUrlUp(handle, filepath, uploadurl, JSON.stringify(options));
        
    },
    signFile:function(path, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        this.loadLogoImage(DelfinoConfig.logoImageUrl);

        options = options || {};
        if(options.delimiter) options.delimeter = options.delimiter;
        if(options.delimeter) options.delimiter = options.delimeter;
        if(options.multiSignDelimiter) options.multiSignDelimeter = options.multiSignDelimiter;
        if(options.multiSignDelimeter) options.multiSignDelimiter = options.multiSignDelimeter;
        if(options.closeOnError == null && DelfinoConfig.closeOnError!=null ) options.closeOnError = DelfinoConfig.closeOnError;
        if(this.getModule()=="G3" && window.location.protocol.toLowerCase()!="https:"){
            if (_Delfino_SystemMode == "real") options.vidRandom = false;
        }

        if (typeof options.disableExpireFilter === "undefined") options.disableExpireFilter = DelfinoConfig.disableExpireFilter;
        if (typeof options.disableExpireWarn === "undefined") options.disableExpireWarn = DelfinoConfig.disableExpireWarn;
        
        if(options.addCertStoreType == null  && DelfinoConfig.addCertStoreType!=null ) options.addCertStoreType = DelfinoConfig.addCertStoreType;
        if(options.addCertStoreType){
            options.attributeAsData = true;
            if(options.signedAttribute == null){
                options.signedAttribute = "certStoreType";
            }
            else if(options.signedAttribute.indexOf("certStoreType")==-1){
                options.signedAttribute += ",certStoreType";
            }
        }
        
        if (typeof options.signType === "undefined") options.signType = "signature";
        var handle = this._addCompleteIfNeedToHex(options, complete);
        DCrypto.signFile(handle, path, JSON.stringify(options));
    },
    verifySignFile:function(path, signature, cert, options, complete)
    {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init(false) == false) return "";

        options = options || {};
        if (typeof options.signType === "undefined") options.signType = "signature";
        
        var handle = this.addComplete(complete);
        DCrypto.verifySignFile(handle, path, signature, cert, JSON.stringify(options));
    },   
    getKTBScanResult:function(complete)
    {
        if(this.init(false) == false) return "";

        var handle = this.addComplete(complete);
        DCrypto.getKTBScanResult(handle);
    },
    _fixOptionsComplete:function(options, complete){
        var args = {};
        
        if(typeof options === "function" || (options && typeof options.complete === "function")){
            args.complete = options;
        }
        if(typeof complete === "function" || (complete && typeof complete.complete === "function")){
            args.complete = complete;
        }
        if(complete != null && typeof complete === "object" && typeof complete.complete !== "function"){
            args.options = complete;
        }
        if(options != null && typeof options === "object" && typeof options.complete !== "function"){
            args.options = options;
        }

        var executeFunctionByName = function(str, args)
        {
            var arr = str.split('.');
            var fn = window[ arr[0] ];
            
            for (var i = 1; i < arr.length; i++)
            { fn = fn[ arr[i] ]; }

            if(typeof fn === 'function')
                fn.apply(window, args);
        }

        if(typeof args.complete === 'function') {
            if(args.complete.name !== 'delfino_complete') {
                var tmp = args.complete;
                args.complete = function delfino_complete(result, context) {
                    tmp(result, context);
                    if(result.raIssueAppFunc) {
                        //window[result.raIssueAppFunc]();
                        executeFunctionByName(result.raIssueAppFunc, []);
                    }
                    setFocusBack();
                }
            }
        } else if(typeof args.complete === 'object' && typeof args.complete.complete === 'function') {
            if(args.complete.name !== 'delfino_complete') {
                var tmp = args.complete.complete;
                args.complete.complete = function delfino_complete(result, context) {
                    tmp(result, context);
                    if(result.raIssueAppFunc) {
                        //window[result.raIssueAppFunc]();
                        executeFunctionByName(result.raIssueAppFunc, []);
                    }
                    setFocusBack();
                }
            }
        } else {
            args.complete = function delfino_complete(result, context) {
                if(result.raIssueAppFunc) {
                    //window[result.raIssueAppFunc]();
                    executeFunctionByName(result.raIssueAppFunc, []);
                }
                setFocusBack();
            }
        }

        return args;
    },
    preloadOff:function(){
        return Delfino4Html.preloadOff();
    },
    getDeviceID:function(done) {
        DelfinoDeviceID.getDeviceID(done);
    },
  	ucpidSign:function(userAgreement, userAgreeInfos, options, complete){
  		var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        options = options || {};
        options.dataType = "ucpid";
        options.addNonce = false;
        options.signedAttribute = "signingTime";
        options.attributeAsData = false;

        options.resetCertificate = true;
        Delfino_eraseCookie('EAUSE');
        options.cacheCert = true;
        
        var data = {userAgreement : userAgreement, userAgreeInfos: userAgreeInfos};

        this.sign(data, options, complete);
  	},
    multiSignForMyData:function(inputData, options, complete) {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;
        options = options || {};
        options.dataType = "mydata";
        options.signType = "mydata";
        options.addNonce = false;
        options.signedAttribute = "signingTime";
        options.attributeAsData = false;

        options.resetCertificate = true;
        Delfino_eraseCookie('EAUSE');
        options.cacheCert = true;
        
        var data = [];
        for(var i=0;i<inputData.length;i++) {
            data.push({
                orgCode: inputData[i].orgCode,
                ucpidRequestInfo: {
                    userAgreement : inputData[i].ucpidRequestInfo.userAgreement,
                    userAgreeInfo: inputData[i].ucpidRequestInfo.userAgreeInfo,
                    ispUrlInfo: inputData[i].ucpidRequestInfo.ispUrlInfo,
                    ucpidNonce: inputData[i].ucpidRequestInfo.ucpidNonce
                },
                consentInfo: {
                    consent: inputData[i].consentInfo.consent,
                    consentNonce: inputData[i].consentInfo.consentNonce
                }
            });
        }

        this.sign(data, options, complete);
    },
    fincertSign:function(data, options, complete) {
        var optionsComplete = this._fixOptionsComplete(options, complete);
        options = optionsComplete.options;
        complete = optionsComplete.complete;
        
        if(this.init() == false) return;

        options.fincertSign = true;

        var handle = this._addCompleteIfNeedToHex(options, complete);

        DCrypto.fincertSign(handle, data, options);
    }
};
var DelfinoG2G4 = _Delfino;

window.Delfino = DelfinoG2G4;
}

function Delfino_complete(handle, param){
    setTimeout(function(){
        var complete = Delfino.getComplete(handle);
        Delfino.removeComplete(handle);
        if(Delfino.emptyComplete() && DCrypto.stopGetResultTimer){
            DC_enableBrowser();
            DCrypto.stopGetResultTimer();
        }
        
        if(complete !=null && complete.complete!=null ){
            DC_enableBrowser();
            if(typeof param === "string") param = jQuery.parseJSON(param);

            if(param.status==1 && param.message=="가져오기 내보내기 성공."){
                complete.complete(param, complete.context);
                return;
            }

            if(param.cmd == "requestCertificate2" || param.cmd == "updateCertificate2"){
                if(DelfinoConfig.alertCmpComplete || DelfinoConfig.alertCmpComplete === undefined){
                    if(param.status!=0){
                        if (param.status == 1 && param.message == "") param.message = "인증서가 정상적으로 발급/갱신 되었습니다.";
                        window.DC_alert(param.message, function() {
                            complete.complete(param, complete.context);
                        });
                        return;
                    }
                }
                complete.complete(param, complete.context);
                return;
            }

            //2014.03.17 password err check
            if ((param.cmd == null || param.cmd == "sign") && param.status == 1 && !param.signData && !param.signedAndEnvelopedData && !param.signedDataList) {
                param.status = 0;
                param.message = "Password error.";
            } else if (Delfino.isPasswordError(param.status) && DelfinoConfig.passwordError != true) {
                param.status = 0;
            }

            if (param.status == -15000) {
                param.status = 0;

                if(window.EA && ('object' === typeof window.EA)) {
                    var data = param.sign_data;
                    var options = JSON.parse(param.sign_options);
                    var tmpRand = wizvera.kryptos.random.getBytesSync(32);
                    var randomBSID = wizvera.kryptos.util.bytesToHex(tmpRand);
                    if(options.resetCertificate) {
                        EA.resetSessionData();
                    }
                    data = EA.normalizeSignData(data, options);

                    EA.init(randomBSID);
                    // options.alreadyHasAttribute = true;
                    EA.setTbsData({data:data, options:options});
                    if (window.EA.tbsData.options.resetCertificate) {
                        EA.resetSessionData();
                    }

                    EA.open_user_interface(function(result) {
                        if (result.status == 1) {
                            Delfino_createCookie('EAUSE', 'true');
                        }
                        complete.complete(result);
                    });
                    return;
                }
            }

            if(param.status == -10301 && param.url){
                if(navigator.userAgent.match(/Linux/i)) {
                    window.open(param.url);
                }
            }

            complete.complete(param, complete.context);
        }
    }, 1);
}

function Delfino_generatePKCS7SignedData_success_callback(pkcs7, vid_random){
    //2014.03.17 password err check
    if (pkcs7 == null || pkcs7 == "") {
        Delfino_error_callback(0, "Password error.");
        return;
    }

    if(Delfino.generatePKCS7SignedDataSuccessCallback==null){
        var pkcs7Form = jQuery("#Delfino_PKCS7_form")[0];
        pkcs7Form.PKCS7.value = pkcs7;
        pkcs7Form.VID_RANDOM.value = vid_random;
        pkcs7Form.submit();
    }
    else{
        Delfino.generatePKCS7SignedDataSuccessCallback(pkcs7, vid_random);
    }
}

function Delfino_error_callback(code, message) {
    if(Delfino.generatePKCS7SignedDataErrorCallback==null){
        if (code != 0){
            window.DC_alert("error:"+code + ":" + message);
        }
    }
    else{
        Delfino.generatePKCS7SignedDataErrorCallback(code, message);
    }
}

function Delfino_requestCertificate_complete_callback(code , msg){
    setTimeout(function() {
        if(code!=0){
            if (code == 1 && (msg == "" || msg == "success"))  msg = "인증서가 정상적으로 발급되었습니다.";
            window.DC_alert(msg, function() {
                if(Delfino.requestCertificate_complete_callback!=null){
                    Delfino.requestCertificate_complete_callback(code, msg);
                }
            });
            return;
        }
        if(Delfino.requestCertificate_complete_callback!=null){
            Delfino.requestCertificate_complete_callback(code, msg);
        }
    }, 1);
}

function Delfino_updateCertificate_complete_callback(code , msg){
    setTimeout(function() {
        if(code!=0){
            if (code == 1 && (msg == "" || msg == "success")) msg = "인증서 갱신에 성공했습니다.";
            window.DC_alert(msg, function() {
                if(Delfino.updateCertificate_complete_callback!=null){
                    Delfino.updateCertificate_complete_callback(code, msg);
                }
            });
        }
        if(Delfino.updateCertificate_complete_callback!=null){
            Delfino.updateCertificate_complete_callback(code, msg);
        }
    }, 1);
}

function Delfino_createCookie(name,value,days) {    
    var cookie = encodeURIComponent(name) + "=" + encodeURIComponent(value) + "; path=/; secure";
    
    if (typeof days === 'number') {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        cookie += "; expires=" + date.toGMTString();
    }

    if ( typeof DelfinoConfig !== "undefined" && DelfinoConfig.multiDomain && document.location.hostname.indexOf(DelfinoConfig.multiDomain) >= 0) {
        cookie += "; domain=" + DelfinoConfig.multiDomain;
    }

    document.cookie = cookie;
}

function Delfino_readCookie(key) {
    var cookies = document.cookie ? document.cookie.split('; ') : [];    
    for (var i=0; i < cookies.length; i++) {
        var parts = cookies[i].split('=');
        var name;
        try {
            name = decodeURIComponent(parts[0]);
        } catch(e) {
            name = parts[0];
        }
        if (key === name) {
            try {
                return parts.length>1 ? decodeURIComponent(parts[1]) : '';
            } catch(e) {
                return '';
            }
        }
    }
    return '';
}

function Delfino_eraseCookie(name) {
    Delfino_createCookie(name,"",-1);
}

window.Delfino_complete = Delfino_complete;
window.Delfino_generatePKCS7SignedData_success_callback = Delfino_generatePKCS7SignedData_success_callback;
window.Delfino_error_callback = Delfino_error_callback;
window.Delfino_requestCertificate_complete_callback = Delfino_requestCertificate_complete_callback;
window.Delfino_updateCertificate_complete_callback = Delfino_updateCertificate_complete_callback;
window.Delfino_createCookie = Delfino_createCookie;
window.Delfino_readCookie = Delfino_readCookie;
window.Delfino_eraseCookie = Delfino_eraseCookie;

var DelfinoHandler = DelfinoHandler || (function(jQuery){
    if(Delfino.initHandler != undefined) {
        Delfino._handlerInitUrl = '';
        return Delfino;
    }

    var _delfino = {};
    var _parent = Delfino;
    var _parentFuncs = ["scrapingSign","complexSign","ucpidSign", "multiSignForMyData", "getKTBScanResult", "exportCertificate", "importCertificate", "signFileUrlDown", "signFileUrlSign", "signFileUrlUp", "verifySignFile", "signFile", "signFileUrl", "deleteCertificate", "setProperty", "resetCertificate", "loginForm", "sign","signData","addSigner","init","login","signForm","requestCertificate","requestCertificate2","updateCertificate","updateCertificate2","signKeyValue","multiSign","multiSignString","manageCertificate"];

    function backupParentFunctions() {
        for(var index in _parentFuncs) {
            var func = _parentFuncs[index];
            _parent["par_"+func] = _parent[func];
        }
    }

    backupParentFunctions();
    jQuery.extend(true,_delfino,_parent);

    function createProxyFunctions() {
        for(var index in _parentFuncs) {
            var func = _parentFuncs[index];
            (function(func){
                _delfino[func] = function() {
                    DelfinoHandler.callWithInitHandler(func,arguments);
                };
            })(func);
        }
    }
    createProxyFunctions();



    /* createProxyFunctions가 잘 안되면 일일이 다할것
    _delfino.sign = function() {
        this.callWithInitHandler("sign",arguments);
    }
*/
    _delfino._handlerInit = false;
    _delfino._handlerInitUrl = "";
    _delfino.isHandlerInit = function() {
        if(this._handlerInitUrl != window.location.href){
            delfino.handler.secure.reset();
            this._handlerInit = false;
        } 

        return this._handlerInit;
    };

    _delfino.setHandlerInit = function(init) {
        this._handlerInit = init;
        if(init === true) {
            this._handlerInitUrl = window.location.href;
            return;
        }
        delfino.handler.secure.reset();
    };
    _delfino.isInProcessHandlerInit = function() { return this._handlerInitProcess; };
    _delfino.setInProcessHandlerInit = function(process) { this._handlerInitProcess = process; };

    _delfino.callWithInitHandler = function(fnName,args)  {

        //-----------------------------------------------------------------------
        this._lastCallTime = this._lastCallTime || {};
        if(this._lastCallTime[fnName] != undefined && (fnName == "login" || fnName == "sign" )) {
            var elapsed = new Date() - this._lastCallTime[fnName];
            elapsed = Math.round(elapsed / 600);
            if(elapsed <=3) {
                if(args[1].ssid == ""){
                    //alert(fnName + ": 천천히 합시다 " +elapsed + " sec");
                    return;
                }
            }
        }
        this._lastCallTime[fnName] = new Date();
        //-----------------------------------------------------------------------

        var parentFnName = "par_"+fnName;

        if(_delfino.isInProcessHandlerInit()) {
            setTimeout(function() {
                _delfino.callWithInitHandler(fnName, args);
            }, 50);
            return;
        }
        _delfino.setInProcessHandlerInit(true);
        this.initHandler({retryCount:0,execTimeout:1000,nnnn:fnName,success:function(){
        //this.initHandler({retryCount:(DC_browserInfo.MSIE)?0:1,execTimeout:1000,success:function(){
            _delfino.setInProcessHandlerInit(false);
            var fn = Delfino[parentFnName];
            fn.apply(Delfino,args);
        }});
    };

    _delfino.isInstall = function(goInstall,completeCallback) {
        function tempError(param) {
            if(goInstall == true)
                DCrypto.goInstallPage();
            else
                completeCallback(false);
        }
        function tempSuccess() {
            completeCallback(true);
        }
        delfino.handler.helper.isInstall({"ctx":{},"error":tempError,"success":tempSuccess});
    };

    _delfino.initHandler = function(ctx) {

        /* //WIZVERA_TEST_START
        var check_allTIME = new Date();
        var check_TIME = new Date();
        var check_MSG = "";
        //WIZVERA_TEST_END */

        if(this.isHandlerInit() == true) {
            if(ctx.success != undefined)
                ctx.success();
            return true;
        }

        if(ctx == undefined) ctx = {retryCount:3,execTimeout:2000};
        this._ctx = ctx;

        if(this._ctx.retryCount < 0) {
            delfino.handler.state.clear();
            if(ctx.goInstall != undefined && ctx.goInstall == false) return _delfino.setInProcessHandlerInit(false);
            DCrypto.goInstallPage();
            _delfino.setInProcessHandlerInit(false);
            return;
        }
        this._ctx.retryCount--;

        delfino.handler.state.setState("init",true);
        function installCheckOk(ver) {

            /* //WIZVERA_TEST_START
            check_MSG += "initHandler[ installOK] " + Math.floor( (new Date()).getTime() - check_TIME.getTime() ) / 1000 + "\n";
            check_TIME = new Date();
            //WIZVERA_TEST_END */

            DcryptoHandlerData.version = ver;
            delfino.handler.state.setState("init",false);
            delfino.handler.state.setState("secure",true);

            Delfino.loadLogoImage(DelfinoConfig.logoImageUrl);
            Delfino.init(false);

            /* //WIZVERA_TEST_START
            check_MSG += "initHandler[    initOK] " + Math.floor( (new Date()).getTime() - check_TIME.getTime() ) / 1000 + "\n";
            check_TIME = new Date();
            //WIZVERA_TEST_END */

            (function(ctx){
                delfino.handler.secure.init({success:function(){

                    Delfino.setHandlerInit(true);
                    delfino.handler.state.clear();
                    if(ctx.success != undefined) {

                        /* //WIZVERA_TEST_START
                        check_MSG += "initHandler[secureOK] " + Math.floor( (new Date()).getTime() - check_TIME.getTime() ) / 1000 + "\n";
                        check_TIME = new Date();
                        //WIZVERA_TEST_END */
                        ctx.success();
                        
                        /* //WIZVERA_TEST_START
                        check_MSG += "initHandler[ success] " + Math.floor( (new Date()).getTime() - check_TIME.getTime() ) / 1000 + "\n\n";
                        check_MSG += "initHandler[ALL_TIME] " + Math.floor( (new Date()).getTime() - check_allTIME.getTime() ) / 1000 + "\n";
                        if (document.location.href.indexOf("debug=on")>=0 && document.location.hostname.indexOf("wizvera.com")>=0) alert(check_MSG);
                        //WIZVERA_TEST_END */
                        
                    }
                },error:function(){
                    delfino.handler.state.clear();
                    _delfino.setInProcessHandlerInit(false);
                }});
            })(this.ctx);
        }
        function installCheckError(param) {

            /* //WIZVERA_TEST_START
            check_MSG += "initHandler[notInstall] " + Math.floor( (new Date()).getTime() - check_TIME.getTime() ) / 1000 + "\n";
            if (document.location.href.indexOf("debug=on")>=0) alert(check_MSG);
            //WIZVERA_TEST_END */

            if(param.objver == "") {    //timeout , error
                if(ctx.retryCount < 0) {
                    delfino.handler.state.clear();
                    if(ctx.goInstall != undefined && ctx.goInstall == false) return _delfino.setInProcessHandlerInit(false);
                    DCrypto.goInstallPage();
                    _delfino.setInProcessHandlerInit(false);
                    return;
                }

                (function(ctx){
                    setTimeout(function(){Delfino.initHandler(ctx);},ctx.execTimeout);
                })(this.ctx);
                return;
            }
            else if (param.objver < param.confver) { //old version
                delfino.handler.state.clear();
                if(ctx.goInstall != undefined && ctx.goInstall == false) return _delfino.setInProcessHandlerInit(false);
                DCrypto.goInstallPage();
                _delfino.setInProcessHandlerInit(false);
                return;
            }
            delfino.handler.state.setState("init", false);
            _delfino.setInProcessHandlerInit(false);
        }

        (function(ctx){
            setTimeout(function() {
                delfino.handler.helper.isInstall({"ctx":ctx,"error":installCheckError,"success":installCheckOk});
            },1);
        })(this._ctx);
    };

    _delfino.init = function(installCheck) {
        if(installCheck == undefined)
            installCheck = true;

        if(this.inited) {
            return true;
        }


        return this.par_init(installCheck);

    };
    _delfino.getMACAddress = function(cb) {
        //var completeCallback = function(mac){ alert(mac); };
        //if (typeof(cb) != "function") cb = completeCallback;
        if (typeof(cb) != "function") return "";

        delfino.handler.getProperty("MACAddress",{}).onsuccess(function(res){
            if(res.res == 0) {
                cb(res.data);
            } else {
                cb("");
            }
        }).onerror(function(){
            cb("");
        }).invoke();
    };
    _delfino.getVersion = function(cb)
    {
        if (typeof(cb) != "function") return "";
        delfino.handler.getVersion({}).onsuccess(function(res){
            if(res.res == 0) {
                cb(res.data);
            } else {
                cb("");
            }
        }).onerror(function(){
            cb("");
        }).invoke();
    };
    _delfino.setProperties = function(properties) {
        DCrypto.setPropertyJson(properties);
    };

    _delfino.setLang = function(lang){
        DelfinoConfig.lang = lang;

        var langUrl="";
        if(lang == "KOR" || lang == "korean"){
            langUrl = DelfinoConfig.langUrl.koreanUrl;
            lang = "korean";
        }
        else if(lang == "ENG" || lang == "english"){
            langUrl = DelfinoConfig.langUrl.englishUrl;
            lang = "english";
        }
        else if(lang == "CHN" || lang == "chinese"){
            langUrl = DelfinoConfig.langUrl.chaneseUrl;
            lang = "chinese";
        }
        else if(lang == "JPN" || lang == "japanese"){
            langUrl = DelfinoConfig.langUrl.japaneseUrl;
            lang = "japanese";
        }
        else if(lang == "VNM" || lang == "vietnamese"){
            langUrl = DelfinoConfig.langUrl.vietnameseUrl;
            lang = "vietnamese";
        }

        jQuery.ajax({
            url: langUrl,
            async: false,
               dataType: 'text',
               success: function(data){
                   DCrypto.setLang(lang, data);
               }
        });
    };

    return _delfino;
})(jQuery);

jQuery(document).ready(function setup() {
    if(typeof window.DelfinoConfig === 'undefined' || typeof window.DC_setModule === 'undefined') {
        setTimeout(setup, 100);
        return;
    }

    try {
        if(Delfino.initHandler != undefined) {
            //Delfino.initHandler({retryCount:0,execTimeout:2000,goInstall:false});
        } else {
            Delfino.init(false); //Preloaded
        }
    } catch(e) {}
});

if( DelfinoConfig.useRecentModule ){
    Delfino.setModule();
}
else{
    Delfino.setModule(DelfinoConfig.module);
}

})(jQuery);
