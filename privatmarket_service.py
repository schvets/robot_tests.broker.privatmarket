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


def format_amount(amount):
    amount = round(amount/100, 2)
    return format(float(amount), '.2f')
