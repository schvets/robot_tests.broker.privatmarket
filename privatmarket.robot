*** Settings ***
Library  Selenium2Screenshots
Library  String
Library  DateTime
Library  Selenium2Library
Library  Collections
Library  DebugLibrary
Library  privatmarket_service.py

*** Variables ***
${COMMONWAIT}	40

${tender_data_title}											xpath=//div[contains(@class,'title-div')]
${tender_data_description}										css=div.description
${tender_data_procurementMethodType}							css=div#tenderType
${tender_data_status}											css=div#tenderStatus
${tender_data_value.amount}										css=#tenderBudget
${tender_data_value.currency}									css=#tenderBudgetCcy
${tender_data_value.valueAddedTaxIncluded}						css=#tenderBudgetTax
${tender_data_tenderID}											css=div#tenderId
${tender_data_procuringEntity.name}								css=a[ng-click='act.openCard()']
${tender_data_enquiryPeriod.startDate}							xpath=(//span[@ng-if='p.bd'])[1]
${tender_data_enquiryPeriod.endDate}							xpath=(//span[@ng-if='p.ed'])[1]
${tender_data_tenderPeriod.startDate}							xpath=(//span[@ng-if='p.bd'])[2]
${tender_data_tenderPeriod.endDate}								xpath=(//span[@ng-if='p.ed'])[2]
${tender_data_auctionPeriod.startDate}							xpath=(//span[@ng-if='p.bd'])[3]
${tender_data_complaintPeriod.endDate}							css=span#cmplPeriodEnd
${tender_data_minimalStep.amount}								css=#lotAmount
${tender_data_minimalStep_lot.amount}							css=#lotMinStepAmount
${tender_data_items.description}								css=a[ng-click='adb.showCl = !adb.showCl;']
${tender_data_items.deliveryDate.endDate}						xpath=//div[contains(@class,'delivery-info')]//div[.='Кінець:']/following-sibling::div
${tender_data_items.deliveryLocation.latitude}					css=span.latitude
${tender_data_items.deliveryLocation.longitude}					css=span.longitude
${tender_data_items.deliveryAddress.countryName}				css=prz-address[addr='adb.deliveryAddress'] span#countryName
${tender_data_items.deliveryAddress.countryName_ru}				css=prz-address[addr='adb.deliveryAddress'] span#countryName
${tender_data_items.deliveryAddress.countryName_en}				css=prz-address[addr='adb.deliveryAddress'] span#countryName
${tender_data_items.deliveryAddress.postalCode}					css=prz-address[addr='adb.deliveryAddress'] span#postalCode
${tender_data_items.deliveryAddress.region}						css=prz-address[addr='adb.deliveryAddress'] span#region
${tender_data_items.deliveryAddress.locality}					css=prz-address[addr='adb.deliveryAddress'] span#locality
${tender_data_items.deliveryAddress.streetAddress}				css=prz-address[addr='adb.deliveryAddress'] span#streetAddress
${tender_data_items.classification.scheme}						xpath=//div[@ng-if="adb.classification"]
${tender_data_items.classification.id}							xpath=//div[@ng-if="adb.classification"]
${tender_data_items.classification.description}					xpath=//div[@ng-if="adb.classification"]
${tender_data_items.additionalClassifications[0].scheme}		xpath=//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_items.additionalClassifications[0].id}			xpath=//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_items.additionalClassifications[0].description}	xpath=//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_items.unit.name}									xpath=//div[.='Кількість:']/following-sibling::div
${tender_data_items.unit.code}									xpath=//div[.='Кількість:']/following-sibling::div
${tender_data_items.quantity}									xpath=//div[.='Кількість:']/following-sibling::div
${tender_data_questions.description}							css=div.description
${tender_data_questions.date}									xpath=//div[@class = 'question-head title']/b[2]
${tender_data_questions.title}									css=div.question-head.title span
${tender_data_questions.answer}									css=div[ng-bind-html='q.answer']
${tender_data_lots.title}										css=div.lot-head span.ng-binding
${tender_data_lots.description}									css=section.lot-description section.description
${tender_data_lots.value.amount}								css=#lotAmount
${tender_data_lots.value.currency}								css=#lotCcy
${tender_data_lots.value.valueAddedTaxIncluded}					css=#lotTax
${tender_data_bids}												xpath=(//table[@class='bids']//tr)[2]
${complaints[0].title}											xpath=(//div[@class='title']/span)[1]
${complaints[0].description}									xpath=(//div[@ng-bind-html='q.description'])[1]
${complaints[0].documents.title}								xpath=(//span[@class='file-name'])[1]
${complaints[0].status}											xpath=(//div[contains(@ng-if,'q.status')])[1]

${locator_tenderCreation.buttonEdit}			xpath=//button[@ng-click='act.createAfp()']
${locator_tenderCreation.buttonSave}			css=button.btn.btn-success
${locator_tenderCreation.buttonBack}			xpath=//a[@ng-click='act.goBack()']
${locator_tenderCreation.description}			css=textarea[ng-model='model.filterData.adbName']

${locator_tenderClaim.buttonCreate}				css=button[ng-click='act.createAfp()']
${locator_tenderClaim.fieldPrice}				xpath=//input[@ng-model='model.price']
${locator_tenderClaim.checkedLot.fieldPrice}	xpath=//input[@ng-model='model.checkedLot.userPrice']
${locator_tenderClaim.fieldEmail}				css=input[ng-model='model.person.email']
${locator_tenderClaim.buttonSend}				css=button[ng-click='act.sendAfp()']
${locator_tenderClaim.buttonCancel}				css=button[ng-click='act.delAfp()']
${locator_tenderClaim.buttonGoBack}				css=a[ng-click='act.ret2Ad()']
${locator_tender.ajax_overflow}					xpath=//div[@class='ajax_overflow']


${tender_data_cancellations[0].status}						xpath=//div[@class='info-div']/div[last()]/div/div[1]/div[1]
${tender_data_cancellations[0].reason}						xpath=//div[@class='info-div']/div[last()]/div/div[1]/div[2]
${tender_data_cancellations[0].documents[0].title}			css=.file-name.ng-binding
${tender_data_cancellations[0].documents[0].description}	xpath=//div[@class='file-descriptor']/span[2]
${tender_data_title_en}										css=.title-div.ng-binding
${tender_data_title_ru}										css=.title-div.ng-binding
${tender_data_description_en}								css=#tenderDescription
${tender_data_description_ru}								css=#tenderDescription


${tender_data_procuringEntity.address.countryName}		css=#procurerAddr #countryName
${tender_data_procuringEntity.address.locality}			css=#procurerAddr #locality
${tender_data_procuringEntity.address.postalCode}		css=#procurerAddr #postalCode
${tender_data_procuringEntity.address.region}			css=#procurerAddr #region
${tender_data_procuringEntity.address.streetAddress}	css=#procurerAddr #streetAddress

${tender_data_procuringEntity.contactPoint.name}		xpath=//div[@class='delivery-info']/div[2]/div[@class='info-item-val ng-binding']
${tender_data_procuringEntity.contactPoint.telephone}	xpath=//div[@class='delivery-info']/div[4]/div[@class='info-item-val ng-binding']
${tender_data_procuringEntity.contactPoint.url}			xpath=//div[@class='delivery-info']/div[5]/div[@class='info-item-val ng-scope']
${tender_data_procuringEntity.identifier.legalName}		xpath=//div[@id='procurerLegalName']/div[2]
${tender_data_procuringEntity.identifier.scheme}		xpath=//div[@class='delivery-info ng-scope']/div[2]/div[2]
${tender_data_procuringEntity.identifier.id}			xpath=//div[@id='procurerId']/div[2]

${tender_data_documents[0].title}						css=#tenderDocs .file-name
${tender_data_causeDescription}							css=#tenderType>div

${tender_data_awards[0].status}									xpath=//div[@class='modal-body info-div ng-scope']/div[10]/div[2]
${tender_data_awards[0].suppliers[0].address.countryName}		xpath=(//prz-address[@id='procurerAddr'])[2]//*[@id='countryName']
${tender_data_awards[0].suppliers[0].address.locality}			xpath=(//prz-address[@id="procurerAddr"])[2]//*[@id='locality']
${tender_data_awards[0].suppliers[0].address.postalCode}		xpath=(//prz-address[@id="procurerAddr"])[2]//*[@id='postalCode']
${tender_data_awards[0].suppliers[0].address.region}			xpath=(//prz-address[@id="procurerAddr"])[2]//*[@id='region']
${tender_data_awards[0].suppliers[0].address.streetAddress}		xpath=(//prz-address[@id="procurerAddr"])[2]//*[@id='streetAddress']
${tender_data_awards[0].suppliers[0].contactPoint.telephone}	xpath=//div[@class='modal-body info-div ng-scope']/div[7]/div[2]
${tender_data_awards[0].suppliers[0].contactPoint.name}			xpath=//div[@class='modal-body info-div ng-scope']/div[6]/div[2]
${tender_data_awards[0].suppliers[0].contactPoint.email}		xpath=//div[@class='modal-body info-div ng-scope']/div[8]/div[2]
${tender_data_awards[0].suppliers[0].identifier.scheme}			xpath=//div[@class='modal-body info-div ng-scope']/div[2]/div[2]
#${tender_data_awards[0].suppliers[0].identifier.legalName}		xpath=//div[@class='modal-body info-div ng-scope']/div[1]/div[2]
${tender_data_awards[0].suppliers[0].identifier.id}				xpath=//div[@class='modal-body info-div ng-scope']/div[3]/div[2]
${tender_data_awards[0].suppliers[0].name}						xpath=//div[@class='modal-body info-div ng-scope']/div[1]/div[2]
${tender_data_awards[0].value.valueAddedTaxIncluded}			xpath=//div[@class='modal-body info-div ng-scope']/div[9]/div[2]
${tender_data_awards[0].value.currency}							xpath=//div[@class='modal-body info-div ng-scope']/div[9]/div[2]
${tender_data_awards[0].value.amount}							xpath=//div[@class='modal-body info-div ng-scope']/div[9]/div[2]
${tender_data_awards[0].documents[0].title}						css=.modal-body .file-name
${tender_data_contracts[0].status}								xpath=//div[@class='modal-body info-div ng-scope']/div[4]/div[2]

*** Keywords ***
Підготувати дані для оголошення тендера
	[Arguments]  ${username}  ${tender_data}
	[return]	${tender_data}


Підготувати клієнт для користувача
	[Arguments]  ${username}
	[Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо
	${service args}=	Create List	--ignore-ssl-errors=true	--ssl-protocol=tlsv1
	${browser} =		Convert To Lowercase	${USERS.users['${username}'].browser}

	${desired_capabilities} =    Create Dictionary    nativeEvents      ${False}

	Run Keyword If	'phantomjs' in '${browser}'	Run Keywords	Create Webdriver	PhantomJS	${username}	service_args=${service args}
	...   AND   Go To			${USERS.users['${username}'].homepage}
	...   ELSE	Open Browser	${USERS.users['${username}'].homepage}   ${USERS.users['${username}'].browser}   alias=${username}   desired_capabilities=${desired_capabilities}

	Set Window Position		@{USERS.users['${username}'].position}
	Maximize Browser Window
	Run Keyword If	'Provider' in '${username}'	Login	${username}


Створити тендер
	[Arguments]  @{ARGUMENTS}
	Fail  Функція не підтримується майданчиком


Пошук тендера по ідентифікатору
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  tenderId

	Mark Step								${ARGUMENTS[1]} + ${ARGUMENTS[0]}

	Switch browser							${ARGUMENTS[0]}
	Go to									${USERS.users['${ARGUMENTS[0]}'].homepage}
	Sleep									2s
	Wait Until Element Is Enabled			id=tenders	timeout=${COMMONWAIT}
	Switch To Frame							id=tenders
	Sleep									3s
	Wait Until Element Is Visible			css=input#search-query-input
	Wait Until Element Not Stale			css=input#search-query-input	40
	Wait Until Element Is Enabled			xpath=//tr[@ng-repeat='t in model.tenderList']	timeout=${COMMONWAIT}

	${suite_name} = 						Convert To Lowercase	${SUITE_NAME}
	${education_type} = 					Set Variable If
		...  'negotiation' in '${suite_name}'	False
		...  True

	Wait For Tender							${ARGUMENTS[1]}	${education_type}
	sleep									2s
	Click Element							css=tr[id='${ARGUMENTS[1]}']

	sleep									2s
	Switch To Frame							id=tenders
	Wait Until Element Is Not Visible		css=input#search-query-input	20s
	Wait Until Element Is Visible			css=div#tenderStatus	timeout=${COMMONWAIT}
	Wait Until Element Not Stale			${tender_data_title}	40


Відкрити детальну інформацію про позицію
	[Arguments]  ${item}
	#check if extra information is already opened
	Mark Step							step1
	Wait Until Page Contains Element	xpath=//div[@ng-show='adb.showCl']	5s
	${element_class} =					Get Element Attribute	xpath=(//div[@ng-show='adb.showCl'])[${item}]@class
	Run Keyword Unless	'ng-hide' in '${element_class}'	Return From Keyword	False
	Mark Step							step2

	Wait Until Element Is Visible		css=div.info-item-val a	timeout=${COMMONWAIT}
	Wait Until Element Not Stale		css=div.info-item-val a	10
	Mark Step							step3

	${locator} = 						Set Variable	xpath=(//a[@ng-click='adb.showCl = !adb.showCl;'])[${item}]
	Wait Until Element Is Visible		${locator}	timeout=${COMMONWAIT}
	Scroll Page To Element				${locator}
	Wait Until Element Not Stale		${locator}	10
	Mark Step							step4
	Click Element	${locator}
	Wait Until Element Is Visible		xpath=(//div[@ng-if='adb.classification'])[${item}]	timeout=10
	Mark Step     step5


Відкрити потрібну інформацію по тендеру
	[Arguments]  ${username}  ${field}
#	Switch browser					${username}
	Wait Until Element Is Visible	${tender_data_title}	timeout=${COMMONWAIT}

	#choose UK language
	${status} =	Run Keyword And Return Status	Element Should Be Visible	css=a#lang_uk
	Run Keyword If	${status}	Click Element	css=a#lang_uk

	#switch to correct tab
	${tab_num} =	Set Variable If
		...  'questions' in '${field}'	2
		...  'complaint' in '${field}'	3
		...  1
	Switch To Tab	${tab_num}
	Sleep			2s


Обрати потрібний лот за id
	[Arguments]  ${lot_id}
	#if lot is just one we don't have to switch
	Sleep								2s
	${is_multilot} =					Run Keyword And Return Status	Element Should Be Visible	css=div.lot-chooser
	Run Keyword Unless					${is_multilot}	Return From Keyword	${False}

	Mark Step							obraty lot ${lot_id}
	Sleep								2s
	Wait Until Element Is Visible		css=div.lot-chooser	1
	Wait Until Element Is Enabled		css=div.lot-chooser	1
	Click Element						css=div.lot-chooser>div.toggle-div
	Sleep								1s
	${status} =	Run Keyword And Return Status	Element Should Be Visible	xpath=//div[@ng-repeat='lot in model.lotPortion' and contains(., '${lot_id}')]
	Mark Step							our status: ${status}

	Wait Until Element Is Visible		xpath=//div[@ng-repeat='lot in model.lotPortion' and contains(., '${lot_id}')]	timeout=${COMMONWAIT}
	Wait Enable And Click Element		xpath=//div[@ng-repeat='lot in model.lotPortion' and contains(., '${lot_id}')]
	Wait Until Element Is Not Visible	xpath=//div[@ng-repeat='lot in model.lotPortion' and contains(., '${lot_id}')]	timeout=${COMMONWAIT}
	Sleep								1s
	Mark Step							lot obrano


Обрати потрібний лот за порядковим номером
	[Arguments]  ${number}
	#if lot is just one we don't have to switch
	Sleep								2s
	${is_multilot} =					Run Keyword And Return Status	Element Should Be Visible	css=div.lot-chooser
	Run Keyword Unless					${is_multilot}	Return From Keyword	${False}

	Mark Step							obraty lot ${number}
	Sleep								2s
	Wait Until Element Is Visible		css=div.lot-chooser	1
	Wait Until Element Is Enabled		css=div.lot-chooser	1
	Click Element						css=div.lot-chooser>div.toggle-div

	Wait Enable And Click Element		xpath=(//div[@ng-repeat='lot in model.lotPortion'])[${number}]
	Wait Until Element Is Not Visible	xpath=(//div[@ng-repeat='lot in model.lotPortion'])[${number}]	timeout=${COMMONWAIT}
	Sleep								1s
	Mark Step							lot obrano


Отримати положення предмету
	[Arguments]  ${item_id}
	${with_lot} = 	Run Keyword And Return Status		Wait Until Element Is Visible		css=#lotSection	timeout=${COMMONWAIT}

	Run Keyword If		'add_item' in ${TEST_TAGS}		Wait Until Keyword Succeeds	2min	10s	Check Condition With Reload	1	${item_id}
		...	ELSE IF		'add_lot' in ${TEST_TAGS}		Wait Until Keyword Succeeds	2min	10s	Check Condition With Reload	1	${item_id}

	${tender_data} = 							Execute Javascript	return angular.element("#tenderId").scope().model.ad;
	mark step									${tender_data}

	${item_num}	${lot_num}	${lots_count} = 	get_lot_num_by_item	${tender_data}	${item_id}
	Mark Step									${item_id} - ${item_num} - ${lot_num}
	[return]  ${item_num}  ${lot_num}


Отримати інформацію із предмету
	[Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${element}
	Mark Step	${username} - ${tender_uaid} - ${item_id} - ${element}
	Відкрити потрібну інформацію по тендеру	${username}	${element}

	${item}	${lot} =	Отримати положення предмету		${item_id}
	Обрати потрібний лот за порядковим номером			${lot}

	#show extra information if it is needed
	Відкрити детальну інформацію про позицію	${item}

	${element} = 	Set Variable	items.${element}

	Run Keyword And Return If	'${element}' == 'items.classification.id'				Отримати строку			${element}	3	${item}
	Run Keyword And Return If	'${element}' == 'items.description'						Отримати текст елемента	${element}		${item}
	Run Keyword And Return If	'${element}' == 'items.quantity'						Отримати число			${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'items.classification.description'		Отримати класифікацію	${element}		${item}
	Run Keyword And Return If	'${element}' == 'items.deliveryDate.endDate'			Отримати дату та час	${element}		${item}
	Run Keyword And Return If	'${element}' == 'items.unit.name'						Отримати назву			${element}	1	${item}
	Run Keyword And Return If	'${element}' == 'items.unit.code'						Отримати код			${element}	1	${item}
	Run Keyword And Return If	'${element}' == 'items.deliveryLocation.latitude'		Отримати число			${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'items.deliveryLocation.longitude'		Отримати число			${element}	0	${item}

	Run Keyword And Return If	'${element}' == 'items.deliveryAddress.countryName_ru'				Отримати інформацію з елемента зі зміною локалізації			${element}	${item}	ru
	Run Keyword And Return If	'${element}' == 'items.deliveryAddress.countryName_en'				Отримати інформацію з елемента зі зміною локалізації			${element}	${item}	en
	Run Keyword And Return If	'${element}' == 'items.classification.scheme'						Отримати інформацію з items.classification.scheme				${element}	${item}
	Run Keyword And Return If	'${element}' == 'items.additionalClassifications[0].scheme'			Отримати інформацію з items.addClassifications[0].scheme		${element}	${item}
	Run Keyword And Return If	'${element}' == 'items.additionalClassifications[0].id'				Отримати строку													${element}	3		${item}
	Run Keyword And Return If	'${element}' == 'items.additionalClassifications[0].description'	Отримати класифікацію											${element}	${item}

	Run Keyword And Return If	'items.deliveryAddres' in '${element}'								Отримати текст елемента				${element}	${item}

	Wait Until Element Is Visible	${tender_data_${element}}	timeout=${COMMONWAIT}
	${result_full} =				Get Text	${tender_data_${element}}
	${result} =						Strip String	${result_full}
	[Return]  ${field_value}


Отримати інформацію із нецінового показника
	[Arguments]  ${username}  ${tender_uaid}  ${feature_id}  ${field_name}
	Відкрити потрібну інформацію по тендеру	${username}  ${field_name}
	Wait For Element With Reload            xpath=//div[contains(@class,'info-item-label') and contains(., '${feature_id}')]  1

	Обрати потрібний лот за порядковим номером	1

	${result} = 	Run Keyword If	'${field_name}' == 'title'	Get Text	xpath=//div[contains(@class,'info-item-label') and contains(., '${feature_id}')]
		...	ELSE IF		'${field_name}' == 'description'		Get Text	xpath=//div[contains(., '${feature_id}')]/following-sibling::div[@ng-click='feature.showCl = !feature.showCl;']
		...	ELSE IF		'${field_name}' == 'featureOf'			Отримати інформацію з featureOf	${feature_id}	${field_name}
		...	ELSE		There is no such feature parameter.

	${result} =		Convert To String	${result}
	${result} =		Replace String	    ${result}	.:	.
	${result} =		Strip String		${result}
	[Return]  ${result}


Отримати інформацію із тендера
	[Arguments]  ${username}  ${item}  ${element}
	Відкрити потрібну інформацію по тендеру	${username}	${element}

	Run Keyword And Return If	'${element}' == 'value.amount'					Отримати сумму			${element}
	Run Keyword And Return If	'${element}' == 'enquiryPeriod.startDate'		Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'enquiryPeriod.endDate'			Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'tenderPeriod.startDate'		Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'tenderPeriod.endDate'			Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'complaintPeriod.endDate'		Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'bids'							Перевірити присутність bids
	Run Keyword And Return If	'${element}' == 'value.currency'				Отримати інформацію з value.currency					${element}
	Run Keyword And Return If	'${element}' == 'value.valueAddedTaxIncluded'	Отримати інформацію про включення ПДВ					${element}
	Run Keyword And Return If	'${element}' == 'status'						Отримати інформацію з status							${element}
	Run Keyword And Return If	'${element}' == 'causeDescription'				Отримати інформацію з causeDescription					${element}
	Run Keyword And Return If	'${element}' == 'minimalStep.amount'			Отримати інформацію з minimalStep.amount				${element}	0
	Run Keyword And Return If	'${element}' == 'title_en'						Отримати інформацію з елемента зі зміною локалізації	${element}	0	en
	Run Keyword And Return If	'${element}' == 'title_ru'						Отримати інформацію з елемента зі зміною локалізації	${element}	0	ru
	Run Keyword And Return If	'${element}' == 'description_en'				Отримати інформацію з елемента зі зміною локалізації	${element}	0	en
	Run Keyword And Return If	'${element}' == 'description_ru'				Отримати інформацію з елемента зі зміною локалізації	${element}	0	ru
	Run Keyword And Return If	'${element}' == 'auctionPeriod.startDate'		Отримати інформацію з auctionPeriod.startDate			${element}	${item}
	Run Keyword And Return If	'${element}' == 'procurementMethodType'			Отримати інформацію з procurementMethodType				${element}
	Run Keyword And Return If	'${element}' == 'cancellations[0].status'		Отримати інформацію з cancellations[0].status			${element}

	Run Keyword And Return If	'${element}' == 'lots.value.amount'							Отримати сумму										${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'causeDescription'							Отримати інформацію з causeDescription				${element}
	Run Keyword And Return If	'${element}' == 'awards[0].status'							Отримати інформацію з awards[0].status				${element}
	Run Keyword And Return If	'${element}' == 'awards[0].value.currency'					Отримати інформацію з awards[0].value.currency				${element}
	Run Keyword And Return If	'${element}' == 'awards[0].value.amount'					Отримати інформацію з awards[0].value.amount		${element}
	Run Keyword And Return If	'${element}' == 'awards[0].documents[0].title'				Отримати інформацію з awards[0].documents[0].title	${element}
	Run Keyword And Return If	'${element}' == 'awards[0].value.valueAddedTaxIncluded'		Отримати інформацію про включення ПДВ				${element}


	Wait Until Element Is Visible	${tender_data_${element}}	timeout=${COMMONWAIT}
	${result_full} =				Get Text	${tender_data_${element}}
	${result} =						Strip String	${result_full}
	[return]	${result}


Отримати інформацію із лоту
	[Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${element}
	Відкрити потрібну інформацію по тендеру		${username}	${element}
	${element_for_work} = 	Convert To String	lots.${element}

	Run Keyword If	'add_lot' in ${TEST_TAGS}		Wait Until Keyword Succeeds	2min	10s		Check Condition With Reload	1	${object_id}
		...	ELSE IF		'delete_lot' in ${TEST_TAGS}	Wait Until Keyword Succeeds	2min	10s	Check Condition With Reload	1	${object_id}

	#show more info of lot
	Wait Until Element Is Visible					css=a[ng-click='model.shwFull = !model.shwFull']	timeout=${COMMONWAIT}
	${attribute} =	Get Element Attribute			css=a[ng-click='model.shwFull = !model.shwFull'] span@id
	Mark Step  ${attribute}
	Run Keyword If	'showMore' in '${attribute}'	Click Element	css=a[ng-click='model.shwFull = !model.shwFull']

	Обрати потрібний лот за id						${object_id}

	Run Keyword And Return If	'${element}' == 'value.amount'					Отримати сумму							${element_for_work}
	Run Keyword And Return If	'${element}' == 'value.valueAddedTaxIncluded'	Отримати інформацію про включення ПДВ	${element_for_work}
	Run Keyword And Return If	'${element}' == 'value.currency'				Отримати інформацію з ${element}		${element_for_work}

	Wait Until Element Is Visible	${tender_data_${element_for_work}}	timeout=${COMMONWAIT}
	${result_full} =				Get Text	${tender_data_${element_for_work}}
	${result} =						Strip String	${result_full}

	[return]	${result}


Отримати інформацію із запитання
	[Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
	${element_for_work} = 	Convert To String	questions.${field_name}
	Відкрити потрібну інформацію по тендеру	${username}	${element_for_work}

	Run Keyword If	'${element_for_work}' == 'questions.title'				Wait For Element With Reload	${tender_data_${element_for_work}}	2
	Run Keyword If	'${element_for_work}' == 'questions.answer'				Wait For Element With Reload	${tender_data_${element_for_work}}	2
	Run Keyword And Return If	'${element_for_work}' == 'questions.date'	Отримати дату та час			${element_for_work}

	Wait Until Element Is Visible	${tender_data_${element_for_work}}	timeout=${COMMONWAIT}
	${result_full} =				Get Text	${tender_data_${element_for_work}}
	${result} =						Strip String	${result_full}
	[return]	${result}


Отримати текст елемента
	[Arguments]  ${element_name}  ${item}=${1}
	${index} =  					Evaluate	${item}-1
	Wait Until Element Is Visible	${tender_data_${element_name}}
	@{itemsList}=					Get Webelements	${tender_data_${element_name}}
	${result_full} =				Get Text		${itemsList[${index}]}
	[return]	${result_full}


Отримати строку
	[Arguments]  ${element_name}  ${position_number}  ${item}=${1}
	${result_full} =				Отримати текст елемента	${element_name}	${item}
	${result} =						Strip String	${result_full}
	${result} =						Replace String	${result}	,	${EMPTY}
	${values_list} =				Split String	${result}
	${result} =						Strip String	${values_list[${position_number}]}	mode=both	characters=:
	[return]	${result}


Отримати число
	[Arguments]  ${element_name}  ${position_number}  ${item}=${1}
	${value}=	Отримати строку		${element_name}	${position_number}	${item}
	${result}=	Convert To Number	${value}
	[return]	${result}

Отримати сумму
	[Arguments]  ${element_name}
	${value}=	Get text			${tender_data_${element_name}}
	${value}=	Replace String		${value}	${SPACE}	${EMPTY}
	${result}=	Convert To Number	${value}	2
	[return]	${result}


Отримати ціле число
	[Arguments]  ${element_name}  ${position_number}  ${item}=${1}
	${value}=	Отримати строку		${element_name}	${position_number}	${item}
	${result}=	Convert To Integer	${value}
	[return]	${result}


Отримати дату та час
	[Arguments]  ${element_name}  ${item}=${1}
	${result_full} =	Отримати текст елемента	${element_name}	${item}
	${work_string} =	Replace String			${result_full}	${SPACE},${SPACE}	${SPACE}
	${work_string} =	Replace String			${result_full}	,${SPACE}	${SPACE}
	${values_list} =	Split String			${work_string}
	${day} =			Convert To String		${values_list[0]}
	${month} =			get_month_number		${values_list[1]}
	${year} =			Convert To String		${values_list[2]}
	${time} =			Convert To String		${values_list[3]}
	${result}=			Convert To String		${year}-${month}-${day} ${time}
	${result} = 		get_time_with_offset	${result}
	[return]	${result}


Отримати класифікацію
	[Arguments]  ${element_name}  ${item}=${1}
	${result_full} =	Отримати текст елемента	${element_name}	${item}
	${reg_expresion} =	Set Variable	[0-9A-zА-Яа-яёЁЇїІіЄєҐґ\\s\\:]+\: \\w+[\\d\\.\\-]+ ([А-Яа-яёЁЇїІіЄєҐґ\\s;,\\"_\\(\\)\\.]+)
	${result} =			Get Regexp Matches	${result_full}	${reg_expresion}	1
	[return]	${result[0]}


Отримати назву
	[Arguments]  ${element_name}  ${position_number}  ${item}=${1}
	${result_full} =	Отримати строку	${element_name}	${position_number}	${item}
	${result} =			get_unit_name	${result_full}
	[return]	${result}


Отримати код
	[Arguments]  ${element_name}  ${position_number}  ${item}=${1}
	${result_full} =	Отримати строку	${element_name}	${position_number}	${item}
	${unit_name} = 		get_unit_name	${result_full}
	${result} =			get_unit_code	${unit_name}
	[return]	${result}


Отримати номер позиції
	[Arguments]  ${element_name}  ${reg_exp}
	${item} =	Get Regexp Matches	${element_name}	${reg_exp}	1
	${length} =	Get Length	${item}
	${result} =	Run Keyword If	'${length}' == '0'	Set Variable	0
		...  ELSE	Convert To Integer	${item[0]}
	[return]  ${result}


Перевірити присутність bids
	Element Should Not Be Visible	${tender_data_${element}}
	[return]	${None}


Отримати інформацію з auctionPeriod.startDate
	[Arguments]  ${element}
	Wait For Element With Reload	${tender_data_${element}}	1
	${start_date} =					Отримати дату та час	${element}
	${result} =						get_time_with_offset	${start_date}
	[return]  ${result}


Отримати інформацію з value.currency
	[Arguments]    ${element_name}
	${currency} =	Отримати текст елемента	${element_name}
	${currency_type} =	get_currency_type	${currency}
	[return]  ${currency_type}


Отримати інформацію про включення ПДВ
	[Arguments]  ${element_name}
	${value_added_tax_included} =	Get text	${tender_data_${element_name}}
	${result} =	Set Variable If	'з ПДВ' in '${value_added_tax_included}'	True
	${result} =	Convert To Boolean	${result}
	[return]  ${result}


Отримати інформацію з items.classification.scheme
	[Arguments]  ${element}  ${item}
	${first_part} =		Отримати строку	${element}	1	${item}
	${second_part} =	Отримати строку	${element}	2	${item}
	${result} =			Set Variable	${first_part} ${second_part}
	${currency_type} =	get_classification_type	${result}
	[return]  ${currency_type}


Отримати інформацію з procurementMethodType
	[Arguments]  ${element_name}
	${method_name} =	Get text	${tender_data_${element_name}}
	${method_type} =	get_procurement_method_type	${method_name}
	[return]  ${method_type}


Отримати інформацію з status
	[Arguments]  ${element_name}
	${status_name} =	Get text		${tender_data_${element_name}}
	Run Keyword And Ignore Error	Wait Until Element Does Not Contain	${tender_data_${element_name}}	'Прием предложений завершен'	5
	${status_type} =	get_status_type	${status_name}
	[return]  ${status_type}


Отримати інформацію з minimalStep.amount
	[Arguments]  ${element}  ${position_number}
	${locator} =	Set Variable If
		...  0 == ${number_of_lots}	minimalStep.amount
		...  minimalStep_lot.amount
	${result} =	Отримати сумму	${locator}
	[return]	${result}


Отримати інформацію з cancellations[0].status
	[Arguments]  ${element}
	${text} =	Отримати текст елемента  ${element}
	${result} =	Set Variable If	'Відмінено' in '${text}'	active
	[return]  ${result}


Отримати інформацію з items.addClassifications[0].scheme
	[Arguments]  ${element}  ${item}
	${first_part} =		Отримати строку	${element}	1	${item}
	${second_part} =	Отримати строку	${element}	2	${item}
	${result} =			Set Variable	${first_part} ${second_part}
	${class_type} =		get_classification_type	${result}
	[return]  ${class_type}


Отримати інформацію з items.addClassifications.[0].description
	[Arguments]  ${element}  ${item}
	${text} =		Отримати текст елемента  ${element}  ${item}
	${newText} =	Replace String Using Regexp		${text}	.*\\d	${EMPTY}
	${result} =		Strip String	${newText}
	[return]	${result}


Отримати інформацію з items.addClassifications.[0].id
	[Arguments]  ${element}  ${item}
	${text} =		Отримати текст елемента  ${element}  ${item}
	${newText} =	Get Regexp Matches		${text}	: (\\d.*\\d)	1
	${result} = 	Convert To String  ${newText[0]}
	[return]	${result}


Отримати інформацію з items.addClassifications.[0].scheme
	[Arguments]  ${element}  ${item}
	${text} =			Отримати текст елемента  ${element}  ${item}
	${newText} =		Get Regexp Matches		${text}	Классификатор (.*):	1
	${convertText} = 	Convert To String  ${newText[0]}
	${result} =			get_classification_type	${convertText}
	[return]	${result}


Отримати інформацію з causeDescription
	[Arguments]  ${element}  ${item}=${0}
	Wait Enable And Click Element		css=#tenderType>span
	${text} =	Отримати текст елемента  ${element}  ${item}
	[return]	${text}


Отримати інформацію з елемента зі зміною локалізації
	[Arguments]  ${element}  ${item}  ${localization}
	Click Element						css=a#lang_${localization}
	Wait For Ajax
	Wait Until Element Is Visible		css=span#lang_${localization}	timeout=${COMMONWAIT}
	Wait Until Element Is Visible		css=#nolotSection div[class='info-item'] a	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled		css=#nolotSection div[class='info-item'] a	timeout=${COMMONWAIT}
	Click Element						css=#nolotSection div[class='info-item'] a
	Run Keyword If	${item} > 0			Відкрити детальну інформацію про позицію	${item}
	${text} =							Отримати текст елемента  ${element}  ${item}
	[return]	${text}


Отримати інформацію з awards[0].documents[0].title
	[Arguments]  ${element}
	Click Element						xpath=//tr[@class=' bold']/td[2]/a
	Wait Until Element Is Visible		xpath=//div[@class='modal-body info-div ng-scope']/div[10]/div[2]	timeout=${COMMONWAIT}
	Wait For Ajax
	${text} =							Отримати текст елемента  ${element}
	[return]	${text}

Отримати інформацію з awards[0].status
	[Arguments]  ${element}
	${text} =							Отримати текст елемента  ${element}
	${newText} =						Set Variable If	'Розглядається' in '${text}'	active
	[return]	${newText}


Отримати інформацію з awards[0].value.amount
	[Arguments]  ${element}
	${text} =							Отримати число			${element}	0
	Click Element						css=.icon-remove.pull-right
	Wait Until Element Is Not Visible	css=.icon-remove.pull-right
	[return]	${text}


Отримати інформацію з featureOf
	[Arguments]  ${feature_id}  ${element}
	${result} = 	Get Text	xpath=//div[contains(@class, 'info-item ng-scope') and contains(., '${feature_id}')]/parent::div//section[contains(@class, 'description')]

	#get featureOf identifier
	${result} =	Set Variable If
		...  'По закупівлі' in '${result}'	tenderer
		...  'По лоту' in '${result}'		lot
		...  'По позиціям' in '${result}'	item
		...  ${result}

	[return]	${result}


Внести зміни в тендер
	[Arguments]  @{ARGUMENTS}
	Fail  Функція не підтримується майданчиком


Створити вимогу
	[Arguments]  ${user}  ${tender_id}  ${complaints}
	privatmarket.Пошук тендера по ідентифікатору	${user}	${tenderId}
	Switch To Tab						3
	Wait Enable And Click Element		xpath=//button[contains(@ng-click, 'act.setComplaintOnlyTender()')]
	Wait For Ajax
	Wait For Element Value				css=input[ng-model='model.person.phone']
	Wait Until Element Is Visible		xpath=//input[@ng-model='model.complaint.user.title']	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled		xpath=//input[@ng-model='model.complaint.user.title']	timeout=${COMMONWAIT}
	Input Text							xpath=//input[@ng-model='model.complaint.user.title']	${complaints.data.title}
	Input Text							css=div.info-item-val textarea							${complaints.data.description}
	Scroll Page To Element				xpath=//input[@ng-model='model.person.email']
	Input Text							xpath=//input[@ng-model='model.person.email']			${USERS.users['${user}'].email}
	Click Button						css=button[ng-click='act.saveComplaint()']
	Wait For Ajax
	Wait Until Element Is Enabled		css=div.alert-info	timeout=${COMMONWAIT}
	Wait Until Element Not Stale		css=div.alert-info	40
	Wait Until Element Contains			css=div.alert-info	Ваше требование успешно сохранено!	timeout=10
	${claim_data} =	Create Dictionary	id=123
	${claim_resp} =	Create Dictionary	data=${claim_data}
	[return]  ${claim_resp}

#TODO Multiple keywords with name 'Завантажити документацію до вимоги' found. Give the full name of the keyword you want to use:
#Завантажити документацію до вимоги
#	[Arguments]  ${user}  ${tender_id}  ${complaints}  ${document}
#	${correctFilePath} = 				Replace String	${document}	\\	\/
#	Execute Javascript					$("#fileToUpload").removeClass();
#	Choose File							css=input#fileToUpload	${correctFilePath}
#	sleep								5s
#	Wait Until Element Is Visible		css=div.file-item
#	[return]  ${document}


#Подати вимогу
#	[Arguments]  ${user}  ${tender_id}  ${complaints}  ${confrimation_data}
#	Click Button						xpath=//button[@ng-click='act.sendComplaint()']
#	Wait For Ajax
#	Wait Until Element Is Enabled		css=div.alert-info	timeout=${COMMONWAIT}
#	Wait Until Element Not Stale		css=div.alert-info	40
#	Wait Until Element Contains			css=div.alert-info	Ваше требование успешно отправлено!	timeout=10
#	Wait For Ajax
#	sleep								3s
#	Wait Until Element Is Not Visible	xpath=//input[@ng-model="model.question.title"]	timeout=${COMMONWAIT}
#	Wait For Ajax
#	Wait Until Element Not Stale		css=span[ng-click='act.hideModal()']	40
#	Click Element						css=span[ng-click='act.hideModal()']
#	sleep								3s
#	Wait Until Element Is Not Visible	css=div.info-item-val textarea	timeout=30
#	Element Should Not Be Visible		css=div.error


Скасувати вимогу
	[Arguments]    ${user}  ${tender_id}  ${claim_data}  ${cancellation_data}
	Wait Until Element Is Visible		css=a[ng-click='act.showCancelComplaintWnd(q)']	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled		css=a[ng-click='act.showCancelComplaintWnd(q)']	timeout=${COMMONWAIT}
	Click element						css=a[ng-click='act.showCancelComplaintWnd(q)']

	Wait Until Element Is Visible		xpath=//textarea[@ng-model='model.cancelComplaint.reason']	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled		xpath=//textarea[@ng-model='model.cancelComplaint.reason']	timeout=${COMMONWAIT}
	Wait Until Element Not Stale		xpath=//textarea[@ng-model='model.cancelComplaint.reason']	40
	Input Text							xpath=//textarea[@ng-model='model.cancelComplaint.reason']	${cancellation_data.data.cancellationReason}
	Click Button						css=button[ng-click='act.cancelComplaint()']
	Wait For Ajax
	Wait Until Element Is Not Visible	css=button[ng-click='act.cancelComplaint()']	timeout=${COMMONWAIT}
	Wait Until Element Contains			css=span#cmplStatus0	Отменено	timeout=${COMMONWAIT}


Задати питання
	[Arguments]  ${provider}  ${tender_id}  ${question}
	privatmarket.Пошук тендера по ідентифікатору	${provider}	${tender_id}
	Wait For Ajax
	Switch To Tab						2
	Wait Until Element Not Stale		xpath=//button[@ng-click='act.sendEnquiry()']	40
	Wait Until Element Is Enabled		xpath=//button[@ng-click='act.sendEnquiry()']				timeout=10
	Click Button						xpath=//button[@ng-click='act.sendEnquiry()']
	Заповнити форму питання				${question.data.title}	${question.data.description}	${USERS.users['${provider}'].email}
	[return]  True


Заповнити форму питання
	[Arguments]  ${title}  ${description}  ${email}
	Wait For Ajax
	sleep								4s
	Wait For Element Value				css=input[ng-model='model.person.phone']
	Wait Until Element Not Stale		xpath=//input[@ng-model="model.question.title"]	40
	Wait Until Element Is Visible		xpath=//input[@ng-model="model.question.title"]				timeout=10
	Wait Until Element Is Enabled		xpath=//input[@ng-model="model.question.title"]				timeout=10
	Input text							xpath=//input[@ng-model="model.question.title"]				${title}
	Input text							xpath=//textarea[@ng-model='model.question.description']	${description}
	Input text							xpath=//input[@ng-model='model.person.email']				${email}
	Click Button						xpath=//button[@ng-click='act.sendQuestion()']
	Wait For Notification				Ваш вопрос успешно помещен в очередь на отправку. Спасибо за обращение!
	Wait Until Element Not Stale		css=span[ng-click='act.hideModal()']	40
	Click Element						css=span[ng-click='act.hideModal()']
	Wait Until Element Is Not Visible	xpath=//input[@ng-model='model.question.title']	timeout=20


Задати питання до лоту
	[Arguments]  ${provider}  ${tender_id}  ${lot_id}  ${question}
	Обрати потрібний лот за id	${lot_id}
	Wait Enable And Click Element	css=a[ng-click='act.sendLotEnquiry()']
	Заповнити форму питання			${question.data.title}	${question.data.description}	${USERS.users['${provider}'].email}
	[return]  True


Задати питання на предмет
	[Arguments]  ${provider}  ${tender_id}  ${item_id}  ${question}
	log	Is not ready yet!


Оновити сторінку з тендером
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  tenderId

	privatmarket.Пошук тендера по ідентифікатору		@{ARGUMENTS}[0]	@{ARGUMENTS}[1]


Подати цінову пропозицію
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  tenderId
	...	${ARGUMENTS[2]} ==  bid

	Run Keyword If	'без прив’язки до лоту' in '${TEST_NAME}'	Fail  Така ситуація не може виникнути
	Run Keyword If	'без нецінового показника' in '${TEST_NAME}'	Fail  Така ситуація не може виникнути

	Switch browser						${ARGUMENTS[0]}
	privatmarket.Пошук тендера по ідентифікатору	${ARGUMENTS[0]}   ${ARGUMENTS[1]}

	Відкрити заявку
	Wait Until Element Not Stale		${locator_tenderClaim.fieldEmail}	40

	${amount} =	Set Variable If
		...  'multiLotTender' in '${SUITE_NAME}'	${Arguments[2].data.lotValues[1]['value']['amount']}
		...  ${Arguments[2].data.value.amount}
	${amount} = 	Convert To String	${amount}

	Run Keyword If	'multiLotTender' in '${SUITE_NAME}'	Input Text	${locator_tenderClaim.checkedLot.fieldPrice}	${amount}
		...  ELSE	Input Text	${locator_tenderClaim.fieldPrice}	${amount}

	Click Element						${locator_tenderClaim.fieldEmail}
	Input Text							${locator_tenderClaim.fieldEmail}	${USERS.users['${ARGUMENTS[0]}'].email}

	#Just for aboveThreshold tests
	Run Keyword If	'open' in '${SUITE_NAME}'	Run Keywords	Click element	css=input[ng-disabled='model.selfQualifiedDisabled']
	...   AND   Click element	css=input[ng-disabled='model.selfEligibleDisabled']

	sleep								1s
	Scroll Page To Element				${locator_tenderClaim.buttonSend}
	Click Button						${locator_tenderClaim.buttonSend}
	Wait For Ajax Overflow Vanish
	Close confirmation					Ваша заявка была успешно помещена в очередь на отправку!
	Wait Until Element Is Visible		css=div.afp-info.ng-scope.ng-binding
	wait until element contains			css=div.afp-info.ng-scope.ng-binding	Номер заявки
	Wait For Ajax
	${claim_id}=						Get text			css=div.afp-info.ng-scope.ng-binding
	${result}=							Get Regexp Matches	${claim_id}	Номер заявки: (\\d*),	1

	Run Keyword If	'open' in '${SUITE_NAME}'	Run Keywords	Click Element	css=a[ng-click='act.ret2Ad()']
	...   AND   Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td[4 and contains(., 'Отправлена')]	1

	[return]	${Arguments[2]}


Дочекатися статусу заявки
	[Arguments]  ${status}
	Wait Until Element Is Visible		xpath=//table[@class='bids']//tr[1]/td[4]
	Wait Until Keyword Succeeds			1min	10s	Element Should contain	xpath=//table[@class='bids']//tr[1]/td[4]	${status}


Відкрити заявку
	Wait For Ajax
	Wait Until Element Is Visible		css=div#tenderStatus	${COMMONWAIT}

	${tender_status} =					Get text	css=div#tenderStatus
	Run Keyword Unless	'до початку періоду подачі' in '${TEST_NAME}'	Run Keyword If	'${tender_status}' == 'Период уточнений завершен'	Wait For Element With Reload	${locator_tenderClaim.buttonCreate}	1

	Scroll Page To Element				${locator_tenderClaim.buttonCreate}
	Wait Until Element Not Stale		${locator_tenderClaim.buttonCreate}	30
	Wait Enable And Click Element		${locator_tenderClaim.buttonCreate}
	sleep								3s
	Wait Until Element Is Not Visible	${locator_tenderClaim.buttonCreate}	50s
	Wait For Element Value				css=input[ng-model='model.person.lastName']
	Wait Until Element Is Enabled		${locator_tenderClaim.fieldEmail}	20


Змінити цінову пропозицію
	[Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
	privatmarket.Пошук тендера по ідентифікатору	${username}   ${tender_uaid}
	Wait For Ajax

	Wait Enable And Click Element		${locator_tenderClaim.buttonCreate}
	Wait For Ajax
	Wait For Element Value				css=input[ng-model='model.person.lastName']
	Wait Until Element Is Enabled		${locator_tenderClaim.fieldEmail}	${COMMONWAIT}
	sleep								5s

	Run Keyword 						Змінити ${fieldname}	${fieldvalue}
	Run Keyword Unless	'open' in '${SUITE_NAME}'	Run Keywords	Click Element	${locator_tenderClaim.fieldEmail}
	...   AND   Input Text	${locator_tenderClaim.fieldEmail}	${USERS.users['${username}'].email}

	Scroll Page To Element				${locator_tenderClaim.buttonSend}
	Click Button						${locator_tenderClaim.buttonSend}

	${test_name} =	Convert To Lowercase	${TEST_NAME}
	Run Keyword If	'оновити статус цінової пропозиції' in '${test_name}'	Close confirmation	Ваша заявка была успешно помещена в очередь на отправку!
		...  ELSE	Close confirmation	Ваша заявка была успешно сохранена!

	Wait Until Element Is Visible		css=div.afp-info.ng-scope.ng-binding
	Wait For Ajax
	${claim_id}=						Get text			css=div.afp-info.ng-scope.ng-binding
	${result}=							Get Regexp Matches	${claim_id}	Номер заявки: (\\d*),	1
	[return]	${fieldname}


Змінити parameters.0.value
	[Arguments]  ${fieldvalue}
	Select From List	xpath=(//select[@ng-model='feature.userValue'])[1]	${fieldvalue}


Змінити lotValues.0.value.amount
	[Arguments]  ${fieldvalue}
	Input Text	${locator_tenderClaim.checkedLot.fieldPrice}	${fieldvalue}


Змінити value.amount
	[Arguments]  ${fieldvalue}
	Run Keyword If	'multiLotTender' in '${SUITE_NAME}'	Input Text	${locator_tenderClaim.checkedLot.fieldPrice}	${fieldvalue}
		...  ELSE	Input Text	${locator_tenderClaim.fieldPrice}	${fieldvalue}


Змінити status
	[Arguments]  ${fieldvalue}
	[return]  True
#	лише клікаємо зберегти, нічого не змінюючи


Скасувати цінову пропозицію
	[Arguments]  ${username}  ${tender_uaid}
	[Documentation]

	privatmarket.Пошук тендера по ідентифікатору	${username}	${tender_uaid}
	Wait For Ajax
	Wait Enable And Click Element		${locator_tenderClaim.buttonCreate}
	Wait For Element Value				css=input[ng-model='model.person.lastName']
	Scroll Page To Element				${locator_tenderClaim.buttonCancel}
	Wait Enable And Click Element		${locator_tenderClaim.buttonCancel}
	Close Confirmation					Ваша заявка успешно отменена!
	Wait Until Element Is Enabled		${locator_tenderClaim.buttonCreate}	${COMMONWAIT}
	[return]	${ARGUMENTS[1]}


Отримати пропозицію
	[Arguments]  ${username}  ${tender_uaid}
	Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td[4 and contains(., 'Недействительная')]	1
	${button_of_send_claim_text} =	Get text	${locator_tenderClaim.buttonCreate}
	${status} =						Set Variable	invalid
	${bid} =						get_bid_data	${status}
	[return]	${bid}


Відповісти на питання
	[Arguments]  @{ARGUMENTS}
	Fail  Функція не підтримується майданчиком


Завантажити документ в ставку
	[Arguments]  ${user}  ${filePath}  ${tenderId}  ${doc_type}=documents
	privatmarket.Пошук тендера по ідентифікатору	${user}   ${tenderId}
	Відкрити заявку
	Input Text							${locator_tenderClaim.fieldEmail}	${USERS.users['${user}'].email}

	Wait Until Element Is Enabled		css=button[ng-click='act.chooseFile()']	${COMMONWAIT}
	Scroll Page To Element				css=button[ng-click='act.chooseFile()']
	sleep  3s

	${list_item} =	get_doc_identifier	${doc_type}
	Select From List By Value			css=select[ng-model='model.currFileVfv']	${list_item}
	${correctFilePath} = 				Replace String		${filePath}	\\	\/

	Execute Javascript					$("#fileToUpload").removeClass();
	Choose File							css=input#fileToUpload	${correctFilePath}

	${upload_response} =	Зберегти доданий файл	${filePath}
	#before step for Change File
	privatmarket.Пошук тендера по ідентифікатору	${user}	${tenderId}
	[return]	${upload_response}


Зберегти доданий файл
	[Arguments]  ${filePath}
	Wait Until Element Is Not Visible	css=div[ng-show='progressVisible'] div.progress-bar	timeout=30
	Sleep								5s
	Wait Until Element Is Visible		xpath=(//div[contains(@class, 'file-item')])[1]	timeout=30

	Click Button						${locator_tenderClaim.buttonSend}
	Close confirmation					Ваша заявка была успешно сохранена!
	${dateModified}						Get text	css=span.file-tlm
	Click Element						${locator_tenderClaim.buttonGoBack}
	wait until element is visible		css=table.bids tr
	Wait For Element With Reload		xpath=//table[@class='bids']//tr[1]/td//img[contains(@src,'clip_icon.png')]	1

	#получим ссылку на файл и его id
	Scroll Page To Element				css=a[ng-click='act.showDocWin(b)']
	Click Element						css=a[ng-click='act.showDocWin(b)']
	Wait For Ajax
	Wait Until Element Is Enabled		xpath=(//div[@ng-click='openUrl(file.url)'])[last()]	5s
	${url} = 							Execute Javascript	var scope = angular.element($("div[ng-click='openUrl(file.url)']")).last().scope(); return scope.file.url
	${uploaded_file_data} =				fill_file_data  ${url}  ${filePath}  ${dateModified}  ${dateModified}
	${upload_response} = 				Create Dictionary
	Set To Dictionary					${upload_response}	upload_response	${uploaded_file_data}
	[return]	${upload_response}


Змінити документ в ставці
	[Arguments]  ${user}  ${filePath}  ${docid}
	Відкрити заявку
	Scroll Page To Element				css=button[ng-click='act.chooseFile()']
	sleep  2s

	${correctFilePath} = 				Replace String		${filePath}	\\	\/
	Execute Javascript					$("#fileToUpload").removeClass();
	Execute Javascript					angular.element($("input[ng-model='model.fileName']")).scope().$parent.act.changeFile(angular.element("div.file-item").scope().file);
	Choose File							css=input#fileToUpload    ${correctFilePath}

	${uploaded_file_data} =				Зберегти доданий файл	${filePath}
	[return]  ${uploaded_file_data}


Змінити документацію в ставці
	[Arguments]  ${privat_doc}  ${bidid}  ${docid}
	Відкрити заявку
	Scroll Page To Element		css=button[ng-click='act.chooseFile()']

	Run Keyword					Змінити ${bidid.data.confidentiality} для файлу	${bidid}
	${file_name} =				Get text	xpath=(//span[@class='file-name ng-binding'])[last()]
	${uploaded_file_data} =		Зберегти доданий файл	${file_name}
	[return]  ${uploaded_file_data}


Змінити buyerOnly для файлу
	[Arguments]  ${bidid}
	Click Element					xpath=(//div[@ng-if='model.canSecretFiles'])[last()]
	Wait For Ajax
	Wait Until Element Is Enabled	css=textarea[ng-model='model.fvHideReason']
	Input Text						css=textarea[ng-model='model.fvHideReason']		${bidid.data.confidentialityRationale}
	Click Button					xpath=//button[contains(@ng-click,'act.setFvHidden')]
	Wait For Notification			Файл был успешно скрыт!


Обробити скаргу
	[Arguments]  @{ARGUMENTS}
	Fail  Функція не підтримується майданчиком


Отримати посилання на аукціон для глядача
	[Arguments]  ${user}  ${tenderId}
	${result} =	Отримати посилання на аукціон	${user}  ${tenderId}
	[return]  ${result}


Отримати посилання на аукціон для учасника
	[Arguments]  ${user}  ${tenderId}
	${result} =	Отримати посилання на аукціон	${user}  ${tenderId}
	[return]  ${result}


Отримати посилання на аукціон
	[Arguments]  ${user}  ${tenderId}
	privatmarket.Пошук тендера по ідентифікатору	${user}   ${tenderId}
	Wait For Element With Reload					css=a[ng-click='act.takePart()']	1
	Scroll Page To Element							css=a[ng-click='act.takePart()']
	Wait Until Element Is Visible					css=a[ng-click='act.takePart()']  timeout=30

	${request_string} =	Convert To String
		...  return (function(){var link = angular.element($("a[ng-click='act.takePart()']")).scope().model.ad.auctionUrl; if(!link || link=='None'){return false;} else return true;})()
	Wait For Condition								${request_string}	${COMMONWAIT}
	${result} =	Execute Javascript					return angular.element($("a[ng-click='act.takePart()']")).scope().model.ad.auctionUrl;
	[return]  ${result}


#Custom Keywords
Login
	[Arguments]  ${username}
	Click Element						xpath=//span[.='Вход']
	Wait Until Element Is Visible		id=p24__login__field	${COMMONWAIT}
	Execute Javascript					$('#p24__login__field').val(${USERS.users['${username}'].login})
	Check If Element Stale				xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']
	Input Text							xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']	${USERS.users['${username}'].password}
	Click Element						xpath=//div[@id="login_modal" and @style='display: block;']//button[@type='submit']
	Wait Until Element Is Visible		css=ul.user-menu  timeout=30
	Wait Until Element Is Visible		css=a[data-target='#select_cabinet']  timeout=${COMMONWAIT}


Wait For Ajax
	sleep				2s
	Wait For Condition	return window.jQuery!=undefined && jQuery.active==0	60s


Wait Until Element Not Stale
	[Arguments]  ${locator}  ${time}
	sleep 			2s
	${left_time} =	Evaluate  ${time}-2
	${element_state} =	Check If Element Stale	${locator}
	run keyword if  ${element_state} and ${left_time} > 0	Wait Until Element Not Stale	${locator}	${left_time}


Check If Element Stale
	[Arguments]  ${locator}
	${element} =	Get Webelement	${locator}
	${element_state} =	is_element_not_stale	${element}
	[return]  ${element_state}


Switch To Frame
	[Arguments]  ${frameId}
	Wait Until Element Is enabled	${frameId}	${COMMONWAIT}
	Select Frame					${frameId}


Wait Enable And Click Element
	[Arguments]  ${elementLocator}
	Wait Until Element Is enabled	${elementLocator}	${COMMONWAIT}
	Click Element					${elementLocator}
	Wait For Ajax


Wait Visibulity And Click Element
	[Arguments]  ${elementLocator}
	Wait Until Element Is Visible	${elementLocator}	${COMMONWAIT}
	Click Element					${elementLocator}
	Wait For Ajax


Mark Step
	[Arguments]  ${stepName}
	${time} =	Get Time
	Log to console	_${stepName} - ${time}
	Log Many	_${stepName} - ${time}


Close Confirmation
	[Arguments]	${confirmation_text}
	Wait For Ajax
	Wait Until Element Is Visible		css=p.ng-binding	${COMMONWAIT}
	Wait Until Element Contains			css=p.ng-binding	${confirmation_text}	${COMMONWAIT}
	Scroll Page To Element				css=p.ng-binding
	Wait Visibulity And Click Element	xpath=//button[@ng-click='close()']
	Wait Until Element Is Not Visible	xpath=//button[@ng-controller='inFrameModalCtrl']	${COMMONWAIT}
	Wait For Ajax


Wait For Notification
	[Arguments]	${message_text}
	Wait For Ajax
	Wait Until Element Is Enabled		xpath=//div[@class='alert-info ng-scope ng-binding']	timeout=${COMMONWAIT}
	Wait Until Element Contains			xpath=//div[@class='alert-info ng-scope ng-binding']	${message_text}	timeout=10
	Wait For Ajax


Wait For Element Value
	[Arguments]	${locator}
	Wait For Ajax
	${cssLocator} =	Get Substring	${locator}	4
	Wait For Condition				return window.$($("${cssLocator}")).val()!='' && window.$($("${cssLocator}")).val()!='None'	${COMMONWAIT}
	${value}=	get value			${locator}
	Mark Step						_value_when_we_wait_it_${value}


Scroll Page To Element
	[Arguments]	${locator}
	${cssLocator} =		Run Keyword If	'css' in '${TEST_NAME}'	Get Substring	${locator}	4
		...  ELSE	Get Substring	${locator}	6
	${js_expresion} =	Run Keyword If	'css' in '${TEST_NAME}'	Convert To String	return window.$("${cssLocator}")[0].scrollIntoView()
		...  ELSE	Convert To String	return window.$x("${cssLocator}")[0].scrollIntoView()
	Sleep	2s


Wait For Tender
	[Arguments]	${tender_id}  ${education_type}
	Mark Step  in_Wait For Tender
	Wait Until Keyword Succeeds	10min	10s	Try Search Tender	${tender_id}	${education_type}


Try Search Tender
	[Arguments]	${tender_id}  ${education_type}
	#проверим правильный ли режим
	Mark Step	in_Try Search Tender
	${education_is_off} = 	Run Keyword And Return Status		Element Should Not Be Visible	css=a#test-mode-off
	Run Keyword If	${education_type} and ${education_is_off}	Run Keywords	Switch To Education Mode

	#заполним поле поиска
	${text_in_search} =					Get Value	css=input#search-query-input
	Run Keyword Unless	'${tender_id}' == '${text_in_search}'	Run Keywords	Clear Element Text	css=input#search-query-input
	...   AND   sleep		1s
	...   AND   Input Text	css=input#search-query-input	${tender_id}

	#выполним поиск
	Click Element						css=button#search-query-button
	Wait For Ajax Overflow Vanish
	Wait Until Element Is Enabled		id=${tender_id}	timeout=10
	[return]	True


Switch To Education Mode
	Sleep								2s
	Wait Until Element Is Enabled		css=a#test-model-switch	timeout=${COMMONWAIT}
	Click Element						css=a#test-model-switch
	Wait Until Element Is Visible		css=a#test-mode-off	${COMMONWAIT}
	Wait For Ajax Overflow Vanish
	Sleep								2s
	Wait Until Element Not Stale		xpath=//tr[@ng-repeat='t in model.tenderList']	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled		xpath=//tr[@ng-repeat='t in model.tenderList']	timeout=${COMMONWAIT}


Reload And Switch To Tab
	[Arguments]  ${tab_number}
	Mark Step					in_reload
	Reload Page
	Switch To Frame		id=tenders
	Switch To Tab		${tab_number}
	Wait For Ajax


Switch To Tab
	[Arguments]  ${tab_number}
	${class} =	Get Element Attribute	xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]@class
	Run Keyword Unless	'white-icon' in '${class}'	Wait Visibulity And Click Element	xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]


Wait For Element With Reload
	[Arguments]  ${locator}  ${tab_number}
	Mark Step					in_wait
	Wait Until Keyword Succeeds			4min	10s	Try Search Element	${locator}	${tab_number}


Try Search Element
	[Arguments]	${locator}  ${tab_number}
	Mark Step					in_search
	Reload And Switch To Tab			${tab_number}
	Wait For Ajax
	Wait Until Element Is Enabled		${locator}	3
	[return]	True


Check Condition With Reload
	[Arguments]  ${tab_number}  ${item_id}

	Mark Step	in_check_condition_with_reload
	Reload And Switch To Tab	${tab_number}
	Wait For Ajax

	${tender_data} = 	Execute Javascript	return angular.element("#tenderId").scope().model.ad;
	${result} = 		is_object_present	${tender_data}	${item_id}
	Run Keyword Unless	${result}	Fail

	[return]	${result}


Wait For Ajax Overflow Vanish
	Wait Until Element Is Not Visible	${locator_tender.ajax_overflow}	${COMMONWAIT}


Click element by JS
	[Arguments]	${locator}
	Execute Javascript					window.$("${locator}").mouseup()
