(function(GLOBAL){
"strict"

var Delfino = GLOBAL.Delfino;
var DelfinoConfig = GLOBAL.DelfinoConfig;
var SignType = Delfino.SignType;

function adjustSignOptions(signOptions) {
	// set default options
	signOptions.resetCertificate = (signOptions.resetCertificate === undefined || signOptions.resetCertificate === null) ? true : signOptions.resetCertificate;
	signOptions.cacheCertFilter = (signOptions.cacheCertFilter === undefined || signOptions.cacheCertFilter === null) ? false : signOptions.cacheCertFilter;
	signOptions.addNonce = (signOptions.addNonce === undefined || signOptions.addNonce === null) ? false : signOptions.addNonce;
	
	if(signOptions.userCI) {
		signOptions.userCi = signOptions.userCI;
		delete signOptions.userCI;
	}
	
	if(signOptions.userInfo) {
		var userInfo = {
			userName: signOptions.userInfo.UserName,
			userPhone: signOptions.userInfo.UserPhoneNumber,
			userBirthday: signOptions.userInfo.UserBirthday
		};
		
		signOptions.userInfo = userInfo;
	}
	
	return signOptions;
}

function adjustSignData(signData, signOptions, signType) {
	var data = signOptions.data || signData;
	
	if(typeof data === 'object') {
		try {
			data = JSON.stringify(data);
		} catch(e) {}
	}

	if(signType === 'MYDATA') try { data = JSON.parse(data);} catch(e) {};
	
	return data;
}

function sign(request) {
	var signRequest = undefined;
	
	if(typeof request === 'object') {
		signRequest = request;
	} else {
		try { 
			signRequest = JSON.parse(request);
		} catch(e) {
			signRequest = {};
		}
	}

	var provider = signRequest.provider;
	var signType = signRequest.signType || SignType.LOGIN;
	var signData = signRequest.signData || '';
	var signOptions = signRequest.signOptions || {};
	
	if(provider === 'pubcert') {
		Delfino.setModule('G4');
	} else {
		Delfino.setModule('G10');

		signOptions.provider = signOptions.provider || provider;
		
		if(provider === 'fincert' || provider === 'fincertcorp') {
			signOptions.closeWhenFinCertCanceled = true;

			var VPCGClientApp = GLOBAL.VPCGClientApp || (top && top.VPCGClientApp);
			if(VPCGClientApp.raIssueAppFunc) 
				signOptions.raIssueAppFunc = 'VPCGClientApp.raIssueAppFunc';
		}
	}
	
	signOptions = adjustSignOptions(signOptions);

	var signFunc = undefined;
	var argArray = [];

	if(signType === SignType.LOGIN) {
		signFunc = Delfino.login;
	} else if(signType === SignType.AUTH) {
		signFunc = Delfino.auth;
	} else if(signType === SignType.AUTH2) {
		signFunc = Delfino.auth2;
	} else if(signType === SignType.SIMPLE) {
		signFunc = Delfino.sign;
		delete signOptions.dataType;
	} else if(signType === SignType.CONFIRM) {
		signFunc = Delfino.sign;
		signOptions.dataType = signOptions.dataType || 'formattedText';
	} else if(signType === SignType.MULTI) {
		signFunc = Delfino.multiSign;
		if(Array.isArray(signData)) {
			var delimiter = signOptions.multiSignDelimiter || DelfinoConfig.multiSignDelimiter || '|';
			signOptions.multiSignDelimiter = delimiter;
			signData = signData.join(delimiter);
		}
	} else if(signType === "MYDATA") {
		signFunc = Delfino.multiSignForMyData;
	} else if(signType === 'mdSign') {
		signFunc = Delfino.mdSign;
	} else if(signType === 'mdMultiSign') {
		signFunc = Delfino.mdMultiSign;
	} else if(signType === 'complexSign') {
		signFunc = Delfino.complexSign;
	} else if(signType === 'signature') {
		signFunc = Delfino.sign;

		signOptions.signType = 'signature';
		signOptions.digestAlgorithm = signOptions.digestAlgorithm || 'sha256';
	} else if(signType === 'fincertSign') {
		signFunc = Delfino.fincertSign;
	} else if(signType === 'manageCertificate') {
		signFunc = Delfino.manageCertificate;
	}

	signFunc = signFunc.bind(Delfino);
	
	signData = adjustSignData(signData, signOptions, signType);

	if(signType !== 'manageCertificate') {
		argArray.push(signData);
	}
	
	argArray.push(signOptions);
	argArray.push(function(result) {
		var VPCGClientApp = GLOBAL.VPCGClientApp || (top && top.VPCGClientApp);

		if(VPCGClientApp && VPCGClientApp.signComplete) {
			VPCGClientApp.signComplete(JSON.stringify(result));
		}
	});
	
	if(signFunc) {
		signFunc.apply(Delfino, argArray);
	}
};
		
GLOBAL.DelfinoG10Sign = sign;
	
})(window);