// script 주소 설정.
(function(GLOBAL) {
var _scriptBase = "/wizvera/delfino";
var scriptList = [
    _scriptBase + '/delfino_config.js',
    _scriptBase + '/delfino_internal.min.js',
    _scriptBase + '/delfino.js',
    _scriptBase + '/delfino_site.js'
];
var scriptBody = {};

function appendScript(url, i) {
    var requestScript = new XMLHttpRequest();
    requestScript.addEventListener('load', function(event) {
        if(event.target.status !== 200 && event.target.status !== 304) {
            alert('There is an error on load '+url+' file.('+event.target.status+')');
            return;
        }
        var txt = this.responseText;
        if(!txt) {
            alert('There is an error on load '+url+' file.(No response text)');
            return;
        }
        scriptBody[i] = txt;
        checkScriptAndRun();
    });

    requestScript.addEventListener("error", function(evt) {
        alert('There is an error on load '+url+' file.(network)');
    });

    requestScript.open("GET", url[i]);
    requestScript.send();
}
function checkScriptAndRun() {
    for(var i=0;i<scriptList.length;i++)
        if(!scriptBody[i])
            return;

    for(var i=0;i<scriptList.length;i++)
        GLOBAL.eval.call(GLOBAL, scriptBody[i]);
}

for(var i=0;i<scriptList.length;i++) appendScript(scriptList, i);
})(window);
