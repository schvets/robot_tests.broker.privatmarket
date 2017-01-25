*** Settings ***
Library  Selenium2Screenshots
Library  String
Library  DateTime
Library  Selenium2Library
Library  Collections
Library  DebugLibrary
Library  OperatingSystem
Library  privatmarket_service.py


*** Variables ***
${COMMONWAIT}	40

${tender_data_title}											xpath=//div[contains(@class,'title-div')]
${tender_data_description}										css=div.description
${tender_data_procurementMethodType}							xpath=//div[@class='status-label ng-binding'][2]
${tender_data_status}											css=div#tenderStatus
${tender_data_value.amount}										css=#tenderBudget
${tender_data_value.currency}									css=#tenderBudgetCcy
${tender_data_value.valueAddedTaxIncluded}						css=#tenderBudgetTax
${tender_data_tenderID}											css=div#tenderId
${tender_data_procuringEntity.name}								css=a[ng-click='commonActions.openCard()']
${tender_data_enquiryPeriod.startDate}							xpath=//span[@id='active.enquiries-bd']
${tender_data_enquiryPeriod.endDate}							xpath=//span[@id='active.enquiries-ed']
${tender_data_tenderPeriod.startDate}							xpath=//span[@id='active.tendering-bd']
${tender_data_tenderPeriod.endDate}								xpath=//span[@id='active.tendering-ed']
${tender_data_auctionPeriod.startDate}							xpath=//span[@id='active.auction-bd']
${tender_data_complaintPeriod.endDate}							css=span#cmplPeriodEnd
${tender_data_bids}												xpath=(//table[@class='bids']//tr)[2]
${tender_data_minimalStep.amount}								css=#lotMinStepAmount
${tender_data_items.description}								css=a[ng-click='adb.showCl = !adb.showCl;']
${tender_data_items.deliveryDate.endDate}						xpath=//div[@ng-if='adb.deliveryDate.endDate']/div[2]
${tender_data_items.deliveryLocation.latitude}					css=span.latitude
${tender_data_items.deliveryLocation.longitude}					css=span.longitude
${tender_data_items.deliveryAddress.countryName}				css=prz-address[addr='adb.deliveryAddress'] span#countryName
${tender_data_items.deliveryAddress.countryName_ru}				xpath=//div[@class='info-item ng-scope']//span[@id='countryName']
${tender_data_items.deliveryAddress.countryName_en}				xpath=//div[@class='info-item ng-scope']//span[@id='countryName']
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
${tender_data_lots.title}										div[@id='lot-title']
${tender_data_lots.description}									section[@class='description marged ng-binding']
${tender_data_lots.value.amount}								*[@id='lotAmount']
${tender_data_lots.value.currency}								*[@id='lotCcy']
${tender_data_lots.value.valueAddedTaxIncluded}					*[@id='lotTax']
${tender_data_lots.minimalStep.amount}							*[@id='lotMinStepAmount']
${tender_data_lots.minimalStep.currency}						*[@id='lotMinStepCcy']
${tender_data_lots.minimalStep.valueAddedTaxIncluded}			*[@id='lotMinStepTax']
${tender_data_lotValues[0].value.amount}						xpath=//table[@class='bids']//tr[1]/td[3]

${locator_tenderCreation.buttonEdit}			xpath=//button[@ng-click='act.createAfp()']
${locator_tenderCreation.buttonSave}			css=button.btn.btn-success
${locator_tenderCreation.buttonBack}			xpath=//a[@ng-click='act.goBack()']
${locator_tenderCreation.description}			css=textarea[ng-model='model.filterData.adbName']

${locator_tenderClaim.buttonCreate}				css=button[ng-click='commonActions.createAfp()']
${locator_tenderClaim.fieldPrice}				css=input#price0
${locator_tenderClaim.fieldEmail}				css=input[ng-model='model.person.email']
${locator_tenderClaim.buttonSend}				css=button[ng-click='act.sendAfp()']
${locator_tenderClaim.buttonCancel}				css=button[ng-click='act.delAfp()']
${locator_tenderClaim.buttonGoBack}				css=a[ng-click='act.ret2Ad()']
${locator_tender.ajax_overflow}					css=div.ajax_overflow

${tender_data_cancellations[0].status}						xpath=//div[@class='info-div']/div[last()]/div/div[1]/div[1]
${tender_data_cancellations[0].reason}						xpath=//div[@class='info-div']/div[last()]/div/div[1]/div[2]
${tender_data_cancellations[0].documents[0].title}			css=.file-name.ng-binding
${tender_data_cancellations[0].documents[0].description}	xpath=//div[@class='file-descriptor']/span[2]
${tender_data_title_en}										css=.title-div>span
${tender_data_title_ru}										css=.title-div>span
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

${tender_data_documents[0].title}						xpath=//prozorro-doc[contains(@ng-repeat, \"documentOf:'tender'\")]//*[@class='file-name ng-binding']
${tender_data_documents[1].title}						xpath=//prozorro-doc[contains(@ng-repeat, \"documentOf:'lot'\")]//*[@class='file-name ng-binding']
${tender_data_causeDescription}							css=#tenderType>div:nth-of-type(2)
${tender_data_cause}									css=#tenderType>div:nth-of-type(1)

${tender_data_awards[0].status}									xpath=//div[@class='modal-body info-div ng-scope']/div[4]/div[2]
${tender_data_awards[0].suppliers[0].address.countryName}		xpath=(//prz-address[@id='procurerAddr'])[2]//*[@id='countryName']
${tender_data_awards[0].suppliers[0].address.locality}			xpath=(//prz-address[@id="procurerAddr"])[2]//*[@id='locality']
${tender_data_awards[0].suppliers[0].address.postalCode}		xpath=(//prz-address[@id="procurerAddr"])[2]//*[@id='postalCode']
${tender_data_awards[0].suppliers[0].address.region}			xpath=(//prz-address[@id="procurerAddr"])[2]//*[@id='region']
${tender_data_awards[0].suppliers[0].address.streetAddress}		xpath=(//prz-address[@id="procurerAddr"])[2]//*[@id='streetAddress']
${tender_data_awards[0].suppliers[0].contactPoint.telephone}	xpath=//div[@class='modal-body info-div ng-scope']/div[7]/div[2]
${tender_data_awards[0].suppliers[0].contactPoint.name}			xpath=//div[@class='modal-body info-div ng-scope']/div[6]/div[2]
${tender_data_awards[0].suppliers[0].contactPoint.email}		xpath=//div[@class='modal-body info-div ng-scope']/div[8]/div[2]
${tender_data_awards[0].suppliers[0].identifier.scheme}			xpath=//div[@class='modal-body info-div ng-scope']/div[2]/div[2]
${tender_data_awards[0].suppliers[0].identifier.legalName}		xpath=//div[@class='modal-body info-div ng-scope']/div[1]/div[2]
${tender_data_awards[0].suppliers[0].identifier.id}				xpath=//div[@class='modal-body info-div ng-scope']/div[3]/div[2]
${tender_data_awards[0].suppliers[0].name}						xpath=//tr[@class=' bold']/td[2]/a
${tender_data_awards[0].value.valueAddedTaxIncluded}			xpath=//div[@class='modal-body info-div ng-scope']/div[9]/div[2]
${tender_data_awards[0].value.currency}							xpath=//div[@class='modal-body info-div ng-scope']/div[9]/div[2]
${tender_data_awards[0].value.amount}							xpath=//div[@class='modal-body info-div ng-scope']/div[9]/div[2]
${tender_data_awards[0].documents[0].title}						css=.modal-body .file-name
${tender_data_contracts[0].status}								xpath=//div[@class='modal-body info-div ng-scope']/div[10]/div[2]

*** Keywords ***
Підготувати дані для оголошення тендера
	[Arguments]  ${username}  ${tender_data}  ${role_name}
	Run keyword if	'${role_name}' != 'tender_owner'	Return From Keyword	${tender_data}
	${tender_data.data} = 	modify_test_data	${tender_data.data}
	[return]	${tender_data}


Підготувати клієнт для користувача
	[Arguments]  ${username}
	[Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо

	${service args}=	Create List	--ignore-ssl-errors=true	--ssl-protocol=tlsv1
	${browser} =		Convert To Lowercase	${USERS.users['${username}'].browser}
	${extention_dir} = 	Set variable	C:\\Users\\Oks\\AppData\\Local\\Google\\Chrome\\User Data\\Profile 5\\Extensions\\ggmdpepbjljkkkdaklfihhngmmgmpggp\\2.0_0
	${if_dir_exist} = 	Run Keyword And Return Status	Directory Should Exist	${extention_dir}

	${options}= 	Evaluate	sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
	Call Method	${options}	add_argument	--allow-running-insecure-content
	Call Method	${options}	add_argument	--disable-web-security
	Call Method	${options}	add_argument	--start-maximized
	Call Method	${options}	add_argument	--nativeEvents\=false
	Run Keyword If	${if_dir_exist} == ${TRUE}	Call Method	${options}	add_argument	--load-extension\=${extention_dir}

	Run Keyword If	'phantomjs' in '${browser}'	Run Keywords	Create Webdriver	PhantomJS	${username}	service_args=${service args}
	...   ELSE	Create WebDriver	Chrome	chrome_options=${options}	alias=${username}
	Go To	${USERS.users['${username}'].homepage}
	Run Keyword Unless	'Viewer' in '${username}'	Login	${username}


Створити тендер
	[Arguments]  ${username}  ${tender_data}
	${items} =								Get From Dictionary	${tender_data.data}	items
	${features} =							Get From Dictionary	${tender_data.data}	features
	${lots} =								Get From Dictionary	${tender_data.data}	lots

	Wait Until Element Is Enabled			id=tenders	timeout=${COMMONWAIT}
	Switch To Frame							id=tenders
	Sleep									1s

	Switch To Education Mode
	Wait Until Element Is Visible			css=button[ng-click='template.newTender()']
	Click Button							css=button[ng-click='template.newTender()']
	Wait For Ajax

	#choose UK language
	${status} =	Run Keyword And Return Status	Element Should Be Visible	css=a#lang_uk
	Run Keyword If	${status}	Click Element	css=a#lang_uk
	Wait For Ajax

#step 0
	#we should add choosing of procurementMethodType
	Wait Until Element Is Enabled				css=input[data-id='procurementName']				${COMMONWAIT}
	Input Text									css=input[data-id='procurementName']				${tender_data.data.title}
	Sleep	1s
	Input Text									css=textarea[data-id='procurementDescription']		${tender_data.data.description}

	#CPV
	Mark Step									CPV
	Wait For Ajax
	Click Button								xpath=(//button[@data-id='actChoose'])[1]
	Wait Until Element Is Visible				css=section[data-id='classificationTreeModal']		${COMMONWAIT}
	Wait Until Element Is Visible				css=input[data-id='query']							${COMMONWAIT}
	Search By Query								css=input[data-id='query']							${items[0].classification.id}
	Wait For Ajax
	Click Button								css=button[data-id='actConfirm']

	#additionalClassifications
	Mark Step									additionalClassifications
	Click Button								css=section[data-id='additionalClassifications'] button[data-id='actChoose']
	Wait Until Element Is Visible				css=section[data-id='classificationTreeModal']		${COMMONWAIT}
	Wait Until Element Is Visible				css=input[data-id='query']							${COMMONWAIT}
	Search By Query								css=input[data-id='query']							${items[0].additionalClassifications[0].id}
	Wait For Ajax
	Click Button								css=button[data-id='actConfirm']
	Wait For Ajax
	Input Text									css=input[data-id='postalCode']		${tender_data.data.procuringEntity.address.postalCode}
	Input Text									css=input[data-id='countryName']	${tender_data.data.procuringEntity.address.countryName}
	Input Text									css=input[data-id='region']			${tender_data.data.procuringEntity.address.region}
	Input Text									css=input[data-id='locality']		${tender_data.data.procuringEntity.address.locality}
	Input Text									css=input[data-id='streetAddress']	${tender_data.data.procuringEntity.address.streetAddress}
	Input Text									css=input[data-id='name']			${tender_data.data.procuringEntity.contactPoint.name}
#	Input Text									css=input[data-id='telephone']		${tender_data.data.procuringEntity.contactPoint.telephone}
	Input Text									css=input[data-id='email']			${tender_data.data.procuringEntity.contactPoint.email}
	Input Text									css=input[data-id='faxNumber']		${tender_data.data.procuringEntity.contactPoint.faxNumber}
	Input Text									css=input[data-id='url']			${tender_data.data.procuringEntity.contactPoint.url}

	Scroll Page To Element						css=button[data-id='actSave']
	Click Button								css=button[data-id='actSave']
	Close Confirmation							Данные успешно сохранены

#step general
	Mark Step									step 1
	Click Element								css=#tab_1
	Додати lots									${lots}

#step lots/items
	Mark Step									step 2
	Додати items								${items}
	Click Button								css=button[data-id='actSave']
	Close Confirmation							Данные успешно сохранены

#step features
	Mark Step									step 3
	Click Element								css=#tab_2
	${features_count} = 						Get Length	${features}
	Run Keyword If		${features_count} > 0	Додати features	${features}
	Click Button								css=button[data-id='actSave']
	Close Confirmation							Данные успешно сохранены

#step docs
	Mark Step									step 4
	${this_section_necessity} = 				Run keyword and return status	Dictionary Should Contain Key	${tender_data.data}	documents
	Click Element								css=#tab_3
	Wait For Ajax
	Wait Until Element Is Visible				css=button[data-id='actNextStep']	timeout=10
	Run Keyword If	${this_section_necessity}	Добавить document				${tender_data.data}
		...	ELSE								Click Button					css=button[data-id='actNextStep']

#step budget
	Mark Step									step 5
	Click Element								css=#tab_4
	Заповнити date+amount						${tender_data.data}
	Click Button								css=button[data-id='actSave']
	Close Confirmation							Данные успешно сохранены

#step publication
	Mark Step									step 6
	Click Element								css=#tab_5
	Wait For Ajax
	Wait Until Element Is Visible				css=button[data-id='actSend']
	Click Button								css=button[data-id='actSend']
	Close Confirmation							Закупка поставлена в очередь на отправку в ProZorro. Статус закупки Вы можете отслеживать в личном кабинете.
	Wait For Ajax
	Wait Until Element Is Visible				css=div#tenderStatus
	${temp_id} = 								Отримати інформацію з tenderID	inner
	Mark Step									Tender_inner_id: ${temp_id}
	Go To										${USERS.users['${username}'].homepage}?utm_source=direct#/${temp_id}
	Wait For Element With Reload				xpath=//div[@id='tenderId' and contains(.,'UA')]	1	7
	${temp_id} = 								Отримати інформацію з tenderID	ua
	Mark Step									Tender_ua_id: ${temp_id}
	[return]	${temp_id}


Додати lots
	[Arguments]  ${lots}
	${lots_count} = 			Get Length	${lots}
	Return From Keyword If		${lots_count} == 0
	:FOR    ${lot}    IN    @{lots}
	\    Wait For Ajax
	\    Click button											css=button[ng-click='model.addLot()']
	\    Wait Until Element Is Enabled							css=input[data-id='title']	10s
	\    Input Text		css=input[data-id='title']				${lot.title}
	\    Input Text		css=textarea[data-id='description']		${lot.description}
	\    ${value_amount} = 			Convert to String			${lot.value.amount}
	\    ${minimalStep_amount} = 	Convert to String			${lot.minimalStep.amount}
	\    Input Text		css=input[data-id='valueAmount']		${value_amount}
	\    Sleep			1s
	\    Input Text		css=input[data-id='minimalStepAmount']	${minimalStep_amount}
	\    Sleep			1s
	\    Input Text		css=input[data-id='guaranteeAmount']	1


Додати items
	[Arguments]  ${items}
	${items_count} = 			Get Length	${items}

	:FOR    ${item}    IN    @{items}
	\    Click button													css=button[ng-click='model.addItem(lot)']
	\    Wait Until Element Is Enabled									css=input[ng-model='item.description']	10s
	\    Input Text			css=input[ng-model='item.description']		${item.description}
	\    Input Text			css=input[data-id='quantity']				${item.quantity}
	\    ${unit} = 			get_unit_ru_name							${item.unit.name}
	\    Mark Step			choose_unit_${unit}
	\    Click Element		xpath=//select[@data-id='unit']/option[text()='${unit}']
	\    Input Text			css=input[data-id='postalCode']				${item.deliveryAddress.postalCode}
	\    Input Text			css=input[data-id='countryName']			${item.deliveryAddress.countryName}
	\    Input Text			css=input[data-id='region']					${item.deliveryAddress.region}
	\    Input Text			css=input[data-id='locality']				${item.deliveryAddress.locality}
	\    Input Text			css=input[data-id='streetAddress']			${item.deliveryAddress.streetAddress}
	\    Set Date		css=input[ng-model='item.deliveryDate.ed.d']	${item.deliveryDate.endDate}


Додати features
	[Arguments]  ${features}
	${features_count} = 		Get Length	${features}
	Wait For Ajax
	@{actExpand_btn_list} = 	Get Webelements	css=button[data-id='actExpand']
	:FOR    ${ELEMENT}    IN    @{actExpand_btn_list}
	\    Wait Until Element Is Visible	${ELEMENT}	${COMMONWAIT}
	\    Click button	${ELEMENT}
	\    @{actExpand_btn_list} = 	Get Webelements	css=button[data-id='actExpand']

	:FOR    ${feature}    IN    @{features}
	\    Click Button						xpath=//button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']
	\    Wait For Ajax
	\    Wait Until Element Is Visible		xpath=//section[div[button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']]]//button[@ng-bind='transl.addCriterion']
	\    Click Button						xpath=//section[div[button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']]]//button[@ng-bind='transl.addCriterion']
	\    Wait Until Element Is Visible		xpath=//section[div[button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']]]//input[@ng-model='feature.title']
	\    Input Text							xpath=//section[div[button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']]]//input[@ng-model='feature.title']				${feature.title}
	\    Input Text							xpath=//section[div[button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']]]//textarea[@ng-model='feature.description']	${feature.description}
	\    Додати criterion	${feature}


Додати criterion
	[Arguments]  ${feature}
	@{criterion_value_list} = 		Get Webelements			xpath=//section[div[button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']]]//input[@ng-model='criterion.value']
	@{criterion_title_list} = 		Get Webelements			xpath=//section[div[button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']]]//input[@ng-model='criterion.title']
	@{criterions_data} = 			Get From Dictionary		${feature}	enum
	${criterions_data_length} = 	Get Length	${criterions_data}
	: FOR    ${index}    IN RANGE    0    ${criterions_data_length}
	\    ${value} = 		Evaluate	${criterions_data[${index}].value}*100
	\    ${value} = 		Convert To String	${value}
	\    Input Text			${criterion_title_list[${index}]}	${criterions_data[${index}].title}
	\    Run Keyword Unless	${value} == 0	Input Text	${criterion_value_list[${index}]}	${value}
	Click button		xpath=//section[div[button[contains(@ng-click,'${feature.featureOf}') and @data-id='actAdd']]]//button[@data-id='actCollapse']


Заповнити date+amount
	[Arguments]  ${tender_data}
	Run Keyword If     ${tender_data.value.valueAddedTaxIncluded}	Select From List By Value	css=select[data-id='ptrValueAddedTaxIncluded']	0
		...	ELSE	Select From List By Value	css=select[data-id='ptrValueAddedTaxIncluded']	1

	Set Date And Time		css=input[ng-model='model.ptr.enquiryPeriod.sd.d']	css=timepicker-pop[input-time='model.ptr.enquiryPeriod.sd.t'] input[ng-model='inputTime']	${tender_data.enquiryPeriod.startDate}
	Set Date And Time		css=input[ng-model='model.ptr.enquiryPeriod.ed.d']	css=timepicker-pop[input-time='model.ptr.enquiryPeriod.ed.t'] input[ng-model='inputTime']	${tender_data.enquiryPeriod.endDate}
	Set Date And Time		css=input[ng-model='model.ptr.tenderPeriod.sd.d']	css=timepicker-pop[input-time='model.ptr.tenderPeriod.sd.t'] input[ng-model='inputTime']	${tender_data.tenderPeriod.startDate}
	Set Date And Time		css=input[ng-model='model.ptr.tenderPeriod.ed.d']	css=timepicker-pop[input-time='model.ptr.tenderPeriod.ed.t'] input[ng-model='inputTime']	${tender_data.tenderPeriod.endDate}
	Set Date And Time		css=input[ng-model='model.ptr.awardPeriod.ed.d']	css=timepicker-pop[input-time='model.ptr.awardPeriod.ed.t'] input[ng-model='inputTime']		${tender_data.tenderPeriod.endDate}


Внести зміни в тендер
	[Arguments]  ${username}  ${tender_id}  ${field_name}  ${field_value}
	Wait Until Element Is Visible	css=button[ng-click='commonActions.createAfp()']	timeout=${COMMONWAIT}
	Click Button					css=button[ng-click='commonActions.createAfp()']
	#TODO till we have a problem with saving of expired but old data
	Run Keyword						Змінити ${field_name}	${field_value}
	Click Button					css=button[data-id='actSave']
	Close Confirmation				Данные успешно сохранены


Змінити лот
	[Arguments]  ${username}  ${tender_id}  ${lot_id}  ${field_name}  ${field_value}
#	Wait Until Element Is Visible	css=button[ng-click='act.createAfp()']	timeout=${COMMONWAIT}
#	Click Button					css=button[ng-click='act.createAfp()']
#	Wait For Ajax
	Змінити поле ${field_name}
	Click Button					css=button[data-id='actSave']
	Close Confirmation				Данные успешно сохранены


Змінити поле value.amount
	[Arguments]  ${username}  ${tender_id}  ${lot_id}  ${field_name}  ${field_value}
	Wait Until Element Is Visible	css=span[ng-bind='model.ptr.value.amount | accounting:2']	timeout=${COMMONWAIT}
	Wait Until Element Is Visible	id=tab_1	timeout=${COMMONWAIT}
	Click Element					id=tab_1
	Click button					xpath=//div[contains(., '${lot_id}')]//button[@ng-click='lot.expanded = true']
	Wait Until Element Is Visible	css=input[data-id='valueAmount']	timeout=${COMMONWAIT}
	Clear Element Text				css=input[data-id='valueAmount']
	Input Text						css=input[data-id='valueAmount']		${field_value}


Змінити поле minimalStep.amount
	[Arguments]  ${username}  ${tender_id}  ${lot_id}  ${field_name}  ${field_value}
	Wait Until Element Is Visible	css=input[data-id='minimalStepAmount']	timeout=${COMMONWAIT}
	Clear Element Text				css=input[data-id='minimalStepAmount']
	Input Text						css=input[data-id='minimalStepAmount']	${field_value}


Створити лот із предметом закупівлі
	[Arguments]  ${username}  ${tender_id}  ${lot}  ${item}
	Додати lots	${lot}
	Додати items	${item}


Додати предмет закупівлі в лот
	[Arguments]  @{Args}
	Wait Until Element Is Visible	css=button[ng-click='act.createAfp()']	timeout=${COMMONWAIT}
	Click Button					css=button[ng-click='act.createAfp()']
	Wait For Ajax
	Wait Until Element Is Visible	css=span[ng-bind='model.ptr.value.amount | accounting:2']	timeout=${COMMONWAIT}
	Wait Until Element Is Visible	id=tab_1	timeout=${COMMONWAIT}
	Click Element					id=tab_1


Змінити tenderPeriod.endDate
	[Arguments]  ${field_value}
	Wait For Ajax
	Wait Visibulity And Click Element	id=tab_4
	Set Date And Time		css=input[ng-model='model.ptr.tenderPeriod.ed.d']	css=timepicker-pop[input-time='model.ptr.tenderPeriod.ed.t'] input[ng-model='inputTime']	${field_value}


Можливість змінити поле value.amount
	[Arguments]  @{field_value}
	debug     поле value.amount

Завантажити документ
	[Arguments]  ${user}  ${document}  ${tenderUaId}
	Wait For Ajax
	Wait Until Element Is Enabled	css=button[ng-click='commonActions.createAfp()']	timeout=${COMMONWAIT}
	Click Button					css=button[ng-click='commonActions.createAfp()']
	Wait For Ajax
	Wait Until Element Is Enabled	id=tab_3	timeout=${COMMONWAIT}
	Click Element					id=tab_3
	Wait For Ajax
	Wait Until Element Is Visible	xpath=//select[@data-id='vfv']	timeout=${COMMONWAIT}

	#doc type is for tender
	Select From List By Value		xpath=//select[@data-id='vfv']	0
	Choose File						css=input[type='file']	${document}
	sleep							3s
	Wait Until Element Is Visible	css=a[data-id='actGetDocument']			timeout=${COMMONWAIT}

	Click Button								css=button[data-id='actSave']
	Close Confirmation							Данные успешно сохранены
	[return]  ${document}


Завантажити документ в лот
	[Arguments]  ${user}  ${document}  ${tender_id}  ${lot_id}
	#start work with lot
	Click button					xpath=//div[@ng-show='!lot.expanded' and contains(., '${lot_id}')]//button[@data-id='actExpand']
	#doc type is for tender
	#TODO  dell next step when the bug with file type will be fixed
	Select From List By Value		xpath=//select[@data-id='vfv']	0
	Select From List By Value		xpath=//div[@ng-show='lot.expanded' and contains(., '${lot_id}')]//select[@ng-model='lot.currentVfv']	0

	Execute Javascript				$("div[ng-show='lot.expanded'] input[type='file']").css('display', '')
	Choose File						xpath=//div[@ng-show='lot.expanded' and contains(., '${lot_id}')]//input[@type='file']	${document}
	sleep							3s
	Wait Until Element Is Visible	xpath=//div[@ng-show='lot.expanded' and contains(., '${lot_id}')]//a[@data-id='actGetDocument']	timeout=${COMMONWAIT}

	Click Button					css=button[data-id='actSave']
	Close Confirmation				Данные успешно сохранены
	Click Element					css=a[data-id='goBack']

	[return]  ${document}


Оновити сторінку з тендером
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  tenderId
	Reload Page
	Wait For Ajax
	Switch To Frame		id=tenders

	${is_in_tender_data} = 	Run Keyword And Return Status	Wait Until Element Is Visible	css=div#tenderStatus	5s
	Run Keyword Unless	${is_in_tender_data}	Return From Keyword

	Відкрити інформацію по лотах
	Відкрити детальну інформацію по позиціям


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

	Mark Step								before search
	Wait For Tender							${ARGUMENTS[1]}	${education_type}
	sleep									2s
	Click Element							css=tr[id='${ARGUMENTS[1]}']

	sleep									2s
	Switch To Frame							id=tenders
	Wait Until Element Is Not Visible		css=input#search-query-input	20s
	Wait Until Element Is Visible			css=div#tenderStatus	timeout=${COMMONWAIT}
	Wait Until Element Not Stale			${tender_data_title}	40

	Chose interface language				uk
	Відкрити інформацію по лотах
	Відкрити детальну інформацію по позиціям


Відкрити детальну інформацію по позиціям
	Wait For Ajax
	Wait Until Element Is Visible						xpath=//a[@ng-click='adb.showCl = !adb.showCl;']	${COMMONWAIT}
	@{description_btn_list} = 	Get Webelements			xpath=//a[@ng-click='adb.showCl = !adb.showCl;']
	${items_count} = 			Get Length				${description_btn_list}
	${items_count} = 			Evaluate				${items_count}+1
	: FOR    ${index}    IN RANGE    1    ${items_count}
	\    Відкрити детальну інформацію про позицію	${index}


Відкрити детальну інформацію про позицію
	[Arguments]  ${index}
	${locator} = 						Set Variable			xpath=(//a[@ng-click='adb.showCl = !adb.showCl;'])[${index}]
	Wait Until Element Is Visible		${locator}
	${element_class} =					Get Element Attribute	${locator}@class
	Run Keyword If	'checked-item' in '${element_class}'		Return From Keyword
	Sleep								1s
	Mark Step							show extra info
	Scroll Page To Element				${locator}
	Wait Until Element Not Stale		${locator}	10
	Click Element	${locator}
	Wait Until Element Is Visible		xpath=(//div[@ng-if='adb.classification'])[${index}]	timeout=10


Відкрити потрібну інформацію по тендеру
	[Arguments]  ${field}
	Wait Until Element Is Visible	${tender_data_title}	timeout=${COMMONWAIT}

	#switch to correct tab
	${tab_num} =	Set Variable If
		...  'questions' in '${field}'	2
		...  'complaint' in '${field}'	3
		...  1
	Switch To Tab	${tab_num}
	Sleep			1s


Chose interface language
	[Arguments]  ${language}
	${status} =	Run Keyword And Return Status	Element Should Be Visible	css=a#lang_${language}
	Run Keyword If	${status}					Click Element	css=a#lang_${language}
	Wait Until Element Is Visible				css=span#lang_${language}	${COMMONWAIT}


Відкрити інформацію по лотах
	Wait For Ajax
	Wait Until Element Is Visible	xpath=//a[contains(@ng-click, 'description')]	${COMMONWAIT}
	@{description_btn_list} = 	Get Webelements			xpath=//a[contains(@ng-click, 'description')]
	${items_count} = 			Get Length				${description_btn_list}
	${items_count} = 			Evaluate				${items_count}+1
	: FOR    ${index}    IN RANGE    1    ${items_count}
	\    Scroll Page To Element							xpath=(//a[contains(@ng-click, 'description')])[${index}]
	\    ${attribute} =	Get Element Attribute			xpath=(//a[contains(@ng-click, 'description')])[${index}]/..@class
	\    Mark Step										checked-nav_${index}
	\    Return From Keyword If							'checked-nav' in '${attribute}'
	\    Mark Step										after checked-nav_${index}
	\    Click Element									xpath=(//a[contains(@ng-click, 'description')])[${index}]
	\    Wait For Ajax
	\    ${is_multilot} =								Run Keyword And Return Status	Element Should Be Visible	xpath=//a[@ng-click='lot.shwFull = !lot.shwFull']
	\    Run Keyword Unless								${is_multilot}	Return From Keyword
	\    Wait Until Element Is Visible					xpath=(//a[@ng-click='lot.shwFull = !lot.shwFull'])[${index}]	timeout=${COMMONWAIT}
	\    ${attribute} =	Get Element Attribute			xpath=(//a[@ng-click='lot.shwFull = !lot.shwFull'])[${index}]@id
	\    Run Keyword If	'showMore' in '${attribute}'	Click Element	xpath=(//a[@ng-click='lot.shwFull = !lot.shwFull'])[${index}]


Отримати положення предмету
	[Arguments]  ${item_id}
	Run Keyword If		'add_item' in ${TEST_TAGS} and 'Можливість додати' in '${PREV TEST NAME}'		Wait Until Keyword Succeeds	2min	10s	Check Condition With Reload	1	${item_id}
		...	ELSE IF		'add_lot' in ${TEST_TAGS} and 'Можливість додати' in '${PREV TEST NAME}'		Wait Until Keyword Succeeds	2min	10s	Check Condition With Reload	1	${item_id}

	${tender_data} = 							Execute Javascript	return angular.element("#tenderId").scope().model.ad;

	${item_num}	${lot_num}	${lots_count} = 	get_lot_num_by_item	${tender_data}	${item_id}
	${item_num} = 								get_item_num		${tender_data}	${item_id}
	Mark Step									${item_id} - ${item_num} - ${lot_num}
	[return]  ${item_num}  ${lot_num}


Отримати інформацію із предмету
	[Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${element}
	Mark Step	${username} - ${tender_uaid} - ${item_id} - ${element}

	${status} =	Run Keyword And Return Status   Wait Until Element Is Visible   xpath=//a[@ng-click='adb.showCl = !adb.showCl;' and contains(., '${item_id}')]  3
	Run Keyword If	'${status}' == 'False'		Wait For Element With Reload	xpath=//a[@ng-click='adb.showCl = !adb.showCl;' and contains(., '${item_id}')]	1

	${item}	${lot} =	Отримати положення предмету		${item_id}
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
	[Return]  ${result}


Отримати інформацію із нецінового показника
	[Arguments]  ${username}  ${tender_uaid}  ${feature_id}  ${field_name}
	Відкрити потрібну інформацію по тендеру	${field_name}
	${is_feature_visible} = 	Run Keyword And Return Status	Element Should Be Visible	xpath=//div[@name='featureName' and contains(., '${feature_id}')]
	Run Keyword If	${is_feature_visible} == ${FALSE}	Wait For Element With Reload		xpath=//div[@name='featureName' and contains(., '${feature_id}')]  1


	${result} = 	Run Keyword If	'${field_name}' == 'title'	Get Text									xpath=//div[@name='featureName' and contains(., '${feature_id}')]
		...	ELSE IF		'${field_name}' == 'description'		Отримати інформацію з feature.description	${feature_id}
		...	ELSE IF		'${field_name}' == 'featureOf'			Отримати інформацію з featureOf				${feature_id}
		...	ELSE		There is no such feature parameter.

	${result} =		Convert To String	${result}
	${result} =		Replace String		${result}	.:	.
	${result} =		Strip String		${result}
	[Return]  ${result}


Отримати інформацію із тендера
	[Arguments]  ${username}  ${tender_ua_id}  ${element}
	Відкрити потрібну інформацію по тендеру	${element}

	Run Keyword And Return If	'${element}' == 'value.amount'					Отримати сумму			${element}
	Run Keyword And Return If	'${element}' == 'enquiryPeriod.startDate'		Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'enquiryPeriod.endDate'			Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'tenderPeriod.startDate'		Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'tenderPeriod.endDate'			Отримати дату та час	${element}
	Run Keyword And Return If	'${element}' == 'bids'							Перевірити присутність bids
	Run Keyword And Return If	'${element}' == 'value.currency'				Отримати інформацію з value.currency					${element}
	Run Keyword And Return If	'${element}' == 'value.valueAddedTaxIncluded'	Отримати інформацію про включення ПДВ					${element}
	Run Keyword And Return If	'${element}' == 'status'						Отримати інформацію з status							${element}
	Run Keyword And Return If	'${element}' == 'causeDescription'				Отримати інформацію з causeDescription					${element}
	Run Keyword And Return If	'${element}' == 'minimalStep.amount'			Отримати сумму											${element}
	Run Keyword And Return If	'${element}' == 'title_en'						Отримати інформацію з елемента зі зміною локалізації	${element}	0	en
	Run Keyword And Return If	'${element}' == 'title_ru'						Отримати інформацію з елемента зі зміною локалізації	${element}	0	ru
	Run Keyword And Return If	'${element}' == 'description_en'				Отримати інформацію з елемента зі зміною локалізації	${element}	0	en
	Run Keyword And Return If	'${element}' == 'description_ru'				Отримати інформацію з елемента зі зміною локалізації	${element}	0	ru
	Run Keyword And Return If	'${element}' == 'auctionPeriod.startDate'		Отримати інформацію з auctionPeriod.startDate			${element}
	Run Keyword And Return If	'${element}' == 'procurementMethodType'			Отримати інформацію з procurementMethodType				${element}
	Run Keyword And Return If	'${element}' == 'cancellations[0].status'		Отримати інформацію з cancellations[0].status			${element}
	Run Keyword And Return If	'${element}' == 'cause'							Отримати інформацію з cause								${element}

	Run Keyword And Return If	'${element}' == 'lots.value.amount'							Отримати сумму										${element}
	Run Keyword And Return If	'${element}' == 'causeDescription'							Отримати інформацію з causeDescription				${element}
	Run Keyword And Return If	'${element}' == 'awards[0].status'							Отримати інформацію з awards[0].status				${element}
	Run Keyword And Return If	'${element}' == 'awards[0].value.currency'					Отримати інформацію з awards[0].value.currency		${element}
	Run Keyword And Return If	'${element}' == 'awards[0].value.amount'					Отримати інформацію з awards[0].value.amount		${element}	0
	Run Keyword And Return If	'${element}' == 'awards[0].documents[0].title'				Отримати інформацію з awards[0].documents[0].title	${element}
	Run Keyword And Return If	'${element}' == 'awards[0].value.valueAddedTaxIncluded'		Отримати інформацію про включення ПДВ				${element}
	Run Keyword And Return If	'${element}' == 'contracts[0].status'						Отримати інформацію з contracts[0].status			${element}
	Run Keyword And Return If	'${element}' == 'awards[0].suppliers[0].name'				Отримати інформацію з awards[0].suppliers[0].name	${element}


	Run Keyword If		'add_tender_doc' in ${TEST_TAGS}		Wait For Element With Reload	${tender_data_documents[0].title}	1

	Wait Until Element Is Visible	${tender_data_${element}}	timeout=${COMMONWAIT}
	${result_full} =				Get Text	${tender_data_${element}}
	${result} =						Strip String	${result_full}
	[return]	${result}


Отримати інформацію із лоту
	[Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${element}
	Відкрити потрібну інформацію по тендеру	${element}
	${element_for_work} = 	Convert To String	lots.${element}
	${element_for_work} = 	Set variable		xpath=//section[contains(@class, 'lot-description') and contains(., '${object_id}')]//${tender_data_${element_for_work}}
	${tender_data} = 		Execute Javascript	return angular.element("#tenderId").scope().model.ad;

	Run Keyword If	'add_lot' in ${TEST_TAGS}		Wait Until Keyword Succeeds	2min	10s		Check Condition With Reload	1	${object_id}
		...	ELSE IF		'delete_lot' in ${TEST_TAGS}	Wait Until Keyword Succeeds	2min	10s	Check Condition With Reload	1	${object_id}

	Run Keyword And Return If	'${element}' == 'value.amount'						Отримати сумму								${element_for_work}
	Run Keyword And Return If	'${element}' == 'value.valueAddedTaxIncluded'		Отримати інформацію про включення ПДВ		${element_for_work}
	Run Keyword And Return If	'${element}' == 'value.currency'					Отримати інформацію з value.currency		${element_for_work}
	Run Keyword And Return If	'${element}' == 'minimalStep.amount'				Отримати сумму								${element_for_work}
	Run Keyword And Return If	'${element}' == 'minimalStep.currency'				Отримати інформацію з value.currency		${element_for_work}
	Run Keyword And Return If	'${element}' == 'minimalStep.valueAddedTaxIncluded'	Отримати інформацію про включення ПДВ		${element_for_work}

	Wait Until Element Is Visible	${element_for_work}	timeout=${COMMONWAIT}
	${result_full} =				Get Text	${element_for_work}
	${result} =						Strip String	${result_full}

	[return]	${result}


Отримати інформацію із запитання
	[Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
	${questions_type} = 	Set Variable If
		...  'лот' in '${TEST_NAME}'			lot_or_item
		...  'предмет' in '${TEST_NAME}'		lot_or_item
		...  questions
	Відкрити потрібну інформацію по тендеру		${questions_type}

	Run Keyword And Return If	'${questions_type}' == 'lot_or_item'		Отримати інформацію із запитання на лот або предмет	${field_name}

	${element_for_work} = 	Set Variable If
		...  '${field_name}' == 'title'			xpath=//div[@class='question-head title' and contains(.,'${object_id}')]/span
		...  '${field_name}' == 'answer'		xpath=//div[contains(.,'${object_id}')]/following-sibling::div/div[@ng-bind-html='q.answer']
		...  '${field_name}' == 'date'			xpath=//div[@class = 'question-head title' and contains(., '${object_id}')]/b[2]
		...  '${field_name}' == 'description'	xpath=//div[contains(.,'${object_id}')]/following-sibling::div[@ng-bind-html='q.description']
		...  ${field_name}

	Run Keyword And Return If	'${field_name}' == 'date'	Отримати дату та час	${element_for_work}

	Wait For Element With Reload	${element_for_work}	2
	Wait Until Element Is Visible	${element_for_work}	timeout=${COMMONWAIT}
	${result_full} =				Get Text			${element_for_work}
	${result} =						Strip String		${result_full}
	[return]	${result}


Отримати інформацію із запитання на лот або предмет
	[Arguments]  ${field_name}
	Wait Until Element Is Visible		css=a[ng-click="act.checkThis(lot, 'lot-faq')"]	timeout=10
	Wait Until Element Is Enabled		css=a[ng-click="act.checkThis(lot, 'lot-faq')"]	timeout=10

	${locator} = 						Set Variable	css=li[ng-class="{'checked-nav':lot.showTab == 'lot-faq'}"]
	${element_class} =					Get Element Attribute	${locator}@class

	Run Keyword If	'simple-nav_item active ng-scope checked-nav' != '${element_class}'	Click Element	css=a[ng-click="act.checkThis(lot, 'lot-faq')"]

	${element_for_work} = 	Set Variable If
		...  '${field_name}' == 'title'			css=.lot-info .question-title
		...  ${field_name}

	Wait Until Element Is Visible	${element_for_work}	timeout=${COMMONWAIT}
	${result_full} =				Get Text			${element_for_work}
	${result} =						Strip String		${result_full}
	[return]	${result}


Отримати інформацію із скарги
	[Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${field_name}  ${award_index}
	Відкрити потрібну інформацію по тендеру	complaint
	Дочекатися статусу вимоги				${complaintID}  ${TEST_NAME}

	${element_for_work} = 	Set Variable If
		...  '${field_name}' == 'title'				xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//span[contains(@class, 'claimHead')]
		...  '${field_name}' == 'description'		xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//div[@ng-bind-html='q.description']
		...  '${field_name}' == 'answer'			xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//div[@class ='question-head title']/span
		...  '${field_name}' == 'data'				xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//div[@class ='question-head title']/b[2]
		...  '${field_name}' == 'complaintID'		xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//span[@id='cmpl0']
		...  '${field_name}' == 'status'			xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//span[@id='cmplStatus0']
		...  '${field_name}' == 'resolutionType'	xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//div[@class='qa-title']
		...  '${field_name}' == 'resolution'		xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//div[contains(@class, 'qa-body')]
		...  '${field_name}' == 'satisfied'			xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//span[@id='cmplStatus0']

	Wait For Element With Reload	${element_for_work}	3
	Wait Until Element Is Visible	${element_for_work}	timeout=${COMMONWAIT}

	Run Keyword And Return If	'${field_name}' == 'date'			Отримати дату та час				${element_for_work}
	Run Keyword And Return If	'${field_name}' == 'status'			Отримати complaint.status			${element_for_work}
	Run Keyword And Return If	'${field_name}' == 'resolutionType'	Отримати complaint.resolutionType	${element_for_work}
	Run Keyword And Return If	'${field_name}' == 'satisfied'		Отримати complaint.satisfied		${element_for_work}

	${result_full} = 			Get Text	${element_for_work}
	${result_full} = 			Replace String	${result_full}	, id:	${EMPTY}
	${result} = 				Strip String	${result_full}
	Mark Step					result=${result}

	[return]	${result}


Отримати інформацію із пропозиції
	[Arguments]  ${username}  ${tenderUA_id}  ${element}
	Run Keyword And Return If	'${element}' == 'lotValues[0].value.amount'		Отримати сумму	${element}
	Run Keyword And Return If	'${element}' == 'status'						Отримати bid.status


Отримати bid.status
	Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td[4 and contains(., 'Недійсна')]	1	3	3
	${status} = 	Get Text		xpath=//table[@class='bids']//tr[1]/td[4]
	${status} = 	Set Variable If	'Недійсна' in '${status}'	invalid	wrong status
	[return]	${status}


Дочекатися статусу вимоги
	[Arguments]  ${complaintID}  ${test_name}
	${test_name} =	Replace String	${test_name}	\'	${EMPTY}

	${status} = 	Set Variable If
		...  'незадоволення вимоги' in '${test_name}'	Не вирiшена, обробляється
		...  'задоволення вимоги' in '${test_name}'		Вирiшена
		...  'cancelled' in '${test_name}'				Скасована
		...  'pending' in '${test_name}'				Не вирiшена, обробляється
		...  'поданого статусу' in '${test_name}'		Вiдправлено
		...  'resolved' in '${test_name}'				Вирiшена
		...  'answered' in '${test_name}'				Отримано вiдповiдь
		...  'was called' in '${test_name}'				Вiдмiнено
		...  ${None}

	Return From Keyword If	'${status}' != '${None}'	Wait For Element With Reload	xpath=//div[@class='faq ng-scope' and contains(., '${complaintID}')]//span[contains(., '${status}')]	3
	[return]	${True}


Отримати complaint.status
	[Arguments]  ${element}
	${result_full} = 	Get Text	${element}
	${result} = 	Set Variable If
		...  '${result_full}' == 'Вiдправлено'					claim
		...  '${result_full}' == 'Вирiшена'						resolved
		...  '${result_full}' == 'Отримано вiдповiдь'			answered
		...  '${result_full}' == 'Вiдмiнено'					was called
		...  '${result_full}' == 'Скасована'					cancelled
		...  '${result_full}' == 'Не вирiшена, обробляється'	pending
		...  ${result_full}

	[return]	${result}


Отримати complaint.resolutionType
	[Arguments]  ${element}
	${result_full} = 	Get Text	${element}
	${result} = 	Set Variable If
		...  '${result_full}' == 'Резолюція'	resolved
		...  ${result_full}

	[return]	${result}


Отримати complaint.satisfied
	[Arguments]  ${element}
	${result_full} = 	Get Text	${element}
	${result} = 	Set Variable If
		...  '${result_full}' == 'Не вирiшена, обробляється'	${false}
		...  '${result_full}' == 'Вирiшена'	${true}
		...  ${result_full}

	[return]	${result}


Отримати поле документації до скарги
	[Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${given_value}  ${field_name}  ${award_index}
	Відкрити потрібну інформацію по тендеру	complaint

	${element_for_work} = 	Set Variable If
		...  '${field_name}' == 'title'	xpath=//div[contains(., '${complaintID}')]//span[contains(@class, 'file-name')]

	#get doc title
	${is_element_visible} = 	Run Keyword And Return Status	Element Should Be Visible	${element_for_work}
	Run Keyword If	'${field_name}' == 'title' and ${is_element_visible} == ${False}	Click Element	xpath=//div[contains(., '${complaintID}')]//a[@ng-click='q.showFiles = !q.showFiles']

	Wait Until Element Is Visible	${element_for_work}	timeout=${COMMONWAIT}
	${result_full} =	Get Text	${element_for_work}
	${result} =			Strip String	${result_full}
	[return]  ${result}


Отримати текст елемента
	[Arguments]  ${element_name}  ${item}=${1}
	${index} = 					Evaluate	${item}-1
	${temp_name} = 					Remove String	${element_name}	'
	${selector} = 	Set Variable If
		...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'	${element_name}
		...  ${tender_data_${element_name}}

	Wait Until Element Is Visible	${selector}
	@{itemsList}=					Get Webelements	${selector}
	${result_full} =				Get Text		${itemsList[${index}]}
	${result_full} =				Strip String	${result_full}
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
	${value}=	Отримати текст елемента	${element_name}
	${value}=	Replace String		${value}	${SPACE}	${EMPTY}
	${value}=	Replace String		${value}	грн			${EMPTY}
	${result}=	Convert To Number	${value}
	${result}=	Evaluate			round(${value}, 2)
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
	${value_added_tax_included} =	Отримати текст елемента	${element_name}
	${result} =	Set Variable If	'з ПДВ' in '${value_added_tax_included}'	${True}	${False}
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


Отримати інформацію з cancellations[0].status
	[Arguments]  ${element}
	${text} =	Отримати текст елемента  ${element}
	${result} =	Set Variable If	'Відмінено' in '${text}'	active	${text}
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
	${text} =		Отримати текст елемента	${element}	${item}
	${newText} =	Get Regexp Matches		${text}	: (\\d.*\\d)	1
	${result} = 	Convert To String  ${newText[0]}
	[return]	${result}


Отримати інформацію з items.addClassifications.[0].scheme
	[Arguments]  ${element}  ${item}
	${text} =			Отримати текст елемента	${element}	${item}
	${newText} =		Get Regexp Matches		${text}		Классификатор (.*):	1
	${convertText} = 	Convert To String		${newText[0]}
	${result} =			get_classification_type	${convertText}
	[return]	${result}


Отримати інформацію з causeDescription
	[Arguments]  ${element}  ${item}=${0}
	Wait Enable And Click Element			css=#tenderType>div
	${text} =	Отримати текст елемента		${element}				${item}
	${text} =	Replace String				${text}					Опис:	${EMPTY}
	${text} =	Strip String				${text}
	[return]	${text}


Отримати інформацію з cause
	[Arguments]  ${element}  ${item}=${0}
	${text} =	Отримати текст елемента		${element}	${item}
	${cause_type} =	Set Variable If
		...  'Закупівля творів' in '${text}'				artContestIP
		...  'Відсутність конкуренції' in '${text}'			noCompetition
		...  'Нагальна потреба' in '${text}'				quick
		...  'двічі відмінено тендер' in '${text}'			twiceUnsuccessful
		...  'додаткову закупівлю' in '${text}'				additionalPurchase
		...  'додаткових будівельних робіт' in '${text}'	additionalConstruction
		...  'Закупівля юридичних послуг' in '${text}'		stateLegalServices
	[return]	${cause_type}


Отримати інформацію з елемента зі зміною локалізації
	[Arguments]  ${element}  ${item}  ${localization}
	Chose interface language			${localization}
	Wait Until Element Is Enabled		css=#tenderType								timeout=${COMMONWAIT}
	Click Element						css=#tenderType
	Run Keyword If	${item} > 0			Click Element	xpath=//div[@class='nav-tab']//li[1]/a
	Run Keyword If	${item} > 0			Відкрити детальну інформацію про позицію	${item}
	${text} =							Отримати текст елемента  ${element}
	${result} =			Strip String	${text}

	Chose interface language			uk
	Відкрити інформацію по лотах
	Відкрити детальну інформацію по позиціям
	[return]	${result}


Отримати інформацію з tenderID
	[Arguments]  ${id_type}
	${element_text} = 					Get Text	${tender_data_tenderID}
	${reg_expresion} =	Set Variable If
		...  'ua' in '${id_type}'		${None}
		...  'inner' in '${id_type}'	([\\d]{6}) от

	Return from Keyword If		'${reg_expresion}' == '${None}'	${element_text}
	${result} =			Get Regexp Matches	${element_text}	${reg_expresion}	1
	[return]	${result[0]}


Отримати інформацію з awards[0].documents[0].title
	[Arguments]  ${element}
	Wait Enable And Click Element		css=.nav-tab li:nth-of-type(3)>a
	Click Element						${tender_data_awards[0].suppliers[0].name}
	Wait Until Element Is Visible		${tender_data_contracts[0].status}	timeout=${COMMONWAIT}
	Wait For Ajax
	${text} =							Отримати текст елемента  ${element}
	[return]	${text}


Отримати інформацію з awards[0].status
	[Arguments]  ${element}
	${text} =							Отримати текст елемента  ${element}
	${newText} =						Set Variable If	'Переможець' in '${text}'	active	${text}
	[return]	${newText}


Отримати інформацію з awards[0].value.amount
	[Arguments]  ${element}  ${position_number}
	${value}=	Отримати строку		${element}	${position_number}
	${value}=	Replace String		${value}	${SPACE}	${EMPTY}
	${result}=	Convert To Number	${value}	2
	Click Element						css=.icon-remove.pull-right
	Wait Until Element Is Not Visible	css=.icon-remove.pull-right
	[return]	${result}


Отримати інформацію з awards[0].value.currency
	[Arguments]  ${element}
	${currency} =						Отримати строку	${element}	1
	${currency_type} =					get_currency_type	${currency}
	[return]	${currency_type}


Отримати інформацію з featureOf
	[Arguments]  ${feature_id}
	${result} = 	Get Text	xpath=//div[@ng-include='page.feature' and contains(., '${feature_id}')]/ancestor::div[contains(@ng-if, 'featureOf')]

	#get featureOf identifier
	${result} =	Set Variable If
		...  'по закупке' in '${result}'	tenderer
		...  'по лоту' in '${result}'		lot
		...  'по позиции' in '${result}'	item
		...  ${result}

	[return]	${result}


Отримати інформацію з feature.description
	[Arguments]  ${feature_id}
	Click Element						xpath=//div[@ng-include='page.feature' and contains(., '${feature_id}')]//img[@id='status-tip']
	Wait Until Element Is Visible		xpath=//div[@ng-include='page.feature' and contains(., '${feature_id}')]//div[@name='featureDescription']
	${result} = 						Get Text	xpath=//div[@ng-include='page.feature' and contains(., '${feature_id}')]//div[@name='featureDescription']
	Click Element						xpath=//div[@ng-include='page.feature' and contains(., '${feature_id}')]//img[@id='status-tip']
	Wait Until Element Is Not Visible	xpath=//div[@ng-include='page.feature' and contains(., '${feature_id}')]//div[@name='featureDescription']

	[return]	${result}


Отримати інформацію з awards[0].suppliers[0].name
	[Arguments]  ${element}
	Click Element						css=.icon-remove.pull-right
	Wait Until Element Is Not Visible	css=.icon-remove.pull-right
	${text} =							Отримати текст елемента  ${element}
	Click Element						${tender_data_awards[0].suppliers[0].name}
	Wait Until Element Is Visible		${tender_data_contracts[0].status}	timeout=${COMMONWAIT}
	Wait For Ajax
	[return]	${text}


Отримати інформацію з contracts[0].status
	[Arguments]  ${element}
	Run Keyword If	'статусу підписаної' in '${TEST_NAME}'		sleep	120s
	Reload And Switch To Tab	1
	${locator} = 						Set Variable			css=.nav-tab li:nth-of-type(3)
	${element_class} =					Get Element Attribute	${locator}@class
	Run Keyword Unless	'checked-nav' in '${element_class}'		Wait Enable And Click Element		css=.nav-tab li:nth-of-type(3)>a
	Wait Enable And Click Element		${tender_data_awards[0].suppliers[0].name}
	Wait Until Element Is Visible		${tender_data_contracts[0].status}	timeout=${COMMONWAIT}
	${text} =		Отримати текст елемента  ${element}
	${result} =		Set Variable If
		...  'Очiкує пiдписання' in '${text}'	pending
		...  'Підписаний' in '${text}'			active
	[return]	${result}


Створити вимогу про виправлення умов закупівлі
	[Arguments]  ${user}  ${tender_id}  ${complaints}  ${document}
	Відкрити потрібну інформацію по тендеру	complaint
	Wait Enable And Click Element		css=button#btnSendClaim
	Заповнити форму вимоги				${user}  ${complaints}  ${document}

	${claim_id} = 						Get Text		css=span#cmpl0
	${claim_id} = 						Replace String	${claim_id}	, id:	${EMPTY}
	${claim_id} =						Strip String	${claim_id}	mode=both
	Sleep								5s
	[return]  ${claim_id}


Створити вимогу про виправлення умов лоту
	[Arguments]    ${user}  ${tender_id}  ${claim}  ${lot_id}  ${document}
#	Обрати потрібний лот за id			${lot_id}
	Wait Enable And Click Element		css=a[ng-click='act.showComplaintLot(lot.id)']
	Заповнити форму вимоги	${user}  ${claim}  ${document}
	Відкрити потрібну інформацію по тендеру	complaint
	${claim_id} = 						Get Text		css=span#cmpl0
	${claim_id} = 						Replace String	${claim_id}	, id:	${EMPTY}
	${claim_id} =						Strip String	${claim_id}	mode=both
	Sleep								5s
	[return]  ${claim_id}


Заповнити форму вимоги
	[Arguments]  ${user}  ${complaints}  ${document}
	Wait For Ajax
	Wait For Element Value				css=input[ng-model='model.person.phone']
	Wait Until Element Is Visible		xpath=//input[@ng-model='model.complaint.user.title']	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled		xpath=//input[@ng-model='model.complaint.user.title']	timeout=${COMMONWAIT}
	Input Text							xpath=//input[@ng-model='model.complaint.user.title']	${complaints.data.title}
	Input Text							css=div.info-item-val textarea							${complaints.data.description}
	Scroll Page To Element				xpath=//input[@ng-model='model.person.email']
	Input Text							xpath=//input[@ng-model='model.person.email']			${USERS.users['${user}'].email}
	Завантажити документ до вимоги		${document}
	Click Button						css=button[ng-click='act.sendComplaint()']
	Wait For Ajax
	Wait Until Element Is Enabled		css=div.alert-info	timeout=${COMMONWAIT}
	Wait Until Element Not Stale		css=div.alert-info	40
	Wait Until Element Contains			css=div.alert-info	Ваша вимога успішно відправлена!	timeout=10
	Wait Until Element Not Stale		css=span[ng-click='act.hideModal()']	40
	Click Element						css=span[ng-click='act.hideModal()']
	Wait Until Element Is Not Visible	xpath=//input[@ng-model='model.question.title']	timeout=20


Завантажити документ до вимоги
	[Arguments]  ${document}
	${correctFilePath} = 				Replace String	${document}	\\	\/
	Execute Javascript					$("#fileToUpload").removeClass();
	Choose File							css=input#fileToUpload	${correctFilePath}
	sleep								5s
	Wait Until Element Is Visible		css=div.file-item
	[return]  ${document}


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
	Wait Until Element Contains			css=span#cmplStatus0	Скасована	timeout=${COMMONWAIT}


Підтвердити вирішення вимоги про виправлення умов лоту
	[Arguments]    ${user}  ${tender_id}  ${complaintID}  ${confirmation_data}
	Підтвердити вирішення вимоги	${user}	${tender_id}	${complaintID}	${confirmation_data}


Підтвердити вирішення вимоги про виправлення умов закупівлі
	[Arguments]    ${user}  ${tender_id}  ${complaintID}  ${confirmation_data}
	Підтвердити вирішення вимоги	${user}	${tender_id}	${complaintID}	${confirmation_data}


Підтвердити вирішення вимоги
	[Arguments]    ${user}  ${tender_id}  ${complaintID}  ${confirmation_data}
	Click Element						xpath=//div[contains(@ng-repeat, 'model.ad.complaints') and contains(., '${complaintID}')]//button[contains(@class, 'btn-success')]
	Wait For Ajax
	Wait Until Element Is Visible		css=h4.ng-binding	${COMMONWAIT}
	Wait Until Element Contains			css=h4.ng-binding	Ваша вимога була задоволена	${COMMONWAIT}
	Scroll Page To Element				css=h4.ng-binding
	Wait Visibulity And Click Element	xpath=//button[@ng-click='act.hideMsg()']
	Wait Until Element Is Not Visible	xpath=//button[@ng-click='act.hideMsg()']	${COMMONWAIT}


Задати запитання на тендер
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
	Wait For Element Value				css=input[ng-model='model.person.phone']
	Wait Until Element Not Stale		xpath=//input[@ng-model="model.question.title"]	40
	Wait Until Element Is Visible		xpath=//input[@ng-model="model.question.title"]				timeout=10
	Wait Until Element Is Enabled		xpath=//input[@ng-model="model.question.title"]				timeout=10
	Input text							xpath=//input[@ng-model="model.question.title"]				${title}
	Input text							xpath=//textarea[@ng-model='model.question.description']	${description}
	Input text							xpath=//input[@ng-model='model.person.email']				${email}
	Click Button						xpath=//button[@ng-click='act.sendQuestion()']
	Wait For Notification				Ваше запитання успішно включено до черги на відправку. Дякуємо за звернення!
	Wait Until Element Not Stale		css=span[ng-click='act.hideModal()']	40
	Click Element						css=span[ng-click='act.hideModal()']
	Wait Until Element Is Not Visible	xpath=//input[@ng-model='model.question.title']	timeout=20
	#wait for synchronization
	Sleep								150s


Задати запитання на лот
	[Arguments]  ${provider}  ${tender_id}  ${lot_id}  ${question}
	#Обрати потрібний лот за id	${lot_id}
	privatmarket.Пошук тендера по ідентифікатору	${provider}	${tender_id}
	Wait Enable And Click Element	xpath=//section[contains(@class, 'lot-description') and contains(., '${lot_id}')]//li[2]/a
	Wait Enable And Click Element	css=button[ng-click='act.sendLotEnquiry(lot.id)']
	Заповнити форму питання			${question.data.title}	${question.data.description}	${USERS.users['${provider}'].email}
	[return]  True


Задати запитання на предмет
	[Arguments]  ${provider}  ${tender_id}  ${item_id}  ${question}
	Mark Step	${provider} - ${tender_id} - ${item_id} - ${question}
	privatmarket.Пошук тендера по ідентифікатору	${provider}	${tender_id}
	${item}	${lot} =	Отримати положення предмету		${item_id}
	Відкрити детальну інформацію про позицію	${item}
	Wait Enable And Click Element	xpath=(//a[@ng-click='act.sendItemEnquiry(adb.id)'])[${item}]
	Заповнити форму питання			${question.data.title}	${question.data.description}	${USERS.users['${provider}'].email}
	[return]  True


Перетворити вимогу про виправлення умов закупівлі в скаргу
	[Arguments]  ${provider}  ${tender_id}  ${complaint_id}  ${escalation_data}
	privatmarket.Перетворити вимогу в скаргу	${provider}	${tender_id}


Перетворити вимогу про виправлення умов лоту в скаргу
	[Arguments]  ${provider}  ${tender_id}  ${complaint_id}  ${escalation_data}
	privatmarket.Перетворити вимогу в скаргу	${provider}	${tender_id}


Перетворити вимогу в скаргу
	[Arguments]  ${provider}  ${tender_id}
	privatmarket.Пошук тендера по ідентифікатору	${provider}	${tender_id}
	Wait For Ajax
	Wait For Element With Reload		css=button[ng-click='act.setComplaintResolved(q, false)']	3
	Wait Enable And Click Element		css=button[ng-click='act.setComplaintResolved(q, false)']
	Close Formatted Confirmation	Ваша вимога була успішно переведена в звернення. Чекайте наступного рішення!


Скасувати вимогу про виправлення умов закупівлі
	[Arguments]  ${provider}  ${tender_id}  ${complaint_id}  ${cancellation_data}
	privatmarket.Пошук тендера по ідентифікатору	${provider}	${tender_id}
	Wait For Ajax
	Switch To Tab						3
	privatmarket.Скасувати вимогу  ${provider}  ${tender_id}  ${complaint_id}  ${cancellation_data}


Скасувати вимогу про виправлення умов лоту
	[Arguments]  ${provider}  ${tender_id}  ${complaint_id}  ${cancellation_data}
	privatmarket.Пошук тендера по ідентифікатору	${provider}	${tender_id}
	Wait For Ajax
	Switch To Tab						3
	privatmarket.Скасувати вимогу  ${provider}  ${tender_id}  ${complaint_id}  ${cancellation_data}


Подати цінову пропозицію
	[Arguments]  ${username}  ${tender_id}  ${bid}  ${lots_ids}=${None}  ${features_ids}=${None}

	Run Keyword If	'без нецінових показників' in '${TEST_NAME}'	Fail  Така ситуація не може виникнути
	Run Keyword If	'без прив’язки до лоту' in '${TEST_NAME}'		Fail  Така ситуація не може виникнути

	Відкрити заявку
	Run Keyword If	${lots_ids} != ${None}	Заповнити форму заявки по лотах	${bid}	${lots_ids}
		...  ELSE	Заповнити форму заявки по предмету	${bid}

	Wait Enable And Click Element	css=button[ng-click='commonActions.goNext(1)']
	Wait Until Element Contains	css=div#afpPanel	Крок 2/3
	Click Button				css=button[ng-click='commonActions.goNext(1)']

	#Just for aboveThreshold tests
	Wait Until Element Contains	css=div#afpPanel	Крок 3/3
	Run Keyword If	'open' in '${SUITE_NAME}'	Run Keywords	Click element	css=input#chkSelfQualified
	...   AND   Click element	css=input#chkSelfEligible

	Wait Until Element Is Visible		css=div[ng-if='model.afp.tsdId===0&&model.afp.id']						3s
	${claim_id} = 						Get text			css=div[ng-if='model.afp.tsdId===0&&model.afp.id']
	${result} = 						Get Regexp Matches	${claim_id}	(\\d*), створена	1
	Set to dictionary					${bid.data}		id=${result}

	sleep								1s
	Click Button						${locator_tenderClaim.buttonSend}
	Wait For Ajax Overflow Vanish
	Close Formatted Confirmation		Ваша заявка була успішно включена до черги на відправку!

	Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td[4 and contains(., 'Відправлена')]	1	3	3
	[return]	${bid}


Заповнити форму заявки по лотах
	[Arguments]  ${bid}  ${lots_ids}
	${lots_ids_length} = 	Get Length	${lots_ids}
	: FOR    ${index}    IN RANGE    0    ${lots_ids_length}
	\    ${amount} = 	Convert To String		${bid.data.lotValues[${index}].value.amount}
	\    Input Text		xpath=//div[contains(@class, 'lot-info') and contains(.,'${lots_ids[${index}]}')]//input[contains(@class,'inputUserPrice')]	${amount}


Заповнити форму заявки по предмету
	[Arguments]  ${bid}
	${amount} = 	Convert To String		${bid.data.value.amount}
	Input Text	${locator_tenderClaim.fieldPrice}	${amount}


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
	Wait For Ajax
	Wait Until Element Contains			css=div#afpPanel	Крок 1/3


Змінити цінову пропозицію
	[Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
	Відкрити заявку
	Run Keyword 						Змінити ${fieldname}	${fieldvalue}

	#send request to update the bid
	Click Button						${locator_tenderClaim.buttonSend}
	Wait For Ajax Overflow Vanish

	${test_name} =	Convert To Lowercase	${TEST_NAME}
	Run Keyword If	'оновити статус цінової пропозиції' in '${test_name}'	Close Formatted Confirmation	Ваша заявка була успішно включена до черги на відправку!
		...  ELSE	Close Formatted Confirmation	Ваша заявка була успішно збережена!

	#check whether task was send
	Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td[4 and contains(., 'Відправлена')]	1	3	3

	[return]	${fieldname}


Змінити lotValues[0].value.amount
	[Arguments]  ${fieldvalue}
	#choose corret bid.tab
	Wait Enable And Click Element	css=button[ng-click='commonActions.goNext(1)']
	Wait Until Element Contains		css=div#afpPanel	Крок 2/3

	${fieldvalue} = 	Convert To String			${fieldvalue}
	Wait Until Element Is Enabled					xpath=//div[contains(@class, 'lot-info') and contains(.,'0')]//input[contains(@class,'inputUserPrice')]	${COMMONWAIT}
	Clear Element Text								xpath=//div[contains(@class, 'lot-info') and contains(.,'0')]//input[contains(@class,'inputUserPrice')]
	Input Text										xpath=//div[contains(@class, 'lot-info') and contains(.,'0')]//input[contains(@class,'inputUserPrice')]	${fieldvalue}

	#move to the very last step
	Click Button				css=button[ng-click='commonActions.goNext(1)']
	Wait Until Element Contains	css=div#afpPanel	Крок 3/3


Змінити value.amount
	[Arguments]  ${fieldvalue}
	Clear Element Text								${locator_tenderClaim.fieldPrice}
	Input Text	${locator_tenderClaim.fieldPrice}	${fieldvalue}


Змінити status
	[Arguments]  ${fieldvalue}
	#лише клікаємо зберегти, нічого не змінюючи
	Wait Enable And Click Element	css=button[ng-click='commonActions.goNext(1)']
	Wait Until Element Contains		css=div#afpPanel	Крок 2/3
	#move to the very last step
	Click Button					css=button[ng-click='commonActions.goNext(1)']
	Wait Until Element Contains		css=div#afpPanel	Крок 3/3


Скасувати цінову пропозицію
	[Arguments]  ${username}  ${tender_uaid}
	Відкрити заявку

	Wait Enable And Click Element		css=a[ng-click='act.delAfp()']
	Close Formatted Confirmation		Вашау заявку успішно скасовано!
	[return]	${ARGUMENTS[1]}


Отримати пропозицію
	[Arguments]  ${username}  ${tender_uaid}
	Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td[4 and contains(., 'Недействительная')]	1
	${button_of_send_claim_text} =	Get text	${locator_tenderClaim.buttonCreate}
	${status} =						Set Variable	invalid
	${bid} =						get_bid_data	${status}
	[return]	${bid}


Завантажити документ в ставку
	[Arguments]  ${user}  ${filePath}  ${tenderId}  ${doc_type}=documents
	Відкрити заявку

	Wait Until Element Is Enabled		css=div[ng-if='model.canAddFiles']	${COMMONWAIT}
	Click Element						xpath=(//div[@ng-if='model.canAddFiles']//a)[1]

	#choose file
	Execute Javascript					$("#afpFile").removeClass();
	Choose File							css=#afpFile	${filePath}
	Wait For Ajax

	Заповнити інформацію про файл	${doc_type}

	${upload_response} =				Зберегти доданий файл	${filePath}
	[return]	${upload_response}


Заповнити інформацію про файл
	[Arguments]  ${doc_type}
	${doc_name} =	get_doc_identifier	${doc_type}
	#choose file type
	Click Element						css=div.btn-group a[data-toggle="dropdown"]
	Wait Enable And Click Element		xpath=//li[contains(., '${doc_name}')]

	#choose file language
	Click Element						css=a.lang
	Wait Enable And Click Element		xpath=(//li[@ng-click='act.setFileLang(lang)'])[2]

	#add file
	Click Button						css=button[ng-click='file.addFile();']
	Wait For Ajax
	Wait Until Element Is Visible		css=i[ng-if="model.canAddFiles"]


Зберегти доданий файл
	[Arguments]  ${filePath}
	Wait Enable And Click Element		css=button[ng-click='commonActions.goNext(1)']
	Wait Until Element Contains			css=div#afpPanel	Крок 2/3
	Click Button						css=button[ng-click='commonActions.goNext(1)']
	Wait Until Element Contains			css=div#afpPanel	Крок 3/3

	Click Button						${locator_tenderClaim.buttonSend}
	Wait For Ajax Overflow Vanish
	Close Formatted Confirmation		Ваша заявка була успішно збережена!

	Wait For Element With Reload		xpath=//table[@class='bids']//tr[1]/td//img[contains(@src,'clip_icon.png')]	1	3	3
	Click Element						xpath=//table[@class='bids']//tr[1]/td//img[contains(@src,'clip_icon.png')]
	Wait For Ajax
	Wait Until Element Is Visible		css=div.modal.fade.in	${COMMONWAIT}
	${dateModified}						Get text	css=span.file-tlm

	#get file link and it's id
	Wait Until Element Is Enabled		xpath=(//div[@ng-click='openUrl(file.url)'])[last()]	5s
	${url} = 							Execute Javascript	var scope = angular.element($("div[ng-click='openUrl(file.url)']")).last().scope(); return scope.file.url
	${uploaded_file_data} =				fill_file_data  ${url}  ${filePath}  ${dateModified}  ${dateModified}
	${upload_response} = 				Create Dictionary

	#close window of bid info
	Set To Dictionary					${upload_response}	upload_response	${uploaded_file_data}
	Click Element						css=span[ng-click='act.hideModal()']
	Wait Until Element Is Not Visible	css=div[ng-if='model.canAddFiles']	${COMMONWAIT}
	[return]	${upload_response}


Змінити документ в ставці
	[Arguments]  ${user}  ${tenderId}  ${filePath}  ${docid}  ${doc_type}=documents
	Відкрити заявку
	#choose file
	Execute Javascript					$("#changeFile").removeClass();
	Choose File							css=#changeFile	${filePath}
	Wait For Ajax

	Заповнити інформацію про файл	${doc_type}
	${uploaded_file_data} =				Зберегти доданий файл	${filePath}
	[return]  ${uploaded_file_data}


Змінити документацію в ставці
	[Arguments]  ${username}  ${tender_id}  ${privat_doc}  ${doc_id}
	Відкрити заявку

	Run Keyword					Змінити ${privat_doc.data.confidentiality} для файлу	${privat_doc}
	${uploaded_file_data} =		Зберегти доданий файл	${doc_id}
	[return]  ${True}


Змінити buyerOnly для файлу
	[Arguments]  ${privat_doc}
	Click Element					xpath=(//i[@ng-if='model.canSecretFiles'])[last()]
	Wait For Ajax
	Wait Until Element Is Enabled	css=textarea[ng-model='model.fvHideReason']
	Input Text						css=textarea[ng-model='model.fvHideReason']		${privat_doc.data.confidentialityRationale}
	Click Button					xpath=//button[contains(@ng-click,'act.setFvHidden')]
	Wait For Notification			Файл був успішно прихований!


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
	Input Text							css=#p24__login__field		+${USERS.users['${username}'].login}
	Check If Element Stale				xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']
	Input Text							xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']	${USERS.users['${username}'].password}
	Click Element						xpath=//div[@id="login_modal" and @style='display: block;']//button[@type='submit']
	Wait Until Element Is Visible		css=ul.user-menu  timeout=30
	Wait For Ajax
	Sleep								5s
	Wait Until Element Is Visible		css=a[data-target='#select_cabinet']  timeout=${COMMONWAIT}


Wait For Ajax
	sleep				2s
	Wait For Condition	return window.jQuery!=undefined && jQuery.active==0	60s


Wait Until Element Not Stale
	[Arguments]  ${locator}  ${time}
	sleep 			2s
	${time} = 	Convert To Integer	${time}
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
	Wait Until Element Is Visible		css=p.ng-binding							${COMMONWAIT}
	Wait Until Element Contains			css=p.ng-binding							${confirmation_text}	${COMMONWAIT}
	Wait For Ajax
	Wait Until Element Is Enabled		xpath=//button[@ng-click='close()']			${COMMONWAIT}
	Click Button						xpath=//button[@ng-click='close()']
	Sleep								2s
	Wait Until Element Is Not Visible	xpath=//button[@ng-click='close()']	${COMMONWAIT}


Close Formatted Confirmation
	[Arguments]	${confirmation_text}
	Wait For Ajax
	Wait For Ajax Overflow Vanish
	Wait Until Element Contains			css=.modal.fade.in h4	${confirmation_text}	${COMMONWAIT}
	Wait Enable And Click Element		css=#btnClose
	Wait Until Element Is Not Visible	css=#btnClose
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
	[Arguments]	${element_locator}
	${locator}  ${type} = 	Get Locator And Type	${element_locator}
	${js_expresion} =	Set Variable If	'css' == '${type}'	window.$("${locator}")[0].scrollIntoView()
		...  						'xpath' == '${type}'	document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView()
	Execute Javascript	${js_expresion}
	Wait For Ajax


Get Locator And Type
	[Arguments]	${full_locator}
	${temp_locator} = 	Replace String	${full_locator}	'	${EMPTY}
	${locator} = 	Run Keyword If	'css' in '${temp_locator}'	Get Substring	${full_locator}	4
		...   ELSE IF	'xpath' in '${temp_locator}'	Get Substring	${full_locator}	6
		...   ELSE		${full_locator}

	${type} =	Set Variable If	'css' in '${temp_locator}'	css
		...  	'xpath' in '${temp_locator}'	xpath
		...  	None
	[return]  ${locator}  ${type}


Wait For Tender
	[Arguments]	${tender_id}  ${education_type}
	Mark Step  in_Wait For Tender
	Wait Until Keyword Succeeds	6min	10s	Try Search Tender	${tender_id}	${education_type}


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
	Wait Until Element Not Stale		xpath=//tr[@ng-repeat='t in model.tenderList']	${COMMONWAIT}
	Wait Until Element Is Enabled		xpath=//tr[@ng-repeat='t in model.tenderList']	timeout=${COMMONWAIT}


Reload And Switch To Tab
	[Arguments]  ${tab_number}  ${lot_tab_num}=1
	Mark Step					in_reload
	Reload Page
	Wait For Ajax
	Switch To Frame		id=tenders
	Відкрити інформацію по лотах
	Відкрити детальну інформацію по позиціям
	Run Keyword If	'${tab_number}' != '0'	Switch To Tab		${tab_number}
	Run Keyword If	'${lot_tab_num}' != '0'	Switch To Lot Tab	${lot_tab_num}
	Wait For Ajax


Switch To Tab
	[Arguments]  ${tab_number}
	Wait For Ajax
	Wait Until Element Is Visible		xpath=(//ul[@class='widget-header-block']//a[contains(@ng-click,'act.setActive')])[${tab_number}]	timeout=${COMMONWAIT}
	${class} =	Get Element Attribute	xpath=(//ul[@class='widget-header-block']//a[contains(@ng-click,'act.setActive')])[${tab_number}]@class
	Run Keyword Unless	'white-icon' in '${class}'	Wait Visibulity And Click Element	xpath=(//ul[@class='widget-header-block']//a[contains(@ng-click,'act.setActive')])[${tab_number}]
	Wait For Ajax


Switch To Lot Tab
	[Arguments]  ${lot_tab_num}
	#for now there is no way to chose lot, so '${lot_tab_num}' shows the number just of the first lot
	Wait Until Element Is Visible					xpath=(//section[@id='lotSection']//ul[@class='widget-header-block']//li)[${lot_tab_num}]	timeout=${COMMONWAIT}
	${class} =	Get Element Attribute				xpath=(//section[@id='lotSection']//ul[@class='widget-header-block']//li)[${lot_tab_num}]@class
	Run Keyword Unless	'checked-nav' in '${class}'	Wait Visibulity And Click Element	xpath=(//section[@id='lotSection']//ul[@class='widget-header-block']//li)[${lot_tab_num}]


Wait For Element With Reload
	[Arguments]  ${locator}  ${tab_number}  ${time_to_wait}=3	${lot_tab_num}=0
	Mark Step					in_wait
	Wait Until Keyword Succeeds			${time_to_wait}min	1s	Try Search Element	${locator}	${tab_number}	${lot_tab_num}


Try Search Element
	[Arguments]	${locator}  ${tab_number}  ${lot_tab_num}
	Mark Step						in_search
	Reload And Switch To Tab		${tab_number}	${lot_tab_num}
	Wait For Ajax
	Wait Until Element Is Enabled	${locator}	3
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


Search By Query
	[Arguments]  ${element}  ${query}
	Input Text							${element}	${query}+
	Sleep								1s
	Press Key							${element}	\\08
	Wait Until Element Not Stale		css=input[id='found_${query}']	3
	Wait Until Element Is Enabled		css=input[id='found_${query}']	${COMMONWAIT}
	Wait Until Element Not Stale		xpath=//div[input[@id='found_${query}']]	5
	Click Element						xpath=//div[input[@id='found_${query}']]


Set Date
	[Arguments]  ${element}  ${date}
	${locator}  ${type} = 	Get Locator And Type	${element}
	${correctDate} =	Get Regexp Matches	${date}	(\\d{4}-\\d{2}-\\d{2})	1
	${correctDate} =	Convert Date		${correctDate[0]}	result_format=%d-%m-%Y
	${correctDate} =	Convert To String	${correctDate}
	${js_expresion} =	Run Keyword If	'css' == '${type}'	Convert To String	$("${locator}").datepicker('setDate', '${correctDate}')
		...  ELSE IF	'xpath' == '${type}'		Convert To String	$x("${locator}").datepicker('setDate', '${correctDate}');
	Execute Javascript	${js_expresion}


Set Time
	[Arguments]  ${element}  ${date}
	${deliveryDate} =	Get Regexp Matches	${date}	T(\\d{2}:\\d{2})	1
	Input Text	${element}	${deliveryDate[0]}


Set Date And Time
	[Arguments]  ${date_element}  ${time_element}  ${date}
	Wait Until Element Is Visible	${time_element}	timeout=${COMMONWAIT}
	Set Date	${date_element}	${date}
	Set Time	${time_element}	${date}

