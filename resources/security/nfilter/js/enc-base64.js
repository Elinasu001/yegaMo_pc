(function(){var h=nSaferJS,k=h.lib.WordArray;h.enc.Base64={stringify:function(b){var e=b.words,f=b.sigBytes,c=this._map;b.clamp();b=[];for(var a=0;a<f;a+=3)for(var d=(e[a>>>2]>>>24-a%4*8&255)<<16|(e[a+1>>>2]>>>24-(a+1)%4*8&255)<<8|e[a+2>>>2]>>>24-(a+2)%4*8&255,g=0;4>g&&a+.75*g<f;g++)b.push(c.charAt(d>>>6*(3-g)&63));if(e=c.charAt(64))for(;b.length%4;)b.push(e);return b.join("")},parse:function(b){var e=b.length,f=this._map,c=f.charAt(64);c&&(c=b.indexOf(c),-1!=c&&(e=c));for(var c=[],a=0,d=0;d<e;d++)if(d%
4){var g=f.indexOf(b.charAt(d-1))<<d%4*2,h=f.indexOf(b.charAt(d))>>>6-d%4*2;c[a>>>2]|=(g|h)<<24-a%4*8;a++}return k.create(c,a)},_map:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="}})();