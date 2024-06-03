/**
 *  @name Veraport V2 - veraport20_handler.js
 *  @author jhkoo77
 *  @date 2016.11.24
**/

var vp20 = vp20 || {};
vp20.conf = vp20.conf || {};
vp20.conf.handler = vp20.conf.handler || (function($){
    var _conf = {};
    _conf.version = VP_config.version;

    _conf.port = (VP_platformInfo.x64 != true || VP_platformInfo.Windows != true) ? 16105 : 16106;
    _conf.ajaxto = 3000;
    _conf.ajaxtoShow = 7000;
    _conf.cbName = "vp20handler_callback";
    _conf.reqUrl = "https://127.0.0.1:"+_conf.port;
    _conf.protocol = "wizvera-veraport";
    _conf.protocol_x64 = "wizvera-veraport-x64";
    _conf.iframe_prefix = "veraport20_handler_iframe_";
    _conf.form_prefix = "veraport20_handler_form_";
    _conf.retryLimit = 1;
    _conf.supportSync = false;
    _conf.uiInterval = 1000;
    return _conf;

})(jQuery);

//기존 plug-in 매핑 함수
function vpu_setConfigure(key,value) {
    vp20.handler.store.configure = vp20.handler.store.configure || {};
    vp20.handler.store.configure[key] = value;
}
function vpu_checkVp20Install(goInstallPage) {
    if (!vp_isUse()) return false;
    if (vp20.handler.store.isload) {
        var objver = vpu_getVersion().replace(/[.,]/gi,"");
        var confver = VP_config.version.replace(/[.,]/gi,"");
        //confver = "2.6.0.1".replace(/[.,]/gi,"");; //TODO: 자릿수체크 필요
        //alert(objver + ":" + confver);
        if(objver >= confver) return true;
        if (goInstallPage) vp_goVp20InstallPage();
    } else {
        if (goInstallPage) vp_goVp20InstallPage();
    }
    return false;
}

function vpu_getVersion() {
    return vp20.handler.store.version;
}
function vpu_getOsInfo() {
    return vp20.handler.store.osinfo;
}
function vpu_getAxInfoList() {
    //alert(JSON.stringify(vp20.handler.store.axInfo));
    return vp20.handler.store.axInfo;
}
function vpu_getConfigureJson() {
    //alert(JSON.stringify(vp20.handler.store.configureInfo));
    return vp20.handler.store.configureInfo;
}
function vpu_getDistInfo() {
    //alert(JSON.stringify(vp20.handler.store.distInfo));
    var retDistInfo = {version: "", createDate: "", allowDomains: ""};
    try {
        var distinfo = vp20.handler.store.distInfo;
        if (typeof(distinfo) == "undefined") return null;

        retDistInfo.version = (distinfo[0].version == 0) ? "1.0" : "2.0";
        if(distinfo[0].verstring != null && distinfo[0].verstring != "undefined")
            retDistInfo.version = distinfo[0].verstring;

        retDistInfo.createDate = distinfo[0].createdate;
        if(distinfo[0].allowdomains != null && distinfo[0].allowdomains != "undefined")
            retDistInfo.allowDomains =distinfo[0].allowdomains;
        return retDistInfo;
    }
    catch(err) {
        alert("vpu_getDistInfo[" + err.description + "]");
    }
    return null;
}

function exec_showVeraport(completeCallback,param) {
    var type = param.type;

    vp_setDomain(VP_DOMAIN_URL); //add 2013.01.16
    vp_setAxInfoUrl(VP_config.axInfoURL);
    vp_setLogSendUrl(VP_config.logInfoSendURL);
    vp_setClientInfoSendUrl(VP_config.cliInfoSendURL);
    if (VP_platformInfo.Windows) vp_setRequireAgreement(vp_AgreeInstall,vp_AgreeSiteID,VP_config.agreePageURL,vp_AgreeDefUse);

    var flag = 1;
    if(type ==  VP_TYPE_MANAGE || type ==  VP_TYPE_FULL) {
        vp_setLogo(VP_config.logoLarge);
        vp_setMsg(VP_config.msgLarge);
        vp_setWebInfo(VP_config.msgInfo);
        if (type == VP_TYPE_MANAGE && typeof(VP_config.msgLargeM) != "undefined" && typeof(VP_config.msgInfoM) != "undefined" ) {
            vp_setMsg(VP_config.msgLargeM);
            vp_setWebInfo(VP_config.msgInfoM);
        }
        if(type ==  VP_TYPE_MANAGE) flag = 0;
    } else {
        vp_setLogo(VP_config.logoSmall);
        vp_setMsg(VP_config.msgSmall);
    }
    vp_setConfigure("type",type);


    var showTimeout = function(ctx) {
        vpu_alert("execVP_axInstall showTimeout");
        vp_delay(3000);
        showSuccess("showTimeout", ctx);
    };
    var showError = function(res,ctx) {
        vpu_alert("execVP_axInstall showError");
        vp_delay(1000);
        showSuccess(res, ctx);
    };
    var showSuccess = function(res,ctx) {
        //vpu_alert("execVP_axInstall showSuccess");
        //vp_delay(200);
        if (VP_TYPE_MANAGE == vp20.handler.store.configure["type"]) return;
        var checkTimer = new wiz.util.timer(2000,function(){
            vp20.handler.isRunning({"trigger":"0","completeCallback":ctx.completeCallback}).onsuccess(function(res,ctx){
                if(ctx.trigger != undefined && ctx.trigger == res.data) {
                    checkTimer.stop();
                    navigator.plugins.refresh(false); vp_setForceInstall(""); vp_SetSendVpInfo("false");
                    ctx.completeCallback(ctx.param);
                }
                //alert(res.data);
            }).onerror(function(res,ctx){
                checkTimer.stop(); ctx.completeCallback(ctx.param);
            }).ontimeout(function(ctx){
                checkTimer.stop(); ctx.completeCallback(ctx.param);
            }).invoke();
        });

        checkTimer.start();
    };


    if(VP_platformInfo.Windows){
        vp20.handler.show(vp20.handler.store.configure,{"ajaxto":vp20.conf.handler.ajaxtoShow,"completeCallback":completeCallback,"param":param}).onsuccess(showSuccess).onerror(showError).ontimeout(showTimeout).invoke();
    }else{
        var handle = vp20.handler.addComplete(showSuccess);
        var _resTimer = new wiz.util.timer(3000,function(){
            vp20.handler.getResult("{\"handle\":\"" + handle +"\"}").onsuccess(function(res,ctx){
                _resTimer.stop();
                showSuccess(res,{"completeCallback":completeCallback,"param":param});
            }).invoke();
        });
        vp_setConfigure("plugininfo", pluginInfo2JSON());
        vp20.handler.store.configure["handle"] = handle;
        vp20.handler.show(vp20.handler.store.configure,{"ajaxto":vp20.conf.handler.ajaxtoShow,"completeCallback":completeCallback,"param":param}).invoke();
        _resTimer.start();
    }
}


//[OPEN API] View handler/plug-in Management
function execVP_axManage() {
    execVP_axInstall(VP_TYPE_MANAGE, false, '');
}

//[OPEN API] Required Install handler/plug-in
function execVP_axInstallMust() {
    execVP_axInstall(VP_TYPE_MUST, true, '');
}
//[OPEN API] ALL Install handler/plug-in
function execVP_axInstallAll() {
    execVP_axInstall(VP_TYPE_MUST, true, VP_CONF_SELECTOBJECT_ALL);
}

//[OPEN API] Select Install handler/plug-in
function execVP_axInstallSelect(objectName) {
    execVP_axInstall(VP_TYPE_SELECT, false, objectName);
}

//[OPEN API] Install handler/plug-in
function execVP_axInstall(installType, goInstallPage, objectName) {
    var completeCallback = function(){alert("URL Handler Show Result: veraport show complete");};
    if (typeof(VP_axInstallCB) != "function") VP_axInstallCB = completeCallback;
    if (objectName == "must") objectName = ""; //add 2016-01-27

    if (!VP_config.useHandler) { //plug-in
        VP_axInstall(installType, goInstallPage, objectName);
        if (VP_platformInfo.Windows && !vp_isInstallCB() && installType!= VP_TYPE_MANAGE) VP_axInstallCB();
        return;
    }

    if (!vp_isUse()) {
        if (installType!= VP_TYPE_MANAGE) VP_axInstallCB();
        return;
    }

    var result_isInstall = function(result, param) {
        if(!vp_checkVp20Install(goInstallPage)) return;
        vp_setSelectObject(objectName);
        exec_showVeraport(param.completeCallback, {"type":param.installType});
    };

    execVP_isInstall(result_isInstall, {"completeCallback":VP_axInstallCB,"installType":installType,"goInstallPage":goInstallPage,"objectName":objectName});
}

//[API] Not Install Count(input_param: "obj1,obj2,obj3","must","option","all")
function execVP_axUninstalledCnt(completeCallback, objList) {
    if (objList == "") objList = "must"; //add 2016-01-27

    if (!vp_isUse()) {
        completeCallback(0, null);
        return;
    }

    if (!VP_config.useHandler) { //plug-in
        //completeCallback(VP_axUninstalledCnt(objList), null);
        if (!vp_checkVp20Install(false)) {
            completeCallback(-1, null);
            return;
        }
        try {
            var axInfoList = vp_getAxInfoList();
            if (axInfoList == null) return 0;
            var instInfo = vp_getInstalledInfo(axInfoList,objList);
            //vp_alert("objList ["+objList+"]\ninstList ["+instInfo.instList.length+"]["+instInfo.instList.toString()+"]\nuninsList ["+instInfo.uninsList.length+"]["+instInfo.uninsList.toString()+"]");
            completeCallback(instInfo.uninsList.length, axInfoList);
        } catch (err) {
            vp_alert("VP_axUninstalledCnt[" + err.description + "]");
            completeCallback(0, null);
        }
        return;
    }

    var result_getAxInfo = function(axInfoList, param) {
        try {
            var objList = param.objList;
            if (axInfoList == null) {
                param.completeCallback(0, null);
                return;
            }
            var instInfo = vp_getInstalledInfo(axInfoList,objList);
            //alert("objList ["+objList+"]\ninstList ["+instInfo.instList.length+"]["+instInfo.instList.toString()+"]\nuninsList ["+instInfo.uninsList.length+"]["+instInfo.uninsList.toString()+"]");
            param.completeCallback(instInfo.uninsList.length, axInfoList);
        } catch (err) {
            vp_alert("VP_axUninstalledCnt[" + err.description + "]");
            param.completeCallback(0, null);
        }
    };
    var result_isInstall = function(result, param) {
        if (result) {
            execVP_getAxInfo(result_getAxInfo, {"completeCallback":param.completeCallback,"objList":param.objList});
        } else {
            param.completeCallback(-1, null);
        }
    };
    execVP_isInstall(result_isInstall, {"completeCallback":completeCallback,"objList":objList});
}

//[API] Veraport handler/plugin install check
function execVP_isInstall(completeCallback, param) {
    if (!VP_config.useHandler) { //plug-in
        completeCallback(vp_checkVp20Install(false), param);
        return;
    }

    if (!vp_isUse()) {
        completeCallback(false, param);
        return;
    }

    //vp20.handler.helper.isInstall({"success":function(){completeCallback(true);},"error":function(){completeCallback(false);}});

    if (vpu_checkVp20Install(false)) {
        completeCallback(true, param);
        return;
    }
    if(VP_platformInfo.Windows){
        vp20.handler.getVersion({"param":param}).onsuccess(function(res,ctx){
            completeCallback(vpu_checkVp20Install(false), ctx.param);
        }).onerror(function(res,ctx){
            completeCallback(false, ctx.param);
        }).ontimeout(function(ctx){
            if (VP_browserInfo.MSIE && VP_browserInfo.version < 11) vpu_alert("execVP_isInstall timeout");
            completeCallback(false, ctx.param);
        }).invoke();
    }
    else{
        vp20.handler.getOsInfo({"param":param}).onsuccess(function(res, ctx){
            var handle = vp20.handler.addComplete(completeCallback);
            var _resTimer = new wiz.util.timer(1000,function(){
                vp20.handler.getResult("{\"handle\":\"" + handle +"\"}").onsuccess(function(res,ctx){
                    _resTimer.stop();
                    if (res.data != null) vp20.handler.store.version = res.data;
                    completeCallback(vpu_checkVp20Install(false), param);
                }).invoke();
            });
            vpm_loadInfo();
            vp_setConfigure("useragent", navigator.userAgent);
            //vp_setConfigure("plugininfo", pluginInfo2JSON());
            vp20.handler.store.configure["handle"] = handle;
            vp20.handler.getVersion(vp20.handler.store.configure, {"param":param}).invoke();
            _resTimer.start();
        }).onerror(function(res,ctx){
            completeCallback(false, ctx.param);
        }).ontimeout(function(ctx){
            if (VP_browserInfo.MSIE && VP_browserInfo.version < 11) vpu_alert("execVP_isInstall timeout");
            completeCallback(false, ctx.param);
        }).invoke();
    }
}

function execVP_getVersion(completeCallback, param) {
    //if (typeof(completeCallback) != "function") completeCallback = function(){};
    if (!VP_config.useHandler) { //plug-in
        completeCallback(vp_getVersion(), param);
        return;
    }

    vp20.handler.getVersion({"param":param}).onsuccess(function(res,ctx){
        completeCallback(res.data, ctx.param);
    }).onerror(function(res,ctx){
        completeCallback("0.0.0.0", ctx.param);
    }).ontimeout(function(ctx){
        completeCallback("0.0.0.0", ctx.param);
    }).invoke();
}

function execVP_checkProcess(completeCallback, processName) {
    if (!VP_config.useHandler || !vp_isUse() || !VP_platformInfo.Windows) {
        completeCallback(-2, ""); //미지원 플렛폼
        return;
    }
    if (processName == null || processName == "") {
        completeCallback(0, "");
        return;
    }
    var result_isInstall = function(result, param) {
        if (result) {
            vp20.handler.checkProcess(param.processName,{}).onsuccess(function(res) {
                if(res.data == undefined) {
                    param.completeCallback(-2, ""); //미지원
                } else if(res.data.length == 0) {
                    param.completeCallback(0, ""); //실행된 process없음
                } else {
                	/*
                    var pid = "";
                    $.each(res.data,function(item){
                        pid += res.data[item]["pid"];
                        pid += ",";
                    });
                    */
                    param.completeCallback(res.data.length, res.data);
                }
            }).invoke();
        } else {
            param.completeCallback(-1, null); //미설치
        }
    };
    execVP_isInstall(result_isInstall, {"completeCallback":completeCallback,"processName":processName});
}

function execVP_getAxInfo(completeCallback, param) {
    if (!VP_config.useHandler) { //plug-in
        completeCallback(vp_getAxInfoList(), param);
        return;
    }

    if(VP_platformInfo.Windows){
        vp20.handler.getAxInfo(vp20.handler.store.configure,{"ajaxto":vp20.conf.handler.ajaxtoShow,"param":param}).onsuccess(function(res,ctx){
             completeCallback(res.data,ctx.param);
         }).onerror(function(res,ctx){
             completeCallback(null, ctx.param);
         }).ontimeout(function(ctx){
             vpu_alert("execVP_getAxInfo timeout");
             completeCallback(null, ctx.param);
         }).invoke();
    }else{
        var handle = vp20.handler.addComplete(completeCallback);
        var _resTimer = new wiz.util.timer(3000,function(){
            vp20.handler.getResult("{\"handle\":\"" + handle +"\"}").onsuccess(function(res,ctx){
                _resTimer.stop();
                vp20.handler.store.axInfo = res.data;
                completeCallback(res.data,param);
            }).invoke();
        });
        vp_setConfigure("plugininfo", pluginInfo2JSON());
        vp20.handler.store.configure["handle"] = handle;
        vp20.handler.getAxInfo(vp20.handler.store.configure,{"ajaxto":vp20.conf.handler.ajaxtoShow,"param":param}).invoke();
        _resTimer.start();
    }
}

function execVP_getDistributeInfo(completeCallback, param) {
    if (!VP_config.useHandler) { //plug-in
        completeCallback(vp_getDistInfo(), param);
        return;
    }

    vp20.handler.getDistributeInfo({"param":param}).onsuccess(function(res,ctx){
        completeCallback(vpu_getDistInfo(),ctx.param); //res.data
    }).onerror(function(res,ctx){
        completeCallback(null,ctx.param);
    }).ontimeout(function(ctx){
        completeCallback(null, ctx.param);
    }).invoke();
}

function execVP_getConfigureJson(completeCallback, param) {
    if (!VP_config.useHandler) { //plug-in
        completeCallback(vp_getConfigureJson(), param);
        return;
    }

    vp20.handler.getConfigureJson({"param":param}).onsuccess(function(res,ctx){
        completeCallback(res.data,ctx.param);
    }).onerror(function(res,ctx){
        completeCallback(null,ctx.param);
    }).ontimeout(function(ctx){
        completeCallback(null,ctx.param);
    }).invoke();
}

//handler_debug 함수
function vpu_alert(msg) {
    /* //WIZVERA_TEST_START
    if (document.location.hostname.indexOf("wizvera.com") >= 0) alert(msg);
    //WIZVERA_TEST_END */
}

/*
function installCheck(caller,callerCallback) {
    execVP_isInstall(function(bInstall){
        if(bInstall == true) {
            var parentFnName = "org_"+fnName;
            var fn = window[parentFnName];
            fn.apply(window,args);
            }
        else {
            callerCallback(false);
        }
    });
}

function backupParentFunctions(funcs) {
    for(var index in funcs) {
        var func = funcs[index];
        window["org_"+func] = window[func];
    }
}
function createProxyFunctions(funcs) {
    for(var index in funcs) {
        var func = funcs[index];
        (function(func){
            window[func] = function() {
                installCheck(func,arguments);
            };
        })(func);
    }
}

function test() {
    var funcs = ["execVP_getAxInfo"];
    backupParentFunctions(funcs);
    createProxyFunctions(funcs);
}
test();

function execVP_test(objList, completeCallback) {
    execVP_getAxInfo(function(res){
    });
    //execVP_isInstall(completeCallback, param);
    //execVP_getAxInfo(completeCallback, param);
}
*/

vp20.cmd = (function($){
    var _cmd = {};
    function iframePost(url) {
        var _obj = this;
        _obj.time = new Date().getTime();
        _obj.form = $('<form accept-charset="UTF-8" action="'+url+'" target="veraport20_iframe'+_obj.time+'" method="post" style="display:none; id="veraport20_form'+_obj.time+'"></form>');
        _obj.addParam = function(name,value) {
            $('<input type="hidden"/>').attr("name",name).attr("value",value).appendTo(_obj.form);
        };
        _obj.send = function() {
            var iframe = $('<iframe style="width:1px;height:1px;display:hidden" data-time="'+_obj.time+'" id="veraport20_iframe'+_obj.time+'" name="veraport20_iframe'+_obj.time+'"></iframe>');
            $('body').append(iframe);
            $('body').append(_obj.form);
            _obj.form.submit();
            iframe.load(function(){
                $('#veraport20_form'+$(this).data('time')).remove();
                $(this).remove();
            });
        };
    }
    function invokePost(ctx) {
        var conf = vp20.conf.handler;
        var ip = new iframePost(conf.reqUrl);
        //ip.addParam("cmd",ctx.data.cmd);
        ip.addParam("data",JSON.stringify(ctx.data));
        ip.send();

    };
    function callJsonp(ctx,reqUrl,callData,retryLimit,ajaxto,callbackName) {
        try {
            return $.ajax({
                userctx:ctx,
                url:reqUrl,
                data:callData,
                retryLimit:retryLimit,
                retryCount:0,
                timeout:ajaxto,
                dataType:"jsonp",
                //jsonpCallback:callbackName,
                success : function(res){
                    vp20.handler.callDefaultSuccess(this.userctx.data.cmd,res);
                    if(this.userctx.success != undefined) {
                        this.userctx.success(res,this.userctx);
                    }
                },
                error : function(xhr, textStatus, errorThrown) {
                    //console.log(JSON.stringify(xhr));
                    if(textStatus == "timeout") {
						//console.log("callJsonp timeout");
                        if(this.userctx.timeout != undefined ) {
                            this.userctx.timeout(this.userctx);
                            return;
                        }
                        this.retryCount++;
                        if(this.retryCount <= this.retryLimit) {
                            $.ajax(this);
                            return;
                        }
                    }
                    if(this.userctx.error != undefined) {
                        this.userctx.error(xhr,this.userctx);
                    }else {
                        vp20.handler.callDefaultError(xhr,this.userctx);
                    }
                    return;
                }
            });
        }
        catch(e) {
        }
    }
    function callAjax(ctx,reqUrl,callData,retryLimit,ajaxto,callbackName) {
        var result = {};
        try {
            $.ajax({
                userctx:ctx,
                url:reqUrl,
                data:callData,
                timeout:ajaxto,
                dataType:"json",
                type:"POST",
                async:false,
                crossDomain:true,
                success : function(res){
                    vp20.handler.callDefaultSuccess(this.userctx.data.cmd,res);
                    if(this.userctx.success != undefined) {
                        this.userctx.success(res,this.userctx);
                    }
                    result = res;
                },
                error : function(xhr, textStatus, errorThrown) {
                    if(this.userctx.error != undefined) {
                        this.userctx.error(xhr,this.userctx);
                    }else {
                        vp20.handler.callDefaultError(xhr,this.userctx);
                    }
                    result = undefined;
                }
            });
        }
        catch(e) {
        }
        return result;
    }
    function invokeMethod(ctx) {

        var data = ctx.data;
        if(typeof data == "object")
            data = JSON.stringify(data);
        //data = encodeURIComponent(data);

        var conf = vp20.conf.handler;
        var ajaxto = ctx.ajaxto || conf.ajaxto;
        var retryLimit = ctx.retryLimit || conf.retryLimit;

        var reqUrl = conf.reqUrl;
        if(ctx.reqUrl != undefined)
            reqUrl = reqUrl + ctx.reqUrl;
        else
            reqUrl = reqUrl + "/";

        //var callbackName = conf.cbName+parseInt(Math.random() * 999999 % 999999); //이름이 같은경우 연속해서 호출될경우 박살남
        var callbackName = conf.cbName + new Date().getTime(); //getTime()으로 변경
        if(ctx.sync != undefined && ctx.sync == true) {
            return callAjax(ctx,reqUrl,{"data":data},retryLimit,ajaxto,callbackName);
        }
        return callJsonp(ctx,reqUrl,{"data":data},retryLimit,ajaxto,callbackName);


    };
    _cmd.invoke = function(ctx) {
        if(ctx.sync != undefined && ctx.sync == true)
            return invokeMethod(ctx);

        var tempData = JSON.stringify(ctx.data);
        if(tempData.length > 2048) {
            return invokePost(ctx);
        }
        else {
            return invokeMethod(ctx);
        }
    };

    return _cmd;
})(jQuery);

vp20.handler = vp20.handler || (function($) {
    var completes = {};
    var completeHandle = 0;
    var _handler = {};
    _handler._cb = {};
    _handler._defErrorCallback = function(xhr,ctx){};
    //var _sid = parseInt(Math.random() * 999999 % 999999).toString();
    var _sid = new Date().getTime().toString(); //getTime()으로 변경

    _handler.getSid = function() {
        return _sid;
    };
    _handler.setSid = function(sid) {
        _sid = sid;
    };
    _handler.addComplete = function(complete){
        var handle = completeHandle++;
        completes[handle] = complete ;
        return handle.toString();
    };
    function commonFunc(cmd,data,ctx) {
        ctx = ctx || {};

        if(vp20.conf.handler.supportSync == true) {
            var syncMethod = ["setProperty","setPropertyJson","setConfig","setConfigJson","setConfigureJson","getConfig","getProperty","isAlive","getVersion","getOsInfo","getConfigure","checkProcess"];
            if($.inArray(cmd,syncMethod) >= 0)
                ctx.sync = true;
        }

        var data = {"cmd":cmd,"sid":_sid,"data":data};
        ctx.data = data;
        return getCallbackCtx(ctx.data.cmd,ctx);
    };
    _handler.checkProcess = function(data,ctx)  {
        return commonFunc("checkProcess",data,ctx);
    };
    _handler.setConfigureJson = function(data,ctx) {
        return commonFunc("setConfigureJson",data,ctx);
    };
    _handler.isAlive = function(ctx) {
        return commonFunc("isAlive",{},ctx);
    };
    _handler.loadInfo =function(url,ctx) {
        return commonFunc("loadInfo",{"url":url},ctx);
    };
    _handler.setConfigure =function(key,value,ctx) {
        return commonFunc("setConfigure",{"key":key,"value":value},ctx);
    };
    _handler.getOsInfo = function(ctx) {
        return commonFunc("getOsInfo",{},ctx);
    };
    _handler.getConfigure = function(data,ctx) {
        return commonFunc("getConfigure",data,ctx);
    };
    _handler.getConfigureJson = function(ctx) {
        return commonFunc("getConfigureJson",{},ctx);
    };
    _handler.getLastErrorMsg = function(ctx) {
        return commonFunc("getLastErrorMsg",{},ctx);
    };
    _handler.getDistributeInfo = function(ctx) {
        return commonFunc("getDistributeInfo",{},ctx);
    };
    _handler.isRunning = function(ctx) {
        return commonFunc("isRunning",{},ctx);
    };
    _handler.getResult = function(data,ctx) {
        return commonFunc("getResult",data,ctx);
    };
    _handler.getVersion = function(conf,ctx) {
        if(arguments.length == 1){
            ctx = conf;
            conf = undefined;
        }
        var data = {"cmd":"getVersion"};
        if(conf) {
            data["configure"] = conf;
        }
        return commonFunc("getVersion",data,ctx);
    };
    _handler.show = function(conf,ctx) {
        if(arguments.length == 1){
            ctx = conf;
            conf = undefined;
        }
        var data = {"cmd":"show","type":"1"};
        if(conf) {
            data["configure"] = conf;
        }


        if(!VP_platformInfo.Windows){
            try {
                vpm_showDialog(conf.type);
                vp20.handler.ui.run();
            } catch(err) {VP_complete();}
        }


        return commonFunc("show",data,ctx);
    };

    _handler.getPreDownInfo = function(conf,ctx)  {
        if(arguments.length == 1){
            ctx = conf;
            conf = undefined;
        }
        var data = {"cmd":"getPreDownInfo"};
        if(conf) {
            data["configure"] = conf;
        }
        return commonFunc("getPreDownInfo",data,ctx);
    };
    _handler.getAxInfo = function(conf,ctx) {
        if(arguments.length == 1){
            ctx = conf;
            conf = undefined;
        }
        var data = {"cmd":"getAxInfo"};
        if(conf) {
            data["configure"] = conf;
        }
        return commonFunc("getAxInfo",data,ctx);
    };
    _handler.invoke = function(ctx) {
        return vp20.cmd.invoke(ctx);
    };

    _handler.updateUI = function(confirmResult,ctx) {
        var data = {"cmd":"updateUI","confirmResult":confirmResult};
        ctx = ctx || {};
        ctx['data'] = data;
        return getCallbackCtx(ctx.data.cmd,ctx);
    };

    _handler.on = function(name,success,cbctx) {
        cbctx = cbctx || {};
        cbctx.success = success;
        cbctx.error = this._defaultErrorCallback;

        this._cb[name] = cbctx;
        return this;
    };
    _handler.err = function(err) {
        this._defErrorCallback = err;
    };
    function getCallbackCtx(name,ctx) {
        var defCallback = _handler._cb[name];
        if(undefined == defCallback) {
            defCallback = {};
            defCallback.success = function(res){};
            defCallback.error = function(res){};
            defCallback.timeout = function(res){};
        }
        defCallback.onsuccess = function(cb) { this.success = cb; return this;};
        defCallback.onerror = function(cb) { this.error = cb; return this;};
        defCallback.ontimeout = function(cb) { this.timeout = cb; return this;};
        defCallback.invoke = function() { vp20.handler.invoke(this);};

        ctx = $.extend({},defCallback,ctx);
        return ctx;
    };
    function exec_iframe() {
        var conf = vp20.conf.handler;

        if($('#veraport20iframe').size() == 0) {
            $("<iframe id='veraport20iframe' style='width:1px;height:1px;visibility:hidden;'/>").appendTo('body');
        }
        var arch = (VP_platformInfo.x64 == true) ? "x64" : "x86";
        var protocol = (VP_platformInfo.x64 == true) ? conf.protocol_x64 : conf.protocol;
        var port = vp20.conf.handler.port;

        //alert(conf.protocol+"://exec/"+arch+"/"+port+"/"+encodeURIComponent(navigator.userAgent));

        $('#veraport20iframe').get(0).src = conf.protocol+"://exec/"+arch+"/"+port+"/"+encodeURIComponent(navigator.userAgent);

    }
    function exec_open() {
        var conf = vp20.conf.handler;

        var arch = (VP_platformInfo.x64 == true) ? "x64" : "x86";
        var protocol = (VP_platformInfo.x64 == true) ? conf.protocol_x64 : conf.protocol;
        var port = vp20.conf.handler.port;


        var src = conf.protocol+"://exec/"+arch+"/"+port+"/"+encodeURIComponent(navigator.userAgent);
        var w = window.open(src, 'veraport_handler', 'status=0,toolbar=0, menubar =0, height=0, width =0, top= -10, left=-10 ');
        if(w != null) {
        }else {
        }

    }
    _handler.execute = function() {
        if (VP_browserInfo.MSIE && VP_browserInfo.version == 9) {
            exec_open();
        } else {
            exec_iframe();
        }
    };



    _handler.callDefaultError = function(xhr,ctx) {
        this._defErrorCallback(xhr,ctx);
    };
    _handler.callDefaultSuccess = function(cmd,res) {
        vp20.handler.store.isload = true;
        var fn = this._cb[cmd];
        if(fn != undefined) {
            fn.success(res);
        }
    };


    //default success callback
    _handler.on("getAxInfo",function(res){
        vp20.handler.store.axInfo = res.data;
    });
    _handler.on("getPreDownInfo",function(res){
        vp20.handler.store.preDownInfo = res.data;
    });
    _handler.on("getDistributeInfo",function(res){
        vp20.handler.store.distInfo = res.data;
    });
    _handler.on("getConfigureJson",function(res) {
        vp20.handler.store.configureInfo = res.data;
    });
    _handler.on("getVersion",function(res) {
        vp20.handler.store.version = res.data || "";
    });
    _handler.on("getOsInfo",function(res) {
        vp20.handler.store.osinfo = res.data;
    });
    _handler.err(function(xhr,ctx){
        alert(xhr);
    });

    return _handler;
})(jQuery);

vp20.handler.store = vp20.handler.store || (function($){
    var _store = {};
    _store.configure = undefined;
    _store.isload = false;
    _store.version = "0.0.0.0";
    _store.axInfo = undefined;
    _store.preDownInfo = undefined;
    _store.distInfo = undefined;
    _store.configureInfo = undefined;
    _store.osinfo = undefined;
    return _store;
})(jQuery);

/* for multi ui */
vp20.handler.ui = vp20.handler.ui || (function($) {
    var _ui = {};
    _ui._id = 0;
    _ui._hasBegun = false;

    _ui.run = function(param) {
        console.log("ui run");
        if (_ui._hasBegun){
            console.log("ui run1");
            return;
        }
        _ui._hasBegun = true;

        _ui._id = setInterval(function(){
            vp20.handler.updateUI("").onsuccess(function(res, ctx) {
                var scripts = res.data;
                for(var idx = 0; idx < scripts.length; ++idx) {
                    var script = JSON.parse(scripts[idx]);
                    var fn = window[script.func];
                    try {
                        console.log(script.func + "(" + script.args + ")");
                        if(typeof fn == "function") {

                            var ret = fn.apply(null,script.args);
                            if (script.func == "confirm") {
                                _ui.stop();
                                vp20.handler.updateUI(ret.toString())
                                    .onsuccess(function() { _ui.run(); }).invoke();
                            }
                        }
                    }catch(e) { console.log(e); }

                    // TODO: do better
                    if (script.func == "VP_complete") _ui.stop();
                }
            }).onerror(function(res, ctx) {
                _ui.stop();
            }).invoke();

        }, vp20.conf.handler.uiInterval);
    };
    _ui.stop = function() {
        clearInterval(this._id);
        _ui._hasBegun = false;
    };
    return _ui;
})(jQuery);


vp20.handler.helper = vp20.handler.helper || (function($){
    var _helper = {};
    _helper.isInstall = function(param) {
        param = param || {};
        param.error = param.error || function(){};
        param.success = param.success || function(){};

        vp20.handler.isAlive({}).onsuccess(function(){
            //alert("isInstall_onsuccess");
            vp20.handler.getVersion({}).onsuccess(function(res,ctx){
                var objver = res.data || "";
                objver = objver.replace(/[.,]/gi,"");
                var confver = vp20.conf.handler.version;
                confver = confver.replace(/[.,]/gi,"");
                if(objver < confver) {
                    param.error({"objver":objver,"confver":confver});
                }
                else {
                    param.success();
                }

            }).invoke();
        }).onerror(function(){
            //alert("isInstall_onerror");
            if(param.error) {
                var confver = vp20.conf.handler.version;
                confver = confver.replace(/[.,]/gi,"");
                param.error({"objver":"-1","confver":confver});
            }
        }).ontimeout(function(){
            //alert("isInstall_timeout");
            if(param.error) {
                var confver = vp20.conf.handler.version;
                confver = confver.replace(/[.,]/gi,"");
                param.error({"objver":"-1","confver":confver});
            }
        }).invoke();
    };
    return _helper;
})(jQuery);

var wiz  = wiz || {};
wiz.util = wiz.util || {};
wiz.util.timer = function(interval,fn) {
    this._int = interval;
    this._fn = fn;
    this._id = -1;
    this.start = function() {
        if(this._id >=0) return;
        this._id = setInterval(this._fn,this._int);
    };
    this.stop = function() {
        if(this._id > 0) {
            clearInterval(this._id);
            this._id = -1;
        }
    };
};

function vp20handler_callback(res) {
    //console.log(res);
}


var JSON = JSON || new Object();

JSON.stringify = JSON.stringify || function (obj) {
    var t = typeof (obj);
    if (t != "object" || obj === null) {
        return String(obj);
    }
    else {
        // recurse array or object
        var n, v, json = [], arr = (obj && obj.constructor == Array);
        for (n in obj) {
            v = obj[n]; t = typeof(v);
            if (t == "string") v = '"'+v+'"';
            else if (t == "object" && v !== null) v = JSON.stringify(v);
            json.push((arr ? "" : '"' + n + '":') + String(v));
        }
        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
    }
};

try {
    if (VP_config.useHandler) {
        if (typeof VP_BASE_URL == "undefined") alert("include 'veraport20.js'");
        if (typeof jQuery == "undefined") alert("jQuery is not available!!!");
        //VP_axManage = vpu_axManage;

        //UrlHandler용 함수 assign 필요
        //vp_show = vpu_show;
        VP_axInstall = execVP_axInstall;

        vp_setConfigure = vpu_setConfigure;
        vp_checkVp20Install = vpu_checkVp20Install;
        vp_getVersion = vpu_getVersion;
        vp_getAxInfoList = vpu_getAxInfoList;
        vp_getDistInfo = vpu_getDistInfo;
        vp_getConfigureJson = vpu_getConfigureJson;

        if(!VP_platformInfo.Windows){
            var vpProxy= {};
            vpProxy.GetOSInfo = function(){
                return vpu_getOsInfo();
            };
            vp_getObject = vp_createObject = function() {
                vpm_checkVp20Plugin();
                return vpProxy;
            };
            vpm_checkVp20Plugin = function(){
                navigator.plugins.refresh(false);
                return true;
            };
        }

        vp_init();
    }
} catch(err) { alert("vpu_Main[" + err.description  + "]"); }

