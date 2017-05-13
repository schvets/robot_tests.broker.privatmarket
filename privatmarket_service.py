# coding=utf-8

from selenium.common.exceptions import StaleElementReferenceException
from datetime import datetime
from pytz import timezone


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


def get_file_content(path_to_save_file):
    f = open(path_to_save_file, 'r')
    file_data = f.read()
    f.close()
    return file_data

def modify_test_data(initial_data):
    initial_data['procuringEntity']['name'] = u"ВОЛОДИМИР БІЛЯВЦЕВ"
    return initial_data

def sum_of_numbers(number, value):
    number = int(number) + int(value)
    return number

def get_current_year():
    now = datetime.now()
    return now.year

def get_month_number(month_name):
    monthes = [u"січня", u"лютого", u"березня", u"квітня", u"травня", u"червня",
               u"липня", u"серпня", u"вересня", u"жовтня", u"листопада", u"грудня",
               u"January", u"February", u"March", u"April", u"May", u"June",
               u"July", u"August", u"September", u"October", u"November", u"December"]
    return monthes.index(month_name) % 12 + 1

def get_status_type(status_name):
    type_dictionary = {
        u'Період уточнень та пропозицій': 'active.enquiries',
        u'Період уточнень': 'active.enquiries',
        u'Період прийому пропозицій': 'active.tendering',
        u'Період уточнень та пропозицій завершено': 'active.enquiries.ended',
        u'Аукіон': 'active.auction',
        u'Кваліфікація': 'ctive.qualification',
        u'Визначення переможця': 'active.qualification',
        u'Пропозиції розглянуті': 'active.awarded',
        u'Оплачено, очікується підписання договору': 'active.awarded',
        u'Активний лот': 'active',
        u'Торги не відбулися': 'unsuccessful',
        u'Закупівля не відбулась': 'unsuccessful',
        u'Торги відмінено': 'cancelled',
        u'Очікується протокол': 'pending',
        u'Очікується оплата': 'validation',
        u'Не поступила оплата': 'nopayment',
        u'Не опубліковано у ЦБД': 'draft',
        u'Завершено': 'complete',
        u'Відмінено': 'cancelled',
    }
    type_name = type_dictionary.get(status_name)
    return type_name