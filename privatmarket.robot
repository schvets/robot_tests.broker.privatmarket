*** Settings ***
Library  String
Library  Selenium2Library
Library  privatmarket_service.py
Library  Collections
Library  BuiltIn
Library  op_robot_tests.tests_files.service_keywords

*** Variables ***
${COMMONWAIT}  60

${tender_data.title}  css=div[tid='data.title']
${tender_data.description}  css=div[tid='data.description']
${tender_data.procuringEntity.name}  css=div[tid='data.procuringEntity.name']
${tender_data.value.amount}  css=span[tid='data.value.amount']
${tender_data.value.currency}  css=span[tid='data.value.currency']
${tender_data.value.valueAddedTaxIncluded}  css=span[tid='data.value.valueAddedTaxIncluded']
${tender_data.minimalStep.amount}  css=span[tid='data.minimalStep.amount']
${tender_data.minimalStep.currency}  css=span[tid='data.minimalStep.currency']
${tender_data.minimalStep.valueAddedTaxIncluded}  css=span[tid='data.minimalStep.valueAddedTaxIncluded']

${tender_data.auctionID}  css=div[tid='data.auctionID']
${tender_data.dgfID}  css=div[tid='data.dgfID']
${tender_data.status}  css=span[tid='data.statusName']
${tender_data.enquiryPeriod.startDate}  css=span[tid='data.enquiryPeriod.startDate']
${tender_data.enquiryPeriod.endDate}  css=span[tid='data.enquiryPeriod.endDate']
${tender_data.tenderPeriod.startDate}  css=span[tid='period.from']
${tender_data.tenderPeriod.endDate}  css=span[tid='period.to']
${tender_data.auctionPeriod.startDate}  css=div[tid='data.auctionPeriod'] span[tid='period.from']
${tender_data.auctionPeriod.endDate}  css=div[tid='data.auctionPeriod'] span[tid='period.to']
${tender_data.eligibilityCriteria}  css=div[tid='data.eligibilityCriteria']

${tender_data.items.deliveryDate.endDate}  span[@tid='item.deliveryDate.endDate']
${tender_data.items.deliveryLocation.latitude}  span[@tid='item.deliveryLocation.latitude']
${tender_data.items.deliveryLocation.longitude}  span[@tid='item.deliveryLocation.longitude']
${tender_data.items.deliveryAddress.countryName}  span[@tid='item.deliveryAddress.countryName']
${tender_data.items.deliveryAddress.postalCode}  span[@tid='item.deliveryAddress.postalCode']
${tender_data.items.deliveryAddress.region}  span[@tid='item.deliveryAddress.region']
${tender_data.items.deliveryAddress.locality}  span[@tid='item.deliveryAddress.locality']
${tender_data.items.deliveryAddress.streetAddress}  span[@tid='item.deliveryAddress.streetAddress']
${tender_data.items.classification.scheme}  span[@tid='item.classification.scheme']
${tender_data.items.classification.id}  span[@tid='item.classification.id']
${tender_data.items.classification.description}  span[@tid='item.classification.description']
${tender_data.items.unit.name}  span[@tid='item.unit.name']
${tender_data.items.unit.code}  span[@tid='item.unit.code']
${tender_data.items.quantity}  span[@tid='item.quantity']
${tender_data.items.description}  div[@tid='item.description']
${tender_data.items[0].unit.code}  span[@tid='item.unit.code']
${tender_data.items.additionalClassifications[0].scheme}  span[@tid='item.additionalClassifications.scheme']
${tender_data.items.additionalClassifications[0].id}  span[@tid='item.additionalClassifications.id']
${tender_data.items.additionalClassifications[0].description}  span[@tid='item.additionalClassifications.description']
${tender_data.items.contractPeriod.startDate}  span[@tid='item.contractPeriod.startDate']
${tender_data.items.contractPeriod.endDate}  span[@tid='item.contractPeriod.endDate']

${tender_data.questions.title}  span[@tid='data.question.title']
${tender_data.questions.description}  span[@tid='data.question.description']
${tender_data.questions.date}  span[@tid='data.quesion.date']
${tender_data.questions.answer}  span[@tid='data.question.answer']

${tender_data.doc.title}  xpath=(//div[@id='fileitem'])

${tender_data.cancellations[0].status}  xpath=//span[@tid='data.statusName' and contains(., 'Торги відмінено')]
${tender_data.cancellations[0].reason}  css=div[tid='cancellations.reason']
${tender_data.cancellation.doc.title}  css=div[tid='doc.title']
${tender_data.cancellation.doc.description}  css=div[tid='cancellations.doc.description']

${tender_data.procurementMethodType}  css=div[tid='data.procurementMethodType']
${tender_data.tenderAttempts}  css=span[tid='data.tenderAttempts']
${tender_data.dgfDecisionDate}  css=span[tid='data.dgfDecisionDate']
${tender_data.dgfDecisionID}  css=span[tid='data.dgfDecisionID']

${tender_data.awards[0].status}  xpath=(//span[@tid='award.status'])[1]
${tender_data.awards[1].status}  xpath=(//span[@tid='award.status'])[2]

${tenderBtn.create_edit}  css=button[tid='btn.createlot']

*** Keywords ***
Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  Run Keyword If  '${role_name}' != 'tender_owner'  Return From Keyword  ${tender_data}
  ${tender_data.data}=  modify_test_data  ${tender_data.data}
  [Return]  ${tender_data}


Підготувати клієнт для користувача
  [Arguments]  ${username}
  [Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо

  ${service_args}=  Create List  --ignore-ssl-errors=true  --ssl-protocol=tlsv1
  ${browser}=  Convert To Lowercase  ${USERS.users['${username}'].browser}
  ${disabled}  Create List  Chrome PDF Viewer
  ${prefs}  Create Dictionary  download.default_directory=${OUTPUT_DIR}  plugins.plugins_disabled=${disabled}

  ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
  Call Method  ${options}  add_argument  --allow-running-insecure-content
  Call Method  ${options}  add_argument  --disable-web-security
  Call Method  ${options}  add_argument  --nativeEvents\=false
  Call Method  ${options}  add_experimental_option  prefs  ${prefs}

  ${alias}=   Catenate   SEPARATOR=   browser  ${username}
  Set Global Variable  ${ALIAS_NAME}  ${alias}
  Run Keyword If  'phantomjs' in '${browser}'  Create Webdriver  PhantomJS  ${username}  service_args=${service_args}
  ...  ELSE IF  'chrome' in '${browser}'  Create WebDriver  Chrome  chrome_options=${options}  alias=${ALIAS_NAME}
  ...  ELSE  Open Browser  ${USERS.users['${username}'].homepage}  ff  alias=${ALIAS_NAME}

  Set Window Size  @{USERS.users['${username}'].size}
  Set Window Position  @{USERS.users['${username}'].position}
  Set Selenium Implicit Wait  10s
  Go To  ${USERS.users['${username}'].homepage}
  Run Keyword Unless  'Viewer' in '${username}'  Login  ${username}


Оновити сторінку з тендером
  [Arguments]  ${user_name}  ${tender_id}
  Switch Browser  ${ALIAS_NAME}
  ${tenderEdit}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=input[tid='data.title']  5s
  Run Keyword If  '${tenderEdit}' == 'False'  Reload Page
  Sleep  3s


Створити тендер
  [Arguments]  ${user_name}  ${tender_data}
  ${os}=  Evaluate  platform.system()  platform
  ${items}=  Get From Dictionary  ${tender_data.data}  items
  ${items_number}=  Get Length  ${items}
  Wait Enable And Click Element  css=#simple-dropdown
  Wait Enable And Click Element  css=a[href='#/add-lot']
  ${correctDate}=  Convert Date  ${tender_data.data.dgfDecisionDate}  result_format=%d/%m/%Y
  ${correctDate}=  Convert To String  ${correctDate}

  #main info
  Execute Javascript  angular.prozorroaccelerator=1440;
  Execute Javascript  angular.prozorroauctionstartdelay = 30*60*1000;
  Wait Until Element Is Enabled  css=input[tid='data.title']
  Input text  css=input[tid='data.title']  ${tender_data.data.title}
  Input text  css=input[tid='data.dgfID']  ${tender_data.data.dgfID}
  Select From List  css=select[tid='data.procurementMethodType']  string:${tender_data.data.procurementMethodType}
  Input Text  css=input[tid='dgfDecisionDate']  ${correctDate}
  Input text  css=input[tid='data.dgfDecisionID']  ${tender_data.data.dgfDecisionID}

  Select From List  css=select[tid='data.tenderAttempts']  number:${tender_data.data.tenderAttempts}
  Input text  css=textarea[tid='data.description']  ${tender_data.data.description}
  ${amount_to_enter}=  Convert To String  ${tender_data.data.value.amount}
  ${amount_to_enter2}=  Replace String  ${amount_to_enter}  .  ,
  Click Element  css=input[tid='data.value.amount']
  Run Keyword If  '${os}' == 'Linux'  Input text  css=input[tid='data.value.amount']  ${amount_to_enter}
  ...  ELSE  Input text  css=input[tid='data.value.amount']  ${amount_to_enter2}

  Run Keyword If  '${tender_data.data.value.valueAddedTaxIncluded}' == 'True'  Click Element  css=input[tid='data.value.valueAddedTaxIncluded']
  ...  ELSE  Click Element  css=input[tid='data.value.valueAddedTaxNotIncluded']
  ${amount_to_enter}=  Convert To String  ${tender_data.data.minimalStep.amount}
  ${amount_to_enter2}=  Replace String  ${amount_to_enter}  .  ,
  Click Element  css=input[tid='data.minimalStep.amount']
  Run Keyword If  '${os}' == 'Linux'  Input text  css=input[tid='data.minimalStep.amount']  ${amount_to_enter}
  ...  ELSE  Input text  css=input[tid='data.minimalStep.amount']  ${amount_to_enter2}

  #date/time
  Set Date  css=input[tid='auctionStartDate']  ${tender_data.data.auctionPeriod.startDate}

  #items
  :FOR  ${index}  IN RANGE  ${items_number}
  \  ${should_we_click_btn.additem}=  Set Variable If  '0' != '${index}'  ${True}  ${False}
  \  Додати новий предмет закупівлі  ${items[${index}]}  ${should_we_click_btn.additem}

  Click Button  ${tenderBtn.create_edit}
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Wait Until Element Is Visible  css=div[tid='data.title']  ${COMMONWAIT}
  Wait For Ajax

  #publication
  Wait Until Element Is Visible  css=button[tid='btn.publicateLot']
  Click Button  css=button[tid='btn.publicateLot']
  Wait For Ajax
  Wait For Element With Reload  css=div[tid='data.auctionID']
  ${tender_id}=  Get Text  css=div[tid='data.auctionID']
  Go To  ${USERS.users['${username}'].homepage}
  Wait For Ajax
  [Return]  ${tender_id}


Внести зміни в тендер
  [Arguments]  ${user_name}  ${tender_id}  ${field}  ${value}
  Увійти в редагування тендера
  Run Keyword  Змінити ${field}  ${value}
  ${file_path}  ${file_title}  ${file_content}=  create_fake_doc
  Додати документ до аукціону  ${filepath}  string:clarifications
  Wait Until Element Is Visible  ${tenderBtn.create_edit}  ${COMMONWAIT}
  Click Element  ${tenderBtn.create_edit}
  Wait Until Element Is Visible  css=div[tid='data.title']  ${COMMONWAIT}
  Sleep  10s


Змінити value.amount
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.minimalStep.amount']
  Wait For Ajax
  Input text  css=input[tid='data.minimalStep.amount']  '${value}'


Змінити minimalStep.amount
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.minimalStep.amount']
  Wait For Ajax
  Input text  css=input[tid='data.minimalStep.amount']  '${value}'


Змінити title
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.title']
  Wait For Ajax
  Input text  css=input[tid='data.title']  ${value}

Змінити title_ru
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.title_ru']
  Wait For Ajax
  Input text  css=input[tid='data.title_ru']  ${value}

Змінити title_en
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.title_en']
  Wait For Ajax
  Input text  css=input[tid='data.title_en']  ${value}

Змінити description
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=textarea[tid='data.description']
  Wait For Ajax
  Input text  css=textarea[tid='data.description']  ${value}


Змінити procuringEntity.name
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='procuringEntity.name'
  Wait For Ajax
  Input text  css=input[tid='procuringEntity.name']  ${value}


Змінити tenderPeriod.startDate
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='auctionStartDate']
  Wait For Ajax
  Set Date  css=input[tid='auctionStartDate']  ${value}


Змінити eligibilityCriteria
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='eligibilityCriteria']
  Wait For Ajax
  Input text  css=input[tid='eligibilityCriteria']  ${value}


Змінити guarantee
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.dgfDecisionID']
  Wait For Ajax
  Input text  css=input[tid='guarantyAmount']  ${value}


Змінити dgfDecisionDate
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.dgfDecisionID']
  ${correctDate}=  Convert Date  ${value}  result_format=%d/%m/%Y
  ${correctDate}=  Convert To String  ${correctDate}
  Wait For Ajax
  Input Text  css=input[tid='dgfDecisionDate']  ${correctDate}


Змінити dgfDecisionID
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.dgfDecisionID']
  Wait For Ajax
  Input text  css=input[tid='data.dgfDecisionID']  ${value}


Змінити tenderAttempts
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=select[tid='data.tenderAttempts']
  Wait For Ajax
  Select From List  css=select[tid='data.tenderAttempts']  number:${value}


Змінити dgfID
  [Arguments]  ${value}
  Wait Until Element Is Visible  css=input[tid='data.dgfID']
  Wait For Ajax
  Input text  css=input[tid='data.dgfID']  ${value}


Додати новий предмет закупівлі
  [Arguments]  ${item}  ${should_we_click_btn.additem}=${False}
  Run Keyword If  ${should_we_click_btn.additem}  Wait Visibulity And Click Element  css=button[tid='btn.additem']
  Wait Until Element Is Enabled  xpath=(//textarea[@tid='item.description'])[last()]
  Input text  xpath=(//textarea[@tid='item.description'])[last()]  ${item.description}
  #classification
  Input text  xpath=(//div[@tid='classification']//input)[last()]  ${item.classification.id}
  Wait Until Element Is Enabled  xpath=(//ul[contains(@class, 'ui-select-choices-content')])[last()]
  Wait Enable And Click Element  xpath=//span[@class='ui-select-choices-row-inner' and contains(., '${item.classification.id}')]

  #quantity
  Input text  xpath=(//input[@tid='item.quantity'])[last()]  ${item.quantity}
  Select From List  xpath=(//select[@tid='item.unit.name'])[last()]  ${item.unit.name}

  #address
  Select Checkbox  xpath=(//input[@tid='item.address.checkbox'])[last()]
  Wait Until Element Is Enabled  xpath=(//input[@tid='item.address.countryName'])[last()]
  Input text  xpath=(//input[@tid='item.address.countryName'])[last()]  ${item.deliveryAddress.countryName}
  Input text  xpath=(//input[@tid='item.address.postalCode'])[last()]  ${item.deliveryAddress.postalCode}
  Input text  xpath=(//input[@tid='item.address.region'])[last()]  ${item.deliveryAddress.region}
  Input text  xpath=(//input[@tid='item.address.streetAddress'])[last()]  ${item.deliveryAddress.streetAddress}
  Input text  xpath=(//input[@tid='item.address.locality'])[last()]  ${item.deliveryAddress.locality}


Пошук тендера по ідентифікатору
  [Arguments]  ${user_name}  ${tender_id}
  Wait For Auction  ${tender_id}
  Wait Enable And Click Element  css=a[tid='${tender_id}']
  Wait Until element Is Visible  css=div[tid='data.title']  ${COMMONWAIT}


Отримати інформацію із тендера
  [Arguments]  ${user_name}  ${tender_id}  ${element}
  Run Keyword And Return If  '${element}' == 'status'  Отримати status аукціону  ${element}
  Run Keyword And Return If  '${element}' == 'value.amount'  Отримати число  ${element}
  Run Keyword And Return If  '${element}' == 'value.valueAddedTaxIncluded'  Отримати інформацію про включення ПДВ  ${element}
  Run Keyword And Return If  '${element}' == 'minimalStep.amount'  Отримати число  ${element}
  Run Keyword And Return If  '${element}' == 'minimalStep.valueAddedTaxIncluded'  Отримати інформацію про включення ПДВ  ${element}
  Run Keyword And Return If  '${element}' == 'tender_cancellation_title'  Отримати заголовок документа  ${element}
  Run Keyword And Return If  '${element}' == 'procurementMethodType'  Отримати тип оголошеного лоту  ${element}
  Run Keyword And Return If  '${element}' == 'tenderAttempts'  Отримати значення поля Лоти виставляються  ${element}
  Run Keyword And Return If  '${element}' == 'cancellations[0].status'  Перевірити cancellations[0].status

  Run Keyword And Return If  '${element}' == 'awards[0].status'  Отримати awards status  ${element}
  Run Keyword And Return If  '${element}' == 'awards[1].status'  Отримати awards status  ${element}

  Run Keyword And Return If  'Period.' in '${element}'  Отримати дату та час  ${element}

  Wait Until Element Is Visible  ${tender_data.${element}}  timeout=${COMMONWAIT}
  ${result}=  Отримати текст  ${element}
  [Return]  ${result}


Отримати інформацію із предмету
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${base_element}
  ${element}=  Convert To String  items.${base_element}
  ${element_for_work}=  Set variable  xpath=//div[@ng-repeat='item in data.items' and contains(., '${item_id}')]//${tender_data.${element}}
  Wait For Element With Reload  ${element_for_work}

  Run Keyword And Return If  '${element}' == 'items.deliveryDate.endDate'  Отримати дату та час  ${element_for_work}
  Run Keyword And Return If  '${element}' == 'items.deliveryLocation.latitude'  Отримати число  ${element_for_work}
  Run Keyword And Return If  '${element}' == 'items.deliveryLocation.longitude'  Отримати число  ${element_for_work}
  Run Keyword And Return If  '${element}' == 'items.quantity'  Отримати число  ${element_for_work}
  Run Keyword And Return If  '${element}' == 'items.unit.code'  Отримати unit.code  ${element_for_work}
#  Run Keyword And Return If  'items.contractPeriod' in '${element}'  Отримати дату в ISO форматі  ${element_for_work}  %d-%m-%Y
  Run Keyword And Return If  'items.contractPeriod' in '${element}'  Отримати дату контракту  ${base_element}  ${item_id}  ${element_for_work}


  Wait Until Element Is Visible  ${element_for_work}  timeout=${COMMONWAIT}
  ${result}=  Отримати текст елемента  ${element_for_work}
  [Return]  ${result}


Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${questions_id}  ${element}
  ${element}=  Convert To String  questions.${element}
  ${element_for_work}=  Set variable  xpath=//div[contains(@class, 'questionsBox') and contains(., '${questions_id}')]//${tender_data.${element}}
  Wait Until Element Is Visible  ${element_for_work}  ${COMMONWAIT}
  ${result}=  Отримати текст елемента  ${element_for_work}
  [Return]  ${result}


Wait for question
  [Arguments]  ${element}
  Reload Page
  @{open_questions}  Get Webelements  css=a.glyphicon

  :FOR  ${open_question}  IN  @{open_questions}
  \  Click Element  ${open_question}

  Wait Until Element Is Visible  ${element}  2


Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${element}
  ${element}=  Set Variable If  'скасування лоту' in '${TEST_NAME}'  cancellation.doc.${element}  doc.${element}

  Run Keyword And Return If  '${element}' == 'doc.title'  Отримати заголовок документації до лоту  ${element}  ${doc_id}

  Wait Until Element Is Visible  ${tender_data.${element}}  timeout=${COMMONWAIT}
  ${result}=  Отримати текст  ${element}
  [Return]  ${result}


Отримати заголовок документа
  [Arguments]  ${element_name}  ${doc_id}=${EMPTY}
  ${elements_list}=  Get Webelements  ${tender_data.${element_name}}
  ${size}=  Get Length  ${elements_list}
  ${size}=  Sum_Of_Numbers  ${size}  1
  ${title}=  Set Variable  ${EMPTY}
  :FOR  ${index}  IN RANGE  1  ${size}
  \  ${text}=  Get Element Attribute  ${tender_data.${element_name}}[${index}]@title
  \  ${words}=  Split String  ${text}  \\
  \  ${result}=  Get From List  ${words}  -1
  \  Run Keyword If  '${doc_id}' in '${result}'  Return From Keyword  ${result}
  [Return]  ${title}


Отримати заголовок документації до лоту
  [Arguments]  ${element}  ${doc_id}=${EMPTY}
  ${result}=  Отримати заголовок документа  ${element}  ${doc_id}
  [Return]  ${result}


Отримати інформацію із документа по індексу
  [Arguments]  ${username}  ${tender_uaid}  ${doc_index}  ${element}
  ${index}=  sum of numbers  ${doc_index}  1
  #получим тип документа по индексу
  ${result}=  Get Element Attribute  xpath=(//div[contains(@ng-repeat, 'distinctDocuments')]/*)[${index}]@tid
  Run Keyword And Return If  '${result}' == '${None}'  Get Element Attribute  xpath=(//div[contains(@ng-repeat, 'distinctDocuments')])[${index}]//div[@id="fileitem"]@documenttype
  ${result}=  Remove String  ${result}  data.
  [Return]  ${result}


Отримати текст елемента
  [Arguments]  ${element_name}
  ${temp_name}=  Remove String  ${element_name}  '
  ${selector}=  Set Variable If
  ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
  ...  ${tender_data.${element_name}}

  Wait Until Element Is Visible  ${selector}
  ${result_full}=  Get Text  ${selector}
  ${result}=  Strip String  ${result_full}
  [Return]  ${result}


Отримати unit.code
  [Arguments]  ${element_name}
  ${temp_name}=  Remove String  ${element_name}  '
  ${selector}=  Set Variable If
  ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
  ...  ${tender_data.${element_name}}
  Wait Until Element Is Visible  ${selector}
  ${is_present}=  Run Keyword And Return Status  Get Element Attribute  ${selector}@tidvalue
  Run Keyword And Return If  '${is_present}' == '${TRUE}'  Get Element Attribute  ${selector}@tidvalue
  ${result_full}=  Get Text  ${selector}
  ${result}=  Strip String  ${result_full}
  [Return]  ${result}


Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  ${doc}=  Set Variable  xpath=//div[@id='fileitem' and contains(., '${doc_id}')]
  ${file_name}=  Get Element Attribute  ${doc}@title
  ${file_url}=  Get Element Attribute  ${doc}@url
  download_file_from_url  ${file_url}  ${OUTPUT_DIR}${/}${file_name}
  Sleep  5s
  [Return]  ${file_name}


Отримати текст
  [Arguments]  ${element_name}
  ${result_full}=  Get Text  ${tender_data.${element_name}}
  ${result}=  Strip String  ${result_full}
  [Return]  ${result}


Отримати число
  [Arguments]  ${element_name}
  ${value}=  Отримати текст елемента  ${element_name}
  ${result}=  Convert To Number  ${value}
  [Return]  ${result}


Отримати значення поля Лоти виставляються
  [Arguments]  ${element_name}
  ${result}=  Get Element Attribute  css=span[tid='data.tenderAttempts']@tidvalue
  ${result}=  Convert To Integer  ${result}
  [Return]  ${result}


Отримати дату та час
  [Arguments]  ${element_name}
  Switch Browser  ${ALIAS_NAME}
  ${result_full}=  Отримати текст елемента  ${element_name}
  ${result_full}=  Split String  ${result_full}
  ${day_length}=  Get Length  ${result_full[0]}
  ${day}=  Set Variable If  '${day_length}' == '1'  0${result_full[0]}  ${result_full[0]}
  ${month}=  Replace String  ${result_full[1]}  ,  ${EMPTY}
  ${month}=  get month number  ${month}
  ${year}=  get_current_year
  ${result_full}=  Set Variable  ${day}-${month}-${year} ${result_full[2]}
  ${result}=  get_time_with_offset  ${result_full}
  [Return]  ${result}


Отримати дату в ISO форматі
  [Arguments]  ${element_name}  ${format}
  ${date}=  Отримати текст елемента  ${element_name}
  ${result}=  change_date_to_ISO_format  ${date}  ${format}
  [Return]  ${result}


Отримати дату контракту
  [Arguments]  ${element}  ${item_id}  ${element_name}
  ${date}=  Отримати текст елемента  ${element_name}
  ${verifiable_date}=  change_date_format  ${date}  %d-%m-%Y  %Y-%m-%d
  ${item_index}=  get_object_index_by_id  ${USERS.users['${tender_owner}'].initial_data.data['items']}  ${item_id}
  ${full_date}=  Set Variable  ${USERS.users['${tender_owner}'].initial_data.data['items'][${item_index}].${element}}
  ${etalon_date}=  Get Substring  ${full_date}  0  10
  ${result}=  Set Variable If  '${etalon_date}' == '${verifiable_date}'  ${full_date}  ${verifiable_date}
  [Return]  ${result}


Отримати інформацію про включення ПДВ
  [Arguments]  ${element_name}
  ${value_added_tax_included}=  Отримати текст елемента  ${element_name}
  ${result}=  Set Variable If  'з ПДВ' in '${value_added_tax_included}'  ${True}  ${False}
  [Return]  ${result}


Отримати status аукціону
  [Arguments]  ${element}
  Reload Page
  Sleep  5s
  ${element_text}=  Get Text  xpath=//span[@tid='data.statusName']/span[1]
  ${text}=  Strip String  ${element_text}
  ${result}=  Set Variable If
  ...  '${text}' == 'Період уточнень'  active.enquiries
  ...  '${text}' == 'Період прийому пропозицій'  active.tendering
  ...  '${text}' == 'Аукціон'  active.auction
  ...  '${text}' == 'Кваліфікація'  active.qualification
  ...  '${text}' == 'Оплачено, очікується підписання договору'  active.awarded
  ...  '${text}' == 'Активний лот'  active
  ...  '${text}' == 'Торги не відбулися'  unsuccessful
  ...  '${text}' == 'Завершено'  complete
  ...  '${text}' == 'Торги відмінено'  cancelled
  ...  '${text}' == 'Очікується протокол'  pending
  ...  '${text}' == 'Очікується оплата'  validation
  ...  '${text}' == 'Не поступила оплата'  nopayment
  ...  '${text}' == 'Не опубліковано у ЦБД'  draft
  ...  ${element}
  [Return]  ${result}


Отримати awards status
  [Arguments]  ${element}
  Reload Page
  Sleep  10s
  ${element_text}=  Get Text  ${tender_data.${element}}
  ${text}=  Strip String  ${element_text}
  ${result}=  Set Variable If
  ...  '${text}' == 'очікується протокол'  pending.verification
  ...  '${text}' == 'у черзі на кваліфікацію'  pending.waiting
  ...  '${text}' == 'Очікується підписання договору'  pending.payment
  ...  '${text}' == 'Оплачено, очікується підписання договору/переможець'  active
  ...  '${text}' == 'учасник самодискваліфікувався'  cancelled
  ...  '${text}' == 'дискваліфіковано'  unsuccessful
  ...  ${element}
  [Return]  ${result}


Отримати інформацію із пропозиції
  [Arguments]  ${user_name}  ${tender_id}  ${field}
  ${locator}=  Set Variable If  '${field}' == 'value.amount'  css=span[tid='bid.amount']  null
  Wait For Ajax
  Wait For Element With Reload  ${locator}
  ${result}=  Get Text  ${locator}
  ${result}=  Convert To Number  ${result}
  [Return]  ${result}


Перевірити cancellations[0].status
  ${is_present}=  Run Keyword And Return Status  Element Should Contain  css=span[tid='data.statusName']  Торги відмінено
  ${status}=  Set Variable If  '${is_present}' == 'True'  active  not active
  [Return]  ${status}


Задати запитання на предмет
  [Arguments]  ${user_name}  ${tender_id}  ${item_id}  ${question_data}
  Wait Until Element Is Visible  css=input[ng-model='newQuestion.title']  ${COMMONWAIT}
  Input Text  css=input[ng-model='newQuestion.title']  ${question_data.data.title}
  Input Text  css=textarea[ng-model='newQuestion.text']  ${question_data.data.description}

  Click Element  css=div[ng-model='newQuestion.questionOf'] span
  Wait Enable And Click Element  xpath=//span[@class='ui-select-choices-row-inner' and contains(., '${item_id}')]

  Click Button  css=button[tid='sendQuestion']
  Sleep  5s
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Wait Until Keyword Succeeds  3min  3s  Check If Question Is Uploaded  ${question_data.data.title}


Check If Question Is Uploaded
  [Arguments]  ${title}
  Reload Page
  Wait For Ajax
  @{subtitle}=  Split String  ${title}  '
  Wait Until Element Is Enabled  xpath=//div[@ng-repeat='question in data.questions']//span[@tid='data.question.title' and contains(., '${subtitle[0]}')]  3
  [Return]  True


Задати запитання на тендер
  [Arguments]  ${user_name}  ${tender_id}  ${question_data}
  Wait Until Element Is Visible  css=input[ng-model='newQuestion.title']  ${COMMONWAIT}
  Input Text  css=input[ng-model='newQuestion.title']  ${question_data.data.title}
  Input Text  css=textarea[ng-model='newQuestion.text']  ${question_data.data.description}

  Click Element  css=div[ng-model='newQuestion.questionOf'] span
  Wait Enable And Click Element  xpath=//span[@class='ui-select-choices-row-inner' and contains(., 'Загальне запитання')]

  Click Button  css=button[tid='sendQuestion']
  Sleep  5s
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Wait For Element With Reload  css=span[tid='data.question.date']


Відповісти на запитання
  [Arguments]  ${user_name}  ${tender_id}  ${answer}  ${question_id}
  Wait Until Element Is Visible  xpath=//div[@class='row question' and contains(., '${question_id}')]//button[@tid='answerQuestion']  ${COMMONWAIT}
  Wait Until Element Is Visible  xpath=//div[@class='row question' and contains(., '${question_id}')]//input[@tid='input.answer']  ${COMMONWAIT}
  Input Text  xpath=//div[@class='row question' and contains(., '${question_id}')]//input[@tid='input.answer']  ${answer.data.answer}
  Click Button  xpath=//div[@class='row question' and contains(., '${question_id}')]//button[@tid='answerQuestion']
  Sleep  3s
  Wait For Ajax


Подати цінову пропозицію
  [Arguments]  ${user_name}  ${tender_id}  ${bid}
  Switch Browser  ${ALIAS_NAME}
  ${os}=  Evaluate  platform.system()  platform
  Run Keyword If  'без кваліфікації' in '${TEST NAME}'  Fail  Is not implemented yet
  #дождаться появления поля ввода ссуммы только в случае выполнения первого позитивного теста
  Run Keyword Unless  'Неможливість подати цінову' in '${TEST NAME}' or 'подати повторно цінову' in '${TEST NAME}'
  ...  Wait Until Element Is Enabled  css=button[tid='createBid']  ${COMMONWAIT}
  Click Button  css=button[tid='createBid']
  Wait Until Element Is Enabled  css=#amount  ${COMMONWAIT}
  Run Keyword Unless  '${MODE}' == 'dgfInsider'  Вказати ціну і підтвердити подання пропозиції  ${bid}  ${os}


Вказати ціну і підтвердити подання пропозиції
  [Arguments]  ${bid}  ${os}
  ${amount}=  Convert To String  ${bid.data.value.amount}
  ${amount2}=  Replace String  ${amount}  .  ,
  Run Keyword If  '${os}' == 'Linux'  Input Text  css=input[tid='bid.value.amount']  ${amount}
  ...  ELSE  Input Text  css=input[tid='bid.value.amount']  ${amount2}
  Click Button  css=div#bid button[tid='createBid']
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='saveAndConfirm']  ${COMMONWAIT}
  Click Button  css=button[tid='saveAndConfirm']
  Wait For Ajax
  Wait Until Element Is Not Visible  css=button[tid='saveAndConfirm']
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}


Скасувати цінову пропозицію
  [Arguments]  ${user_name}  ${tender_id}
  Wait For Element With Reload  css=button[tid='btn.deleteBid']  5
  Wait Visibulity And Click Element  css=button[tid='btn.deleteBid']
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Wait Until Element Is Not Visible  css=button[tid='btn.deleteBid']  ${COMMONWAIT}


Змінити цінову пропозицію
  [Arguments]  ${user_name}  ${tender_id}  ${name}  ${value}
  ${os}=  Evaluate  platform.system()  platform
  ${amount}=  Convert To String  ${value}
  ${amount2}=  Replace String  ${amount}  .  ,

  Wait For Element With Reload  css=button[tid='modifyBid']  5
  Wait Visibulity And Click Element  css=button[tid='modifyBid']
  Clear Element Text  css=input[tid='bid.value.amount']
  Run Keyword If  '${os}' == 'Linux'  Input Text  css=input[tid='bid.value.amount']  ${amount}
  ...  ELSE  Input Text  css=input[tid='bid.value.amount']  ${amount2}

  Click Element  css=div#bid button[tid='createBid']
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='saveAndConfirm']  ${COMMONWAIT}
  Click Button  css=button[tid='saveAndConfirm']
  Wait For Ajax
  Wait Until Element Is Not Visible  css=button[tid='saveAndConfirm']
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}


Завантажити документ в ставку
  [Arguments]  ${user_name}  ${filepath}  ${tender_id}=${None}
  Wait Until Element Is Visible  xpath=//*[@tid='modifyDoc']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='modifyDoc']").className = ''
  Sleep  2s
  Choose File  css=input[id='modifyDoc']  ${filepath}
  Sleep  10s
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}


Додати документ до аукціону
  [Arguments]  ${filepath}  ${file_type}
  Wait Until Element Is Visible  css=div[tid='auction.docs'] div[tid='btn.addFiles']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("div[tid='auction.docs'] input#input-doc-lot").className = ''
  Sleep  2s
  Choose File  css=div[tid='auction.docs'] input#input-doc-lot  ${filepath}
  Wait Until Element Is Visible  css=div.modal-backdrop.fade
  Wait Until Element Is Not Visible  css=div.modal-backdrop.fade
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Select From List  xpath=(//div[@tid='auction.docs']//select[@tid='doc.type'])[last()]  ${file_type}
  Wait For Ajax


Додати предмет закупівлі
  [Arguments]  ${user_name}  ${tender_id}  ${item}
  Увійти в редагування тендера
  Run Keyword And Ignore Error  Click Element  css=button[tid='btn.additem']
  Click Element  ${tenderBtn.create_edit}
  Wait Until Element Is Visible  css=div[tid='data.title']  ${COMMONWAIT}


Видалити предмет закупівлі
  [Arguments]  ${user_name}  ${tender_id}  ${item_id}
  Увійти в редагування тендера
  Run Keyword And Ignore Error  Click Element  css=a[tid='remove.item']
  Click Element  ${tenderBtn.create_edit}
  Wait Until Element Is Visible  css=div[tid='data.title']  ${COMMONWAIT}


Завантажити документ
  [Arguments]  ${user_name}  ${filepath}  ${tender_id}=${None}
  Увійти в редагування тендера
  Додати документ до аукціону  ${filepath}  string:technicalSpecifications


Завантажити ілюстрацію
  [Arguments]  ${user_name}  ${tender_id}  ${filepath}
  Увійти в редагування тендера
  Додати документ до аукціону  ${filepath}  string:illustration


Завантажити документ в тендер з типом
  [Arguments]  ${user_name}  ${tender_id}  ${file_path}  ${doc_type}
  Увійти в редагування тендера
  Додати документ до аукціону  ${file_path}  string:${doc_type}


Увійти в редагування тендера
  ${at_modification_page}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=button[tid='btn.modifyLot']  15s
  Run Keyword If  ${at_modification_page}  Click Element  css=button[tid='btn.modifyLot']
  Wait Until Element Is Visible  css=input[tid='data.title']


Додати публічний паспорт активу
  [Arguments]  ${user_name}  ${tender_id}  ${filepath}
  Додати посилання  string:x_dgfPublicAssetCertificate  ${file_path}


Завантажити фінансову ліцензію
  [Arguments]  ${user_name}  ${tender_id}  ${financial_license_path}
  Run Keyword If  '${MODE}' == 'dgfInsider'  Подати цінову пропозицію для Insider
  ...  ELSE  Редагувати пропозицію
  Wait For Ajax
  Wait Until Element Is Visible  css=a[tid='btn.addFinLicenseDocs']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[tid='finLicense']").className = ''
  Sleep  2s
  Choose File  css=input[tid='finLicense']  ${financial_license_path}
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Click Button  css=div#bid button[tid='createBid']
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='saveAndConfirm']  ${COMMONWAIT}
  Click Button  css=button[tid='saveAndConfirm']
  Wait For Ajax
  Wait Until Element Is Not Visible  css=button[tid='saveAndConfirm']
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}


Подати цінову пропозицію для Insider
  Wait Until Element Is Enabled  css=button[tid='createBid']  ${COMMONWAIT}
  Click Button  css=button[tid='createBid']


Редагувати пропозицію
  Wait For Element With Reload  css=button[tid='modifyBid']
  Wait Visibulity And Click Element  css=button[tid='modifyBid']


Отримати кількість документів в ставці
  [Arguments]  ${user_name}  ${tender_id}  ${bid_index}
  Wait For Ajax
  Sleep  10s
  Wait Until Element Is Visible  xpath=//div[@ng-repeat='bid in data.bids']  ${COMMONWAIT}
  ${index}=  Get Index Number  xpath=//div[@ng-repeat='bid in data.bids']  ${bid_index}
  ${result}=  Get Matching Xpath Count  (//div[@ng-repeat='bid in data.bids'])[${index}]//a[@tid='bid.document.title']
  [Return]  ${result}


Отримати дані із документу пропозиції
  [Arguments]  ${user_name}  ${tender_id}  ${bid_index}  ${document_index}  ${field}
  ${bid_index}=  Get Index Number  xpath=//div[@ng-repeat='bid in data.bids']  ${bid_index}
  ${document_index}=  sum_of_numbers  ${document_index}  1
  ${result}=  Get Element Attribute  xpath=((//div[@ng-repeat='bid in data.bids'])[${bid_index}]//span[contains(@tid, 'bid.document.type')])[${document_index}]@tidvalue
  [Return]  ${result}


Додати посилання
  [Arguments]  ${link_type}  ${link}
  Execute Javascript  window.document.evaluate("//div[@tid='btn.addUrl']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
  Wait Visibulity And Click Element  css=div[tid='btn.addUrl']
  Wait Until Element Is Visible  xpath=(//select[@tid='docurl.type'])[last()]  10s
  Select From List  xpath=(//select[@tid='docurl.type'])[last()]  ${link_type}
  Wait Until Element Is Visible  xpath=(//input[@tid='docurl.url'])[last()]  10s
  Input Text  xpath=(//input[@tid='docurl.url'])[last()]  ${link}
  Input Text  xpath=(//input[@tid='docurl.title'])[last()]  Tets test


Додати Virtual Data Room
  [Arguments]  ${user_name}  ${tender_id}  ${vdr_url}
  Додати посилання  string:virtualDataRoom  ${vdr_url}


Додати офлайн документ
  [Arguments]  ${user_name}  ${tender_id}  ${accessDetails}
  Execute Javascript  window.document.evaluate("//div[@tid='btn.addUrl']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
  Wait Visibulity And Click Element  css=div[tid='btn.addUrl']
  Wait Until Element Is Visible  xpath=(//select[@tid='docurl.type'])[last()]  10s
  Select From List  xpath=(//select[@tid='docurl.type'])[last()]  string:x_dgfAssetFamiliarization
  Wait Until Element Is Visible  xpath=(//input[@tid='docurl.title'])[last()]  10s
  Input Text  xpath=(//input[@tid='docurl.title'])[last()]  ${accessDetails}
  Input Text  xpath=(//textarea[@tid='docurl.addfield'])[last()]  ${accessDetails}
  ${file_path}  ${file_title}  ${file_content}=  create_fake_doc
  Додати документ до аукціону  ${file_path}  string:clarifications

#  Auction publication section
  Wait Until Element Is Visible  ${tenderBtn.create_edit}
  Wait For Ajax
  Click Element  ${tenderBtn.create_edit}
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='btn.cancellationLot']  ${COMMONWAIT}


Змінити документ в ставці
  [Arguments]  ${user_name}  ${tender_id}  ${filepath}  ${bidid}
  privatmarket.Завантажити документ в ставку  ${user_name}  ${filepath}


Отримати посилання на аукціон для учасника
  [Arguments]  ${user_name}  ${tender_id}  ${lot_id}=${Empty}
  Switch Browser  ${ALIAS_NAME}
  Go To  ${USERS.users['${username}'].homepage}
  Run Keyword And Ignore Error  Login  ${user_name}
  privatmarket.Пошук тендера по ідентифікатору  ${username}  ${tender_id}
  Wait For Element With Reload  xpath=//a[@tid='bid.participationUrl']  5
  ${url}=  Get Element Attribute  xpath=//a[@tid='bid.participationUrl']@href
  [Return]  ${url}


Отримати посилання на аукціон для глядача
  [Arguments]  ${user_name}  ${tender_id}  ${lot_id}=${Empty}
  Switch Browser  ${ALIAS_NAME}
  Wait For Element With Reload  css=a[tid='public.data.auctionUrl']  5
  ${url}=  Get Element Attribute  css=a[tid='public.data.auctionUrl']@href
  [Return]  ${url}


Підтвердити постачальника
  [Arguments]  ${user_name}  ${tender_id}  ${award_num}
  Wait For Ajax
  Wait For Element With Reload  css=button[tid='btn.award.active']  4
  Click Button  css=button[tid='btn.award.active']
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='defaultOk']  ${COMMONWAIT}
  Click Element  css=button[tid='defaultOk']


Завантажити угоду до тендера
  [Arguments]  ${username}  ${tender_id}  ${contract_num}  ${file_path}
  Wait Until Element Is Visible  xpath=//*[@tid='docContract']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='docsContractI']").className = ''
  Sleep  2s
  Choose File  css=input[id='docsContractI']  ${file_path}
  Sleep  10s
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Wait Until Element Is Enabled  xpath=//*[@tid='contractConfirm']  ${COMMONWAIT}
  Click Element  xpath=//*[@tid='contractConfirm']
  Wait For Ajax
  Close Confirmation
  Wait Until Element Is Not Visible  xpath=//*[@tid='contractConfirm']  ${COMMONWAIT}


Підтвердити підписання контракту
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
  Wait For Ajax
  Wait Until Element Is Enabled  xpath=//input[@tid='contractNumber']  ${COMMONWAIT}
  Input Text  xpath=//input[@tid='contractNumber']  ${contract_num}
  Wait Visibulity And Click Element  xpath=//*[@tid='contractActivate']
  Wait For Ajax
  Close Confirmation
  Wait Until Element Is Not Visible  xpath=//*[@tid='contractActivate']  ${COMMONWAIT}


Скасувати закупівлю
  [Arguments]  ${username}  ${tender_uaid}  ${reason}  ${doc_path}  ${description}
  privatmarket.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Enable And Click Element  css=button[tid='btn.cancellationLot']
  Wait For Ajax

  #add doc
  Wait Until Element Is Visible  css=button[tid='docCancellation']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("#docsCancellation").className = ''
  Sleep  2s
  Choose File  css=#docsCancellation  ${doc_path}
  Wait For Ajax

  #input description
  Wait Until Element Is Enabled  css=input[tid='cancellation.description']
  Input text  css=input[tid='cancellation.description']  ${description}

  #input reason
  Input text  css=input[tid='cancellation.reason']  ${reason}

  #confirm
  Click Button  css=button[tid='btn.cancellation']

  Sleep  10s
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  60
  Wait Until Element Is Visible  ${tender_data.cancellations[0].status}  ${COMMONWAIT}


Завантажити документ рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${file_path}  ${tender_id}  ${award_num}
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='btn.award.disqualify']  ${COMMONWAIT}
  Click Element  css=button[tid='btn.award.disqualify']
  Wait Until Element Is Visible  css=button[tid='btn.award.addDocForCancel']  ${COMMONWAIT}
  ${file_input_path}=  Set Variable  //button[@tid='btn.award.addDocForCancel']/following-sibling::input
  Execute Javascript  document.evaluate("${file_input_path}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.className = ''
  Sleep  2s
  Choose File  xpath=${file_input_path}  ${file_path}
  Wait For Ajax


Дискваліфікувати постачальника
  [Arguments]  ${username}  ${tender_id}  ${award_num}  ${description}
  ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=button[tid='btn.award.disqualify']  5
  Run Keyword If  ${status}  Дискваліфікувати з документом  ${award_num}
  ...  ELSE  Дискваліфікувати без документа  ${award_num}


Дискваліфікувати з документом
  [Arguments]  ${award_num}
  ${file_path}  ${file_title}  ${file_content}=  create_fake_doc
  Click Button  css=button[tid='btn.award.disqualify']
  Wait Until Element Is Visible  css=button[tid='btn.award.addDocForCancel']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='rejectQualificationInput${award_num}']").className = ''
  Sleep  2s
  Choose File  css=input[id='rejectQualificationInput${award_num}']  ${file_path}
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='btn.award.unsuccessful']  ${COMMONWAIT}
  Click Button  css=button[tid='btn.award.unsuccessful']
  Wait For Ajax
  Reload Page


Дискваліфікувати без документа
  [Arguments]  ${award_num}
  Wait Until Element Is Visible  css=button[tid='btn.award.unsuccessful']  ${COMMONWAIT}
  Click Button  css=button[tid='btn.award.unsuccessful']
  Wait For Ajax
  Reload Page


Завантажити протокол аукціону
  [Arguments]  ${username}  ${tender_id}  ${file_path}  ${bid_index}
  privatmarket.Пошук тендера по ідентифікатору  ${username}  ${tender_id}
  Wait Until Element Is Visible  xpath=//*[@tid='docProtocol']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='docsProtocolI']").className = ''
  Sleep  2s
  Choose File  css=input[id='docsProtocolI']  ${file_path}
  Wait For Ajax
  Wait Until Element Is Enabled  xpath=//*[@tid='confirmProtocol']  ${COMMONWAIT}
  Click Element  xpath=//*[@tid='confirmProtocol']
  Sleep  20s


Завантажити протокол аукціону в авард
  [Arguments]  ${username}  ${tender_id}  ${file_path}  ${bid_index}
  #privatmarket.Пошук тендера по ідентифікатору  ${username}  ${tender_id}
  Wait Until Element Is Visible  xpath=//*[@tid='docProtocol']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='docsProtocolI']").className = ''
  Sleep  2s
  Choose File  css=input[id='docsProtocolI']  ${file_path}
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='confirmProtocol']  ${COMMONWAIT}
  Click Element  css=button[tid='confirmProtocol']
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='defaultOk']  ${COMMONWAIT}
  Click Element  css=button[tid='defaultOk']


Підтвердити наявність протоколу аукціону
  [Arguments]  ${user_name}  ${tender_id}  ${award_index}
  Wait For Ajax
  Wait Until Element Contains  ${tender_data.awards[${award_index}].status}  Очікується підписання договору


Скасування рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  Run Keyword If  'PrivatMarket_Provider' in '${username}'  Скасувати рішення для ролі provider  ${username}  ${tender_uaid}  ${award_num}
  ...  ELSE  Скасувати рішення для ролі tender_owner  ${award_num}


Скасувати рішення для ролі provider
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  privatmarket.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait For Element With Reload  css=button[tid='btn.award.cancellation']  4
  Click Button  css=button[tid='btn.award.cancellation']
  Wait For Ajax
  Wait Until Element Is Visible  xpath=(//div[@tid='dialogModal']//button[contains(@class, 'btn btn-success')])[2]  ${COMMONWAIT}
  Click Button  xpath=(//div[@tid='dialogModal']//button[contains(@class, 'btn btn-success')])[2]
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='defaultOk']  ${COMMONWAIT}
  Click Element  css=button[tid='defaultOk']


Скасувати рішення для ролі tender_owner
  [Arguments]  ${award_num}
  Wait For Element With Reload  css=button[tid='btn.award.cancelled']  4
  Wait Until Element Is Visible  css=button[tid='btn.award.cancelled']  ${COMMONWAIT}
  ${buttons_list}=  Get Webelements  css=button[tid='btn.award.cancelled']
  Click Button  css=button[tid='btn.award.cancelled']
  Wait For Ajax
  Close Confirmation


Отримати тип оголошеного лоту
  [Arguments]  ${element}
  Wait Until Element Is Visible  ${tender_data.${element}}
  Wait For Element With Any Text  ${tender_data.${element}}
  ${result}=  Get Element Attribute  css=div[tid='data.procurementMethodType']@tidvalue
  [Return]  ${result}


Отримати кількість документів в тендері
  [Arguments]  ${user_name}  ${tender_id}
  Wait Until Element Is Visible  css=#fileitem  ${COMMONWAIT}
  ${result}=  Get Matching Xpath Count  //div[@id='fileitem']
  [Return]  ${result}


Отримати кількість предметів в тендері
  [Arguments]  ${user_name}  ${tender_id}
  Wait Until Element Is Visible  css=span[tid='item.classification.description']  ${COMMONWAIT}
  ${result}=  Get Matching Xpath Count  //span[@tid='item.classification.description']
  [Return]  ${result}


Login
  [Arguments]  ${username}
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Sleep  7s
  Wait Enable And Click Element  css=a[ui-sref='modal.login']

  Run Keyword If  'Owner' in '${username}'  Login with P24  ${username}
  Run Keyword If  'Provider' in '${username}'  Login with email  ${username}

  #Close message notification
  ${notification_visibility}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=button[ng-click='later()']
  Run Keyword If  '${notification_visibility}' == 'True'  Click Element  css=button[ng-click='later()']
  Wait Until Element Is Not Visible  css=button[ng-click='later()']
  Wait For Ajax
  Wait Until Element Is Visible  css=input[tid='global.search']  ${COMMONWAIT}


Login with P24
  [Arguments]  ${username}
  Wait Enable And Click Element  xpath=//a[contains(@href, 'https://bankid.privatbank.ua')]

  Wait Until Element Is Visible  id=inputLogin  5s
  Input Text  id=inputLogin  +${USERS.users['${username}'].login}
  Input Text  id=inputPassword  ${USERS.users['${username}'].password}
  Click Element  css=.btn.btn-success.custom-btn
  Wait Until Element Is Visible  css=input[id='first-section']  5s
  Input Text  css=input[id='first-section']  12
  Input Text  css=input[id='second-section']  34
  Input Text  css=input[id='third-section']  56
  Click Element  css=.btn.btn-success.custom-btn-confirm.sms
  Sleep  3s
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div#preloader  ${COMMONWAIT}
  Wait Until Element Is Not Visible  css=.btn.btn-success.custom-btn-confirm.sms


Login with email
  [Arguments]  ${username}

  Wait Until Element Is Visible  css=input[id='email']  5s
  Input Text  css=input[id='email']  ${USERS.users['${username}'].login}
  Input Text  css=input[id='password']  ${USERS.users['${username}'].password}
  Click Element  css=button[type='submit']

  Sleep  3s
  Wait For Ajax
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Wait Until Element Is Not Visible  css=button[type='submit']


Wait For Ajax
  Get Location
  Sleep  4s


Wait Until Element Not Stale
  [Arguments]  ${locator}  ${time}
  Sleep  2s
  ${left_time}=  sum_of_numbers  ${time}  -2
  ${element_state}=  Check If Element Stale  ${locator}
  Run Keyword If  ${element_state} and ${left_time} > 0  Wait Until Element Not Stale  ${locator}  ${left_time}


Check If Element Stale
  [Arguments]  ${locator}
  ${element}=  Get Webelement  ${locator}
  ${element_state}=  is_element_not_stale  ${element}
  [Return]  ${element_state}


Wait Enable And Click Element
  [Arguments]  ${elementLocator}
  Wait Until Element Is Enabled  ${elementLocator}  ${COMMONWAIT}
  Click Element  ${elementLocator}
  Wait For Ajax


Wait Visibulity And Click Element
  [Arguments]  ${elementLocator}
  Wait Until Element Is Visible  ${elementLocator}  ${COMMONWAIT}
  Click Element  ${elementLocator}
  Wait For Ajax


Wait For Element Value
  [Arguments]  ${locator}
  Wait For Ajax
  ${cssLocator}=  Get Substring  ${locator}  4
  Wait For Condition  return window.$($("${cssLocator}")).val()!='' && window.$($("${cssLocator}")).val()!='None'  ${COMMONWAIT}
  ${value}=  get value  ${locator}


Get Locator And Type
  [Arguments]  ${full_locator}
  ${temp_locator}=  Replace String  ${full_locator}  '  ${EMPTY}
  ${locator}=  Run Keyword If  'css' in '${temp_locator}'  Get Substring  ${full_locator}  4
  ...  ELSE IF  'xpath' in '${temp_locator}'  Get Substring  ${full_locator}  6
  ...  ELSE  ${full_locator}

  ${type}=  Set Variable If  'css' in '${temp_locator}'  css
  ...  'xpath' in '${temp_locator}'  xpath
  ...  None
  [Return]  ${locator}  ${type}


Wait For Auction
  [Arguments]  ${tender_id}
  Wait Until Keyword Succeeds  5min  10s  Try Search Auction  ${tender_id}


Try Search Auction
  [Arguments]  ${tender_id}
  Wait For Ajax
  Wait Until element Is Enabled  css=input[tid='global.search']  ${COMMONWAIT}

  #заполним поле поиска
  ${text_in_search}=  Get Value  css=input[tid='global.search']
  Run Keyword Unless  '${tender_id}' == '${text_in_search}'  Run Keywords  Clear Element Text  css=input[tid='global.search']
  ...  AND  Input Text  css=input[tid='global.search']  ${tender_id}

  #выполним поиск
  Press Key  css=input[tid='global.search']  \\13
  Wait Until Element Is Not Visible  css=div.progress.progress-bar  ${COMMONWAIT}
  Wait Until Element Is Not Visible  css=div[role='dialog']  ${COMMONWAIT}
  Wait Until Element Not Stale  css=a[tid='${tender_id}']  ${COMMONWAIT}
  Wait Until Element Is Visible  css=a[tid='${tender_id}']  ${COMMONWAIT}
  [Return]  True


Try Search Element
  [Arguments]  ${locator}
  Reload Page
  Wait For Ajax
  Wait Until Element Is Visible  ${locator}  7
  Wait Until Element Is Enabled  ${locator}  5
  [Return]  True


Try Search Element With Text
  [Arguments]  ${locator}  ${text}
  Reload Page
  Wait For Ajax
  Wait Until Element Contains  ${locator}  ${text}  3s
  [Return]  True


Wait For Element With Reload
  [Arguments]  ${locator}  ${time_to_wait}=4
  Wait Until Keyword Succeeds  ${time_to_wait}min  15s  Try Search Element  ${locator}


Set Date
  [Arguments]  ${element}  ${date}
  ${locator}  ${type}=  Get Locator And Type  ${element}
  ${correctDate}=  Get Regexp Matches  ${date}  (\\d{4}-\\d{2}-\\d{2})  1
  ${correctDate}=  Convert Date  ${correctDate[0]}  result_format=%d/%m/%Y
  ${correctDate}=  Convert To String  ${correctDate}
  Input Text  ${element}  ${correctDate}


Set Time
  [Arguments]  ${element_hour}  ${element_min}  ${date}
  ${hour}=  Get Regexp Matches  ${date}  T(\\d{2}):\\d{2}  1
  ${min}=  Get Regexp Matches  ${date}  T\\d{2}:(\\d{2})  1
  Input Text  ${element_hour}  ${hour}
  Input Text  ${element_min}  ${min}


Set Date And Time
  [Arguments]  ${date_element}  ${element_hour}  ${element_min}  ${date}
  Wait Until Element Is Visible  ${element_min}  timeout=${COMMONWAIT}
  Set Date  ${date_element}  ${date}
  Set Time  ${element_hour}  ${element_min}  ${date}


Get Index Number
  [Arguments]  ${elements}  ${element_index}
  ${elementsList}=  Get Webelements  ${elements}
  ${elementByIndex}=  Get From List  ${elementsList}  ${element_index}
  ${index}=  Get Index From List  ${elementsList}  ${elementByIndex}
  ${index}=  sum_of_numbers  ${index}  1
  [Return]  ${index}


Wait For Element With Any Text
  [Arguments]  ${element}
  Wait Until Keyword Succeeds  1min  5s  Try Wait For Element With Any Text  ${element}


Try Wait For Element With Any Text
  [Arguments]  ${element}
  Wait Until Element Is Visible  ${element}  ${COMMONWAIT}
  ${text}=  Get Text  ${element}
  Should Not Be Equal As Strings  ${text}  ${EMPTY}


Close Confirmation
  Wait Until Element Is Visible  xpath=//*[@tid='dialogModal']//*[@tid='defaultOk']  ${COMMONWAIT}
  Click Element  xpath=//*[@tid='dialogModal']//*[@tid='defaultOk']
  Wait For Ajax
  Wait Until Element Is Not Visible  xpath=//*[@tid='dialogModal']//*[@tid='defaultOk']  ${COMMONWAIT}
