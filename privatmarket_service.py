# coding=utf-8

from munch import munchify as privatmarket_munchify
from selenium.common.exceptions import StaleElementReferenceException
from datetime import datetime
from pytz import timezone


def get_month_number(month_name):
    monthes = [u"янв.", u"февр.", u"марта", u"апр.", u"мая", u"июня",
               u"июля", u"авг.", u"сент.", u"окт.", u"нояб.", u"дек."]
    return monthes.index(month_name) + 1


def read_file_content(file_path):
    with open(file_path, 'r') as content_file:
        return content_file.read()


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


def get_bid_data(status):
    return privatmarket_munchify({
        "data": {
            "status": status
        }
    })


def is_element_not_stale(web_element):
    try:
        web_element.is_enabled()
    except StaleElementReferenceException:
        return True
    return False


def get_currency_type(currency):
    currency_dictionary = {
        u'грн': 'UAH'
    }
    currency_type = currency_dictionary.get(currency)
    if currency_type:
        return currency_type
    else:
        return currency


def get_classification_type(classifications):
    classifications_dictionary = {
        u'ДК 016:2010': u'ДКПП',
        u'ДК 021:2015': u'CPV'
    }
    classifications_type = classifications_dictionary.get(classifications)
    if classifications_type:
        return classifications_type
    else:
        return classifications


def get_time_with_offset(date):
    date_obj = datetime.strptime(date, "%Y-%m-%d %H:%M")
    time_zone = timezone('Europe/Kiev')
    localized_date = time_zone.localize(date_obj)
    return localized_date.strftime('%Y-%m-%d %H:%M:%S.%f%z')


def get_procurement_method_type(method_name):
    type_dictionary = {
                       u'Допороговая закупка': 'belowThreshold',
                       u'Открытые торги': 'aboveThresholdUA',
                       u'Открытые торги с публикацией на англ. языке': 'aboveThresholdEU',
                       u'Отчет о заключении договора': 'reporting',
                       u'Переговорная процедура': 'negotiation',
                       u'Срочная переговорная процедура': 'negotiation.quick',
                       u'Открытые торги (особенности обороны)': 'aboveThresholdUA.defense'
                       }
    type_name = type_dictionary.get(method_name)
    return type_name


def get_doc_identifier(doc_type_name):
    type_dictionary = {
                       'eligibility_documents': 20,
                       'qualification_documents': 21,
                       'documents': 48,
                       'financial_documents': 49
                       }
    type_name = type_dictionary.get(doc_type_name)
    return str(type_name)


def get_unit_name(current_name):
    dictionary = {
        u'килограммы': {u'килограмм', u'килограмма', u'килограммов'},
        u'пара': {u'пара', u'пары', u'пар'},
        u'літр': {u'литр', u'литра', u'литров'},
        u'набір': {u'набор', u'набора', u'наборов'},
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
    dictionary.get(current_name)
    for name, variants in dictionary.iteritems():
        if current_name in variants:
            expected_name = name

    if expected_name:
        return expected_name
    else:
        return current_name


def get_unit_code(name):
    dictionary = {
        u'килограмм': u'KGM',
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
