# coding=utf-8

from munch import munchify as privatmarket_munchify
from selenium.common.exceptions import StaleElementReferenceException


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


def bid_data(status):
    status_dictionary = {
                       u'Невалидна': 'invalid',
                       u'Отправлена': 'sent'
                       }

    status_name = status_dictionary.get(status)
    return privatmarket_munchify({
        "data": {
            "status": status_name
        }
    })


def is_element_not_stale(webelement):
    try:
        webelement.is_enabled()
    except StaleElementReferenceException:
        return True
    return False


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
