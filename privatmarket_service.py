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

def change_date_to_ISO_format(date, start_format):
    date_obj = datetime.strptime(date, start_format)
    time_zone = timezone('Europe/Kiev')
    localized_date = time_zone.localize(date_obj)
    return localized_date.isoformat()

def change_date_format(date, start_format, end_format):
    return datetime.strptime(date, start_format).strftime(end_format)


def get_file_content(path_to_save_file):
    f = open(path_to_save_file, 'r')
    file_data = f.read()
    f.close()
    return file_data

def modify_test_data(initial_data):
    initial_data['procuringEntity']['name'] = u"Тестовый Тестовый"
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