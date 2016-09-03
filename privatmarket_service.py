# coding=utf-8

from munch import munchify as privatmarket_munchify
from selenium.common.exceptions import StaleElementReferenceException
from datetime import datetime, timedelta
from pytz import timezone
import dateutil.parser

from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from robot.libraries.BuiltIn import BuiltIn


def fill_file_data(url, title, date_modified, date_published):
    return privatmarket_munchify({
        "data": {
            "url": url,
            "title": title,
            "id": "",
            "dateModified": date_modified,
            "datePublished": date_published,
        }
    })


def is_element_not_stale(web_element):
    try:
        web_element.is_enabled()
    except StaleElementReferenceException:
        return True
    return False


def get_time_with_offset(date):
    date_obj = datetime.strptime(date, "%d-%m-%Y %H:%M")
    time_zone = timezone('Europe/Kiev')
    localized_date = time_zone.localize(date_obj)
    return localized_date.strftime('%Y-%m-%d %H:%M:%S.%f%z')


def add_time(date, minutes_to_add):
    optimized_date = dateutil.parser.parse(date)
    optimized_date = optimized_date + timedelta(minutes=int(minutes_to_add))
    return optimized_date.strftime('%Y-%m-%dT%H:%M:%S.%f%z')


def modify_test_data(initial_data):
    initial_data['procuringEntity']['name'] = u"Ат Тестюршадрову2"
    initial_data['enquiryPeriod']['startDate'] = add_time(initial_data['enquiryPeriod']['startDate'], 5)
    items = initial_data['items']
    for item in items:
        date = dateutil.parser.parse(item['deliveryDate']['endDate'])
        item['deliveryDate']['endDate'] = date.strftime('%Y-%m-%dT00:00:00+03:00')
    return initial_data


def get_unit_name(current_name):
    dictionary = {
        u'кілограми': {u'килограмм', u'килограмма', u'килограммов'},
        u'пара': {u'пара', u'пары', u'пар'},
        u'літр': {u'литр', u'литра', u'литров'},
        u'набір': {u'комплект', u'комплекта', u'комплектов'},
        u'пачок': {u'пачка', u'пачек', u'пачки'},
        u'метри': {u'метр', u'метра', u'метров'},
        u'лот': {u'лот', u'лоты', u'лотов'},
        u'послуга': {u'услуга', u'услуг', u'услуги'},
        u'метри кубічні': {u'метр кубический', u'метра кубического', u'метров кубических'},
        u'ящик': {u'ящик', u'ящика', u'ящиков'},
        u'рейс': {u'рейс', u'рейса', u'рейсов'},
        u'тони': {u'тонна', u'тонны', u'тонн'},
        u'метри квадратні': {u'метр квадратный', u'метра квадратного', u'метров квадратных'},
        u'кілометри': {u'километр', u'километров', u'километра'},
        u'штуки': {u'штука', u'штуки', u'штук'},
        u'місяць': {u'месяц', u'месяца', u'месяцев'},
        u'пачка': {u'пачка', u'пачек', u'пачкики'},
        u'упаковка': {u'упковка', u'упаковок', u'упаковки'},
        u'гектар': {u'гектар', u'гектара', u'гектаров'},
        u'блок': {u'блок', u'блока', u'блоков'}
    }

    expected_name = None
    for name, variants in dictionary.iteritems():
        if current_name in variants:
            expected_name = name

    if expected_name:
        return expected_name
    else:
        return current_name


def get_unit_code(name):
    dictionary = {
        u'кілограми': u'KGM',
        u'пара': u'PR',
        u'літр': u'LTR',
        u'набір': u'SET',
        u'пачок': u'NMP',
        u'метри': u'MTR',
        u'лот': u'LO',
        u'послуга': u'E48',
        u'метри кубічні': u'MTQ',
        u'ящик': u'BX',
        u'рейс': u'E54',
        u'тони': u'TNE',
        u'метри квадратні': u'MTK',
        u'кілометри': u'KMT',
        u'штуки': u'H87',
        u'місяць': u'MON',
        u'пачка': u'RM',
        u'упаковка': u'PK',
        u'гектар': u'HAR',
        u'блок': u'D64'
    }
    expected_name = dictionary.get(name)
    if expected_name:
        return expected_name
    else:
        return name


def format_amount(amount):
    amount = round(amount/100, 2)
    return format(float(amount), '.2f')


def wait_for_angular():
    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    browser = se2lib._current_browser()
    timeout = 60

    js_waiting_var = """
        var waiting = true;
        var callback = function () {waiting = false;}
        var el = document.querySelector('[ng-app]');
        if (typeof angular.element(el).injector() == "undefined") {
            throw new Error('root element ([ng-app]) has no injector.' +
                   ' this may mean it is not inside ng-app.');
        }
        angular.element(el).injector().get('$browser').
                    notifyWhenNoOutstandingRequests(callback);
        return waiting;
    """

    js_get_pending_http_requests = """
    var el = document.querySelector('[ng-app]');
    var $injector = angular.element(el).injector();
    var $http = $injector.get('$http');
    return $http.pendingRequests;
    """

    try:
        WebDriverWait(browser, timeout, 0.2) \
            .until_not(lambda x: browser.execute_script(js_waiting_var))
    except TimeoutException:
        browser.execute_script('return window.NG_PENDING_TIMEOUTS')
        browser.execute_script(js_get_pending_http_requests)
        raise TimeoutException("Problem with angular")