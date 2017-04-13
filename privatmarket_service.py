# coding=utf-8

from munch import munchify as privatmarket_munchify
from selenium.common.exceptions import StaleElementReferenceException
from datetime import datetime, timedelta
from pytz import timezone


def modify_test_data(initial_data):
    #set user name
    # initial_data['procuringEntity']['name'] = u'Товариство З Обмеженою Відповідальністю \'Мак Медіа Прінт\''
    initial_data['procuringEntity']['name'] = u'Товариство З Обмеженою Відповідальністю \'Сільськогосподарська Фірма \'Рубіжне\''
    # initial_data['procuringEntity']['name'] = u'Макстрой Діск, Товариство З Обмеженою Відповідальністю'
    return initial_data


def get_currency_type(currency):
    if isinstance(currency, str):
        currency = currency.decode("utf-8")
    currency_dictionary = {
        u'грн': 'UAH'
    }
    currency_type = currency_dictionary.get(currency)
    if currency_type:
        return currency_type
    else:
        return currency


def get_month_number(month_name):
    monthes = [u"янв.", u"февр.", u"марта", u"апр.", u"мая", u"июня",
               u"июля", u"авг.", u"сент.", u"окт.", u"нояб.", u"дек.",
               u"січ.", u"лют.", u"бер.", u"квіт.", u"трав.", u"черв.",
               u"лип.", u"серп.", u"вер.", u"жовт.", u"лист.", u"груд.",
               u"січня", u"лютого", u"березня", u"квітня", u"травня", u"червня",
               u"липня", u"серпня", u"вересня", u"жовтня", u"листопада", u"грудня"]
    return monthes.index(month_name) % 12 + 1


def get_time_with_offset(date):
    date_obj = datetime.strptime(date, "%Y-%m-%d %H:%M")
    time_zone = timezone('Europe/Kiev')
    localized_date = time_zone.localize(date_obj)
    return localized_date.strftime('%Y-%m-%d %H:%M:%S.%f%z')


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


def get_unit_name(current_name):
    if isinstance(current_name, str):
        current_name = current_name.decode("utf-8")
    dictionary = {
        u'кілограми': {u'килограмм', u'килограмма', u'килограммов'},
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


def get_classification_type(classifications):
    classifications_dictionary = {
        u'ДК 016:2010': u'ДКПП',
        u'ДК 021:2015': u'CPV',
        u'ДК 18-2000': u'ДК018'
    }
    classifications_type = classifications_dictionary.get(classifications)
    if classifications_type:
        return classifications_type
    else:
        return classifications


def get_status_type(status_name):
    type_dictionary = {
        u'Период уточнений': 'active.enquiries',
        u'Період уточнень': 'active.enquiries',
        u'Период уточнений завершен': 'active.enquiries.ended',
        u'Період уточнень завершено': 'active.enquiries.ended',
        u'Подача предложений': 'active.tendering',
        u'Подача пропозицій': 'active.tendering',
        u'Торги': 'active.auction',
        u'Квалификация победителя': 'active.qualification',
        u'Квалификація переможця': 'active.qualification',
        u'Предложения рассмотрены': 'active.awarded',
        u'Пропозиції розглянуті': 'active.awarded',
        u'Закупка не состоялась': 'unsuccessful',
        u'Закупівля не відбулась': 'unsuccessful',
        u'Завершено': 'complete',
        u'Отменено': 'cancelled',
        u'Відмінено': 'cancelled'
                       }
    type_name = type_dictionary.get(status_name)
    return type_name


def convert_float_to_string(number):
    return format(number, '.2f')
