<html>
    <head>
        <script src="jquery/jquery-3.3.1.min.js"></script>
        <script src="delfino_deviceid.min.js"></script>
    </head>
    <body>
        <script language="javascript">

            window.addEventListener('message',function(event) {
                var deviceID;
                wizvera.fp2(function(_deviceID) {
                  deviceID = _deviceID;
                  //console.log("inner deviceID", deviceID);
                  event.source.postMessage(deviceID,event.origin);
                });
            },false);
        </script>
    </body> 
</html>
