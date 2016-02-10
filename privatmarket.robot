*** Settings ***
Library  Selenium2Screenshots
Library  String
Library  DateTime
Library  Selenium2Library
Library  Collections
Library  DebugLibrary
Library  privatmarket_service.py

*** Variables ***
${BROWSER}		chrome
${COMMONWAIT}	20

${tender_data_title}												xpath=//div[contains(@class,'title-div')]
${tender_data_description}											css=div.description	#в наших такого нет
${tender_data_value.amount}											css=div[ng-if='model.budjet'] div.info-item-val
${tender_data_tenderID}												xpath=//div[.='Тендер ID:']/following-sibling::div
${tender_data_procuringEntity.name}									css=a[title='О компании']
${tender_data_enquiryPeriod.startDate}								xpath=(//div[@class='period ng-scope']/div[@class='info-item'])[1]
${tender_data_enquiryPeriod.endDate}								xpath=(//div[@class='period ng-scope']/div[@class='info-item'])[2]
${tender_data_tenderPeriod.startDate}								xpath=(//div[@class='period ng-scope']/div[@class='info-item'])[3]
${tender_data_tenderPeriod.endDate}									xpath=(//div[@class='period ng-scope']/div[@class='info-item'])[4]
${tender_data_minimalStep.amount}									css=div[ng-if='model.ad.minimalStep.amount'] div.info-item-val
${tender_data_items[0].description}									xpath=//section[contains(@class,'marged ')]//a
${tender_data_items[0].deliveryDate.endDate}						xpath=//div[contains(@class,'delivery-info')]//div[.='Конец:']/following-sibling::div
${tender_data_items[0].deliveryLocation.latitude}					xpath=//qw	#в наших такого нет
${tender_data_items[0].deliveryLocation.longitude}					xpath=//qw	#в наших такого нет
${tender_data_items[0].deliveryAddress.countryName}					xpath=//div[.='Адрес:']/following-sibling::div
${tender_data_items[0].deliveryAddress.postalCode}					xpath=//div[.='Адрес:']/following-sibling::div
${tender_data_items[0].deliveryAddress.region}						xpath=//div[.='Адрес:']/following-sibling::div
${tender_data_items[0].deliveryAddress.locality}					xpath=//div[.='Адрес:']/following-sibling::div
${tender_data_items[0].deliveryAddress.streetAddress}				xpath=//div[.='Адрес:']/following-sibling::div
${tender_data_items[0].classification.scheme}						xpath=//div[@ng-if="adb.classification"]
${tender_data_items[0].classification.id}							xpath=//div[@ng-if="adb.classification"]
${tender_data_items[0].classification.description}					xpath=//div[@ng-if="adb.classification"]
${tender_data_items[0].additionalClassifications[0].scheme}			xpath=//div[@ng-repeat="cl in adb.additionalClassifications"]
${tender_data_items[0].additionalClassifications[0].id}				xpath=//div[@ng-repeat="cl in adb.additionalClassifications"]
${tender_data_items[0].additionalClassifications[0].description}	xpath=//div[@ng-repeat="cl in adb.additionalClassifications"]
${tender_data_items[0].unit.name}									xpath=//div[.='Количество:']/following-sibling::div
${tender_data_items[0].unit.code}									xpath=//div[.='Количество:']/following-sibling::div
${tender_data_items[0].quantity}									xpath=//div[.='Количество:']/following-sibling::div
${tender_data_questions[0].description}								css=div.description
${tender_data_questions[0].date}									xpath=//div[@class = 'question-head title']/b[2]
${tender_data_questions[0].title}									css=div.question-head.title span
${tender_data_questions[0].answer}									css=div[ng-bind-html='q.answer']

${locator_tenderCreation.buttonEdit}	xpath=//button[@ng-click='act.createAfp()']
${locator_tenderCreation.buttonSave}	css=button.btn.btn-success
${locator_tenderCreation.buttonBack}	xpath=//a[@ng-click='act.goBack()']
${locator_tenderCreation.description}	css=textarea[ng-model='model.filterData.adbName']

${locator_tenderClaim.buttonCreate}		css=button[ng-click='act.createAfp()']
${locator_tenderClaim.fieldPrice}		xpath=//input[@ng-model='model.price']
${locator_tenderClaim.fieldEmail}		css=input[ng-model='model.person.email']
${locator_tenderClaim.buttonSend}		css=button[ng-click='act.sendAfp()']
${locator_tenderClaim.buttonRecall}		css=button[ng-click='act.retAfp()']
${locator_tenderClaim.buttonCancel}		css=button[ng-click='act.delAfp()']
${locator_tender.ajax_overflow}			xpath=//div[@class='ajax_overflow']


*** Keywords ***
Підготувати дані для оголошення тендера
	${INITIAL_TENDER_DATA} =  test_tender_data
	[return]	${INITIAL_TENDER_DATA}

Підготувати клієнт для користувача
	[Arguments]  ${username}
	log  ${username}
	[Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо
	Open Browser			${USERS.users['${username}'].homepage}   ${USERS.users['${username}'].browser}   alias=${username}
	Set Window Position		@{USERS.users['${username}'].position}
	Maximize Browser Window
	Run Keyword If	'PB_Provider' in '${username}'	Login
	Log Variables

Пошук тендера по ідентифікатору
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  tenderId
	Mark Step						_tender_search_start
	Mark Step						${ARGUMENTS[1]}

	Switch browser					${ARGUMENTS[0]}
	Go to							${USERS.users['${ARGUMENTS[0]}'].homepage}
	Switch To Frame					id=tenders
	Wait Until Element Is Enabled	xpath=//*[@id='sidebar']//input	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled	xpath=(//div[@class='tender-name_info tender-col'])[1]	timeout=${COMMONWAIT}

	${check_result}=				Run Keyword And Return Status	Element Should Contain	css=div.test-mode-aside	Войти в обучающий режим
	Run Keyword If					${check_result}	Switch To Education Mode

	Wait For Ajax
	Wait Until Element Is Enabled	xpath=(//div[@class='tenders_sm_info'])[1]	timeout=${COMMONWAIT}
	Clear Element Text				xpath=//*[@id='sidebar']//input
	sleep							1s
	Input Text						xpath=//*[@id='sidebar']//input	${ARGUMENTS[1]}
	Wait For Tender					${ARGUMENTS[1]}
	Click Element					id=${ARGUMENTS[1]}
	Wait For Ajax
	Wait Until Element Is Visible	xpath=//div[contains(@class,'title-div')]	timeout=20
	Wait Until Element Is Visible	css=div.info-item-val a
	Click Element					css=div.info-item-val a
	Mark Step						_tender_search_end

Створити тендер
	[Arguments]  @{ARGUMENTS}
	Fail  None

Отримати інформацію із тендера
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  element

	Mark Step						_set_tender_info_ + ${ARGUMENTS[1]}
	Switch browser					${ARGUMENTS[0]}
	Wait Until Element Contains		xpath=//div[contains(@class,'title-div')]	[ТЕСТУВАННЯ]	timeout=20

	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'value.amount'							Отримати число		${ARGUMENTS[1]}	0
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'minimalStep.amount'					Отримати число		${ARGUMENTS[1]}	0
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].classification.scheme'		Отримати строку		${ARGUMENTS[1]}	1
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].classification.id'			Отримати строку		${ARGUMENTS[1]}	2
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].classification.description'	Отримати класифікацію		${ARGUMENTS[1]}
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].additionalClassifications[0].scheme'				Отримати строку	${ARGUMENTS[1]}	1
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].additionalClassifications[0].id'					Отримати строку	${ARGUMENTS[1]}	2
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].additionalClassifications[0].description'		Отримати класифікацію	${ARGUMENTS[1]}
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].unit.name'					Отримати строку		${ARGUMENTS[1]}	1
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].quantity'					Отримати ціле число	${ARGUMENTS[1]}	0

	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].deliveryAddress.postalCode'		Отримати частину адреси	${ARGUMENTS[1]}	0
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].deliveryAddress.countryName'		Отримати частину адреси	${ARGUMENTS[1]}	1
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].deliveryAddress.region'			Отримати частину адреси	${ARGUMENTS[1]}	2
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].deliveryAddress.locality'		Отримати частину адреси	${ARGUMENTS[1]}	3
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].deliveryAddress.streetAddress'	Отримати частину адреси	${ARGUMENTS[1]}	4

	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'enquiryPeriod.startDate'	Отримати дату та час	${ARGUMENTS[1]}	1
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'enquiryPeriod.endDate'	Отримати дату та час	${ARGUMENTS[1]}	1
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'tenderPeriod.startDate'	Отримати дату та час	${ARGUMENTS[1]}	1
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'tenderPeriod.endDate'		Отримати дату та час	${ARGUMENTS[1]}	1
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'questions[0].date'		Отримати дату та час	${ARGUMENTS[1]}	0
	Run Keyword And Return If	'${ARGUMENTS[1]}' == 'items[0].deliveryDate.endDate'	Отримати дату та час	${ARGUMENTS[1]}	0

	Run Keyword If	'${ARGUMENTS[1]}' == 'questions[0].title'	Wait For Element With Reload	${tender_data_${ARGUMENTS[1]}}	2
	Run Keyword If	'${ARGUMENTS[1]}' == 'questions[0].answer'	Wait For Element With Reload	${tender_data_${ARGUMENTS[1]}}	2

	Run Keyword If	'${ARGUMENTS[1]}' == 'items[0].deliveryLocation.longitude'	Fail	None
	Run Keyword If	'${ARGUMENTS[1]}' == 'items[0].deliveryLocation.latitude'	Fail	None
	Wait Until Element Is Visible				${tender_data_${ARGUMENTS[1]}}	timeout=20
	${result_full}								Get Text	${tender_data_${ARGUMENTS[1]}}
	${result}									strip_string	${result_full}
	[return]	${result}

Отримати строку
	[Arguments]  ${element_name}  ${position_number}
	Wait Until Element Is Visible	${tender_data_${element_name}}
	${result_full} =				Get Text	${tender_data_${element_name}}
	${result} =						strip_string	${result_full}
	${result} =						Replace String	${result}	,	${EMPTY}
	${result} =						Replace String	${result}	:	${EMPTY}
	${values_list} =				Split String	${result}
	[return]	${values_list[${position_number}]}

Отримати число
	[Arguments]  ${element_name}  ${position_number}
	${value}=	Отримати строку		${element_name}	${position_number}
	${result}=	Convert To Number	${value}
	[return]	${result}

Отримати ціле число
	[Arguments]  ${element_name}  ${position_number}
	${value}=	Отримати строку		${element_name}	${position_number}
	${result}=	Convert To Integer	${value}
	[return]	${result}

Отримати дату та час
	[Arguments]  ${element_name}  ${shift}
	${result_full} =	Get Text			${tender_data_${element_name}}
	${work_string} =	Replace String		${result_full}	${SPACE},${SPACE}	${SPACE}
	${work_string} =	Replace String		${result_full}	,${SPACE}	${SPACE}
	${values_list} =	Split String		${work_string}
	${day} =			Convert To String	${values_list[0 + ${shift}]}
	${month} =			get_month_number	${values_list[1 + ${shift}]}
	${year} =			Convert To String	${values_list[2 + ${shift}]}
	${time} =			Convert To String	${values_list[3 + ${shift}]}
	${result}=			Convert To String	${year}-${month}-${day} ${time}
	[return]	${result}

Отримати частину адреси
	[Arguments]  ${element_name}  ${position_number}
	Wait Until Element Is Visible	${tender_data_${element_name}}
	${result_full} =				Get Text	${tender_data_${element_name}}
	${result} =						strip_string	${result_full}
	${values_list} =				Split String	${result}		,${SPACE}
	[return]	${values_list[${position_number}]}

Отримати класифікацію
	[Arguments]  ${element_name}
	Wait Until Element Is Visible	${tender_data_${element_name}}
	${result_full} =				Get Text	${tender_data_${element_name}}
	${reg_expresion} =				Set Variable	[A-zА-Яа-яёЁЇїІіЄєҐґ\\s]+\: \\w+[\\d\\.\\-]+ ([А-Яа-яёЁЇїІіЄєҐґ\\s,]+)
	${result} =						get_reg_exp_matches	${reg_expresion}	${result_full}
	[return]	${result}

Внести зміни в тендер
	[Arguments]  @{ARGUMENTS}
	Fail  None

Завантажити документ
	[Arguments]  @{ARGUMENTS}
	Fail  None

Подати скаргу
	[Arguments]  @{ARGUMENTS}
	Fail  None

Порівняти скаргу
	[Arguments]  @{ARGUMENTS}
	Fail  None

Задати питання
	[Arguments]  @{ARGUMENTS}
	privatmarket.Пошук тендера по ідентифікатору		@{ARGUMENTS}[0]	@{ARGUMENTS}[1]
	Mark Step							_asking_question_start
	Wait For Ajax
	Mark Step							_asking_question_select_right_tab
	Switch To Tab						2
	Wait Until Element Is Enabled		xpath=//button[@ng-click='act.sendEnquiry()']				timeout=10
	Click Button						xpath=//button[@ng-click='act.sendEnquiry()']
	Mark Step							_asking_question_send
	Wait For Ajax
	Wait For Element Value				css=input[ng-model='model.person.phone']
	Wait Until Element Is Visible		xpath=//input[@ng-model="model.question.title"]				timeout=10
	Wait Until Element Is Enabled		xpath=//input[@ng-model="model.question.title"]				timeout=10
	Input text							xpath=//input[@ng-model="model.question.title"]				${ARGUMENTS[2].data.title}
	Input text							xpath=//textarea[@ng-model='model.question.description']	${ARGUMENTS[2].data.description}
	Input text							xpath=//input[@ng-model='model.person.email']				${USERS.users['${username}'].email}
	Click Button						xpath=//button[@ng-click='act.sendQuestion()']
	Mark Step							_asking_question_finished
	Wait For Ajax
	Mark Step							_asking_question_wait_for_allert
	Wait Until Element Is Enabled		xpath=//div[@class='alert-info ng-scope ng-binding']	timeout=20
	Wait Until Element Contains			xpath=//div[@class='alert-info ng-scope ng-binding']	Ваш вопрос успешно отправлен. Спасибо за обращение!	timeout=10
	Wait For Ajax
	Mark Step							_asking_question_wait_for_allert_disapeare
	sleep								3s
	Wait Until Element Is Not Visible	xpath=//input[@ng-model="model.question.title"]	timeout=20
	Mark Step							_asking_question_end

Оновити сторінку з тендером
	[Arguments]  @{ARGUMENTS}
	privatmarket.Пошук тендера по ідентифікатору		@{ARGUMENTS}[0]	@{ARGUMENTS}[1]

Подати цінову пропозицію
	[Arguments]  @{ARGUMENTS}
	Switch browser						${ARGUMENTS[0]}
	privatmarket.Пошук тендера по ідентифікатору	${ARGUMENTS[0]}   ${ARGUMENTS[1]}
	Wait For Ajax

	Mark Step							_clame_creation_start
	Wait Until Element Is Visible		css=span.state-label.ng-binding
	Mark Step							_clame_creation_get_tender_status

	${tender_status} = 					Get text	css=span.state-label.ng-binding
	Run Keyword If	'${tender_status}' == 'Период уточнений завершен'	Wait For Element With Reload		${locator_tenderClaim.buttonCreate}	1

	Wait Enable And Click Element		${locator_tenderClaim.buttonCreate}
	Wait For Ajax
	Wait For Element Value				css=input[ng-model='model.person.lastName']
	Mark Step		 					_clame_creation_wait_data_load
	sleep								2s
	Wait Until Element Is Enabled		${locator_tenderClaim.fieldPrice}	20
	Mark Step							_clame_creation_set_price
	Input Text							${locator_tenderClaim.fieldPrice}	${Arguments[2].data.value.amount}
	click element						${locator_tenderClaim.fieldEmail}
	Input Text							${locator_tenderClaim.fieldEmail}	${USERS.users['${ARGUMENTS[0]}'].login}
	click element						${locator_tenderClaim.fieldPrice}
	Mark Step							_clame_creation_send_request

	sleep								5s
	Scroll Page To Element				${locator_tenderClaim.buttonSend}
	Click Button						${locator_tenderClaim.buttonSend}
	Wait For Ajax Overflow Vanish
	Close confirmation					Ваша заявка успешно отправлена!
	Mark Step							_clame_creation_save_information
	Wait Until Element Is Visible		css=div.afp-info.ng-scope.ng-binding
	wait until element contains			css=div.afp-info.ng-scope.ng-binding	Номер заявки
	Wait For Ajax
	${clame_id}=						Get text			css=div.afp-info.ng-scope.ng-binding
	${result}=							get_reg_exp_matches	Номер заявки: (\\d*),	${clame_id}	1
	[return]	${Arguments[2]}


Змінити цінову пропозицію
	[Arguments]  @{ARGUMENTS}
	Switch browser						${ARGUMENTS[0]}
	privatmarket.Пошук тендера по ідентифікатору	${ARGUMENTS[0]}   ${ARGUMENTS[1]}
	Wait For Ajax

	Mark Step							_clame_edit_start
	Wait Enable And Click Element		${locator_tenderClaim.buttonCreate}
	Wait For Ajax
	Wait For Element Value				css=input[ng-model='model.person.lastName']
	Wait Until Element Is Enabled		${locator_tenderClaim.fieldPrice}	${COMMONWAIT}
	sleep								5s
	Input Text							${locator_tenderClaim.fieldPrice}	${ARGUMENTS[2].data.value.amount}
	Scroll Page To Element				${locator_tenderClaim.buttonSend}
	Click Button						${locator_tenderClaim.buttonSend}
	Close confirmation					Ваша заявка успешно обновлена!
	Mark Step							_clame_edit_save_information
	Wait Until Element Is Visible		css=div.afp-info.ng-scope.ng-binding
	Wait For Ajax
	${clame_id}=						Get text			css=div.afp-info.ng-scope.ng-binding
	${result}=							get_reg_exp_matches	Номер заявки: (\\d*),	${clame_id}	1
	[return]	${Arguments[2]}

Скасувати цінову пропозицію
	[Arguments]  @{ARGUMENTS}
	privatmarket.Пошук тендера по ідентифікатору	${ARGUMENTS[0]}	${ARGUMENTS[1]}
	Wait For Ajax
	Wait Enable And Click Element		${locator_tenderClaim.buttonCreate}
	Wait Enable And Click Element		${locator_tenderClaim.buttonCancel}
	Close Confirmation					Ваша заявка была отменена!
	Wait Until Element Is Enabled		${locator_tenderClaim.buttonCreate}	${COMMONWAIT}
	[return]	${ARGUMENTS[1]}


Відповісти на питання
	[Arguments]  @{ARGUMENTS}
	Fail  None

Завантажити документ в ставку
	[Arguments]  ${user}  ${filePath}  ${tenderId}
	Switch browser						${user}
	privatmarket.Пошук тендера по ідентифікатору	${user}   ${tenderId}
	Wait For Ajax

	Mark Step							_clame_creation_start
	Wait Until Element Is Visible		css=span.state-label.ng-binding
	Mark Step							_clame_creation_get_tender_status

	Wait Enable And Click Element		${locator_tenderClaim.buttonCreate}
	Wait For Ajax
	Wait For Element Value				css=input[ng-model='model.person.lastName']
	Mark Step		 					_clame_creation_wait_data_load
	sleep								2s

	Wait Until Element Is Enabled		css=button[ng-click='act.chooseFile()']	${COMMONWAIT}
	Scroll Page To Element				css=button[ng-click='act.chooseFile()']
	sleep  3s
	Mark Step							_read_file_data
	${fileContent} =					readFileContent	${filePath}
	${correctFilePath} = 				Replace String		${filePath}	\\	\/
	Mark Step							${fileContent}

	Execute Javascript	var scope = angular.element($("button[ng-click='act.chooseFile()']")).scope();
		...  var generatedFile = new File(["${fileContent}"], "${correctFilePath}.txt", {type: "application/force-download", lastModified: new Date()});
		...  scope.files[0] = generatedFile;
		...  scope.uploadFile(scope.files[0]);

	Wait Until Element Is Not Visible	css=div[ng-show='progressVisible'] div.progress-bar	timeout=30
	Sleep								3s
	Wait Until Element Is Visible		xpath=(//div[contains(@class, 'file-item')])[1]	timeout=30

Змінити документ в ставці
	[Arguments]  @{ARGUMENTS}
	Fail  None

Обробити скаргу
	[Arguments]  @{ARGUMENTS}
	Fail  None

#Custom Keywords
Login
	Click Element					xpath=//span[.='Мой кабинет']
	Wait Until Element Is Visible	id=p24__login__field	${COMMONWAIT}
	Execute Javascript				$('#p24__login__field').val(${USERS.users['${username}'].login})
	Input Text						xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']	${USERS.users['${username}'].password}
	Click Element					xpath=//div[@id="login_modal" and @style='display: block;']//button[@type='submit']
	Wait Until Element Is Visible	css=ul.user-menu  timeout=30

Wait For Ajax
	Wait For Condition	return window.jQuery!=undefined && jQuery.active==0	 ${COMMONWAIT}

Test Fail
	Capture and crop page screenshot	fail.jpg
	Mark Step							__TEST_FAIL___
	Mark Step							${TEST NAME}
	Mark Step							${TEST MESSAGE}
	debug

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

Mark Step
	[Arguments]  ${stepName}
	log to console	_
	log to console	${stepName}

Change Feild Value
	[Arguments]	${locator}	${value}
	Wait For Ajax
	${cssLocator} =	Get Substring	${locator}	4
	sleep							4s
	Wait For Condition				return window.$($("${cssLocator}")).val()!=''	${COMMONWAIT}
	Input Text						${locator}	${value}
	Mark Step						_feild_value_was_changed

Close Confirmation
	[Arguments]	${confirmation_text}
	Wait For Ajax
	sleep								3s
	Wait Until Element Is Visible		css=p.ng-binding	${COMMONWAIT}	${COMMONWAIT}
	Wait Until Element Contains			css=p.ng-binding	${confirmation_text}	${COMMONWAIT}
	sleep								2s
	Wait Visibulity And Click Element	xpath=//button[@ng-click='close()']
	Wait Until Element Is Not Visible	xpath=//button[@ng-controller='inFrameModalCtrl']	${COMMONWAIT}

Wait For Element Value
	[Arguments]	${locator}
	Wait For Ajax
	${cssLocator} =	Get Substring	${locator}	4
	Wait For Condition				return window.$($("${cssLocator}")).val()!='' && window.$($("${cssLocator}")).val()!='None'	${COMMONWAIT}
	${value}=	get value			${locator}
	Mark Step						_value_when_we_wait_it_${value}

Scroll Page To Element
	[Arguments]	${locator}
	${cssLocator} =	Get Substring	${locator}	4
	Execute JavaScript				return window.$("${cssLocator}")[0].scrollIntoView()

Wait For Tender
	[Arguments]	${tender_id}
	Wait Until Keyword Succeeds		10min	30s	Try Search Tender	${tender_id}

Try Search Tender
	[Arguments]	${tender_id}
	Click Element						xpath=//div[@class="search-aside"]/span
	Wait For Ajax Overflow Vanish
	Wait Until Element Is Enabled		id=${tender_id}	timeout=20
	[return]	true

Switch To Education Mode
	Click Element						css=div.test-mode-aside a
	Wait Until Element Contains			css=div.test-mode-aside a	Выйти из обучающего режима	10
	Wait For Ajax Overflow Vanish

Switch To Tab
	[Arguments]  ${tab_number}
	Reload Page
	Switch To Frame						 id=tenders
	Wait Visibulity And Click Element	xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]
	Wait For Ajax

Fail Clame
	Set Global Variable	${tender_clame_try}	1
	{return]	None

Wait For Element With Reload
	[Arguments]  ${locator}  ${tab_number}
	Mark Step							_i_will_wait
	Wait Until Keyword Succeeds			4min	10s	Try Search Element	${locator}	${tab_number}

Try Search Element
	[Arguments]	${locator}  ${tab_number}
	Mark Step							_i_start
	Switch To Tab						${tab_number}
	Mark Step							_i_reloaded
	Wait Until Element Is Enabled		${locator}	2
	[return]	true

Wait For Ajax Overflow Vanish
	Wait Until Element Is Not Visible	${locator_tender.ajax_overflow}	${COMMONWAIT}

#in case staleElementException
Click element by JS
	[Arguments]	${css_locator}
	Execute Javascript					return window.$("${css_locator}").click()

