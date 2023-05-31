// ignore_for_file: file_names

class AuthLinks {
  static String baseUrl =
      'http://kapstone.in/kapstone/shreyas/index.php?micro/';

  //regional

  static var regionalGetMessages = Uri.parse('${baseUrl}Region/regiondata');
  static var regionalGetInsurance = Uri.parse('${baseUrl}Region/insurance');
  static var regionalSearchProject =
      Uri.parse('${baseUrl}Region/searchproject');
  static var regionalSubmitIncome = Uri.parse('${baseUrl}Region/submitincome');
  static var regionalSubmitExpense =
      Uri.parse('${baseUrl}Region/submitexpense');
  static var regionalViewProject = Uri.parse('${baseUrl}Region/viewproject');
  static var regionalAddProject = Uri.parse('${baseUrl}Region/addproject');
  static var regionalAddAccountingHead =
      Uri.parse('${baseUrl}Region/addaccountinghead');
  static var regionalAddUnit = Uri.parse('${baseUrl}Region/addunit');
  static var regionalAddExpense = Uri.parse('${baseUrl}Region/addexpense');
  static var regionalAddOtherIncome =
      Uri.parse('${baseUrl}Region/addotherincome');
  static var regionalGetAccountingHead =
      Uri.parse('${baseUrl}Region/getaccountinghead');
  static var regionalTransferPayment =
      Uri.parse('${baseUrl}Region/transferpayment');
  static var regionalPaySessFundTransfer =
      Uri.parse('${baseUrl}Region/paymentsessfundtransfer');
  static var regionalTransferSessToUnit =
      Uri.parse('${baseUrl}Region/transfersessfundunit');
  static var regionalViewSess = Uri.parse('${baseUrl}Region/viewsessfund');
  static var regionalTransferSess =
      Uri.parse('${baseUrl}Region/sessfundtransfer');
  static var regionalSessFund = Uri.parse('${baseUrl}Region/regionsessfund');
  static var regionalAddBankLinkage =
      Uri.parse('${baseUrl}Region/addbanklinkage');
  static var regionalGetUnits = Uri.parse('${baseUrl}Region/getunitsregion');
  static var regionalPayBankLinkage =
      Uri.parse('${baseUrl}Region/banklinkagepayment');
  static var regionalViewBankLinkage =
      Uri.parse('${baseUrl}Region/viewbanklinkage');
  static var regionalIndMedicalAid =
      Uri.parse('${baseUrl}Region/medicalaidindividual');
  static var regionalTransferMedicalAid =
      Uri.parse('${baseUrl}Region/medicalaidtransfer');
  static var regionalViewMedicalAid =
      Uri.parse('${baseUrl}Region/regionmedicalaid');
  static var regionalTranferGrant = Uri.parse('${baseUrl}Region/transfergrant');
  static var regionalViewGrand = Uri.parse('${baseUrl}Region/viewgrant');
  static var regionalTranferGrandToUnit =
      Uri.parse('${baseUrl}Region/transfergrantunit');
  static var regionalTransferGrand =
      Uri.parse('${baseUrl}Region/transfergrant');

  //Register
  static var memberlogin = Uri.parse('${baseUrl}Register/signinmemb');
  static var signinRegional = Uri.parse('${baseUrl}Register/signinregion');
  static var getPresidentConfig =
      Uri.parse('${baseUrl}Register/getPresidentConfig');
  static var getallunits = Uri.parse('${baseUrl}Register/getallunits');
  static var presidentconfig = Uri.parse('${baseUrl}Register/president_config');
  static var changepassword = Uri.parse('${baseUrl}Register/forgetpass_post');
  static var signupmember = Uri.parse('${baseUrl}Register/signupmemb');
  static var getunits = Uri.parse('${baseUrl}Register/getunits');
  static var signinunit = Uri.parse('${baseUrl}Register/signinunit');
  static var signuppresident = Uri.parse('${baseUrl}Register/signuppresident');

  static var signinpresident = Uri.parse('${baseUrl}Register/signinpresident');
  //Members
  static var unitsearch = Uri.parse('${baseUrl}Member/unitsearch');
  static var memberMonthlyCollection =
      Uri.parse('${baseUrl}Member/searchmonthlycollection');
  static var memberMlist = Uri.parse('${baseUrl}Member/memberlist');
  static var bankloanborrowers =
      Uri.parse('${baseUrl}Member/bankloanborrowers');
  static var bankloanpayments = Uri.parse('${baseUrl}Member/bankloanpayments');
  static var memberMExpense = Uri.parse('${baseUrl}Member/expensedates');
  static var memberMAttendance = Uri.parse('${baseUrl}Member/attendance');
  static var memberBanklinkage = Uri.parse('${baseUrl}Member/viewbanklinkage');
  static var membinsurance = Uri.parse('${baseUrl}Member/insurancereport');
  static var viewMembergrant = Uri.parse('${baseUrl}Member/viewgrant');
  static var festivalFund = Uri.parse('${baseUrl}Member/searchfestivalfund');
  static var sessFund = Uri.parse('${baseUrl}Member/searchsessfund');
  static var viewsessfund = Uri.parse('${baseUrl}Member/viewsessfund');
  static var unitrequest = Uri.parse('${baseUrl}Member/requestunit');
  static var searchsambhadyam = Uri.parse('${baseUrl}Member/searchsambhadyam');
  static var memberloan = Uri.parse('${baseUrl}Member/unitloanborrowers');
  static var report = Uri.parse('${baseUrl}Member/report');
  static var unitintrestpayment =
      Uri.parse('${baseUrl}Member/unitloaninterestpayment');
  static var unitloanpayment = Uri.parse('${baseUrl}Member/unitloanpayment');
  //Unit

  static var getUnitdata = Uri.parse('${baseUrl}Unit/unitdata');
  static var unitPayProfitRegion = Uri.parse('${baseUrl}Unit/payregiondetails');
  static var unitGetProfitAmount = Uri.parse('${baseUrl}Unit/payregion');
  static var unitCloseExternalLoan =
      Uri.parse('${baseUrl}Unit/externalloanindborrowersdetails');
  static var unitExternalLoanPay =
      Uri.parse('${baseUrl}Unit/externalloanindpay');
  static var unitExternalLoanBorrowDeatails =
      Uri.parse('${baseUrl}Unit/externalloanindborrowers');
  static var unitGetExternalLoanBorrowers =
      Uri.parse('${baseUrl}Unit/external_loan_borrowers');
  static var unitAddExternaLoan = Uri.parse('${baseUrl}Unit/external_loan');
  static var unitGetExternalMember =
      Uri.parse('${baseUrl}Unit/getexternalmember');
  static var unitcloseindLoan =
      Uri.parse('${baseUrl}Unit/unitloanindborrowersdetails');
  static var unitLoanIndPay = Uri.parse('${baseUrl}Unit/unitloanindpay');
  static var unitloanindborrowers =
      Uri.parse('${baseUrl}Unit/unitloanindborrowers');
  static var unitloanindAdd = Uri.parse('${baseUrl}Unit/unitloaninddetails');
  static var unitGetshgMember = Uri.parse('${baseUrl}Unit/bank_passbook');
  static var unitGetAllshgMember = Uri.parse('${baseUrl}Unit/getshgmember');
  static var unitloanindborrowersdetails =
      Uri.parse('${baseUrl}Unit/unitloanshgborrowersdetails');
  static var unitLoanShgBorrowers =
      Uri.parse('${baseUrl}Unit/unitloanshgborrowers');
  static var unitLoansHGBorrowers =
      Uri.parse('${baseUrl}Unit/unitloanborrowers');
  static var unitloanshgdetails =
      Uri.parse('${baseUrl}Unit/unitloanshgdetails');
  static var unitLoanshgPay = Uri.parse('${baseUrl}Unit/unitloanshgpay');
  static var unitGetpresidentlist =
      Uri.parse('${baseUrl}Unit/getpresidentlist');
  static var unitAddaccountinghead =
      Uri.parse('${baseUrl}Unit/addaccountinghead');
  static var unitGetaccountinghead =
      Uri.parse('${baseUrl}Unit/getaccountinghead');
  static var unitTransferinsurance =
      Uri.parse('${baseUrl}Unit/transferinsurance');
  static var unitBankyearlyinterestpayment =
      Uri.parse('${baseUrl}Unit/bankyearlyinterestdetails');
  static var unitGetAllBanks = Uri.parse('${baseUrl}Unit/bankyearlyinterest');
  static var unitPaybankAmount = Uri.parse('${baseUrl}Unit/paybank');
  static var getreport = Uri.parse('${baseUrl}Unit/unit_memberreport');
  static var unitSendMessageAllShg = Uri.parse('${baseUrl}Unit/sendmessageall');
  static var unitSendMessageShg = Uri.parse('${baseUrl}Unit/sendmessage');
  static var unitShgyearlyinterestPay =
      Uri.parse('${baseUrl}Unit/shgyearlyinterestadd');
  static var unitShgyearlyinterest =
      Uri.parse('${baseUrl}Unit/shgyearlyinterest');
  static var unitTrackshgsambadhyam =
      Uri.parse('${baseUrl}Unit/trackshgsambadhyam');
  static var unitTransferGranttoShg =
      Uri.parse('${baseUrl}Unit/transfergrantunit');
  static var unitTransferGrant = Uri.parse('${baseUrl}Unit/transfergrant');
  static var unitViewGrants = Uri.parse('${baseUrl}Unit/viewgrant');
  static var unitBanklinkagepayment =
      Uri.parse('${baseUrl}Unit/banklinkagepayment');
  static var unitViewbanklinkage = Uri.parse('${baseUrl}Unit/viewbanklinkage');
  static var unitAddmedicalaidindividual =
      Uri.parse('${baseUrl}Unit/medicalaidindividual');
  static var unitmedicalaidtransfer =
      Uri.parse('${baseUrl}Unit/medicalaidtransfer');
  static var unitshgmedicalaidtransfer =
      Uri.parse('${baseUrl}Unit/shgmedicalaidtransfer');
  static var transferUnitPayment = Uri.parse('${baseUrl}Unit/transferpayment');
  static var unitFetchSessTotal =
      Uri.parse('${baseUrl}Unit/paymentsessfundtransfer');
  static var unitsessfundtransferRegion =
      Uri.parse('${baseUrl}Unit/sessfundtransfer');
  static var unitViewSessFund = Uri.parse('${baseUrl}Unit/viewsessfund');
  static var transfersessfundunit =
      Uri.parse('${baseUrl}Unit/transfersessfundunit');
  static var unitpaySessFund = Uri.parse('${baseUrl}Unit/transfersessfund');
  static var shgsessfundtransferRegion =
      Uri.parse('${baseUrl}Unit/shgsessfundtransfer');
  static var getAllshgUnit = Uri.parse('${baseUrl}Unit/getallshg');
  static var unitaddexpense = Uri.parse('${baseUrl}Unit/addexpense');
  static var addexternalmember = Uri.parse('${baseUrl}Unit/addexternalmember');
  static var getUnitaccountinghead =
      Uri.parse('${baseUrl}Unit/getaccountinghead');
  static var addotherincome = Uri.parse('${baseUrl}Unit/addotherincome');

  //pressident//unitloanpayment
  /* transferinsurance */
  static var presidentTransferinsurance =
      Uri.parse('${baseUrl}President/transferinsurance');
  static var presidentaddmonthlycollection =
      Uri.parse('${baseUrl}President/monthlycollection');
  static var presunitpay = Uri.parse('${baseUrl}President/payunit');
  static var presidentAddfestivalfund =
      Uri.parse('${baseUrl}President/festivalfund');
  static var presidentAddmedicalaid =
      Uri.parse('${baseUrl}President/addmedicalaid');
  static var presidentinsertsessfund =
      Uri.parse('${baseUrl}President/insertsessfund');
  static var presidentPaymedicalaid =
      Uri.parse('${baseUrl}President/paymedicalaid');
  static var transfersessfundpresident =
      Uri.parse('${baseUrl}President/transfersessfund');
  static var transfersessfundmemberpres =
      Uri.parse('${baseUrl}President/transfersessfundmember');
  static var presisessfundpayment =
      Uri.parse('${baseUrl}President/sessfundpayment');
  static var presidentViewsessfund =
      Uri.parse('${baseUrl}President/viewsessfund');
  static var presidentPaysessfund =
      Uri.parse('${baseUrl}President/paysessfund');
  static var presunitloanpaymentdata =
      Uri.parse('${baseUrl}President/shgunitloanpaymentdata');
  static var shgunitloandata = Uri.parse('${baseUrl}President/shgunitloandata');
  static var presidentunitloaninterestpayment =
      Uri.parse('${baseUrl}President/unitloaninterestpayment');
  static var presunitloanpayment =
      Uri.parse('${baseUrl}President/unitloanpayment');
  static var attendancelist = Uri.parse('${baseUrl}President/attendancelist');
  static var getPresidentaccountinghead =
      Uri.parse('${baseUrl}President/getaccountinghead');
  static var attendance = Uri.parse('${baseUrl}President/attendance');
  static var presshgloandata = Uri.parse('${baseUrl}President/shgloandata');
  static var presshgloanIntPaymentdet =
      Uri.parse('${baseUrl}President/shgloaninterestpaymentdetails');
  static var shgloanamountpaymentdetails =
      Uri.parse('${baseUrl}President/shgloanamountpaymentdetails');
  static var addaccountingheadPres =
      Uri.parse('${baseUrl}President/addaccountinghead');
  static var sambhadyam = Uri.parse('${baseUrl}President/sambhadyam');
  static var changePresident = Uri.parse('${baseUrl}President/changepresident');

  static var updatePressidentPassword =
      Uri.parse('${baseUrl}President/changepassword');
  static var addsambhadyam = Uri.parse('${baseUrl}President/addsambhadyam');
  static var closeunitloan = Uri.parse('${baseUrl}President/closeunitloan');
  static var momrecord = Uri.parse('${baseUrl}President/addmomrecord');
  static var getmom = Uri.parse('${baseUrl}President/getmomreport');
  static var unitloan = Uri.parse('${baseUrl}President/unitloan');
  static var addmember = Uri.parse('${baseUrl}President/addmember');
  static var deletemember = Uri.parse('${baseUrl}President/deletemember');
  static var acceptmemberrequest =
      Uri.parse('${baseUrl}President/acceptmemberrequest');
  static var memberRequest = Uri.parse('${baseUrl}President/memberrequest');
  static var shreyasloanreport =
      Uri.parse('${baseUrl}President/shreyasloanreport');
  static var interestpayment = Uri.parse('${baseUrl}President/interestpayment');
  static var addinterestpayment =
      Uri.parse('${baseUrl}President/addinterestpayment');
  static var unitloaninterestpayment =
      Uri.parse('${baseUrl}President/unitloaninterestpayment');
  static var memberlist = Uri.parse('${baseUrl}President/memberlist');
  static var addunitloanpayment =
      Uri.parse('${baseUrl}President/addunitloanpayment');
  static var unitloanborrowers =
      Uri.parse('${baseUrl}President/unitloanborrowers');
  static var expense = Uri.parse('${baseUrl}President/expense');
  static var transfergrantunit =
      Uri.parse('${baseUrl}President/transfergrantunit');
  static var viewgrant = Uri.parse('${baseUrl}President/viewgrant');
  static var getothershg = Uri.parse('${baseUrl}President/getothershg');

  static var transfergrant = Uri.parse('${baseUrl}President/transfergrant');
  static var insertsessfund = Uri.parse(
      '${baseUrl}President/insertsessfund'); //presidentid,date,memberdata
  static var addinsurance = Uri.parse(
      '${baseUrl}President/addinsurance'); //presidentid,date,memberdata
  static var addmedicalaid = Uri.parse(
      '${baseUrl}President/addmedicalaid'); //passbookno,date,memberdata
  static var addPFestivalfund = Uri.parse('${baseUrl}President/festivalfund');
  static var bankloan = Uri.parse('${baseUrl}President/bankloan');
  static var shgloanPres = Uri.parse('${baseUrl}President/external_shg_loan');
  static var pAddExternalMember =
      Uri.parse('${baseUrl}President/addexternalmember');
  static var getexternalmember =
      Uri.parse('${baseUrl}President/getexternalmember');
  static var giveexternalLoan = Uri.parse('${baseUrl}President/external_loan');
}
