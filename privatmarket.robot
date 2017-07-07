*** Settings ***
Library  String
Library  DateTime
Library  Selenium2Library
Library  Collections
Library  DebugLibrary
Library  privatmarket_service.py

*** Variables ***
${COMMONWAIT}  40s
${locator_tenderSearch.searchInput}  css=input#search-query-input
${locator_tender.switchToDemo}  css=a#test-model-switch
${locator_tender.switchToDemoMessage}  css=.test-mode-popup-content.ng-binding
${locator_tenderSearch.addTender}  css=button[data-id='createNewTenderBtn']
${locator_lotAdd.postalCode}  css=input[data-id='postalCode']
${locator_lotAdd.countryName}  css=input[data-id='countryName']
${locator_lotAdd.region}  css=input[data-id='region']
${locator_lotAdd.locality}  css=input[data-id='locality']
${locator_lotAdd.streetAddress}  css=input[data-id='streetAddress']
${locator_tenderAdd.btnSave}  css=button[data-id='actSave']
${locator_tenderCreation.buttonSend}  css=button[data-id='actSend']
${locator_tenderClaim.buttonCreate}  css=button[data-id='editProcBtn']

${tender_data_title}  xpath=//div[contains(@class,'title-div')]
${tender_data_description}  id=tenderDescription
${tender_data_procurementMethodType}  id=tenderType
${tender_data_status}  id=tenderStatus
${tender_data_value.amount}  id=tenderBudget
${tender_data_value.currency}  id=tenderBudgetCcy
${tender_data_value.valueAddedTaxIncluded}  id=tenderBudgetTax
${tender_data_tenderID}  css=#tenderId
${tender_data_procuringEntity.name}  css=a[ng-click='commonActions.openCard()']
${tender_data_enquiryPeriod.startDate}  xpath=(//span[@ng-if='p.bd'])[1]
${tender_data_enquiryPeriod.endDate}  xpath=(//span[contains(@ng-if, 'p.ed')])[1]
${tender_data_tenderPeriod.startDate}  xpath=(//span[@ng-if='p.bd'])[2]
${tender_data_tenderPeriod.endDate}  xpath=(//span[contains(@ng-if, 'p.ed')])[2]
${tender_data_auctionPeriod.startDate}  xpath=(//span[@ng-if='p.bd'])[3]
${tender_data_minimalStep.amount}  css=div#lotMinStepAmount
${tender_data_documentation.title}  xpath=//div[contains(@class, 'doc-file-title')]
${tender_data_documents[0].title}  xpath=//div[contains(@class, 'doc-file-title')]
${tender_data_qualificationPeriod.endDate}  xpath=(//span[contains(@ng-if, 'p.ed')])[4]
${tender_data_causeDescription}  css=#tenderType div.question-div>div:nth-of-type(1)
${tender_data_cause}  css=#tenderType>.action-element

${tender_data_item.description}  //div[@class='description']//span)
${tender_data_item.deliveryDate.startDate}  //div[@ng-if='adb.deliveryDate.startDate']/div[2])
${tender_data_item.deliveryDate.endDate}  //div[@ng-if='adb.deliveryDate.endDate']/div[2])
${tender_data_item.deliveryLocation.latitude}  //span[contains(@class, 'latitude')])
${tender_data_item.deliveryLocation.longitude}  //span[contains(@class, 'longitude')])
${tender_data_item.deliveryAddress.countryName}  //span[@id='countryName'])
${tender_data_item.deliveryAddress.countryName_ru}  //span[@id='countryName'])
${tender_data_item.deliveryAddress.countryName_en}  //span[@id='countryName'])
${tender_data_item.deliveryAddress.postalCode}  //span[@id='postalCode'])
${tender_data_item.deliveryAddress.region}  //span[@id='region'])
${tender_data_item.deliveryAddress.locality}  //span[@id='locality'])
${tender_data_item.deliveryAddress.streetAddress}  //span[@id='streetAddress'])
${tender_data_item.classification.scheme}  //span[contains(@class, 'cl-scheme')])[1]
${tender_data_item.classification.id}  //span[contains(@class, 'cl-id')])[1]
${tender_data_item.classification.description}  //span[contains(@class, 'cl-name')])[1]
${tender_data_item.additionalClassifications[0].scheme}  //span[contains(@class, 'cl-scheme')])[2]
${tender_data_item.additionalClassifications[0].id}  //span[contains(@class, 'cl-id')])[2]
${tender_data_item.additionalClassifications[0].description}  //span[contains(@class, 'cl-name')])[2]
${tender_data_item.unit.name}  //div[@ng-if='adb.quantity']/div[2]/span[2])
${tender_data_item.unit.code}  //div[@ng-if='adb.quantity']/div[2]/span[2])
${tender_data_item.quantity}  //div[@ng-if='adb.quantity']/div[2]/span)

${tender_data_lot.title}  //div[@id='lot-title'])
${tender_data_lot.description}  //section[contains(@class, 'description marged')])
${tender_data_lot.value.amount}  //div[@id='lotAmount'])
${tender_data_lot.value.currency}  //div[@id='lotCcy'])
${tender_data_lot.value.valueAddedTaxIncluded}  //div[@id='lotTax'])
${tender_data_lot.minimalStep.amount}  //div[@id='lotMinStepAmount'])
${tender_data_lot.minimalStep.currency}  //div[@id='lotMinStepCcy'])
${tender_data_lot.minimalStep.valueAddedTaxIncluded}  //div[@id='lotMinStepTax'])

${tender_data_question.title}  //span[contains(@class, 'question-title')])
${tender_data_question.description}  //div[@class='question-div']/div[1])
${tender_data_question.answer}  //div[@class='question-div question-expanded']/div[1])

${tender_data_lot_question.title}  //span[contains(@class, 'question-title')]
${tender_data_lot_question.description}  //div[@class='question-div']/div[1]
${tender_data_lot_question.answer}  //div[@class='question-div question-expanded']/div[1]

${tender_data_feature.featureOf}  /../../../*[1]

${tender_data_complaint.status}  //span[contains(@id, 'cmplStatus')]
${tender_data_complaint.resolutionType}  //div[contains(@ng-if,"resolutionType")]
${tender_data_complaint.resolution}  //div[@class="question-answer title ng-scope"]//div[@class="question-div"]/div[1]
${tender_data_complaint.satisfied}  //span[contains(@data-id, 'satisfied')]
${tender_data_complaint.cancellationReason}  //*[@description='q.cancellationReason']/div/div[1]
${tender_data_complaint.title}  //span[contains(@class, 'claimHead')]
${tender_data_complaint.description}  //div[@class='question-div']

${tender_data_procuringEntity.address.countryName}  css=.delivery-info-container [data-id='address.countryName']
${tender_data_procuringEntity.address.locality}  css=.delivery-info-container [data-id='address.locality']
${tender_data_procuringEntity.address.postalCode}  css=.delivery-info-container [data-id='address.postalCode']
${tender_data_procuringEntity.address.region}  css=.delivery-info-container [data-id='address.region']
${tender_data_procuringEntity.address.streetAddress}  css=.delivery-info-container [data-id='address.streetAddress']
${tender_data_procuringEntity.contactPoint.name}  css=[data-id='contactPoint.name']
${tender_data_procuringEntity.contactPoint.telephone}  css=[data-id='contactPoint.telephone']
${tender_data_procuringEntity.contactPoint.url}  css=[data-id='contactPoint.url']
${tender_data_procuringEntity.identifier.legalName}  css=[data-id='identifier.legalName']
${tender_data_procuringEntity.identifier.scheme}  css=[data-id='identifier.scheme']
${tender_data_procuringEntity.identifier.id}  css=[data-id='identifier.id']

${tender_data_awards[0].documents[0].title}  css=.participant-info-block .doc-file-title
${tender_data_awards[0].status}  css=.lot-info tbody tr:nth-of-type(1) td:nth-of-type(4)>a
${tender_data_awards[0].suppliers[0].address.countryName}  css=.participant-info-block [data-id='address.countryName']
${tender_data_awards[0].suppliers[0].address.locality}  css=.participant-info-block [data-id='address.locality']
${tender_data_awards[0].suppliers[0].address.postalCode}  css=.participant-info-block [data-id='address.postalCode']
${tender_data_awards[0].suppliers[0].address.region}  css=.participant-info-block [data-id='address.region']
${tender_data_awards[0].suppliers[0].address.streetAddress}  css=.participant-info-block [data-id='address.streetAddress']
${tender_data_awards[0].suppliers[0].contactPoint.telephone}  css=.participant-info-block [data-id='contactPoint.telephone']
${tender_data_awards[0].suppliers[0].contactPoint.name}  css=.participant-info-block [data-id='contactPoint.name']
${tender_data_awards[0].suppliers[0].contactPoint.email}  css=.participant-info-block [data-id='contactPoint.email']
${tender_data_awards[0].suppliers[0].identifier.scheme}  css=.participant-info-block [data-id='identifier.scheme']
${tender_data_awards[0].suppliers[0].identifier.legalName}  css=.participant-info-block [data-id='identifier.legalName']
${tender_data_awards[0].suppliers[0].identifier.id}  css=.participant-info-block [data-id='identifier.id']
${tender_data_awards[0].suppliers[0].name}  css=.participant-info-block [data-id='identifier.legalName']
${tender_data_awards[0].value.valueAddedTaxIncluded}  css=.participant-info-block [data-id='value.valueAddedTaxIncluded']
${tender_data_awards[0].value.currency}  css=.participant-info-block [data-id='value.currency']
${tender_data_awards[0].value.amount}  css=.participant-info-block [data-id='value.amount']
${tender_data_contracts[0].status}  css=.modal.fade.in .modal-body:nth-of-type(2) .info-item:nth-of-type(10) .info-item-val


*** Keywords ***
Підготувати дані для оголошення тендера
    [Arguments]  ${username}  ${tender_data}  ${role_name}
#    ${tender_data.data}=  Run Keyword If  'PrivatMarket_Owner' == '${username}'  privatmarket_service.modify_test_data  ${tender_data.data}
    ${tender_data.data}=  privatmarket_service.modify_test_data  ${tender_data.data}
    ${adapted.data}=  privatmarket_service.modify_test_data  ${tender_data.data}
    [Return]  ${tender_data}


Підготувати клієнт для користувача
    [Arguments]  ${username}
    [Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо
    ${service args}=  Create List  --ignore-ssl-errors=true  --ssl-protocol=tlsv1
    ${browser}=  Convert To Lowercase  ${USERS.users['${username}'].browser}
    ${disabled}  Create List  Chrome PDF Viewer
    ${prefs}  Create Dictionary  download.default_directory=${OUTPUT_DIR}  plugins.plugins_disabled=${disabled}
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method  ${chrome_options}  add_argument  --allow-running-insecure-content
    Call Method  ${chrome_options}  add_argument  --disable-web-security
    Call Method  ${chrome_options}  add_argument  --nativeEvents\=false
    Call Method  ${chrome_options}  add_experimental_option  prefs  ${prefs}
#    Call Method  ${chrome_options}  add_argument  --user-data-dir\=/home/lugovskoy/.config/google-chrome/Default

    #Для Viewer'а нужен хром, т.к. на хром настроена автоматическая закачка файлов
    Run Keyword If  '${username}' == 'PrivatMarket_Viewer'  Create WebDriver  Chrome  chrome_options=${chrome_options}  alias=${username}
    Run Keyword If  '${username}' == 'PrivatMarket_Owner'  Create WebDriver  Chrome  chrome_options=${chrome_options}  alias=${username}
    Run Keyword If  '${username}' == 'PrivatMarket_Provider'  Create WebDriver  Firefox  chrome_options=${chrome_options}  alias=${username}
    Go To  ${USERS.users['${username}'].homepage}

#    Open Browser  ${USERS.users['${username}'].homepage}  ${browser}  alias=${username}
    Set Window Size  @{USERS.users['${username}'].size}
    Set Selenium Implicit Wait  10s
    Login  ${username}
    Switch To PMFrame


Пошук тендера по ідентифікатору
    [Arguments]  ${username}  ${tenderId}
    Go To  ${USERS.users['${username}'].homepage}
    Close notification
    Wait Until Element Is Visible  ${locator_tenderSearch.searchInput}  timeout=${COMMONWAIT}

    ${suite_name}=  Convert To Lowercase  ${SUITE_NAME}
    ${education_type}=  Run Keyword If  'negotiation' in '${suite_name}'  Set Variable  False
        ...  ELSE  Set Variable  True

    Wait For Tender  ${tenderId}  ${education_type}
    Wait Visibility And Click Element  css=tr#${tenderId}
    Sleep  5s
    Switch To PMFrame
    Wait Until Element Is Visible  ${tender_data_title}  ${COMMONWAIT}


Створити тендер
    [Arguments]  ${username}  ${tender_data}
    ${presence}=  Run Keyword And Return Status  List Should Contain Value  ${tender_data.data}  lots
    @{lots}=  Run Keyword If  ${presence}  Get From Dictionary  ${tender_data.data}  lots
    ${presence}=  Run Keyword And Return Status  List Should Contain Value  ${tender_data.data}  items
    @{items}=  Run Keyword If  ${presence}  Get From Dictionary  ${tender_data.data}  items
    ${presence}=  Run Keyword And Return Status  List Should Contain Value  ${tender_data.data}  features
    @{features}=  Run Keyword If  ${presence}  Get From Dictionary  ${tender_data.data}  features
    Switch To PMFrame
    Close notification
    Wait Until Element Is Visible  ${locator_tenderSearch.searchInput}  ${COMMONWAIT}
    Check Current Mode New Realisation

#go to form
    Wait For Ajax
    Wait Visibility And Click Element  ${locator_tenderSearch.addTender}
    Unselect Frame
    Wait Until Page Contains Element  id=sender-analytics  ${COMMONWAIT}
    Switch To PMFrame
    ${status}  ${type}=  Run Keyword And Ignore Error  Set Variable  '${tender_data.data.procurementMethodType}'
    ${type}=  Run Keyword If
    ...  '${status}' == 'PASS'  Set Variable  ${type}
    ...  ELSE  Set Variable  ''

    Run Keyword IF
    ...  ${type} == 'aboveThresholdEU'  Wait Visibility And Click Element  css=a[data-id='choosedPrzAboveThresholdEU']
    ...  ELSE IF  ${type} == 'aboveThresholdUA'  Wait Visibility And Click Element  css=a[data-id='choosedPrzAboveThresholdUA']
    ...  ELSE IF  ${type} == 'negotiation'  Wait Visibility And Click Element  css=a[data-id='choosedPrzNegotiation']
    ...  ELSE  Wait Visibility And Click Element  css=a[data-id='choosedPrzBelowThreshold']


#step 0
    #we should add choosing of procurementMethodType
    Wait For Ajax
    Wait Element Visibility And Input Text  css=input[data-id='procurementName']  ${tender_data.data.title}
    Wait Element Visibility And Input Text  css=textarea[data-id='procurementDescription']  ${tender_data.data.description}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=.procurementName input[data-id='procurementNameEn']  ${tender_data.data.title_en}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=textarea[data-id='procurementDescriptionEn']  ${tender_data.data.description_en}

    #CPV
    Wait Visibility And Click Element  xpath=(//span[@data-id='actChoose'])[1]
    Wait Until Element Is Visible  css=section[data-id='classificationTreeModal']  ${COMMONWAIT}
    Wait Until Element Is Visible  css=input[data-id='query']  ${COMMONWAIT}
    Search By Query  css=input[data-id='query']  ${items[0].classification.id}
    Wait Visibility And Click Element  css=button[data-id='actConfirm']
    Run Keyword If  '${items[0].classification.id}' == '99999999-9'  Обрати додаткові класифікатори   ${items[0].additionalClassifications[0].scheme}   ${items[0].additionalClassifications[0].id}

    #date
    Wait For Ajax
    Run Keyword Unless  ${type} == 'aboveThresholdEU' or ${type} == 'aboveThresholdUA' or ${type} == 'negotiation'  Set Enquiry Period  ${tender_data.data.enquiryPeriod.startDate}  ${tender_data.data.enquiryPeriod.endDate}
    Run Keyword Unless  ${type} == 'negotiation'  Set Tender Period  ${tender_data.data.tenderPeriod.startDate}  ${tender_data.data.tenderPeriod.endDate}
    Run Keyword If  ${type} == 'complaints'  Wait Visibility And Click Element  xpath=//span[@class='lot_budget_tax ng-scope']//label[contains(@for,'tax_')]

    #cause
    Run Keyword If  ${type} == 'negotiation'  Обрати підставу вибору переговорної процедури  ${tender_data}
    Run Keyword If  ${type} == 'negotiation'  Wait Element Visibility And Input Text  css=textarea[data-id='causeDescription']  ${tender_data.data.causeDescription}

    #procuringEntityAddress
    Wait Element Visibility And Input Text  ${locator_lotAdd.postalCode}  ${tender_data.data.procuringEntity.address.postalCode}
    Wait Element Visibility And Input Text  ${locator_lotAdd.countryName}  ${tender_data.data.procuringEntity.address.countryName}
    Wait Element Visibility And Input Text  ${locator_lotAdd.region}  ${tender_data.data.procuringEntity.address.region}
    Wait Element Visibility And Input Text  ${locator_lotAdd.locality}  ${tender_data.data.procuringEntity.address.locality}
    Wait Element Visibility And Input Text  ${locator_lotAdd.streetAddress}  ${tender_data.data.procuringEntity.address.streetAddress}

    #contactPoint
    Wait Element Visibility And Input Text  css=input[data-id='name']  ${tender_data.data.procuringEntity.contactPoint.name}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=section[data-id='contactPoint'] input[data-id='nameEn']  ${tender_data.data.procuringEntity.contactPoint.name_en}

    ${modified_phone}=  Remove String  ${tender_data.data.procuringEntity.contactPoint.telephone}  ${SPACE}
    ${modified_phone}=  Remove String  ${modified_phone}  -
    ${modified_phone}=  Remove String  ${modified_phone}  (
    ${modified_phone}=  Remove String  ${modified_phone}  )
    ${modified_phone}=  Set Variable If  '+38' in '${modified_phone}'  ${modified_phone}  +38067${modified_phone}
    ${modified_phone}=  Get Substring  ${modified_phone}  0  13
    Wait Element Visibility And Input Text  css=section[data-id='contactPoint'] input[data-id='telephone']  ${modified_phone}
    Wait Element Visibility And Input Text  css=section[data-id='contactPoint'] input[data-id='email']  ${USERS.users['${username}'].email}
    Wait Element Visibility And Input Text  css=section[data-id='contactPoint'] input[data-id='url']  ${tender_data.data.procuringEntity.contactPoint.url}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=section[data-id='addContactPoint'] input[data-id='name']  ${tender_data.data.procuringEntity.contactPoint.name}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=section[data-id='addContactPoint'] input[data-id='nameEn']  ${tender_data.data.procuringEntity.contactPoint.name_en}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=section[data-id='addContactPoint'] input[data-id='telephone']  ${modified_phone}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=section[data-id='addContactPoint'] input[data-id='email']  ${USERS.users['${username}'].email}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=.procuringEntityName input[data-id='procurementNameEn']  ${tender_data.data.procuringEntity.name_en}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}

#step 1
    Додати lots  ${lots}  ${items}  ${type}

    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Run Keyword If  ${type} == 'negotiation'  Wait Until Element Is Visible  css=label[for='documentation_tender_yes']  ${COMMONWAIT}
    ...  ELSE  Wait Until Element Is Visible  css=section[data-id='step3']  ${COMMONWAIT}

#step 3
    Wait For Ajax
    Run Keyword IF
    ...  ${type} == 'aboveThresholdEU'  Додати нецінові показники  ${features}  ${type}
    ...  ELSE IF  ${type} == 'aboveThresholdUA'  Додати нецінові показники  ${features}  ${type}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}

#step 4
    Run Keyword Unless  ${type} == 'negotiation'  Wait Until Element Is Visible  css=section[data-id='step4']  ${COMMONWAIT}
    Run Keyword Unless  ${type} == 'negotiation'  Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}

#step 5
    Wait Until Element Is Visible  css=section[data-id='step5']  ${COMMONWAIT}
    Sleep  3s
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
    Switch To PMFrame

    Run Keyword IF
    ...  ${type} == 'aboveThresholdEU'  Wait For Element With Reload  xpath=//div[@id='tenderStatus' and contains(., 'Подача пропозицій')]  1
    ...  ELSE IF  ${type} == 'aboveThresholdUA'  Wait For Element With Reload  xpath=//div[@id='tenderStatus' and contains(., 'Подача пропозицій')]  1
    ...  ELSE IF  ${type} == 'negotiation'  Wait For Element With Reload  xpath=//div[@id='tenderStatus' and contains(., 'Звіт')]  1
    ...  ELSE  Wait For Element With Reload  xpath=//div[@id='tenderStatus' and contains(., 'Період уточнень')]  1

    ${tender_id}=  Get Text  ${tender_data_tenderID}
    [Return]  ${tender_id}


Додати lots
    [Arguments]  ${lots}  ${items}  ${type}
    ${lots_count}=  Get Length  ${lots}
    Wait For Ajax

    : FOR  ${index}  IN RANGE  0  ${lots_count}
    \  ${lot_index}=  privatmarket_service.sum_of_numbers  ${index}  1
    \  Run Keyword Unless  '${lot_index}' == '1'  Wait Visibility And Click Element  css=button[data-id='actAddLot']
    \  Wait Element Visibility And Input Text  xpath=(//input[@data-id='title'])[${lot_index}]  ${lots[${index}].title}
    \  Wait Element Visibility And Input Text  xpath=(//textarea[@data-id='description'])[${lot_index}]  ${lots[${index}].description}
    \  ${value_amount}=  privatmarket_service.convert_float_to_string  ${lots[${index}].value.amount}
    \  Wait Element Visibility And Input Text  xpath=(//input[@data-id='valueAmount'])[${lot_index}]  ${value_amount}
    \  Sleep  3s
    \  Run Keyword Unless  ${type} == 'negotiation'  Ввести мінімальний крок  ${lots}  ${index}  ${lot_index}
    \  Run Keyword Unless  ${type} == 'negotiation'  Wait Visibility And Click Element  xpath=(//label[contains(@for,'guarantee')])[${lot_index}]
    \  Run Keyword Unless  ${type} == 'negotiation'  Wait Element Visibility And Input Text  xpath=(//input[@data-id='guaranteeAmount'])[${lot_index}]  1
    \  Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  xpath=(//input[@data-id='titleEn'])[${lot_index}]  ${lots[${index}].title_en}
    \  Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  xpath=(//textarea[@data-id='descriptionEn'])[${lot_index}]  ${lots[${index}].description}
    \  ${count}=  Get Length  ${items}
    \  Run Keyword If  ${count} > 0  Додати items  ${items}  ${lot_index}  ${lots[${index}].id}  ${type}


Додати items
    [Arguments]  ${items}  ${lot_index}  ${lot_id}  ${type}
    ${lot_items}=  privatmarket_service.get_items_from_lot  ${items}  ${lot_id}
    ${items_count}=  Get Length  ${lot_items}
    Wait For Ajax
    : FOR  ${index}  IN RANGE  0  ${items_count}
    \  Додати item до лоту  ${lot_items}  ${items_count}  ${lot_index}  ${index}  ${type}


Додати item до лоту
    [Arguments]  ${items}  ${items_count}  ${lot_index}  ${index}  ${type}
    ${item_index}=  privatmarket_service.sum_of_numbers  ${index}  1
    Run Keyword Unless  '${item_index}' == '1'  Wait Visibility And Click Element  xpath=(//button[@data-id='actAddItem'])[${lot_index}]
    Wait Element Visibility And Input Text  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='description']  ${items[${index}].description}
    Wait Element Visibility And Input Text  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='quantity']  ${items[${index}].quantity}
    ${unitName}=  Run Keyword If
    ...  ${type} == 'aboveThresholdEU'  privatmarket_service.get_unit_name_ru  ${items[${index}].unit.name}
    ...  ELSE  privatmarket_service.get_unit_name  ${items[${index}].unit.name}
    Wait Visibility And Click Element  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//select[@data-id='unit']/option[text()='${unitName}']

    #CPV
    Wait Visibility And Click Element  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//span[@data-id='actChoose']
    Wait Until Element Is Visible  css=section[data-id='classificationTreeModal']  ${COMMONWAIT}
    Wait Until Element Is Visible  css=input[data-id='query']  ${COMMONWAIT}
    Search By Query  css=input[data-id='query']  ${items[${index}].classification.id}
    Wait Visibility And Click Element  css=button[data-id='actConfirm']

    ${deliveryStartDate}=  Get Regexp Matches  ${items[${index}].deliveryDate.startDate}  (\\d{4}-\\d{2}-\\d{2})
    ${deliveryStartDate}=  Convert Date  ${deliveryStartDate[0]}  result_format=%d-%m-%Y
    ${deliveryEndDate}=  Get Regexp Matches  ${items[${index}].deliveryDate.endDate}  (\\d{4}-\\d{2}-\\d{2})
    ${deliveryEndDate}=  Convert Date  ${deliveryEndDate[0]}  result_format=%d-%m-%Y
    Wait Visibility And Click Element  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//section[@data-id='deliveryAddress']//input[@type='radio']
    Wait Element Visibility And Input Text  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='postalCode']  ${items[${index}].deliveryAddress.postalCode}
    Wait Element Visibility And Input Text  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='countryName']  ${items[${index}].deliveryAddress.countryName}
    Wait Element Visibility And Input Text  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='region']  ${items[${index}].deliveryAddress.region}
    Wait Element Visibility And Input Text  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='locality']  ${items[${index}].deliveryAddress.locality}
    Wait Element Visibility And Input Text  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='streetAddress']  ${items[${index}].deliveryAddress.streetAddress}
    Wait Until Element Is Visible  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='deliveryPeriodEnd']  ${COMMONWAIT}
    ${abs_item_index}=  privatmarket_service.get_abs_item_index  ${lot_index}  ${index}  ${items_count}
    Set Date In Item  ${abs_item_index}  deliveryDate  sd  startDate  ${items[${index}].deliveryDate.startDate}
    Set Date In Item  ${abs_item_index}  deliveryDate  ed  endDate  ${items[${index}].deliveryDate.endDate}
    Run Keyword IF  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  xpath=//div[@data-id='lot'][${lot_index}]//div[@data-id='item'][${item_index}]//input[@data-id='descriptionEn']  ${items[${index}].description_en}


Додати нецінові показники
    [Arguments]  ${features}  ${type}
    Wait For Ajax

    #add tender feature
    Wait Visibility And Click Element  css=label[for='features_tender_yes']
    Wait Element Visibility And Input Text  css=[data-id='ptrFeatures'] [ng-model='feature.title']  ${features[1].title}
    Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=[data-id='ptrFeatures'] [ng-model='feature.title_en']  ${features[1].title_en}
    Wait Element Visibility And Input Text  css=[data-id='ptrFeatures'] [ng-model='feature.description']  ${features[1].description}
    Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=[data-id='ptrFeatures'] [ng-model='feature.description_en']  ${features[1].description}

    @{tender_enums}=  Get From Dictionary  ${features[1]}  enum
    ${tender_criterion_count}=  Get Length  ${tender_enums}

    : FOR  ${index}  IN RANGE  0  ${tender_criterion_count}
    \  Run Keyword Unless  '${index}' == '0'  Wait Visibility And Click Element  css=[data-id='ptrFeatures'] [data-id='criteria'] button
    \  ${tender_criterion_value}=  privatmarket_service.get_percent  ${tender_enums[${index}].value}
    \  ${tender_criterion_value}=  Convert to String  ${tender_criterion_value}
    \  ${elem_index}=  privatmarket_service.sum_of_numbers  ${index}  1
    \  Wait Element Visibility And Input Text  xpath=(//section[@data-id='ptrFeatures']//input[@data-id='value'])[${elem_index}]  ${tender_criterion_value}
    \  Wait Element Visibility And Input Text  xpath=(//section[@data-id='ptrFeatures']//input[@ng-model='criterion.title'])[${elem_index}]  ${tender_enums[${index}].title}
    \  Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  xpath=(//section[@data-id='ptrFeatures']//input[@ng-model='criterion.title_en'])[${elem_index}]  ${tender_enums[${index}].title}

    #add lot feature
    Wait Visibility And Click Element  css=label[for='features_lots_yes']
    Wait Visibility And Click Element  css=[data-id='lot'] button[data-id='actAdd']
    Wait Element Visibility And Input Text  css=[data-id='lot'] [ng-model='feature.title']  ${features[0].title}
    Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=[data-id='lot'] [ng-model='feature.title_en']  ${features[0].title_en}
    Wait Element Visibility And Input Text  css=[data-id='lot'] [ng-model='feature.description']  ${features[0].description}
    Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=[data-id='lot'] [ng-model='feature.description_en']  ${features[0].description}

    @{lot_enums}=  Get From Dictionary  ${features[0]}  enum
    ${lot_criterion_count}=  Get Length  ${lot_enums}

    : FOR  ${index}  IN RANGE  0  ${lot_criterion_count}
    \  Run Keyword Unless  '${index}' == '0'  Wait Visibility And Click Element  css=[data-id='lot'] [data-id='criteria'] button
    \  ${lot_criterion_value}=  privatmarket_service.get_percent  ${lot_enums[${index}].value}
    \  ${lot_criterion_value}=  Convert to String   ${lot_criterion_value}
    \  ${elem_index}=  privatmarket_service.sum_of_numbers  ${index}  1
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//input[@data-id='value'])[${elem_index}]  ${lot_criterion_value}
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//input[@ng-model='criterion.title'])[${elem_index}]  ${lot_enums[${index}].title}
    \  Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//input[@ng-model='criterion.title_en'])[${elem_index}]  ${lot_enums[${index}].title}

    #add item feature
    Wait Visibility And Click Element  css=label[for='features_item_yes']
    Wait Visibility And Click Element  css=[data-id='item'] button[data-id='actAdd']
    Wait Element Visibility And Input Text  css=[data-id='item'] [ng-model='feature.title']  ${features[2].title}
    Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=[data-id='item'] [ng-model='feature.title_en']  ${features[2].title_en}
    Wait Element Visibility And Input Text  css=[data-id='item'] [ng-model='feature.description']  ${features[2].description}
    Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  css=[data-id='item'] [ng-model='feature.description_en']  ${features[2].description}


    @{item_enums}=  Get From Dictionary  ${features[2]}  enum
    ${item_criterion_count}=  Get Length  ${item_enums}

    : FOR  ${index}  IN RANGE  0  ${item_criterion_count}
    \  Run Keyword Unless  '${index}' == '0'  Wait Visibility And Click Element  css=[data-id='item'] [data-id='criteria'] button
    \  ${item_criterion_value}=  privatmarket_service.get_percent  ${item_enums[${index}].value}
    \  ${item_criterion_value}=  Convert to String   ${item_criterion_value}
    \  ${elem_index}=  privatmarket_service.sum_of_numbers  ${index}  1
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='item']//input[@data-id='value'])[${elem_index}]  ${item_criterion_value}
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='item']//input[@ng-model='criterion.title'])[${elem_index}]  ${item_enums[${index}].title}
    \  Run Keyword If  ${type} == 'aboveThresholdEU'  Wait Element Visibility And Input Text  xpath=(//div[@data-id='item']//input[@ng-model='criterion.title_en'])[${elem_index}]  ${item_enums[${index}].title}


Обрати підставу вибору переговорної процедури
    [Arguments]  ${tender_data}
    Wait Visibility And Click Element  css=.cs-title .alink
    Wait For Ajax
    Wait Visibility And Click Element  css=input[value='${tender_data.data.cause}']
    Wait Visibility And Click Element  css=button[data-id='actConfirm']
    Wait For Ajax


Ввести мінімальний крок
    [Arguments]  ${lots}  ${index}  ${elem_index}
    ${minimalStep_amount}=  Convert to String  ${lots[${index}].minimalStep.amount}
    Wait Element Visibility And Input Text  xpath=(//input[@data-id='minimalStepAmount'])[${elem_index}]  ${minimalStep_amount}


Оновити сторінку з тендером
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...  ${ARGUMENTS[0]} == username
    ...  ${ARGUMENTS[1]} == tenderId
    Reload Page
    Sleep  2s
    Switch To PMFrame


Внести зміни в тендер
    [Arguments]  ${user_name}  ${tenderId}  ${parameter}  ${value}
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Switch To PMFrame
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}
    Wait Until Element Is Visible  css=input[data-id='tenderPeriodEnd']  ${COMMONWAIT}
    Run Keyword If  '${parameter}' == 'tenderPeriod'  Set Date And Time  tenderPeriod  endDate  css=input[data-id='tenderPeriodEnd']  ${value}
    Run Keyword If  '${parameter}' == 'description'  Wait Element Visibility And Input Text  css=textarea[data-id='procurementDescription']  ${value}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait Until Element Is Visible  css=section[data-id='step2']  ${COMMONWAIT}
    Wait Visibility And Click Element  css=#tab_4 a
    Wait For Ajax
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
    Sleep  120s


Змінити лот
    [Arguments]  ${user_name}  ${tenderId}  ${lot_id}  ${field}  ${value}

    Run Keyword And Return If  'value.amount' == '${field}'  Змінити ${field} лоту  ${value}
    Run Keyword And Return If  'minimalStep.amount' == '${field}'  Змінити ${field} лоту  ${value}

    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait For Ajax
    Wait Visibility And Click Element  css=#tab_4 a
    Wait For Ajax
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}
#    Sleep  4s
#    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
#    Wait Until Element Contains  css=div.modal-body.info-div  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.  ${COMMONWAIT}
#    Wait For Ajax
#    Reload Page
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.

Змінити value.amount лоту
    [Arguments]  ${value}
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}
    Wait For Ajax
    Wait Visibility And Click Element  css=#tab_1 a
    ${value_amount}=  privatmarket_service.convert_float_to_string  ${value}
    Wait Element Visibility And Input Text  css=input[data-id='valueAmount']  ${value_amount}
    Sleep  3s


Змінити minimalStep.amount лоту
    [Arguments]  ${value}
    ${minimalStep_amount}=  Convert to String  ${value}
    Wait Element Visibility And Input Text  css=input[data-id='minimalStepAmount']  ${minimalStep_amount}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait For Ajax
    Wait Visibility And Click Element  css=#tab_4 a
    Wait For Ajax
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}
#    Sleep  4s
#    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
#    Wait Until Element Contains  css=div.modal-body.info-div  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.  ${COMMONWAIT}
#    Wait For Ajax
#    Reload Page
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.



Додати неціновий показник на лот
    [Arguments]  ${user_name}  ${tenderId}  ${feature}  ${lot_id}
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}
    Wait Visibility And Click Element  css=#tab_2 a
    Sleep  2s
    Wait Visibility And Click Element  xpath=//div[@data-id='lot']//button[contains(., 'Додати показник')]
    Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//input[@ng-model='feature.title'])[last()]  ${feature.title}
    Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//input[@ng-model='feature.title_en'])[last()]  ${feature.title_en}
    Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//textarea[@ng-model='feature.description'])[last()]  ${feature.description}
    Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//textarea[@ng-model='feature.description_en'])[last()]  ${feature.description}

    @{lot_enums}=  Get From Dictionary  ${feature}  enum
    ${lot_criterion_count}=  Get Length  ${lot_enums}

    : FOR  ${index}  IN RANGE  0  ${lot_criterion_count}
    \  Run Keyword Unless  '${index}' == '0'  Wait Visibility And Click Element  xpath=(//div[@data-id='lot']//section[@data-id='criteria']//button)[last()]
    \  ${lot_criterion_value}=  privatmarket_service.get_percent  ${lot_enums[${index}].value}
    \  ${lot_criterion_value}=  Convert to String   ${lot_criterion_value}
    \  ${elem_index}=  privatmarket_service.sum_of_numbers  ${index}  1
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//input[@ng-model='criterion.value'])[last()]  ${lot_criterion_value}
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//input[@ng-model='criterion.title'])[last()]  ${lot_enums[${index}].title}
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='lot']//input[@ng-model='criterion.title_en'])[last()]  ${lot_enums[${index}].title}

    Switch To PMFrame
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait For Ajax
    Wait Visibility And Click Element  css=#tab_4 a
    Wait For Ajax
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
    Sleep  120s


Додати неціновий показник на предмет
  [Arguments]  ${username}  ${tender_uaid}  ${feature}  ${item_id}
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Switch To PMFrame
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}
    Wait Visibility And Click Element  css=#tab_2 a
    Sleep  3
    Wait Visibility And Click Element  xpath=//div[@data-id='item']//button[contains(., 'Додати показник')]

    Wait Element Visibility And Input Text  xpath=(//div[@data-id='item']//input[@ng-model='feature.title'])[last()]  ${feature.title}
    Wait Element Visibility And Input Text  xpath=(//div[@data-id='item']//textarea[@ng-model='feature.description'])[last()]  ${feature.description}

    @{item_enums}=  Get From Dictionary  ${feature}  enum
    ${item_criterion_count}=  Get Length  ${item_enums}

    : FOR  ${index}  IN RANGE  0  ${item_criterion_count}
    \  Run Keyword Unless  '${index}' == '0'  Wait Visibility And Click Element  xpath=(//div[@data-id='item']//section[@data-id='criteria']//button)[last()]
    \  ${item_criterion_value}=  privatmarket_service.get_percent  ${item_enums[${index}].value}
    \  ${item_criterion_value}=  Convert to String   ${item_criterion_value}
    \  ${elem_index}=  privatmarket_service.sum_of_numbers  ${index}  1
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='item']//input[@ng-model='criterion.value'])[last()]  ${item_criterion_value}
    \  Wait Element Visibility And Input Text  xpath=(//div[@data-id='item']//input[@ng-model='criterion.title'])[last()]  ${item_enums[${index}].title}

    Switch To PMFrame
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait For Ajax
    Wait Visibility And Click Element  css=#tab_4 a
    Wait For Ajax
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
    Sleep  120s

    Sleep  360s

Видалити неціновий показник
    [Arguments]  ${user_name}  ${tenderId}  ${feature_id}
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}
    Wait For Ajax
    Wait Visibility And Click Element  css=#tab_2 a
    Wait Visibility And Click Element  xpath=(//div[@data-id='lot']//button[@data-id='actRemove'])[last()]
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait For Ajax
    Wait Visibility And Click Element  css=#tab_4 a
    Wait For Ajax
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}
#    Sleep  4s
#    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
#    Wait Until Element Contains  css=div.modal-body.info-div  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.  ${COMMONWAIT}
#    Wait For Ajax
#    Reload Page
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.


Завантажити документ
    [Arguments]  ${user_name}  ${filepath}  ${tenderId}
    #перейдем к редактированию
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}

    #откроем нужную вкладку
    Run Keyword If  'переговорної процедури' in '${TEST_NAME}'  Wait Visibility And Click Element  css=#tab_2 a
    ...  ELSE  Wait Visibility And Click Element  css=#tab_3 a

    #загрузим файл
    Wait Visibility And Click Element  css=label[for='documentation_tender_yes']
    Run Keyword And Ignore Error  Wait Visibility And Click Element  xpath=//select[@id='chooseTypeptr']//option[2]
    Run Keyword And Ignore Error  Wait Visibility And Click Element  xpath=//select[@id='chooseType0']//option[2]
    Sleep  1s
    Run Keyword And Ignore Error  Wait Visibility And Click Element  xpath=//select[@id='chooseLangptr']//option[@value='en']
    Sleep  1s
    Run Keyword And Ignore Error  Choose File  css=section[data-id='ptrDocuments'] #inputFileptr  ${filePath}
    Run Keyword And Ignore Error  Choose File  css=section[data-id='ptrDocuments'] #inputFile0  ${filePath}
    Sleep  5s
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait For Ajax
    Wait Until Element Is Visible  css=section[data-id='step5']  ${COMMONWAIT}
    Sleep  1s
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}

#Дождемся подтверждения и обновим страницу, поскольку тут не выходит его закрыть
    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
    Sleep  180s


Завантажити документ в лот
    [Arguments]  ${user_name}  ${filepath}  ${tenderId}  ${lot_id}
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}
    Wait Visibility And Click Element  css=#tab_3 a
    Sleep  2s
    Wait Visibility And Click Element  css=label[for='documentation_lot_yes']
    Wait Visibility And Click Element  xpath=//section[@data-id='lots']//select[@data-id='choseType']/option[2]
    Sleep  1s
    Wait Visibility And Click Element  xpath=//div[@data-id='lot']//select[@data-id='choseType']//option[2]
    Sleep  1s
    Wait Visibility And Click Element  xpath=//div[@data-id='lot']//select[@data-id='choseLang']//option[2]
    Sleep  1s
    Choose File  css=section[data-id='lots'] [type='file']  ${filePath}
    Sleep  5s
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait For Ajax
    Wait Until Element Is Visible  css=section[data-id='step5']  ${COMMONWAIT}
    Wait For Ajax
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}

#Дождемся подтверждения и обновим страницу, поскольку тут не выходит его закрыть
    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
    Sleep  180s


Завантажити документ у кваліфікацію
    [Arguments]  ${user_name}  ${filepath}  ${tenderId}  ${bid_index}
    Wait Until Element Is Visible  xpath=//li[contains(@ng-class, 'lot-parts')]
    ${class}=  Get Element Attribute  xpath=//li[contains(@ng-class, 'lot-parts')]@class
    Run Keyword Unless  'checked-nav' in '${class}'  Click Element  xpath=//li[contains(@ng-class, 'lot-parts')]

    ${index}=  privatmarket_service.sum_of_numbers  ${bid_index}  1
    Run Keyword If
    ...  '${index}' == '1'  Wait Visibility And Click Element  xpath=(//a[@ng-click='act.openQualification(q)'])[${index}]
    ...  ELSE  Wait Visibility And Click Element  xpath=(//a[@ng-click='act.openQualification(q)'])[last()]
    Wait For Ajax
    #Wait Visibility And Click Element  xpath=//form[@name='fileForm']/select[1]/option[text()='Отчет об оценке']
    Wait Visibility And Click Element  xpath=//div[@class='files-upload']//select[@class='form-block__select form-block__select_short']//option[2]
    Sleep  1s
    Wait Visibility And Click Element  xpath=//div[@class='files-upload']//select[@class='form-block__select ng-scope form-block__select_short']//option[2]
    Sleep  1s
    Choose File  xpath=//div[@class='files-upload']//input[@type='file']  ${filePath}
    Sleep  5s


Підтвердити кваліфікацію
    [Arguments]  ${user_name}  ${tenderId}  ${bid_index}
    Run Keyword If  '${bid_index}' == '0'  Wait Visibility And Click Element  xpath=//li[contains(@ng-class, 'lot-parts')]
    ${index}=  privatmarket_service.sum_of_numbers  ${bid_index}  1
    Run Keyword If  '${bid_index}' == '0'  Wait Visibility And Click Element  xpath=(//a[@ng-click='act.openQualification(q)'])[${index}]
    Wait For Ajax
    Wait Visibility And Click Element  css=#chkSelfQualified
    Wait Visibility And Click Element  css=#chkSelfEligible
    Wait Until Element Is Enabled  xpath=//button[@ng-click="act.setQualificationStatus('active')"]
    Wait Visibility And Click Element  xpath=//button[@ng-click="act.setQualificationStatus('active')"]
    Wait Until Element Is Visible  css=.notify


Затвердити остаточне рішення кваліфікації
    [Arguments]  ${user_name}  ${tenderId}
    Wait For Element With Reload  css=button[data-id='finishPreQualBtn']  1
    Wait Visibility And Click Element  css=button[data-id='finishPreQualBtn']
    Wait For Element With Reload  xpath=//div[@id='tenderStatus' and contains(., 'Пауза перед аукціоном')]  1


Отримати інформацію із тендера
    [Arguments]  ${user_name}  ${tender_uaid}  ${field_name}
    Switch To PMFrame
    Wait Until Element Is Visible  ${tender_data_title}  ${COMMONWAIT}

    Run Keyword Unless  'award_view' in @{TEST_TAGS} or 'add_contract' in @{TEST_TAGS}  Відкрити детальну інформацію по позиціям

    #get information
    ${result}=  Run Keyword If
    ...  'award_view' in @{TEST_TAGS} or 'add_contract' in @{TEST_TAGS}  Отримати інформацію про постачальника  ${tender_uaid}  ${field_name}
    ...  ELSE  Отримати інформацію зі сторінки  ${tender_uaid}  ${field_name}
    [Return]  ${result}


Відкрити детальну інформацію по позиціям
    Відкрити детальну інформацію по лотам
    ${elements}=  Get Webelements  css=.lot-info .description a
    ${count}=  Get_Length  ${elements}
    :FOR  ${item}  In Range  0  ${count}
    \  ${item}=  privatmarket_service.sum_of_numbers  ${item}  1
    \  ${class}=  Get Element Attribute  xpath=(//div[@class='lot-info']//div[@class='description']/a)[${item}]@class
    \  Run Keyword Unless  'checked-item' in '${class}'  Click Element  xpath=(//div[@class='lot-info']//div[@class='description']/a)[${item}]


Відкрити інформацію по запитанням на всі лоти
    ${elements}=  Get Webelements  xpath=//li[contains(@ng-class, 'lot-faq')]
    ${count}=  Get_Length  ${elements}
    :FOR  ${item}  In Range  0  ${count}
    \  ${item}=  privatmarket_service.sum_of_numbers  ${item}  1
    \  ${class}=  Get Element Attribute  xpath=(//li[contains(@ng-class, 'lot-faq')])[${item}]@class
    \  Run Keyword Unless  'checked-item' in '${class}'  Click Element  xpath=(//li[contains(@ng-class, 'lot-faq')])[${item}]
    \  Run Keyword If  'відповіді на запитання' in '${TEST_NAME}'  Wait Visibility And Click Element  xpath=(//div[contains(@class, 'question-answer')]//div[contains(@class, 'question-expand-div')]/a[1])[${item}]


Відкрити інформацію про вкладені файли вимоги
    ${elements}=  Get Webelements  xpath=//a[contains(., 'Показати вкладені файли')]
    ${count}=  Get_Length  ${elements}
    :FOR  ${item}  In Range  0  ${count}
    \  ${item}=  privatmarket_service.sum_of_numbers  ${item}  1
    \  Click Element  xpath=(xpath=//a[contains(., 'Показати вкладені файли')])[${item}]


Відкрити детальну інформацію по лотам
    ${elements}=  Get Webelements  xpath=//li[contains(@ng-class, 'description')]
    ${count}=  Get_Length  ${elements}
    :FOR  ${item}  In Range  0  ${count}
    \  ${item}=  privatmarket_service.sum_of_numbers  ${item}  1
    \  ${class}=  Get Element Attribute  xpath=(//li[contains(@ng-class, 'description')])[${item}]@class
    \  Run Keyword Unless  'checked-nav' in '${class}'  Click Element  xpath=(//li[contains(@ng-class, 'description')])[${item}]


Створити постачальника, додати документацію і підтвердити його
    [Arguments]  ${username}  ${tender_uaid}  ${supplier_data}  ${document}
    Click Element  xpath=(//li[contains(@ng-class, 'lot-parts')])[1]
    Wait For Ajax
    Run Keyword And Ignore Error  Click Button  css=button[data-id='addParticipant']
    Wait Visibility And Click Element  css=.bids tbody tr td:nth-of-type(4) a
    Wait Until Element Is Visible  css=.modal.fade.in  ${COMMONWAIT}
    Wait For Ajax
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.identifier.legalName']  ${supplier_data.data.suppliers[0].identifier.legalName}
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.identifier.id']  ${supplier_data.data.suppliers[0].identifier.id}

    Wait Element Visibility And Input Text  css=input[ng-model='supplier.address.postalCode']  ${supplier_data.data.suppliers[0].address.postalCode}
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.address.countryName']  ${supplier_data.data.suppliers[0].address.countryName}
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.address.region']  ${supplier_data.data.suppliers[0].address.region}
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.address.locality']  ${supplier_data.data.suppliers[0].address.locality}
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.address.streetAddress']  ${supplier_data.data.suppliers[0].address.streetAddress}

    Wait Element Visibility And Input Text  css=input[ng-model='supplier.contactPoint.name']  ${supplier_data.data.suppliers[0].contactPoint.name}
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.contactPoint.telephone']  ${supplier_data.data.suppliers[0].contactPoint.telephone}
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.contactPoint.email']  ${supplier_data.data.suppliers[0].contactPoint.email}
    Wait Element Visibility And Input Text  css=input[ng-model='supplier.contactPoint.url']  ${supplier_data.data.suppliers[0].contactPoint.url}

    Wait Element Visibility And Input Text  css=input[ng-model='model.awardDraft.value.amount']  ${supplier_data.data.value.amount}
    Wait Visibility And Click Element  css=.modal.fade.in input[type='checkbox']
    Wait Visibility And Click Element  css=button[data-id='btn-send-award']
    Wait Until Element Is Enabled  css=div.alert-info  timeout=${COMMONWAIT}
    Wait Until Element Contains  css=div.alert-info  Данні успішно відправлені  timeout=10
    Wait Visibility And Click Element  css=div.modal-header i.icon-remove
    Wait For Ajax
    Reload Page
    Switch To PMFrame
    Wait Visibility And Click Element  xpath=(//li[contains(@ng-class, 'lot-parts')])[1]
    Wait Visibility And Click Element  css=.bids tbody tr td:nth-of-type(4) a
    Wait Visibility And Click Element  xpath=//div[@class='form-block__item']/form/select[1]/option[text()='Уведомления о решении']
    Sleep  1s
    Wait Visibility And Click Element  xpath=//div[@class='form-block__item']/form/select[2]/option[@value='1']
    Sleep  1s
    Choose File  xpath=//div[@class='form-block__item']/form/div/input  ${document}
    Sleep  5s
    Wait Visibility And Click Element  css=button[data-id='setActive']
    Sleep  2min


Підтвердити підписання контракту
    [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
    Reload Page
    Switch To PMFrame
    Wait Visibility And Click Element  xpath=(//li[contains(@ng-class, 'lot-cont')])[1]
    Wait For Ajax
    Wait Element Visibility And Input Text  css=input[ng-model='local.entity.title']  ${tender_uaid}
    Wait Element Visibility And Input Text  css=#contractNumber  ${tender_uaid}
    Click Element  css=#dateSigned
    Wait Visibility And Click Element  css=.today.day
    Wait For Ajax
    Click Element  css=#endDate
    Wait Visibility And Click Element  css=.today.day
    Wait For Ajax
    Wait Until Element Is Enabled  css=button[ng-click="act.saveContract('active')"]  ${COMMONWAIT}
    Click Button  css=button[ng-click="act.saveContract('active')"]
    Wait Until Element Is Visible  css=.notify  ${COMMONWAIT}
    Sleep  1min


Отримати інформацію зі сторінки
    [Arguments]  ${base_tender_uaid}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'value.amount'  Convert Amount To Number  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'value.currency'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'value.valueAddedTaxIncluded'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'enquiryPeriod.startDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'enquiryPeriod.endDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'tenderPeriod.startDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'tenderPeriod.endDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'minimalStep.amount'  Convert Amount To Number  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'status'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'qualificationPeriod.endDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'qualifications[0].status'  Отримати статус пропозиції кваліфікації  1
    Run Keyword And Return If  '${field_name}' == 'qualifications[1].status'  Отримати статус пропозиції кваліфікації  2
    Run Keyword And Return If  '${field_name}' == 'title_en'  Отримати інформацію зі зміною локалізації  ${field_name}  EN
    Run Keyword And Return If  '${field_name}' == 'title_ru'  Отримати інформацію зі зміною локалізації  ${field_name}  RU
    Run Keyword And Return If  '${field_name}' == 'description_en'  Отримати інформацію зі зміною локалізації  ${field_name}  EN
    Run Keyword And Return If  '${field_name}' == 'description_ru'  Отримати інформацію зі зміною локалізації  ${field_name}  RU
    Run Keyword And Return If  '${field_name}' == 'causeDescription'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'cause'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'awards[0].complaintPeriod.endDate'  Отримати інформацію з ${field_name}  1

    Wait Until Element Is Visible  ${tender_data_${field_name}}
    ${result_full}=  Get Text  ${tender_data_${field_name}}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із лоту
    [Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
    ${className}=  Get Element Attribute  xpath=//section[@id='lotSection']/section[contains(., '${object_id}')]//li[1]@class
    Run Keyword If  '${className}' == 'simple-nav_item active'  Wait Visibility And Click Element  //section[@id='lotSection']/section[contains(., '${object_id}')]//li[1]/a
    ${element}=  Set Variable  xpath=(//section[@id='lotSection']/section[contains(., '${object_id}')]${tender_data_lot.${field_name}}

    Run Keyword And Return If  '${field_name}' == 'value.amount'  Convert Amount To Number  ${element}
    Run Keyword And Return If  '${field_name}' == 'value.currency'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'value.valueAddedTaxIncluded'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'minimalStep.amount'  Отримати суму  ${element}
    Run Keyword And Return If  '${field_name}' == 'minimalStep.currency'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'minimalStep.valueAddedTaxIncluded'  Отримати інформацію з ${field_name}  ${element}

    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із предмету
    [Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
    Відкрити детальну інформацію по позиціям
    ${info}=  Set Variable  xpath=//div[@class='lot-info']/section[contains(., '${object_id}')]//div[@class='info-item-val']/div[@class='description']/a
    ${info_class}=  Get Element Attribute  ${info}@class
    Run Keyword Unless  'checked-item' in '${info_class}'  Click Element  ${info}
    ${element}=  Set Variable  xpath=(//div[@class='lot-info']/section[contains(., '${object_id}')]${tender_data_item.${field_name}}

    Run Keyword And Return If  '${field_name}' == 'deliveryDate.startDate'  Отримати дату та час  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'deliveryDate.endDate'  Отримати дату та час  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'deliveryLocation.latitude'  Отримати число  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'deliveryLocation.longitude'  Отримати число  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'additionalClassifications[0].scheme'  Отримати інформацію з ${field_name}  ${element}
#    Run Keyword And Return If  '${field_name}' == 'classification.scheme'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'unit.name'  Отримати інформацію з ${field_name}  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'unit.code'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'quantity'  Отримати суму  ${element}
    Run Keyword And Return If  '${field_name}' == 'deliveryAddress.countryName_ru'  Отримати інформацію із предмету зі зміною локалізації  ${field_name}  ${object_id}  RU
    Run Keyword And Return If  '${field_name}' == 'deliveryAddress.countryName_en'  Отримати інформацію із предмету зі зміною локалізації  ${field_name}  ${object_id}  EN

    Wait Until Element Is Visible  ${element}  timeout=${COMMONWAIT}
    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію про постачальника
    [Arguments]  ${tender_uaid}  ${field_name}
    ${open_status}=  Run Keyword And Return Status  Wait Until Element Is Visible  xpath=//img[contains(@ng-src, 'icon-minus.png')]  1s
    Run Keyword Unless  ${open_status}  Відкрити детальну інформацію про постачальника

    Run Keyword And Return If  '${field_name}' == 'awards[0].status'  Отримати статус заявки  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'awards[0].value.valueAddedTaxIncluded'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'awards[0].value.currency'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'awards[0].value.amount'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'contracts[0].status'  Отримати статус договору  ${field_name}

    Wait Until Element Is Visible  ${tender_data_${field_name}}  ${COMMONWAIT}
    ${result_full}=  Get Text  ${tender_data_${field_name}}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із запитання
    [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}

    ${element}=  Set Variable If
    ...  'запитання на тендер' in '${TEST_NAME}'  xpath=(//div[contains(@class, 'faq') and contains(., '${question_id}')]${tender_data_question.${field_name}}
    ...  'запитання на всі лоти' in '${TEST_NAME}'  xpath=//div[contains(@class, 'lot-info') and contains(., '${question_id}')]${tender_data_lot_question.${field_name}}

    Run Keyword If
    ...  'запитання на тендер' in '${TEST_NAME}'  Wait For Element With Reload  ${element}  2
    ...  ELSE  Wait For Element With Reload  ${element}  1

    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із документа
    [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
    Wait For Element With Reload  xpath=//div[contains(@${field},'${doc_id}')]  1
    Wait Until Element Is Visible  xpath=//div[contains(@${field},'${doc_id}')]  ${COMMONWAIT}
    ${result}=  Get Text  xpath=//div[contains(@${field},'${doc_id}')]
    [Return]  ${result}


Отримати інформацію із нецінового показника
    [Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
    Відкрити детальну інформацію по позиціям

    ${element}=  Set Variable IF
        ...  '${field_name}' == 'featureOf'  xpath=//div[contains(@class, 'feature name') and contains(., '${object_id}')]${tender_data_feature.${field_name}}
        ...  xpath=//div[contains(@class, 'feature name') and contains(., '${object_id}')]

    Run Keyword And Return If  '${field_name}' == 'title'  Отримати інформацію з feature  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'description'  Отримати інформацію з feature  ${element}  1
    Run Keyword And Return If  '${field_name}' == 'featureOf'  Отримати інформацію з ${field_name}  ${element}

    Wait Until Element Is Visible  ${element}  timeout=${COMMONWAIT}
    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із скарги
    [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${field_name}  ${award_index}
    ${element}=  Set Variable  xpath=//div[contains(@class, 'faq') and contains(., '${complaintID}')]${tender_data_complaint.${field_name}}
    ${test_case_name}=  Remove String  ${TEST_NAME}  '
    Run Keyword If
    ...  '${test_case_name}' == 'Відображення поданого статусу вимоги'  Search by status  ${element}[contains(.,"Вiдправлено")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу answered вимоги'  Search by status  ${element}[contains(.,"Отримано вiдповiдь")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу resolved вимоги'  Search by status  ${element}[contains(.,"Вирiшена")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу cancelled вимоги'  Search by status  ${element}[contains(.,"Скасована")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу pending вимоги'  Search by status  ${element}[contains(.,"Отримано вiдповiдь")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу cancelled скарги'  Search by status  ${element}[contains(.,"Скасована")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу answered вимоги про виправлення визначення переможця'  Search by status  ${element}[contains(.,"Отримано вiдповiдь")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу resolved вимоги про виправлення визначення переможця'  Search by status  ${element}[contains(.,"Вирiшена")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу cancelled чернетки вимоги про виправлення визначення переможця'  Search by status  ${element}[contains(.,"Скасована")]  3
    ...  ELSE IF  '${test_case_name}' == 'Відображення статусу cancelled скарги про виправлення визначення переможця'  Search by status  ${element}[contains(.,"Скасована")]  3
    ...  ELSE IF  'Відображення статусу cancelled після draft -> claim -> answered вимоги' in '${test_case_name}'  Search by status  ${element}[contains(.,"Скасована")]  3
    ...  ELSE IF  'Відображення статусу pending після draft -> claim -> answered вимоги' in '${test_case_name}'  Search by status  ${element}[contains(.,"Не вирiшена, обробляється")]  3
    ...  ELSE  run keyword  Search by status  ${element}  3
    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    Run Keyword And Return If  '${field_name}' == 'status'  privatmarket_service.get_claim_status  ${result}
    Run Keyword And Return If  '${field_name}' == 'resolutionType'  Отримати resolutionType  ${result}
    Run Keyword And Return If  '${field_name}' == 'satisfied'  Отримати статус вирішення  ${result}
    [Return]  ${result}


Search by status
    [Arguments]  ${locator}  ${tab_number}
    Wait Until Keyword Succeeds  5min  10s  Try To Search Complaint  ${locator}  3


Try To Search Complaint
    [Arguments]  ${locator}  ${tab_number}
    Reload And Switch To Tab  ${tab_number}
    Wait For Ajax
    Wait Until Element Is Visible  ${locator}  5s


Отримати resolutionType
    [Arguments]  ${text}
    ${text}=  Set Variable If  'Рішення замовника: вирiшена' in '${text}'  resolved
    [Return]  ${text}


Отримати статус вирішення
    [Arguments]  ${text}
    ${text}=  Set Variable If
    ...  'так' in '${text}'  ${TRUE}
    ...  'ні' in '${text}'  ${FALSE}
    ...  ${text}
    [Return]  ${text}


Відкрити детальну інформацію про постачальника
    ${class}=  Get Element Attribute  xpath=(//li[contains(@ng-class, 'lot-parts')])[1]@class
    Run Keyword Unless  'checked-nav' in '${class}'  Click Element  xpath=(//li[contains(@ng-class, 'lot-parts')])[1]
    Wait Visibility And Click Element  xpath=//img[contains(@ng-src, 'icon-plus.png')]
    Wait Until Element Is Visible  xpath=//img[contains(@ng-src, 'icon-minus.png')]


Отримати статус заявки
    [Arguments]  ${field_name}
    Wait Until Element Is Visible  ${tender_data_${field_name}}  ${COMMONWAIT}
    ${status_name}=  Get text  ${tender_data_${field_name}}
    ${status_type}=  Set Variable If
    ...  'Переможець переговорів' == '${status_name}'  active
    ...  ELSE  ${status_name}
    [Return]  ${status_type}


Отримати статус договору
    [Arguments]  ${field_name}

    Run Keyword If  'статусу підписаної угоди з постачальником' in '${TEST_NAME}'
    ...  Wait For Element With Reload  //div[contains(@class, 'modal fade')]//div[contains(@class, 'modal-body')][1]/div[10]/div[contains(., 'Підписаний')]  1

    Wait Until Element Is Visible  ${tender_data_${field_name}}  ${COMMONWAIT}
    ${status_name}=  Get text  ${tender_data_${field_name}}
    ${status_type}=  Run Keyword If
    ...  'Очiкує пiдписання' == '${status_name}'  Set Variable  pending
    ...  ELSE IF  'Підписаний' == '${status_name}'  Set Variable  active
    ...  ELSE  Set Variable  ${status_name}
    Reload Page
    [Return]  ${status_type}


Отримати інформацію із документа до скарги
    [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${doc_id}  ${field}
    ${element} =  Set Variable  xpath=//a[contains(.,"Показати вкладені файли")]
    Показати вкладені файли  ${element}
    ${element_new}=  Set Variable  xpath=(//div[contains(@title,'${doc_id}')])
    Wait Until Element Is Visible  xpath=(//div[contains(@title,'${doc_id}')])
    ${doc_text} =  Get Text  ${element_new}
    [Return]  ${doc_text}


Показати вкладені файли
     [Arguments]  ${element}
     ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${element}  20s
     Run Keyword If  '${status}' == 'True'  Click Element  ${element}



Отримати статус пропозиції кваліфікації
    [Arguments]  ${item}
    Wait Until Element Is Visible  xpath=//li[contains(@ng-class, 'lot-parts')]
    ${class}=  Get Element Attribute  xpath=//li[contains(@ng-class, 'lot-parts')]@class
    Run Keyword Unless  'checked-nav' in '${class}'  Click Element  xpath=//li[contains(@ng-class, 'lot-parts')]
    Wait Until Element Is Visible  css=.bids>tbody>tr:nth-of-type(${item})>td:nth-of-type(3)  timeout=${COMMONWAIT}

    ${elem_text}=  Get Text  css=.bids>tbody>tr:nth-of-type(${item})>td:nth-of-type(3)
    ${status_text}=  Split String  ${elem_text}  \n
    ${status}=  Strip String  ${status_text[0]}
    ${result}=  privatmarket_service.get_status_type  ${status}
    [Return]  ${result}


Отримати документ до лоту
    [Arguments]  ${username}  ${tender_uaid}  ${lot_id}  ${doc_id}
    ${file_name}=  privatmarket.Отримати документ  ${username}  ${tender_uaid}  ${doc_id}
    [Return]  ${file_name}


Отримати документ
    [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
    Wait For Element With Reload  xpath=//div[contains(@title,'${doc_id}')]  1
    Scroll Page To Element  xpath=//div[contains(@title,'${doc_id}')]
    Wait Visibility And Click Element  xpath=//div[contains(@title,'${doc_id}')]
    # Добален слип, т.к. док не успевал загрузиться
    sleep  20s
    ${file_name_full}=  Get Text  xpath=//div[contains(@title,'${doc_id}')]
    ${file_name}=  Strip String  ${file_name_full}
    [Return]  ${file_name}


Отримати посилання на аукціон для глядача
    [Arguments]  ${user}  ${tenderId}
    Wait For Element With Reload  css=button#takepartLink  1
    Wait Visibility And Click Element  css=button#takepartLink
    Wait Until Element Is Visible  xpath=//a[contains(@href, 'https://auction-sandbox.openprocurement.org/tenders/')]  timeout=30
    ${result}=  Get Element Attribute  xpath=//a[contains(@href, 'https://auction-sandbox.openprocurement.org/tenders/')]@href
    [Return]  ${result}


Відповісти на запитання
    [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
    Switch To PMFrame
    Run Keyword And Return If  'на всі лоти' in '${TEST_NAME}'  Відповісти на запитання на лот  ${answer_data}  ${question_id}

    Switch To Tab  2
    Wait For Element With Reload  xpath=//button[contains(@ng-click, 'act.answerFaq')]  2
    Wait Visibility And Click Element  xpath=//button[contains(@ng-click, 'act.answerFaq')]
    Wait Element Visibility And Input Text  id=questionAnswer  ${answer_data.data.answer}
    Sleep  2s
    Wait Visibility And Click Element  id=btnSendAnswer
    Wait For Notification  Ваша відповідь успішно відправлена!
    Wait Visibility And Click Element  css=span[ng-click='act.hideModal()']
    Wait Until Element Is Not Visible  id=questionAnswer  timeout=20
    #этот слип нужен, т.к. нет синхронизации и квинта ищет ответ в следующем тесте... а его нет пока не синхранизируемся
    Sleep  90s


Відповісти на запитання на лот
    [Arguments]  ${answer_data}  ${question_id}
    Switch To PMFrame
    ${element}=  Set Variable  xpath=//div[contains(@class, 'lot-info') and contains(., '${question_id}')]//button
    Wait For Element With Reload  ${element}  1
    Wait Visibility And Click Element  ${element}
    Wait Element Visibility And Input Text  id=questionAnswer  ${answer_data.data.answer}
    Sleep  2s
    Wait Visibility And Click Element  id=btnSendAnswer
    Wait For Notification  Ваша відповідь успішно відправлена!
    Wait Visibility And Click Element  id=btnClose
    Wait Until Element Is Not Visible  id=questionAnswer  timeout=20
    #этот слип нужен, т.к. нет синхронизации и квинта ищет ответ в следующем тесте... а его нет пока не синхранизируемся
    Sleep  90s


Отримати інформацію з value.currency
    [Arguments]  ${element_name}
    ${currency}=  Отримати строку  ${element_name}  0
    ${currency_type}=  get_currency_type  ${currency}
    [Return]  ${currency_type}


Отримати інформацію з awards[0].value.currency
    [Arguments]  ${element_name}
    ${currency}=  Отримати текст елемента  ${element_name}
    ${currency_type}=  privatmarket_service.get_currency_type  ${currency}
    [Return]  ${currency_type}


Отримати інформацію з awards[0].value.amount
    [Arguments]  ${element_name}
    ${text}=  Отримати текст елемента  ${element_name}
    ${text_new}=  Strip String  ${text}
    ${result}=  convert to number  ${text_new}
    [Return]  ${result}


Отримати інформацію з value.valueAddedTaxIncluded
    [Arguments]  ${element_name}
    ${temp_name}=  Remove String  ${element_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
        ...  ${tender_data_${element_name}}

    ${value_added_tax_included}=  Get text  ${element}
    ${result}=  Set Variable If  'з ПДВ' in '${value_added_tax_included}'  True
    ${result}=  Convert To Boolean  ${result}
    [Return]  ${result}


Отримати інформацію з awards[0].value.valueAddedTaxIncluded
    [Arguments]  ${element_name}
    ${temp_name}=  Remove String  ${element_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
        ...  ${tender_data_${element_name}}

    ${value_added_tax_included}=  Get text  ${element}
    ${result}=  Set Variable If  'з ПДВ' in '${value_added_tax_included}'  True
    ${result}=  Convert To Boolean  ${result}
    [Return]  ${result}


Отримати інформацію з minimalStep.currency
    [Arguments]  ${element_name}
    ${currency}=  Отримати строку  ${element_name}  0
    ${currency_type}=  get_currency_type  ${currency}
    [Return]  ${currency_type}


Отримати інформацію з minimalStep.valueAddedTaxIncluded
    [Arguments]  ${element_name}
    ${temp_name}=  Remove String  ${element_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
        ...  ${tender_data_${element_name}}

    ${value_added_tax_included}=  Get text  ${element}
    ${result}=  Set Variable If  'з ПДВ' in '${value_added_tax_included}'  True
    ${result}=  Convert To Boolean  ${result}
    [Return]  ${result}


Отримати інформацію з типу податку
    [Arguments]  ${element}
    ${value_added_tax_included}=  Get text  ${element}
    ${result}=  Set Variable If  'з ПДВ' in '${value_added_tax_included}'  True
    ${result}=  Convert To Boolean  ${result}
    [Return]  ${result}


Отримати інформацію з unit.code
    [Arguments]  ${element}
    Wait Until Element Is Visible  ${element}
    ${result_full}=  Get Text  ${element}
    ${result}=  privatmarket_service.get_unit_code  ${result_full}
    [Return]  ${result}


Отримати інформацію з quantity
    [Arguments]  ${element_name}
    ${result_full}=  Get Text  ${element_name}
    ${result}=  Strip String  ${result_full}
    ${result}=  Replace String  ${result}  .00  ${EMPTY}
    ${result}=  Strip String  ${result}
    [Return]  ${result}


Отримати інформацію з classification.scheme
    [Arguments]  ${element}
    Wait Until Element Is Visible  ${element}
    ${result_full}=  Get Text  ${element}
    ${result}=  privatmarket_service.get_classification_type  ${result_full}
    [Return]  ${result}


Отримати інформацію з additionalClassifications[0].scheme
    [Arguments]  ${element}
    Wait Until Element Is Visible  ${element}
    ${result_full}=  Get Text  ${element}
    ${result}=  privatmarket_service.get_classification_type  ${result_full}
    [Return]  ${result}


Отримати інформацію з status
    [Arguments]  ${element_name}
    privatmarket.Оновити сторінку з тендером
    Wait Until Element Is Visible  ${tender_data_${element_name}}  ${COMMONWAIT}
    #Added sleep, becource we taketext in status bar
    Sleep  5s
    ${status_name}=  Get text  ${tender_data_${element_name}}
    ${status_type}=  privatmarket_service.get_status_type  ${status_name}
    [Return]  ${status_type}


Отримати інформацію з feature
    [Arguments]  ${element}  ${id}
    Wait For Element With Reload  ${element}  1
    ${result_full}=  Отримати текст елемента  ${element}
    ${result_full}=  Strip String  ${result_full}
    ${values_list}=  Split String  ${result_full}  \n
    ${result}=  Set Variable  ${values_list[${id}]}
    [Return]  ${result}


Отримати інформацію з featureOf
    [Arguments]  ${element}
    ${text}=  Отримати текст елемента  ${element}
    ${result}=  Set Variable If
    ...  'по закупівлі' in '${text}'  tenderer
    ...  'по позиції' in '${text}'  item
    ...  'по лоту' in '${text}'  lot
    [Return]  ${result}


Отримати інформацію з causeDescription
    [Arguments]  ${element}
    Wait Visibility And Click Element  css=#tenderType
    ${result_full}=  Отримати текст елемента  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію з cause
    [Arguments]  ${element}
    Wait Until Element Is Visible  css=#tenderType
    ${result_full}=  Отримати текст елемента  ${element}
    ${result_full}=  Strip String  ${result_full}
    ${result}=  privatmarket_service.get_cause  ${result_full}
    [Return]  ${result}


Отримати інформацію зі зміною локалізації
    [Arguments]  ${element}  ${lang}
    Unselect Frame
    Wait Visibility And Click Element  xpath=//li[contains(@class, 'change-language-item') and contains(., '${lang}')]
    Wait Until Element Is Visible  xpath=//li[contains(@class, 'change-language-item') and contains(., '${lang}')]/b
    Wait For Ajax
    Switch To PMFrame
    ${element}=  Set Variable If
    ...  'title' in '${element}'  title
    ...  'description' in '${element}'  description
    ${text}=  Отримати текст елемента  ${element}
    ${result}=  Strip String  ${text}
    Unselect Frame
    Wait Visibility And Click Element  xpath=//li[contains(@class, 'change-language-item') and contains(., 'UK')]
    Switch To PMFrame
    [Return]  ${result}


Отримати інформацію із предмету зі зміною локалізації
    [Arguments]  ${field_name}  ${object_id}  ${lang}
    ${index}=  Get Item Number  ${object_id}
    Unselect Frame
    Wait Visibility And Click Element  xpath=//li[contains(@class, 'change-language-item') and contains(., '${lang}')]
    Wait Until Element Is Visible  xpath=//li[contains(@class, 'change-language-item') and contains(., '${lang}')]/b
    Wait For Ajax
    Switch To PMFrame
    Відкрити детальну інформацію по позиціям
    ${element}=  Set Variable  xpath=(//section[@id='subject-section']${tender_data_item.${field_name}}[${index}]
    ${text}=  Отримати текст елемента  ${element}
    ${result}=  Strip String  ${text}
    Unselect Frame
    Wait Visibility And Click Element  xpath=//li[contains(@class, 'change-language-item') and contains(., 'UK')]
    Switch To PMFrame
    [Return]  ${result}


Отримати інформацію з awards[0].complaintPeriod.endDate
    [Arguments]  ${shift}
    Reload Page
    Switch To PMFrame
    ${class}=  Get Element Attribute  xpath=(//li[contains(@ng-class, 'lot-parts')])[1]@class
    Run Keyword Unless  'checked-nav' in '${class}'  Click Element  xpath=(//li[contains(@ng-class, 'lot-parts')])[1]
    ${title}=  Get Element Attribute  xpath=//table[@class='bids']/tbody//td[4]/a@title
    ${work_string}=  Get Regexp Matches  ${title}  до (.)*
    ${work_string}=  Get From List  ${work_string}  0
    ${work_string}=  Replace String  ${work_string}  ,${SPACE}  ${SPACE}
    ${values_list}=  Split String  ${work_string}
    ${day}=  Convert To Integer  ${values_list[0 + ${shift}]}
    ${day}=  Set Variable If  ${day} < 10  0${day}  ${day}
    ${month}=  privatmarket_service.get_month_number  ${values_list[1 + ${shift}]}
    ${month}=  Set Variable If  ${month} < 10  0${month}  ${month}
    ${year}=  Convert To String  ${values_list[2 + ${shift}]}
    ${time}=  Convert To String  ${values_list[3 + ${shift}]}
    ${date}=  Convert To String  ${year}-${month}-${day} ${time}
    ${result}=  privatmarket_service.get_time_with_offset  ${date}
    [Return]  ${result}


Отримати строку
    [Arguments]  ${element_name}  ${position_number}
    ${result_full}=  Отримати текст елемента  ${element_name}
    ${result}=  Strip String  ${result_full}
    ${result}=  Replace String  ${result}  ,  ${EMPTY}
    ${values_list}=  Split String  ${result}
    ${result}=  Strip String  ${values_list[${position_number}]}  mode=both  characters=:
    [Return]  ${result}


Отримати текст елемента
    [Arguments]  ${element_name}
    ${temp_name}=  Remove String  ${element_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
        ...  ${tender_data_${element_name}}

    Wait Until Element Is Visible  ${element}  ${COMMONWAIT}
    ${result_full}=  Get Text  ${element}
    [Return]  ${result_full}


Отримати дату та час
    [Arguments]  ${element_name}  ${shift}
    Run Keyword If  'періоду блокування' in '${TEST_NAME}'  Wait For Element With Reload  ${tender_data_${element_name}}  1
    ${result_full}=  Отримати текст елемента  ${element_name}
    ${work_string}=  Replace String  ${result_full}  ${SPACE},${SPACE}  ${SPACE}
    ${work_string}=  Replace String  ${result_full}  ,${SPACE}  ${SPACE}
    ${values_list}=  Split String  ${work_string}
    ${day}=  Convert To String  ${values_list[0 + ${shift}]}
    ${month}=  privatmarket_service.get_month_number  ${values_list[1 + ${shift}]}
    ${month}=  Set Variable If  ${month} < 10  0${month}  ${month}
    ${year}=  Convert To String  ${values_list[2 + ${shift}]}
    ${time}=  Convert To String  ${values_list[3 + ${shift}]}
    ${date}=  Convert To String  ${year}-${month}-${day} ${time}
    ${result}=  privatmarket_service.get_time_with_offset  ${date}
    [Return]  ${result}


Отримати суму
    [Arguments]  ${element_name}
    ${result}=  Отримати текст елемента  ${element_name}
    ${result}=  Remove String  ${result}  ${SPACE}
    ${result}=  Replace String  ${result}  ,  .
    ${result}=  Convert To Number  ${result}
    [Return]  ${result}


Отримати число
    [Arguments]  ${element_name}  ${position_number}
    ${value}=  Отримати строку  ${element_name}  ${position_number}
    ${result}=  Convert To Number  ${value}
    [Return]  ${result}


Отримати класифікацію
    [Arguments]  ${element_name}
    ${result_full} =  Отримати текст елемента  ${element_name}
    ${reg_expresion} =  Set Variable  [0-9A-zА-Яа-яёЁЇїІіЄєҐґ\\s\\:]+\: \\w+[\\d\\.\\-]+ ([А-Яа-яёЁЇїІіЄєҐґ\\s;,\\"_\\(\\)\\.]+)
    ${result} =  Get Regexp Matches  ${result_full}  ${reg_expresion}  1
    [Return]  ${result[0]}


Отримати інформацію з unit.name
    [Arguments]  ${element_name}  ${position_number}
    ${result_full}=  Отримати строку  ${element_name}  ${position_number}
    ${result}=  privatmarket_service.get_unit_name  ${result_full}
    [Return]  ${result}


Обрати додаткові класифікатори
    [Arguments]  ${scheme}  ${classificationId}
    Обрати схему  ${scheme}
    Обрати класифікатори  ${classificationId}


Обрати класифікатори
    [Arguments]  ${classificationId}
    Wait Visibility And Click Element  xpath=//section[@data-id='additionalClassifications']//span[@data-id='actChoose']
    Wait Until Element Is Visible  css=section[data-id='classificationTreeModal']  ${COMMONWAIT}
    Wait Until Element Is Visible  css=input[data-id='query']  ${COMMONWAIT}
    Wait Element Visibility And Input Text  css=input[data-id='query']  ${classificationId}
    Wait Until Element Is Not Visible  css=.modal-body.tree.pm-tree
    Sleep  1
    Wait Visibility And Click Element  xpath=//div[@data-id='foundItem']//label[@for='found_${classificationId}']
    Wait Visibility And Click Element  css=[data-id='actConfirm']


Обрати схему
    [Arguments]  ${scheme}
    Wait Visibility And Click Element  css=[data-id='additionalClassifications'] .content-caption-info
    Sleep  1
    Wait Visibility And Click Element  xpath=//section[@data-id='schemeCheckModal']//label[@for='scheme_${scheme}']
    Wait Visibility And Click Element  xpath=//section[@data-id='schemeCheckModal']//button[@data-id='actConfirm']
    Sleep  1


Close notification
    Switch To PMFrame
    ${notification_visibility}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=section[data-id='popupHelloModal'] span[data-id='actClose']
    Run Keyword If  ${notification_visibility}  Click Element  css=section[data-id='popupHelloModal'] span[data-id='actClose']


Switch To PMFrame
    Sleep  5s
    Unselect Frame
    Wait Until Element Is Visible  id=tenders  ${COMMONWAIT}
    Switch To Frame  id=tenders


Switch To Frame
    [Arguments]  ${frameId}
    Wait Until Element Is enabled  ${frameId}  ${COMMONWAIT}
    Select Frame  ${frameId}


Login
    [Arguments]  ${username}
    Wait Visibility And Click Element  css=a[data-target='#login_modal']
    Wait Until Element Is Visible  id=p24__login__field  ${COMMONWAIT}
    Execute Javascript  $('#p24__login__field').val('+${USERS.users['${username}'].login}')
    Input Text  xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']  ${USERS.users['${username}'].password}
    Wait Visibility And Click Element  xpath=//div[@id="login_modal" and @style='display: block;']//button[@type='submit']
    Wait Until Element Is Visible  css=ul.user-menu  timeout=30


Wait Visibility And Click Element
    [Arguments]  ${elementLocator}
    Wait Until Element Is Visible  ${elementLocator}  ${COMMONWAIT}
    Click Element  ${elementLocator}


Wait Element Visibility And Input Text
    [Arguments]  ${elementLocator}  ${input}
    Wait Until Element Is Visible  ${elementLocator}  ${COMMONWAIT}
    Input Text  ${elementLocator}  ${input}


Wait For Tender
    [Arguments]  ${tender_id}  ${education_type}
    Wait Until Keyword Succeeds  7min  5s  Try Search Tender  ${tender_id}  ${education_type}


Try Search Tender
    [Arguments]  ${tender_id}  ${education_type}
    Switch To PMFrame
    Check Current Mode New Realisation

    #заполним поле поиска
    Clear Element Text  ${locator_tenderSearch.searchInput}
    Sleep  1s
    Input Text  ${locator_tenderSearch.searchInput}  ${tender_id}

    #выполним поиск
    Click Element  css=button#search-query-button
    Wait Until Element Is Not Visible  xpath=//div[@class='ajax_overflow']  ${COMMONWAIT}
    Wait Until Element Is Enabled  id=${tender_id}  timeout=10
    [Return]  True


Check Current Mode New Realisation
    [Arguments]  ${education_type}=${True}
    privatmarket.Оновити сторінку з тендером
    Close notification
    #проверим правильный ли режим
    Wait Until Element Is Visible  ${locator_tender.switchToDemo}  ${COMMONWAIT}
    Wait Visibility And Click Element  ${locator_tender.switchToDemo}
    Wait For Ajax
    ${check_result}=  Get Text  ${locator_tender.switchToDemo}
    Run Keyword If  '${check_result}' == 'Увійти в демо-режим' or '${check_result}' == 'Войти в демо-режим'  Switch To Education Mode


Switch To Education Mode
    [Arguments]  ${education_type}=${True}
    Wait Visibility And Click Element  ${locator_tender.switchToDemo}
    Wait Until Element Is Visible  ${locator_tender.switchToDemoMessage}  ${COMMONWAIT}


Convert Amount To Number
    [Arguments]  ${field_name}
    ${temp_name}=  Remove String  ${field_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${field_name}
        ...  ${tender_data_${field_name}}

    ${result_full}=  Get Text  ${element}
    ${text}=  Strip String  ${result_full}
    ${text_new}=  Replace String  ${text}  ${SPACE}  ${EMPTY}
    ${result}=  convert to number  ${text_new}
    [Return]  ${result}


Wait For Element With Reload
    [Arguments]  ${locator}  ${tab_number}
    Wait Until Keyword Succeeds  5min  10s  Try Search Element  ${locator}  ${tab_number}


Try Search Element
    [Arguments]  ${locator}  ${tab_number}
    Reload And Switch To Tab  ${tab_number}
    Run Keyword If
    ...  '${tab_number}' == '1' and 'запитання на всі лоти' in '${TEST_NAME}'  Відкрити інформацію по запитанням на всі лоти
    ...  ELSE IF  '${tab_number}' == '1' and 'статусу підписаної угоди з постачальником' in '${TEST_NAME}'  Відкрити детальну інформацію про постачальника
    ...  ELSE IF  '${tab_number}' == '1'  Відкрити детальну інформацію по позиціям
    ...  ELSE IF  '${tab_number}' == '2' and 'відповіді на запитання' in '${TEST_NAME}'  Wait Visibility And Click Element  css=.question-answer .question-expand-div>a:nth-of-type(1)
    ...  ELSE IF  '${tab_number}' == '3' and 'заголовку документації' in '${TEST_NAME}'  Відкрити інформацію про вкладені файли вимоги
    Wait Until Element Is Enabled  ${locator}  10
    Wait For Ajax
    [Return]  True


Reload And Switch To Tab
    [Arguments]  ${tab_number}
    Reload Page
    Switch To PMFrame
    Switch To Tab  ${tab_number}


Switch To Tab
    [Arguments]  ${tab_number}
    ${class}=  Get Element Attribute  xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]@class
    Run Keyword Unless  'white-icon' in '${class}'  Wait Visibility And Click Element  xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]


Search By Query
    [Arguments]  ${element}  ${query}
    Sleep  1s
    Wait Element Visibility And Input Text  ${element}  ${query}
    Wait Until Element Is Not Visible  css=.modal-body.tree.pm-tree
    Wait Until Keyword Succeeds  20s  500ms  Check Element Attribute  css=[data-id='searchMonitor']  data-status  ok
    Wait Until Element Is Enabled  xpath=//div[@data-id='foundItem']//label[@for='found_${query}']  ${COMMONWAIT}
    Wait Visibility And Click Element  xpath=//div[@data-id='foundItem']//label[@for='found_${query}']


Check Element Attribute
    [Arguments]  ${element}  ${attribute_name}  ${value}
    ${attribute}=  Get Element Attribute  ${element}@${attribute_name}
    ${result}=  Set Variable  False
    ${result}=  Run Keyword If  '${attribute}' == '${value}'  Set Variable  True
    [Return]  ${result}


Set Date And Time
    [Arguments]  ${element}  ${fild}  ${time_element}  ${date}
    Set Date  ${element}  ${fild}  ${date}
#    Set Time  ${time_element}  ${date}


Set Date
    [Arguments]  ${element}  ${fild}  ${date}
    Execute Javascript  var s = angular.element('[ng-controller=CreateProcurementCtrl]').scope(); s.model.ptr.${element}.${fild} = new Date(Date.parse("${date}")); s.$broadcast('periods:init'); s.$root.$apply()


Set Date In Item
    [Arguments]  ${index}  ${element}  ${param}  ${field}  ${date}
    Execute Javascript
    ...  var s = angular.element('[ng-controller=CreateProcurementCtrl]').scope();
    ...  s.model.ptr.items[${index}].${element}.${param} = new Date("${date}");
    ...  s.model.ptr.items[${index}].${element}.${field} = new Date("${date}").getTime();
    ...  s.$root.$apply()


Set Time
    [Arguments]  ${element}  ${date}
    ${time}=  Get Regexp Matches  ${date}  T(\\d{2}:\\d{2})  1
    Input Text  ${element}  ${time[0]}


Close Confirmation In Editor
    [Arguments]  ${confirmation_text}
    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
    Wait Until Element Contains  css=div.modal-body.info-div  ${confirmation_text}  ${COMMONWAIT}
    Sleep  2s
    Wait Visibility And Click Element  css=button[data-id='modal-close']
    Sleep  1s
    Wait Until Element Is Not Visible  css=div.modal-body.info-div  ${COMMONWAIT}


Wait For Notification
    [Arguments]  ${message_text}
    Wait Until Element Is Enabled  xpath=//div[@class='alert-info ng-scope ng-binding']  timeout=${COMMONWAIT}
    Wait Until Element Contains  xpath=//div[@class='alert-info ng-scope ng-binding']  ${message_text}  timeout=10


Scroll Page To Element
    [Arguments]  ${locator}
    ${temp}=  Remove String  ${locator}  '
    ${cssLocator}=  Run Keyword If  'css' in '${temp}'  Get Substring  ${locator}  4
    ...  ELSE  Get Substring  ${locator}  6
    ${js_expresion}=  Run Keyword If  'css' in '${temp}'  Convert To String  return window.$("${cssLocator}")[0].scrollIntoView()
    ...  ELSE  Convert To String  return window.$x("${cssLocator}")[0].scrollIntoView()
    Sleep  2s


Set Enquiry Period
    [Arguments]  ${startDate}  ${endDate}
    Wait Until Element Is Visible  css=input[data-id='enquiryPeriodStart']  ${COMMONWAIT}
    Set Date And Time  enquiryPeriod  startDate  css=input[data-id='enquiryPeriodStart']  ${startDate}
    Wait Until Element Is Visible  css=input[data-id='enquiryPeriodEnd']  ${COMMONWAIT}
    Set Date And Time  enquiryPeriod  endDate  css=input[data-id='enquiryPeriodEnd']  ${endDate}


Set Tender Period
    [Arguments]  ${startDate}  ${endDate}
    Wait Until Element Is Visible  css=input[data-id='tenderPeriodStart']  ${COMMONWAIT}
    Set Date And Time  tenderPeriod  startDate  css=input[data-id='tenderPeriodStart']  ${startDate}
    Wait Until Element Is Visible  css=input[data-id='tenderPeriodEnd']  ${COMMONWAIT}
    Set Date And Time  tenderPeriod  endDate  css=input[data-id='tenderPeriodEnd']  ${endDate}


Wait For Ajax
    Wait For Condition  return window.jQuery!=undefined && jQuery.active==0  60s
    Sleep  2s


Get Item Number
    [Arguments]  ${object_id}
    ${elements}=  Get Webelements  xpath=//section[contains(@class, 'lot-description')]//section/div/section[not (contains(@class, 'description'))]
    ${item_num}=  Set Variable  0
    ${count}=  Get_Length  ${elements}
    :FOR  ${item}  In Range  0  ${count}
    \  ${item}=  privatmarket_service.sum_of_numbers  ${item}  1
    \  ${text}=  Get Text  xpath=(//div[@class='lot-info']/section//div[@class='description']//a)[${item}]
    \  ${item_num}=  Run Keyword If  '${object_id}' in '${text}'  Set Variable  ${item}
    \  ...  ELSE  Set Variable  ${item_num}
    [Return]  ${item_num}


Відповісти на вимогу про виправлення умов закупівлі
    [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
    Wait Until Keyword Succeeds  5min  10s  Wait For Element With Reload  xpath=//div[@id='nav-tab']//span[@class='ng-scope ng-binding']  3
    Wait Until Keyword Succeeds  15min  10s  Wait For Element With Reload  xpath=//div[contains(@class,'faq ng-scope') and contains(.,', id: ${complaintID}')]//button[@class='btn btn-success ng-scope ng-binding']  3
    Wait Visibility And Click Element  xpath=//div[contains(@class,'faq ng-scope') and contains(.,', id: ${complaintID}')]//button[@class='btn btn-success ng-scope ng-binding']
    Wait Visibility And Click Element  xpath=//div[@class='info-item']//select[@id='resolutionType']/option[@value='${answer_data.data.resolutionType}']
    Wait Element Visibility And Input Text  xpath=//textarea[@class='ng-pristine ng-valid']  ${answer_data.data.resolution}
    Wait Visibility And Click Element  xpath=//button[@data-id='btn-send-complaint-resolution']
    Sleep  120s


Відповісти на вимогу про виправлення умов лоту
    [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
    privatmarket.Відповісти на вимогу про виправлення умов закупівлі  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}

Завантажити документ рішення кваліфікаційної комісії
    [Arguments]  ${username}  ${document}  ${tender_uaid}  ${award_num}
    Wait Until Element Is Visible  xpath=//li[contains(@ng-class, 'lot-parts')]
    ${class}=  Get Element Attribute  xpath=//li[contains(@ng-class, 'lot-parts')]@class
    Run Keyword Unless  'checked-nav' in '${class}'  Click Element  xpath=//li[contains(@ng-class, 'lot-parts')]

    Wait Until Keyword Succeeds  15min  10s  Wait Visibility And Click Element  xpath=//div[@class='lot-info ng-scope' and contains(.,'Кваліфікація учасників') ]//table[@class='bids']//a[@class='ng-binding']
    Sleep  1s
    Wait Visibility And Click Element  xpath=//div[@class='files-upload']//select[@class='form-block__select form-block__select_short']//option[2]
    Sleep  1s
    Wait Visibility And Click Element  xpath=//div[@class='files-upload']//select[@class='form-block__select ng-scope form-block__select_short']//option[3]
    Sleep  1s
    Choose File  xpath=//div[@class='files-upload']//input[@type='file']  ${document}
    Sleep  5s


Відповісти на вимогу про виправлення визначення переможця
    [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}  ${award_index}
    privatmarket.Відповісти на вимогу про виправлення умов закупівлі  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}

Підтвердити постачальника
    [Arguments]  ${username}  ${tender_uaid}  ${award_num}
    Wait Until Element Is Visible  xpath=//li[contains(@ng-class, 'lot-parts')]
    ${class}=  Get Element Attribute  xpath=//li[contains(@ng-class, 'lot-parts')]@class
    Run Keyword Unless  'checked-nav' in '${class}'  Click Element  xpath=//li[contains(@ng-class, 'lot-parts')]
    Wait Visibility And Click Element  xpath=//div[@class='award-section award-actions ng-scope']//button[@data-id='setActive']

