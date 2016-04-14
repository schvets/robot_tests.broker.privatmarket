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


def get_Classifications_type(classifications):
    classifications_dictionary = {
        u'ДК 016:2010': u'ДКПП'
    }
    classifications_type = classifications_dictionary.get(classifications)
    if classifications_type:
        return classifications_type
    else:
        return classifications


def get_Identification_Scheme(scheme):
    scheme_dictionary = {
        u'ЕГРПОУ': u'UA-EDR',
        u'ЄДРПОУ': u'UA-EDR'
    }
    identification_Scheme = scheme_dictionary.get(scheme)
    if identification_Scheme:
        return identification_Scheme
    else:
        return scheme