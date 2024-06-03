var nFilterKeyStr = "ABCDEFGHIJKLMNOP" + "QRSTUVWXYZabcdef" + "ghijklmnopqrstuv" + "wxyz0123456789+/" + "=";
var nFilterB64map = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
var nFilterB64padchar = "=";
var nFilterKeyLength = 0;

/**
 * base64 인코딩
 * @param input
 * @returns {string}
 */
function nFilterEncode64(input) {
    input = escape(input);
    var output = "";
    var chr1, chr2, chr3 = "";
    var enc1, enc2, enc3, enc4 = "";
    var i = 0;

    do {
        chr1 = input.charCodeAt(i++);
        chr2 = input.charCodeAt(i++);
        chr3 = input.charCodeAt(i++);

        enc1 = chr1 >> 2;
        enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
        enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
        enc4 = chr3 & 63;

        if (isNaN(chr2)) {
            enc3 = enc4 = 64;
        } else if (isNaN(chr3)) {
            enc4 = 64;
        }

        output = output + nFilterKeyStr.charAt(enc1) + nFilterKeyStr.charAt(enc2) +
            nFilterKeyStr.charAt(enc3) + nFilterKeyStr.charAt(enc4);
        chr1 = chr2 = chr3 = "";
        enc1 = enc2 = enc3 = enc4 = "";
    } while (i < input.length);

    return output;
}

/**
 * base64 디코딩
 * @param input
 */
function nFilterDecode64(input) {
    var output = "";
    var chr1, chr2, chr3 = "";
    var enc1, enc2, enc3, enc4 = "";
    var i = 0;

    var base64test = /[^A-Za-z0-9\+\/\=]/g;
    if (base64test.exec(input)) {

    }
    input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

    do {
        enc1 = nFilterKeyStr.indexOf(input.charAt(i++));
        enc2 = nFilterKeyStr.indexOf(input.charAt(i++));
        enc3 = nFilterKeyStr.indexOf(input.charAt(i++));
        enc4 = nFilterKeyStr.indexOf(input.charAt(i++));

        chr1 = (enc1 << 2) | (enc2 >> 4);
        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
        chr3 = ((enc3 & 3) << 6) | enc4;

        output = output + String.fromCharCode(chr1);

        if (enc3 != 64) {
            output = output + String.fromCharCode(chr2);
        }
        if (enc4 != 64) {
            output = output + String.fromCharCode(chr3);
        }

        chr1 = chr2 = chr3 = "";
        enc1 = enc2 = enc3 = enc4 = "";

    } while (i < input.length);

    return unescape(output);
}

/**
 * hex to base64
 * @param h
 * @returns {string}
 */
function nFilterHex2b64(h) {
    var i;
    var c;
    var ret = "";
    for (i = 0; i + 3 <= h.length; i += 3) {
        c = parseInt(h.substring(i, i + 3), 16);
        ret += nFilterB64map.charAt(c >> 6) + nFilterB64map.charAt(c & 63);
    }
    if (i + 1 == h.length) {
        c = parseInt(h.substring(i, i + 1), 16);
        ret += nFilterB64map.charAt(c << 2);
    } else if (i + 2 == h.length) {
        c = parseInt(h.substring(i, i + 2), 16);
        ret += nFilterB64map.charAt(c >> 2) + nFilterB64map.charAt((c & 3) << 4);
    }
    while ((ret.length & 3) > 0)
        ret += nFilterB64padchar;
    return ret;
}

function nFilterParseBigInt(str, r) {
    return new BigInteger(str, r);
}

function nFilterLinebrk(s, n) {
    var ret = "";
    var i = 0;
    while (i + n < s.length) {
        ret += s.substring(i, i + n) + "\n";
        i += n;
    }
    return ret + s.substring(i, s.length);
}

function nFilterByte2Hex(b) {
    if (b < 0x10)
        return "0" + b.toString(16);
    else
        return b.toString(16);
}

function nFilterPkcs1pad2(s, n) {
    if (n < s.length + 11) {
        alert("Message too long for RSA");
        return null;
    }
    var ba = new Array();
    var i = s.length - 1;
    while (i >= 0 && n > 0) {
        var c = s.charCodeAt(i--);
        if (c < 128) {
            ba[--n] = c;
        } else if ((c > 127) && (c < 2048)) {
            ba[--n] = (c & 63) | 128;
            ba[--n] = (c >> 6) | 192;
        } else {
            ba[--n] = (c & 63) | 128;
            ba[--n] = ((c >> 6) & 63) | 128;
            ba[--n] = (c >> 12) | 224;
        }
    }
    ba[--n] = 0;
    var rng = new SecureRandom();
    var x = new Array();
    while (n > 2) {
        x[0] = 0;
        while (x[0] == 0) rng.nextBytes(x);
        ba[--n] = x[0];
    }
    ba[--n] = 2;
    ba[--n] = 0;
    return new BigInteger(ba);
}

function nFilterRSAKey() {
    this.n = null;
    this.e = 0;
    this.d = null;
    this.p = null;
    this.q = null;
    this.dmp1 = null;
    this.dmq1 = null;
    this.coeff = null;
}

function nFilterRSASetPublic(N, E) {
    if (N != null && E != null && N.length > 0 && E.length > 0) {
        this.n = nFilterParseBigInt(N, 16);
        this.e = parseInt(E, 16);
    } else
        alert("Invalid RSA public key");
}

function nFilterRSADoPublic(x) {
    return x.modPowInt(this.e, this.n);
}

function nFilterRSAEncrypt(text) {
    var m = nFilterPkcs1pad2(text, (this.n.bitLength() + 7) >> 3);
    if (m == null) return null;
    var c = this.doPublic(m);
    if (c == null) return null;
    var h = c.toString(16);
    return nFilterRSAPaddingCheck(h);
}

/**
 * 입력데이터 암호화
 * @param inputValue 입력데이터
 * @returns {*}
 */
function nFilterInputEncrypt(inputValue) {
    if (inputValue.length == 256 || inputValue.length == 512) {
        return inputValue;
    }
    inputValue = inputValue;
    var rsa = new nFilterRSAKey();

    if (nFilterInputDisplayElement.getAttribute("decArea") == "financial") {
        // 20170620 - jhlee :: 카드사 공개키를 삽입
        rsa.setPublic(nFilterFinancialRsaPublicKey, nFilterFinancialRsaExponent);
    } else {
        rsa.setPublic(document.getElementById("nfilter_modulus").value, document.getElementById("nfilter_exponent").value);
    }

    var encryptedValue = "";
    var blockSize = 100;

    if (inputValue.length > blockSize) {

        var length = Number(inputValue.length / blockSize).toFixed(2);

        var _tmp_password = "";

        for (var i = 0; i < length; i++) {
            var _substring_password = inputValue.substring((i * blockSize), (i + 1) * blockSize);
            _tmp_password += rsa.encrypt(_substring_password);
        }
        encryptedValue = _tmp_password;
    } else {
        encryptedValue = rsa.encrypt(inputValue);
    }

    return encryptedValue;
}

nFilterRSAKey.prototype.doPublic = nFilterRSADoPublic;
nFilterRSAKey.prototype.setPublic = nFilterRSASetPublic;
nFilterRSAKey.prototype.encrypt = nFilterRSAEncrypt;

/**
 * 20170424 - jhlee
 * ECDH 추가로 인한 암호화 방식 추가
 * @param inputValue
 * @returns
 */
function nFilterInputEncryptEcdh(inputValue) {

    var sPubKeyFor = "";
    var secretKey = "";
    var encryptedValue = "";
    var xorSecretKey = "";

    if (inputValue.length == 256 || inputValue.length == 512) {
        return inputValue;
    }

    // 키세팅
    if (nFilterInputDisplayElement.getAttribute("decArea") == "financial") {

        // 카드사 공개키 세팅
        document.getElementById("nfilter_financial_modulus").value = nFilterFinancialEcdhPublicKey;

        // 카드사에서 받아온 base64 인코딩된 공개키를 Hex String으로 변환
        sPubKey = Base642HexStr(document.getElementById("nfilter_financial_modulus").value);

        // 클라이언트 개인키와 카드사 공개키로 비밀키 생성
        secretKey = DeriveECKey("secp256r1", nFilterSecurityPrikey, sPubKey);

        // seed xor 연산을 위한 값 세팅
        var sPubKeyForSeed = Base642HexStr(document.getElementById("nfilter_modulus").value); // 서버공개키
        var secretKeyForSeed = DeriveECKey("secp256r1", nFilterSecurityPrikey, sPubKeyForSeed);

        for (var i = 0; i < (secretKey.length / 2); i++) {
            var skey = (parseInt(secretKey.substring(2 * i, 2 * i + 2), 16) ^ parseInt(secretKeyForSeed.substring(2 * i, 2 * i + 2), 16)).toString(16);
            xorSecretKey += skey.length == 1 ? '0' + skey : skey;
        }

        // SEED 암호화
        encryptedValue = SEEDEncrypt(nSaferJS.mode.CFB, '00000000000000000000000000000000', xorSecretKey, inputValue);
        //webFinancialSecretkey = xorSecretKey;
        //console.log("encryptedValue >>>>>>> "+encryptedValue);

    } else {
        // 서버에서 받아온 base64 인코딩된 공개키를 Hex String으로 변환
        sPubKey = Base642HexStr(document.getElementById("nfilter_modulus").value);

        // 클라이언트 개인키와 서버의 공개키로 비밀키 생성
        secretKey = DeriveECKey("secp256r1", nFilterSecurityPrikey, sPubKey);
        //console.log("secretKey >>> "+secretKey);

        // SEED 암호화
        encryptedValue = SEEDEncrypt(nSaferJS.mode.CFB, '00000000000000000000000000000000', secretKey, inputValue);
        //console.log("encryptedValue >>>>>>> "+encryptedValue);
        //webSecretkey = secretKey;
    }

    return encryptedValue;
}

/**
 * 20170621 - jhlee
 * RSA방식 financial 공개키 처리 함수 - 시작
 */
function setFinancialRsaPublicKey(key) {
    var publickey = Base64.decode(key);
    var asn1 = ASN1.decode(publickey);
    var modStart = asn1.sub[1].sub[0].sub[0].posContent();
    var modLen = asn1.sub[1].sub[0].sub[0].length;
    var modbytes = [];
    for (var x = 1; x < modLen; x++) {
        modbytes.push(asn1.stream.enc[x + modStart]);
    }
    var modulusHex = "";
    for (var x = 0; x < modLen - 1; x++) {
        var hexByte = modbytes[x].toString(16);

        // might need padding before appending
        modulusHex += (hexByte.length == 1) ? "0" + hexByte : hexByte;
    }
    // 공개키 modulus
    nFilterFinancialRsaPublicKey = modulusHex;
    //console.log("nFilterFinancialRsaPublicKey >>> "+nFilterFinancialRsaPublicKey);

    var exponent = asn1.sub[1].sub[0].sub[1].content();
    // 공개키 exponent
    nFilterFinancialRsaExponent = Number(exponent).toString(16);
    //console.log("nFilterFinancialRsaExponent >>> "+ nFilterFinancialRsaExponent);
}
/**
 * 20170621 - jhlee
 * RSA방식 financial 공개키 처리 함수 - 종료
 */

/**
 * 20171124 - jhlee
 * block 단위로 RSA 암호화시 padding 이슈로 처리 -tl
 */
function nFilterRSAPaddingCheck(e) {
    var datablock = (nFilterKeyLength == 2048) ? 512 : 256;

    if(e.length == datablock) {
        return e;
    } else {
        var gap = datablock - e.length;
        for(var i=0, insertZero = "0" ; i < gap-1 ; i++) {
            insertZero += "0";
        }
        return insertZero + e;
    }
}
/**
 * 20171124 - jhlee
 * block 단위로 RSA 암호화시 padding 이슈로 처리
 */