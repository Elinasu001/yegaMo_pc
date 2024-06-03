/**
 * Created by SI2_JongRakMoon on 2018-03-07.
 */

var bankCalcUtils = {
    /**
     *  예금계산
     *  @param {number} period 예금 기간
     *  @param {number} money 예치금
     *  @param {number} rate 예금 이율
     *  @param {string} depositType 예금방법(1:단리,0:복리)
     *  @return {Object} 계산 결과 Obj
     */
    fnCal1: function (period, money, rate, depositType) {
        var result = {
            title: [],
            //일반 - {money[0]: 만기 지급액,money[1]: 세후이자}
            normal: {money: []},
            //세금우대 - {money[0]: 만기 지급액,money[1]: 세후이자}
            preference: {money: []},
            //비과세 - {money[0]: 만기 지급액,money[1]: 세후이자}
            exemption: {money: []}
        };

        var before = 0; 								// 세전이자
        var after = 0; 									// 일반세후이자
        var primetaxmoney = 0; 							// 우대세금

        period = parseInt(period);
        money = parseInt(money);

        //단리 계산
        if (depositType == "1") {
            before = parseInt(money * (rate / 100) / 12); 														 // 세전이자
            after = before - this.cutWon(this.cutWon(before * 0.14) + this.cutWon(before * 0.014)); // 세후이자
            primetaxmoney = before - this.cutWon(this.cutWon(before * 0.09) + this.cutWon(before * 0.005)); // 세금우대

            result.title[0] = '만기지급액';
            result.title[1] = '세후이자';

            result.normal.money[0] = money + after * period;
            result.normal.money[1] = after * period;
            if (period < 12) {
                result.preference.money[0] = 0;
                result.preference.money[1] = 0;
            } else {
                result.preference.money[0] = money + primetaxmoney * period;
                result.preference.money[1] = primetaxmoney * period;
            }
            result.exemption.money[0] = money + before * period;
            result.exemption.money[1] = before * period;
        } else {
            before = parseInt(money * Math.pow(1 + (rate / 100) / 12, period)); 					// 세전이자
            before = parseInt(before - money);
            after = before - this.cutWon(this.cutWon(before * 0.14) + this.cutWon(before * 0.014)); 	// 세후이자
            primetaxmoney = before - this.cutWon(this.cutWon(before * 0.09) + this.cutWon(before * 0.005));  // 세금우대

            result.title[0] = '만기지급액';
            result.title[1] = '세후이자';

            result.normal.money[0] = money + after;
            result.normal.money[1] = after;
            if (period < 12) {
                result.preference.money[0] = 0;
                result.preference.money[1] = 0;
            } else {
                result.preference.money[0] = money + primetaxmoney;
                result.preference.money[1] = primetaxmoney;
            }
            result.exemption.money[0] = money + before;
            result.exemption.money[1] = before;
        }

        return result;
    },

    /**
     *  적금계산 - 월
     *  @param {number} period 예금 기간
     *  @param {number} money 예치금
     *  @param {number} rate 예금 이율
     *  @return {Object}
     */
    fnCal2: function (period, money, rate) {
        var result = {
            title: [],
            //일반 - {money[0]: 만기 지급액,money[1]: 세후이자}
            normal: {money: []},
            //세금우대 - {money[0]: 만기 지급액,money[1]: 세후이자}
            preference: {money: []},
            //비과세 - {money[0]: 만기 지급액,money[1]: 세후이자}
            exemption: {money: []}
        };

        var before = 0; 								// 세전이자
        var after = 0; 									// 일반세후이자
        var primetaxmoney = 0; 							// 우대세금

        var tmp = 0;
        var tax = 9.5;

        period = parseInt(period);
        money = parseInt(money);

        for (var i = 1; i <= period; i++) {
            tmp = money * (period - i + 1) * (rate / 100 / 12);
            before += tmp;
        }
        before = parseInt(before);
        after = before - this.cutWon((before * 0.154)); // 세후이자
        primetaxmoney = before - this.cutWon((before * 0.095)); // 세금우대

        result.title[0] = '만기지급액';
        result.title[1] = '세후이자';

        result.normal.money[0] = money * period + after;
        result.normal.money[1] = after;
        if (period < 12) {
            result.preference.money[0] = 0;
            result.preference.money[1] = 0;
        } else {
            result.preference.money[0] = money * period + primetaxmoney;
            result.preference.money[1] = primetaxmoney;
        }
        result.exemption.money[0] = money * period + before;
        result.exemption.money[1] = before;

        return result;
    },

    /**
     *  적금계산 - 만기
     *  @param {number} period 예금 기간
     *  @param {number} money 예치금
     *  @param {number} rate 예금 이율
     *  @return {Object}
     */
    fnCal3: function (period, money, rate) {
        var result = {
            title: [],
            //일반 - {money[0]: 만기 지급액,money[1]: 세후이자}
            normal: {money: []},
            //세금우대 - {money[0]: 만기 지급액,money[1]: 세후이자}
            preference: {money: []},
            //비과세 - {money[0]: 만기 지급액,money[1]: 세후이자}
            exemption: {money: []}
        };

        var before = 0; 								// 세전이자
        var after = 0; 									// 일반세후이자
        var primetaxmoney = 0; 							// 우대세금

        var tmp = 0;
        var tmp1 = 0;

        period = parseInt(period);
        money = parseInt(money);

        result.title[0] = '월납입액';
        result.title[1] = '세후이자';

        for (var i = 1; i <= period; i++) {
            tmp = (period - i + 1) * (rate / 100 / 12);
            before += tmp;
        }

        tmp = money / (period + before);
        tmp1 = tmp * before;

        result.exemption.money[0] = Math.round((money - tmp1) / period);
        result.exemption.money[1] = Math.round(this.cutWon(tmp1));

        tmp = money / (period + before - (before * 0.154));
        tmp1 = tmp * before;

        result.normal.money[0] = Math.round(Math.round((money - (tmp1 - tmp1 * 0.154)) / period));
        result.normal.money[1] = Math.round(this.cutWon(tmp1 - tmp1 * 0.154));

        tmp = money / (period + before - (before * 0.095));
        tmp1 = tmp * before;

        if (period < 12) {
            result.preference.money[0] = 0;
            result.preference.money[1] = 0;
        } else {
            result.preference.money[0] = Math.round((money - (tmp1 - tmp1 * 0.095)) / period);
            result.preference.money[1] = this.cutWon(tmp1 - tmp1 * 0.095);
        }
        return result;
    },

    /**
     *  대출계산기
     *  @param {number} loanType 대출 방법(0:원금만기일시상환,1:원금균등상환,2:원리금균등상환)
     *  @param {number} originMoney 대출원금
     *  @param {number} loanPeriod 대출기간
     *  @param {number} holdingPeriod 거치기간
     *  @param {number} loanRate 대출이율
     *  @return {Object}
     */
    fnCal4: function (loanType, originMoney, loanPeriod, holdingPeriod, loanRate) {
        var result = {
            //원금
            originMoney: originMoney,
            //빌린기간
            loanPeriod: loanPeriod,
            //거치기간
            holdingPeriod: holdingPeriod,
            //이자율
            loanRate: loanRate,
            //원금만기일시산환일 경우:월평균이자,원금균등상환일경우:월납입원금,원리금균등산환일경우:월상환금액
            repaymentMoney: 0,
            //총 이자액
            interestMoney: 0,
            //원금 및 총이자액 합계
            totalMoney: 0,
            /*
            index: 회차 - 1
            row.repaymentTotalMoney:상환금
            row.repaymentOriginMoney:납입원금
            row.repaymentInterestMoney:이자
            row.repaymentOriginMoneySum:납입원금누계
            row.remainMoney:잔금
            */
            table: []
        };

        //계산결과
        var monthlyLoan = 0;	//월상환금
        var totalInterest = 0;		//총이자
        var loanAndInterest = 0;		//원금및이자

        var interest = 0;	//이자
        var repaymentOriginMoney = 0;	//납입원금
        var repayment = 0;	//상환금

        var originRepaymentTotal = 0;	//납입원금 누계
        var remainMoney = originMoney;	//잔금

        for (var i = 0; i < loanPeriod; i++) {
            interest = this.calcInterest(loanType, i, originMoney, loanRate, remainMoney);
            totalInterest = totalInterest + interest;

            if (loanType == "2") {
                repayment = this.calcRepayment(loanType, repaymentOriginMoney, interest, loanRate, loanPeriod, holdingPeriod, originMoney, i);
                if (i >= holdingPeriod) {	//거치기간 후부터 계산
                    repaymentOriginMoney = this.calcOriginLoanMoney(loanType, i, loanPeriod, originMoney, holdingPeriod, repayment, interest);
                }
            } else {
                if (i >= holdingPeriod) {	//거치기간 후부터 계산
                    repaymentOriginMoney = this.calcOriginLoanMoney(loanType, i, loanPeriod, originMoney, holdingPeriod, repayment, interest);
                }
                repayment = this.calcRepayment(loanType, repaymentOriginMoney, interest, loanRate, loanPeriod, holdingPeriod, originMoney, i);
            }
            originRepaymentTotal = originRepaymentTotal + repaymentOriginMoney;
            remainMoney = originMoney - originRepaymentTotal;

            var row = {};
            row.repaymentTotalMoney = Math.round(repayment);
            row.repaymentOriginMoney = Math.round(repaymentOriginMoney);
            row.repaymentInterestMoney = Math.round(interest);
            row.repaymentOriginMoneySum = Math.round(originRepaymentTotal);
            row.remainMoney = Math.round(remainMoney);

            result.table.push(row);
        }

        if (loanType == "0") {
            monthlyLoan = totalInterest / loanPeriod;
        } else if (loanType == "1") {
            monthlyLoan = repaymentOriginMoney / (loanPeriod - holdingPeriod);
        } else if (loanType == "2") {
            monthlyLoan = repaymentOriginMoney * loanRate / 12;
            monthlyLoan = monthlyLoan * (Math.pow((1 + loanRate / 12), (loanPeriod - holdingPeriod)));
            monthlyLoan = monthlyLoan / (Math.pow((1 + loanRate / 12), (loanPeriod - holdingPeriod)) - 1);
        }
        loanAndInterest = repaymentOriginMoney + totalInterest;

        result.repaymentMoney = Math.round(monthlyLoan);
        result.interestMoney = Math.round(totalInterest);
        result.totalMoney = Math.round(loanAndInterest);

        return result;
    },

    /**
     * 이자계산 로직
     * @param {string} loanType 대출 방법(0:원금만기일시상환,1:원금균등상환,2:원리금균등상환)
     * @param {string} i 대출 개월수
     * @param {string} originMoney 원금
     * @param {string} loanRate 대출 이율
     * @param {string} remainLoan 남은 대출금액
     * @return {number} 이달에 발생한 이자
     */
    calcInterest: function (loanType, i, originMoney, loanRate, remainLoan) {	//이자
        var result = 0;
        if (loanType == "0") {					//원금만기일시상환
            //$I$8*$J$26/12
            result = originMoney * loanRate / 12;
        } else if (loanType == "1") {				//원금균등상환
            if (i == 0) {
                //$I$8*$J$26/12
                result = originMoney * loanRate / 12;
            } else {
                //N28*$J$26/12
                result = remainLoan * loanRate / 12;
            }
        } else if (loanType == "2") {				//원리금균등상환
            if (i == 0) {
                //$I$8*$J$26/12
                result = originMoney * loanRate / 12;
            } else {
                //N28*$J$26/12
                result = remainLoan * loanRate / 12;
            }
        }
        return result;
    },

    /**
     *    납입원금 계산
     * @param {string} loanType 대출 방법(0:원금만기일시상환,1:원금균등상환,2:원리금균등상환)
     * @param {string} i 대출 개월수
     * @param {string} loanPeriod 대출기간
     * @param {string} originMoney 원금
     * @param {string} holdingPeriod 거치기간
     * @param {string} repaymentMoney 상환금액
     * @param {string} interest 이자
     * @return {number} 납입한 원금
     */
    calcOriginLoanMoney: function (loanType, i, loanPeriod, originMoney, holdingPeriod, repaymentMoney, interest) {
        var result = 0;
        if (loanType == "0") {					//원금만기일시상환
            if (i == (loanPeriod - 1)) {	//마지막라인인경우
                result = originMoney;
            }
        } else if (loanType == "1") {				//원금균등상환
            //$I$8/($I$11-$I$14)
            result = originMoney / (loanPeriod - holdingPeriod);
        } else if (loanType == "2") {				//원리금균등상환
            result = repaymentMoney - interest;
        }
        return result;
    },

    /**
     *    상환금 계산
     * @param {string} loanType 대출 방법(0:원금만기일시상환,1:원금균등상환,2:원리금균등상환)
     * @param {string} repaymentOriginMoney 상환 원금
     * @param {string} interest 대출 이자
     * @param {string} loanRate 대출 이율
     * @param {string} loanPeriod 대출기간
     * @param {string} holdingPeriod 거치기간
     * @param {string} originMoney 원금
     * @param {string} i 대출 개월수
     * @return {number} 상환할 금액
     */
    calcRepayment: function (loanType, repaymentOriginMoney, interest, loanRate, loanPeriod, holdingPeriod, originMoney, i) {
        var result = 0;
        if (loanType == "0") {					//원금만기일시상환
            result = repaymentOriginMoney + interest;
        } else if (loanType == "1") {				//원금균등상환
            result = repaymentOriginMoney + interest;
        } else if (loanType == "2") {				//원리금균등상환
            if (i >= holdingPeriod) {	//거치기간 후부터 계산
                //($I$8*$J$26/12*(1+$J$26/12)^($I$11-$I$14))/((1+$J$26/12)^($I$11-$I$14)-1)
                result = (originMoney * loanRate / 12) * (Math.pow((1 + loanRate / 12), (loanPeriod - holdingPeriod)));
                result = result / (Math.pow((1 + loanRate / 12), (loanPeriod - holdingPeriod)) - 1);
            } else {
                result = repaymentOriginMoney + interest;
            }
        }
        return result;
    },

    /**
     * @param {number} money
     * @return {string} 소수점 아래 4번째 절삭
     */
    cutWon: function (money) {
        var chgstr;
        var retstr;

        money = Number(money + 0.001);

        chgstr = String(money);
        //alert("??:"+chgstr);
        retstr = chgstr.substring(0, chgstr.length - 1) + "0";

        return Number(retstr);
    },

    /**
     * @param {number} money
     * @return {string} 30000 -> 30,000
     */
    addComma: function (money) {
        money = removeComma(money);
        money = Math.round(money);
        if (money == 0 || isNaN(money)) {
            return '0';
        }

        var chgstr = String(money);
        var li = chgstr.length - 3;
        var retstr = "";
        var i;

        for (i = li; i >= 1; i = i - 3) {
            retstr = "," + chgstr.substring(i, i + 3) + retstr;
        }

        retstr = chgstr.substring(0, i + 3) + retstr;
        return retstr;
    },
    /**
     * @param {number} money
     * @return {string} 30,000 -> 30000
     */
    removeComma: function (money) {
        return money.replace(/,/g, '');
    }
};