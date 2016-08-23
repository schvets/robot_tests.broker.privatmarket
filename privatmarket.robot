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
${COMMONWAIT}	10


*** Keywords ***
Підготувати дані для оголошення тендера
	[Arguments]  ${username}  ${tender_data}  ${role_name}
	Run keyword if	'${role_name}' != 'tender_owner'	Return From Keyword	${tender_data}
	${tender_data.data} = 	modify_test_data	${tender_data.data}
	[return]	${tender_data}


Підготувати клієнт для користувача
	[Arguments]  ${username}
	[Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо

	${service_args} =	Create List	--ignore-ssl-errors=true	--ssl-protocol=tlsv1
	${browser} =		Convert To Lowercase	${USERS.users['${username}'].browser}

	${options}= 	Evaluate	sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
	Call Method	${options}	add_argument	--allow-running-insecure-content
	Call Method	${options}	add_argument	--disable-web-security
	Call Method	${options}	add_argument	--start-maximized
	Call Method	${options}	add_argument	--nativeEvents\=false

	Run Keyword If	'phantomjs' in '${browser}'	Run Keywords	Create Webdriver	PhantomJS	${username}	service_args=${service_args}
	...   ELSE	Create WebDriver	Chrome	chrome_options=${options}	alias=${username}
	Go To	${USERS.users['${username}'].homepage}
	Run Keyword Unless	'Viewer' in '${username}'	Login	${username}


Оновити сторінку з тендером
	[Arguments]  @{ARGUMENTS}
	Reload Page

Пошук тендера по ідентифікатору
	[Arguments]  ${user_name}  ${tender_id}
	Wait Until element Is Enabled			css=input#businessSearch		${COMMONWAIT}
	Input Text	css=input#businessSearch	${tender_id}
	Press Key	css=input#businessSearch	\\13
	Wait Until Element Is Not Visible		css=div.progress.progress-bar	${COMMONWAIT}
	Wait Until Element Is Not Visible		css=div[role='dialog']	${COMMONWAIT}
	Wait Until Element Not Stale			css=a[tid='${tender_id}']	${COMMONWAIT}
	Wait Enable And Click Element			css=a[tid='${tender_id}']
	Wait Until element Is Visible			css=span[tid='data.title']		${COMMONWAIT}


#Custom Keywords
Login
	[Arguments]  ${username}
	debug   login


Wait For Ajax
	sleep				2s
#	Wait For Condition	return window.jQuery!=undefined && jQuery.active==0	60s


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


Wait For Element Value
	[Arguments]	${locator}
	Wait For Ajax
	${cssLocator} =	Get Substring	${locator}	4
	Wait For Condition				return window.$($("${cssLocator}")).val()!='' && window.$($("${cssLocator}")).val()!='None'	${COMMONWAIT}
	${value}=	get value			${locator}
	Mark Step						_value_when_we_wait_it_${value}


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


Click element by JS
	[Arguments]	${locator}
	Execute Javascript					window.$("${locator}").mouseup()

