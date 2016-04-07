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
        u'ДК 016:2010': u'ДКПП'
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
                       u'Открытые торги с публикацией на англ.языке': 'aboveThresholdEU',
                       u'Отчет о заключении договора': 'reporting',
                       u'Переговорная процедура': 'negotiation',
                       u'Срочная переговорная процедура': 'negotiation.quick',
                       u'Открытые торги (особенности обороны)': 'aboveThresholdUA.defense'
                       }
    type_name = type_dictionary.get(method_name)
    return type_name
