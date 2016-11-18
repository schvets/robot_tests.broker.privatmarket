*** Settings ***
Library  String
Library  Selenium2Library
Library  DebugLibrary
Library  privatmarket_service.py
Library  Collections
Library  BuiltIn


*** Variables ***
${COMMONWAIT}	20

${tender_data.title}									css=span[tid='data.title']
${tender_data.description}								css=span[tid='data.description']
${tender_data.procuringEntity.name}						css=span[tid='procuringEntity.name']
${tender_data.value.amount}								css=span[tid='data.value.amount']
${tender_data.value.currency}							css=span[tid='data.value.currency']
${tender_data.value.valueAddedTaxIncluded}				css=span[tid='data.value.valueAddedTaxIncluded']
${tender_data.minimalStep.amount}						css=span[tid='data.minimalStep.amount']
${tender_data.minimalStep.currency}						css=span[tid='data.minimalStep.currency']
${tender_data.minimalStep.valueAddedTaxIncluded}		css=span[tid='data.minimalStep.valueAddedTaxIncluded']

${tender_data.auctionID}								css=p[tid='data.auctionID']
${tender_data.dgfID}									css=span[tid='data.dgfID']
${tender_data.enquiryPeriod.startDate}					css=span[tid='data.enquiryPeriod.startDate']
${tender_data.enquiryPeriod.endDate}					css=span[tid='data.enquiryPeriod.endDate']
${tender_data.tenderPeriod.startDate}					css=span[tid='data.tenderPeriod.startDate']
${tender_data.tenderPeriod.endDate}						css=span[tid='data.tenderPeriod.endDate']
${tender_data.auctionPeriod.startDate}					css=span[tid='data.auctionPeriod.startDate']
${tender_data.auctionPeriod.endDate}					css=span[tid='data.auctionPeriod.endDate']
${tender_data.eligibilityCriteria}						css=span[tid='data.eligibilityCriteria']

${tender_data.items.deliveryDate.endDate}				span[@tid='item.deliveryDate.endDate']
${tender_data.items.deliveryLocation.latitude}			span[@tid='item.deliveryLocation.latitude']
${tender_data.items.deliveryLocation.longitude}			span[@tid='item.deliveryLocation.longitude']
${tender_data.items.deliveryAddress.countryName}		span[@tid='item.deliveryAddress.countryName']
${tender_data.items.deliveryAddress.postalCode}			span[@tid='item.deliveryAddress.postalCode']
${tender_data.items.deliveryAddress.region}				span[@tid='item.deliveryAddress.region']
${tender_data.items.deliveryAddress.locality}			span[@tid='item.deliveryAddress.locality']
${tender_data.items.deliveryAddress.streetAddress}		span[@tid='item.deliveryAddress.streetAddress']
${tender_data.items.classification.scheme}				span[@tid='item.classification.scheme']
${tender_data.items.classification.id}					span[@tid='item.classification.id']
${tender_data.items.classification.description}			span[@tid='item.classification.description']
${tender_data.items.unit.name}							span[@tid='item.unit.name']
${tender_data.items.unit.code}							span[@tid='item.unit.code']
${tender_data.items.quantity}							span[@tid='item.quantity']
${tender_data.items.description}						span[@tid='item.description']

${tender_data.questions.title}							span[@tid='data.question.title']
${tender_data.questions.description}					span[@tid='data.question.description']
${tender_data.questions.date}							span[@tid='data.quesion.date']
${tender_data.questions.answer}							span[@tid='data.question.answer']

${tender_data.doc.title}								xpath=//tr[@ng-repeat='doc in docs'][1]//a
${tender_data.auction.status}							css=span[tid='data.statusName']

${tender_data.cancellations[0].status}					css=span[tid='cancellation.status']
${tender_data.cancellations[0].reason}					css=span[tid='cancellation.reason']
${tender_data.cancellation.doc.title}					css=a[tid='cancellation.doc.title']
${tender_data.cancellation.doc.description}				css=span[tid='cancellation.doc.description']


*** Keywords ***
Підготувати дані для оголошення тендера
	[Arguments]  ${username}  ${tender_data}  ${role_name}
	Run Keyword If	'${role_name}' != 'tender_owner'	Return From Keyword	${tender_data}
	${tender_data.data} = 	modify_test_data	${tender_data.data}
	[return]	${tender_data}


Підготувати клієнт для користувача
	[Arguments]  ${username}
	[Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо

	${service_args} =	Create List	--ignore-ssl-errors=true	--ssl-protocol=tlsv1
	${browser} =		Convert To Lowercase	${USERS.users['${username}'].browser}
	${disabled}			Create List				Chrome PDF Viewer
	${prefs}			Create Dictionary		download.default_directory=${OUTPUT_DIR}	plugins.plugins_disabled=${disabled}

	${options}= 	Evaluate	sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
	Call Method	${options}		add_argument	--allow-running-insecure-content
	Call Method	${options}		add_argument	--disable-web-security
	Call Method	${options}		add_argument	--start-maximized
	Call Method	${options}		add_argument	--nativeEvents\=false
	Call Method	${options}		add_experimental_option	prefs	${prefs}

	Run Keyword If	'phantomjs' in '${browser}'	Create Webdriver	PhantomJS	${username}	service_args=${service_args}
	...   ELSE	Create WebDriver	Chrome	chrome_options=${options}	alias=${username}

	Set Selenium Implicit Wait						10s
	Go To	${USERS.users['${username}'].homepage}
	Run Keyword Unless	'Viewer' in '${username}'	Login	${username}


Оновити сторінку з тендером
	[Arguments]  ${user_name}  ${tender_id}
	Switch Browser	${user_name}
	Reload Page
	Sleep	3s


Створити тендер
	[Arguments]  ${user_name}  ${tender_data}
	${items} = 	Get From Dictionary	${tender_data.data}	items
	Wait Enable And Click Element			css=#simple-dropdown
	Wait Enable And Click Element			css=a[href='#/add-lot']

	#main info
	Execute Javascript						angular.prozorroaccelerator=1440;
	Wait Until Element Is Enabled			css=input[tid='data.title']
	Input text								css=input[tid='data.title']							${tender_data.data.title}
	Input text								css=textarea[tid='data.description']				${tender_data.data.description}
	Select From List						css=select[tid='data.procurementMethodType']		string:${mode}
	Input text								css=input[tid='data.value.amount']					'${tender_data.data.value.amount}'
	Run Keyword If	'${tender_data.data.value.valueAddedTaxIncluded}' == 'True'	Click Element	css=input[tid='data.value.valueAddedTaxIncluded']
		...  ELSE	Click Element	css=input[tid='data.value.valueAddedTaxNotIncluded']
	Input text								css=input[tid='data.minimalStep.amount']			'${tender_data.data.minimalStep.amount}'
	Input text								css=input[tid='data.dgfID']							${tender_data.data.dgfID}

	#item
	Wait Until Element Is Enabled			css=input[tid='item.description']
	Input text								css=input[tid='item.description']					${items[0].description}
	Select From List						css=select[tid='item.classification.scheme']		string:${items[0].classification.scheme}

	#classification
	Input text								css=div[tid='classification'] input					${items[0].classification.id}
	Wait Until Element Is Enabled			css=ul.ui-select-choices-content
	Wait Enable And Click Element			xpath=//span[@class='ui-select-choices-row-inner' and contains(., '${items[0].classification.id}')]

	#address
	Input text								css=input[tid='item.address.countryName']			${items[0].deliveryAddress.countryName}
	Input text								css=input[tid='item.address.postalCode']			${items[0].deliveryAddress.postalCode}
	Input text								css=input[tid='item.address.region']				${items[0].deliveryAddress.region}
	Input text								css=input[tid='item.address.streetAddress']			${items[0].deliveryAddress.streetAddress}
	Input text								css=input[tid='item.address.locality']				${items[0].deliveryAddress.locality}

	#quantity
	Input text								css=input[tid='item.unit.code']						${items[0].unit.code}
	Input text								css=input[tid='item.unit.name']						${items[0].unit.name}
	Input text								css=input[tid='item.quantity']						${items[0].quantity}

	#date/time
	Set Date And Time						css=input[tid='auctionStartDate']	css=div[tid='auctionStartTime'] input[ng-model='hours']	css=div[tid='auctionStartTime'] input[ng-model='minutes']	${tender_data.data.auctionPeriod.startDate}
	Click Button							css=button[tid='btn.createlot']
	Wait Until element Is Visible			css=span[tid='data.title']		${COMMONWAIT}
	Wait For Element With Reload			css=p[tid='data.auctionID']
	${tender_id} = 							Get Text	css=p[tid='data.auctionID']
	Go To									${USERS.users['${username}'].homepage}
	Wait For Ajax
	[return]  ${tender_id}


Пошук тендера по ідентифікатору
	[Arguments]  ${user_name}  ${tender_id}
	Wait For Auction						${tender_id}
	Wait Enable And Click Element			css=a[tid='${tender_id}']
	Wait Until element Is Visible			css=span[tid='data.title']		${COMMONWAIT}


Отримати інформацію із тендера
	[Arguments]  ${user_name}  ${tender_id}  ${element}
	${element} =	Set Variable If
		...  'absence_bid' in ${TEST_TAGS} and '${element}' == 'status'		auction.${element}
		...  'tender_cancellation' in ${TEST_TAGS} and '${element}' == 'status'		auction.${element}
		...  'tender_view' in ${TEST_TAGS} and '${element}' == 'status'		auction.${element}
		...  ${element}

	Run Keyword And Return If	'${element}' == 'status'								Отримати status		${user_name}	${tender_id}
	Run Keyword And Return If	'${element}' == 'value.amount'							Отримати число							${element}
	Run Keyword And Return If	'${element}' == 'value.valueAddedTaxIncluded'			Отримати інформацію про включення ПДВ	${element}
	Run Keyword And Return If	'${element}' == 'minimalStep.amount'					Отримати число							${element}
	Run Keyword And Return If	'${element}' == 'minimalStep.valueAddedTaxIncluded'		Отримати інформацію про включення ПДВ	${element}
	Run Keyword And Return If	'${element}' == 'auction.status'						Отримати status аукціону				${element}
	Run Keyword And Return If	'${element}' == 'tender_cancellation_title'				Отримати заголовок документа			${element}


	Run Keyword If				'auctionPeriod' in '${element}'	Wait Until Keyword Succeeds	5min	3s	Check For Auction Dates
	Run Keyword And Return If	'Period.' in '${element}'								Отримати дату та час					${element}

	Wait Until Element Is Visible	${tender_data.${element}}	timeout=${COMMONWAIT}
	${result} =						Отримати текст	${element}
	[return]	${result}


Отримати інформацію із предмету
	[Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${element}
	${element} = 			Convert To String	items.${element}
	${element_for_work} = 	Set variable		xpath=//div[@ng-repeat='item in data.items' and contains(., '${item_id}')]//${tender_data.${element}}
	Wait For Element With Reload				${element_for_work}

	Run Keyword And Return If	'${element}' == 'items.deliveryDate.endDate'			Отримати дату та час			${element_for_work}
	Run Keyword And Return If	'${element}' == 'items.deliveryLocation.latitude'		Отримати число					${element_for_work}
	Run Keyword And Return If	'${element}' == 'items.deliveryLocation.longitude'		Отримати число					${element_for_work}
	Run Keyword And Return If	'${element}' == 'items.quantity'						Отримати число					${element_for_work}

	Wait Until Element Is Visible	${element_for_work}	timeout=${COMMONWAIT}
	${result} =				Отримати текст елемента		${element_for_work}
	[return]	${result}


Отримати інформацію із запитання
	[Arguments]  ${username}  ${tender_uaid}  ${questions_id}  ${element}
	${element} = 			Convert To String			questions.${element}
	${element_for_work} = 	Set variable				xpath=//div[contains(@class, 'questionsBox') and contains(., '${questions_id}')]//${tender_data.${element}}
	Wait Until Keyword Succeeds							1min	5s	Wait for question	${element_for_work}
	${result} =				Отримати текст елемента		${element_for_work}
	[return]	${result}


Wait for question
	[Arguments]  ${element}
	Reload Page
	@{open_questions}		Get Webelements	css=a.glyphicon

	:FOR    ${open_question}    IN    @{open_questions}
	\    Click Element  	${open_question}

	Wait Until Element Is Visible	${element}	2


Отримати інформацію із документа
	[Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${element}
	${element} =	Set Variable If		'скасування лоту' in '${TEST_NAME}'		cancellation.doc.${element}		doc.${element}

	Run Keyword And Return If	'${element}' == 'doc.title'		Отримати заголовок документації до лоту		${element}
	Run Keyword And Return If	'${element}' == 'cancellation.doc.title'	Отримати заголовок документа	${element}

	Wait Until Element Is Visible	${tender_data.${element}}	timeout=${COMMONWAIT}
	${result} =		Отримати текст	${element}
	[return]	${result}


Отримати заголовок документа
	[Arguments]  ${element}
	${text} =	Get Element Attribute	${tender_data.${element}}@title
	${words} =	Split String	${text}	\\
	${result} =	Get From List	${words}	-1
	[return]	${result}


Отримати заголовок документації до лоту
	[Arguments]  ${element}
	Wait For Element With Reload	css=div[ng-click='openLotDocsModal()']
	Click Element	css=div[ng-click='openLotDocsModal()']

	${result} =		Отримати заголовок документа	${element}
	[return]	${result}


Отримати текст елемента
	[Arguments]  ${element_name}
	${temp_name} = 					Remove String	${element_name}	'
	${selector} = 	Set Variable If
		...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'	${element_name}
		...  ${tender_data.${element_name}}

	Wait Until Element Is Visible	${selector}
	${result_full} =				Get Text		${selector}
	${result_full} =				Strip String	${result_full}
	[return]	${result_full}


Отримати документ
	[Arguments]  ${username}  ${tender_uaid}  ${doc_id}
	${file_name} =	Get Element Attribute	${tender_data.doc.title}@title
	${file_name} =	Replace String			${file_name}	:	-
	${file_name} =	Replace String			${file_name}	~	-
	${file_name} =	Replace String			${file_name}	\\	%5C
	Click Element							${tender_data.doc.title}
	Sleep									8s
	[return]	${file_name}


Отримати текст
	[Arguments]  ${element_name}
	${result_full} =				Get Text		${tender_data.${element_name}}
	${result} =						Strip String	${result_full}
	[return]	${result}


Отримати число
	[Arguments]  ${element_name}
	${value}=	Отримати текст елемента		${element_name}
	${result}=	Convert To Number	${value}
	[return]	${result}


Отримати дату та час
	[Arguments]  ${element_name}
	${result_full} =	Отримати текст елемента	${element_name}
	${result_full} =	Replace String			${result_full}	з${SPACE}	${EMPTY}
	${result_full} =	Replace String			${result_full}	до${SPACE}	${EMPTY}
	${result} = 		get_time_with_offset	${result_full}
	[return]	${result}


Отримати інформацію про включення ПДВ
	[Arguments]  ${element_name}
	${value_added_tax_included} =	Отримати текст елемента	${element_name}
	${result} =	Set Variable If	'з ПДВ' in '${value_added_tax_included}'	${True}	${False}
	[return]  ${result}


Отримати status
	[Arguments]  ${user_name}  ${tender_id}
	privatmarket.Оновити сторінку з тендером	${user_name}  ${tender_id}
	${active_active_period} = 	Run Keyword And Return Status	Wait Until Element Is Visible	css=div.arrow-present	5s

	${locator} = 	Set Variable If	${active_active_period}	css=div.arrow-present	css=div.arrow-future
	${status_line} = 	Get Text				${locator}
	@{list} = 			Split String			${status_line}
	${status} = 		Set Variable If	'Уточнення' in '${list[0]}'	active.enquiries
		...  	'Пропозиції' in '${list[0]}'			active.tendering
		...  	'Аукціон' in '${list[0]}'				active.auction
		...  	'Визначення переможця' in '${list[0]} ${list[1]}'	active.qualification
		...  	Anknown: ${status_line}
	[return]  ${status}


Отримати status аукціону
	[Arguments]  ${element}
	${status_name} =	Set Variable If
		...  'absence_bid' in ${TEST_TAGS}	Неуспішний лот (не відбувся аукціон)
		...  'tender_cancellation' in ${TEST_TAGS}	Скасований лот (скасовано аукціон)

	Wait Until Keyword Succeeds			3min	10s	Try Search Element With Text	${tender_data.${element}}	${status_name}
	${text} =				Отримати текст елемента		${element}
	${result} =	Set Variable If
		...  '${text}' == 'Неуспішний лот (не відбувся аукціон)'	unsuccessful
		...  '${text}' == 'Скасований лот (скасовано аукціон)'	cancelled
		...  '${text}' == 'Завершений аукціон (завершений)'	complete
		...  ${element}
	[return]  ${result}


Отримати інформацію із пропозиції
	[Arguments]  ${user_name}  ${tender_id}  ${field}
	${locator} = 	Set Variable If	'${field}' == 'value.amount'	css=span[tid='bid.value.amount']	null
	Wait For Ajax
	Wait For Element With Reload		${locator}
	${result} = 	Get Text			${locator}
	${result} = 	Convert To Number	${result}
	[return]  ${result}


Задати запитання на предмет
	[Arguments]  ${user_name}  ${tender_id}  ${item_id}  ${question_data}
	Wait Until Element Is Visible			css=input[ng-model='newQuestion.title']	${COMMONWAIT}
	Input Text								css=input[ng-model='newQuestion.title']	${question_data.data.title}
	Input Text								css=textarea[ng-model='newQuestion.text']	${question_data.data.description}

	Click Element							css=div[ng-model='newQuestion.questionOf'] span
	Wait Enable And Click Element			xpath=//span[@class='ui-select-choices-row-inner' and contains(., '${item_id}')]

	Click Button							css=button[tid='sendQuestion']
	Sleep									5s
	Wait Until Element Is Not Visible		css=div.progress.progress-bar	${COMMONWAIT}
	Wait Until Keyword Succeeds				3min	3s	Check If Question Is Uploaded	${question_data.data.title}


Check If Question Is Uploaded
	[Arguments]  ${title}
	Reload Page
	Wait For Ajax
	Wait Enable And Click Element	css=a[ng-click='hideAddFilters = !hideAddFilters']
	Wait Until Element Is Enabled	xpath=//div[@ng-repeat='item in data.items']//div[@ng-if='data.questions' and contains(., '${title}')]	3
	[return]	True


Задати запитання на тендер
	[Arguments]  ${user_name}  ${tender_id}  ${question_data}
	Wait Until Element Is Visible			css=input[ng-model='newQuestion.title']	${COMMONWAIT}
	Input Text								css=input[ng-model='newQuestion.title']	${question_data.data.title}
	Input Text								css=textarea[ng-model='newQuestion.text']	${question_data.data.description}

	Click Element							css=div[ng-model='newQuestion.questionOf'] span
	Wait Enable And Click Element			xpath=//span[@class='ui-select-choices-row-inner' and contains(., 'Загальне питання по аукціону')]

	Click Button							css=button[tid='sendQuestion']
	Sleep									5s
	Wait Until Element Is Not Visible		css=div.progress.progress-bar	${COMMONWAIT}
	Wait For Element With Reload			css=span[tid='data.quesion.date']


Відповісти на запитання
	[Arguments]  ${user_name}  ${tender_id}  ${answer}  ${question_id}
	Wait Until Element Is Visible	xpath=//div[@class='row questionsBox ng-scope' and contains(., '${question_id}')]//button[@class='btn-answer']	${COMMONWAIT}
	Click Element	xpath=//button[@class='btn-answer' and @tid='question.showAnswerBlock']
	Wait Until Element Is Visible	css=textarea[tid='data.question.answerEdit']	${COMMONWAIT}
	Input Text	css=textarea[tid='data.question.answerEdit']	${answer.data.answer}
	Click Button	css=button[tid='answerQuestion']
	Wait Until Element Is Not Visible	css=div.progress.progress-bar	${COMMONWAIT}


Подати цінову пропозицію
	[Arguments]  ${user_name}  ${tender_id}  ${bid}
	Run Keyword If	'без кваліфікації' in '${TEST NAME}'	Fail	Is not implemented yet
	#дождаться появления поля ввода ссуммы только в случае выполнения первого позитивного теста
	Run Keyword Unless	'Неможливість подати цінову' in '${TEST NAME}' or 'подати повторно цінову' in '${TEST NAME}'
		...  Wait For Element With Reload	css=input[ng-model='newbid.amount']	5
	${amount} = 						Convert To String	${bid.data.value.amount}
	Input Text							css=input[ng-model='newbid.amount']		${amount}
	Click Button						css=button[ng-click='createBid(newbid)']
	Wait Until Element Is Visible		css=div.progress.progress-bar			${COMMONWAIT}
	Wait For Ajax
	Wait Until Element Is Not Visible	css=div.progress.progress-bar			${COMMONWAIT}


Скасувати цінову пропозицію
	[Arguments]  ${user_name}  ${tender_id}  ${bid}
	Wait For Element With Reload		css=button[ng-click='deleteBid(bid)']	5
	Wait Until Element Is Visible		css=button[ng-click='deleteBid(bid)']	${COMMONWAIT}
	Click Button						css=button[ng-click='deleteBid(bid)']
	Wait Until Element Is Visible		css=div.progress.progress-bar			${COMMONWAIT}
	Wait For Ajax
	Wait Until Element Is Not Visible	css=div.progress.progress-bar			${COMMONWAIT}
	Wait Until Element Is Not Visible	css=button[ng-click='deleteBid(bid)']	${COMMONWAIT}


Змінити цінову пропозицію
	[Arguments]  ${user_name}  ${tender_id}  ${name}  ${value}
	${amount} = 						Convert To String	${value}

	Wait For Element With Reload		css=label[ng-click='showModifyBidOrSave(bid)']	5
	Wait Until Element Is Visible		css=label[ng-click='showModifyBidOrSave(bid)']	${COMMONWAIT}
	Click Element						css=label[ng-click='showModifyBidOrSave(bid)']
	Clear Element Text					css=input[tid='bid.value.newAmount']
	Input Text							css=input[tid='bid.value.newAmount']			${amount}
	Click Element						css=label[ng-click='showModifyBidOrSave(bid)']
	Wait Until Element Is Visible		css=div.progress.progress-bar					${COMMONWAIT}
	Wait For Ajax
	Wait Until Element Is Not Visible	css=div.progress.progress-bar					${COMMONWAIT}


Завантажити документ в ставку
	[Arguments]  ${user_name}  ${filepath}  ${tender_id}=${None}
	Wait Until Element Is Visible			css=label[tid='modifyDoc']		${COMMONWAIT}
	Choose File								css=input[id='modifyDocs']		${filepath}
	Wait Until Element Is Visible			css=div.progress.progress-bar	${COMMONWAIT}
	sleep									10s
	Wait For Ajax
	Wait Until Element Is Not Visible		css=div.progress.progress-bar	${COMMONWAIT}


Завантажити документ
	[Arguments]  ${user_name}  ${filepath}  ${tender_id}=${None}
	Wait Until Element Is Visible	css=span[tid='editBtn']
	Click Element	css=span[tid='editBtn']
	Wait Until Element Is Visible	css=div[tid='btn.add.docs']
	Click Element	css=div[tid='btn.add.docs']
	Wait Until Element Is Enabled	css=div[tid='btn.addFiles']	${COMMONWAIT}
	Choose File		css=input[id='fileInputPr']	${filepath}
	Wait For Ajax
	Wait Until Element Is Not Visible	css=div.progress.progress-bar	${COMMONWAIT}
	Select From List	css=select[tid='doc.type']	string:technicalSpecifications
	Wait For Ajax
	Click Element	css=button[tid='btn.addDocs']
	Wait Until Element Is Not Visible	css=button[tid='btn.addDocs']	${COMMONWAIT}
	Wait Until Element Is Visible	css=button[tid='btn.refreshlot']
	Click Element	css=button[tid='btn.refreshlot']


Завантажити ілюстрацію
	[Arguments]  ${user_name}  ${tender_id}  ${filepath}
	Wait Until Element Is Visible	css=span[tid='editBtn']	${COMMONWAIT}
	Click Element	css=span[tid='editBtn']
	Wait Until Element Is Visible	css=div[tid='btn.add.docs']
	Click Element	css=div[tid='btn.add.docs']
	Wait Until Element Is Enabled	css=div[tid='btn.addFiles']	${COMMONWAIT}
	Choose File		css=input[id='fileInputPr']	${filepath}
	Wait For Ajax
	Wait Until Element Is Not Visible	css=div.progress.progress-bar	${COMMONWAIT}
	Select From List	xpath=(//select[@tid='doc.type'])[2]	string:illustration
	Wait For Ajax
	Click Element	css=button[tid='btn.addDocs']
	Wait Until Element Is Not Visible	css=button[tid='btn.addDocs']	${COMMONWAIT}
	Wait Until Element Is Visible	css=button[tid='btn.refreshlot']
	Click Element	css=button[tid='btn.refreshlot']


Додати Virtual Data Room
	[Arguments]  ${user_name}  ${tender_id}  ${filepath}
	Fail    Is not implemented


Змінити документ в ставці
	[Arguments]  ${user_name}  ${tender_id}  ${filepath}  ${bidid}
	privatmarket.Завантажити документ в ставку	${user_name}	${filepath}


Отримати посилання на аукціон для учасника
	[Arguments]  ${user_name}  ${tender_id}
	Wait For Element With Reload			xpath=//div[@ng-if='data.auctionUrl']/a[contains(@href, 'https://auction-sandbox.ea.openprocurement.org')]	5
	${url} = 	Get Element Attribute		xpath=//div[@ng-if='data.auctionUrl']/a[contains(@href, 'https://auction-sandbox.ea.openprocurement.org')]@href
	[return]  ${url}


Отримати посилання на аукціон для глядача
	[Arguments]  ${user_name}  ${tender_id}  ${lot_id}=1
	${url} = 	privatmarket.Отримати посилання на аукціон для учасника	${user_name}	${tender_id}
	[return]  ${url}


Підтвердити постачальника
	[Arguments]  ${user_name}  ${tender_id}  ${award_num}
	Wait For Element With Reload			css=button[ng-click='confirmAward(award)']
	${buttons_list} = 	Get Webelements		css=button[ng-click='confirmAward(award)']
	Click Button							${buttons_list[${award_num}]}
	Wait For Ajax


Підтвердити підписання контракту
	[Arguments]  ${username}  ${tender_uaid}  ${contract_num}
	Wait For Element With Reload			css=button[tid='contractActivate']

	Wait Until Element Is Visible			css=label[tid='docContract']	${COMMONWAIT}
	${file_path}  ${file_name}  ${file_content} = 	create_fake_doc
	Choose File								css=input[id='docsContractI']	${file_path}
	Wait Until Element Is Visible			css=div.progress.progress-bar	${COMMONWAIT}
	sleep									10s
	Wait For Ajax
	Wait Until Element Is Not Visible		css=div.progress.progress-bar	${COMMONWAIT}

	Wait Until Element Is Enabled			css=button[tid='contractActivate']	${COMMONWAIT}
	Click Button							css=button[tid='contractActivate']
	Wait Until Element Is Not Visible		css=button[tid='contractActivate']	${COMMONWAIT}
	Remove File  ${file_path}


Скасувати закупівлю
	[Arguments]  ${username}  ${tender_uaid}  ${reason}  ${doc_path}  ${description}

	privatmarket.Пошук тендера по ідентифікатору	${username}	${tender_uaid}
	Wait Enable And Click Element			css=button[tid='cancelBtn']
	Wait For Ajax

	#add doc
	Wait Until Element Is Visible			css=button[tid='docCancellation']		${COMMONWAIT}
	Choose File								css=#docsCancellation		${doc_path}
	Wait Until Element Is Visible			css=div.progress.progress-bar	${COMMONWAIT}
	Wait For Ajax

	#input description
	Wait Until Element Is Enabled			css=input[tid='cancellation.description']
	Input text								css=input[tid='cancellation.description']	${description}

	#input reason
	Input text								css=input[tid='cancellation.reason']	${reason}

	#confirm
	Click Button							css=button[tid='btn.cancellation']

	Wait Until Element Is Visible			css=div.progress.progress-bar	${COMMONWAIT}
	sleep									10s
	Wait For Ajax
	Wait Until Element Is Not Visible		css=div.progress.progress-bar	60
	Wait Until Element Is Visible			${tender_data.cancellations[0].status}		${COMMONWAIT}


#Custom Keywords
Login
	[Arguments]  ${username}
	Wait Until Element Is Not Visible	css=div.progress.progress-bar			${COMMONWAIT}
	Sleep				7s
	Wait Enable And Click Element		css=a[ng-click="loginModal('login')"]
	Wait Enable And Click Element		xpath=//a[contains(@href, 'https://bankid.privatbank.ua')]

	Wait Until Element Is Visible		css=input[id='loginLikePhone']			5s
	Input Text							css=input[id='loginLikePhone']			+${USERS.users['${username}'].login}
	Input Text							css=input[id='passwordLikePassword']	${USERS.users['${username}'].password}
	Click Element						css=div[id='signInButton']
	Wait Until Element Is Visible		css=input[id='first-section']	5s
	Input Text							css=input[id='first-section']	12
	Input Text							css=input[id='second-section']	34
	Input Text							css=input[id='third-section']	56
	Click Element						css=a[id='confirmButton']
	Sleep								3s
	Wait For Ajax
	Wait Until Element Is Not Visible	css=div.progress.progress-bar			${COMMONWAIT}
	Wait Until Element Is Not visible	css=a[id='confirmButton']
	Wait Until Element Is Visible		css=input#businessSearch


Wait For Ajax
	Get Location
	Sleep			4s


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
	Wait Until Element Is Enabled	${elementLocator}	${COMMONWAIT}
	Click Element					${elementLocator}
	Wait For Ajax


Wait Visibulity And Click Element
	[Arguments]  ${elementLocator}
	Wait Until Element Is Visible	${elementLocator}	${COMMONWAIT}
	Click Element					${elementLocator}
	Wait For Ajax


Wait For Element Value
	[Arguments]	${locator}
	Wait For Ajax
	${cssLocator} =	Get Substring	${locator}	4
	Wait For Condition				return window.$($("${cssLocator}")).val()!='' && window.$($("${cssLocator}")).val()!='None'	${COMMONWAIT}
	${value}=	get value			${locator}


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


Wait For Auction
	[Arguments]	${tender_id}
	Wait Until Keyword Succeeds	5min	10s	Try Search Auction	${tender_id}


Try Search Auction
	[Arguments]	${tender_id}
	Wait For Ajax
	Wait Until element Is Enabled			css=input#businessSearch		${COMMONWAIT}

	#заполним поле поиска
	${text_in_search} =					Get Value	css=input#businessSearch
	Run Keyword Unless	'${tender_id}' == '${text_in_search}'	Run Keywords	Clear Element Text	css=input#businessSearch
	...   AND   Input Text	css=input#businessSearch	${tender_id}

	#выполним поиск
	Press Key	css=input#businessSearch	\\13
	Wait Until Element Is Not Visible		css=div.progress.progress-bar	${COMMONWAIT}
	Wait Until Element Is Not Visible		css=div[role='dialog']	${COMMONWAIT}
	Wait Until Element Not Stale			css=a[tid='${tender_id}']	${COMMONWAIT}
	Wait Until Element Is Visible			css=a[tid='${tender_id}']	${COMMONWAIT}
	[return]	True


Try Search Element
	[Arguments]	${locator}
	Reload Page
	Wait For Ajax
	Wait Until Element Is Visible	${locator}	3
	Wait Until Element Is Enabled	${locator}	3
	[return]	True


Try Search Element With Text
	[Arguments]	${locator}  ${text}
	Reload Page
	Wait For Ajax
	Wait Until Element Contains		${locator}	${text}	3s
	[return]	True


Wait For Element With Reload
	[Arguments]  ${locator}  ${time_to_wait}=2
	Wait Until Keyword Succeeds			${time_to_wait}min	3s	Try Search Element	${locator}


Check For Auction Dates
	Reload Page
	Wait For Ajax
	Wait Until Element Does Not Contain	xpath=//div[span[@tid="data.auctionPeriod.startDate"]]	період не визначено	5s
	[return]	True


Set Date
	[Arguments]  ${element}  ${date}
	${locator}  ${type} = 	Get Locator And Type	${element}
	${correctDate} =	Get Regexp Matches	${date}	(\\d{4}-\\d{2}-\\d{2})	1
	${correctDate} =	Convert Date		${correctDate[0]}	result_format=%d-%m-%Y
	${correctDate} =	Convert To String	${correctDate}
	Input Text	${element}	${correctDate}


Set Time
	[Arguments]  ${element_hour}  ${element_min}  ${date}
	${hour} =	Get Regexp Matches	${date}	T(\\d{2}):\\d{2}	1
	${min} =	Get Regexp Matches	${date}	T\\d{2}:(\\d{2})	1
	Input Text	${element_hour}	${hour}
	Input Text	${element_min}	${min}


Set Date And Time
	[Arguments]  ${date_element}  ${element_hour}  ${element_min}  ${date}
	Wait Until Element Is Visible	${element_min}	timeout=${COMMONWAIT}
	Set Date	${date_element}	${date}
	Set Time	${element_hour}	${element_min}	${date}

