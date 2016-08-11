# coding=utf-8

from munch import munchify as privatmarket_munchify
from selenium.common.exceptions import StaleElementReferenceException
from datetime import datetime, timedelta
from pytz import timezone
import dateutil.parser


def get_month_number(month_name):
    monthes = [u"янв.", u"февр.", u"марта", u"апр.", u"мая", u"июня",
               u"июля", u"авг.", u"сент.", u"окт.", u"нояб.", u"дек.",
               u"січ.", u"лют.", u"бер.", u"квіт.", u"трав.", u"черв.",
               u"лип.", u"серп.", u"вер.", u"жовт.", u"лист.", u"груд.",
               u"січеня", u"лютого", u"березня", u"квітня", u"травня", u"червня",
               u"липня", u"серпня", u"вересня", u"жовтня", u"листопада", u"грудня", ]
    return monthes.index(month_name) % 12 + 1


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


def get_procurement_method_type(method_name):
    type_dictionary = {
        u'Допорогові закупівлі': 'belowThreshold',
        u'Відкриті торги': 'aboveThresholdUA',
        u'Відкриті торги з публікацією англ.мовою': 'aboveThresholdEU',
        u'Звіт про укладений договір': 'reporting',
        u'Переговорна процедура': 'negotiation',
        u'Переговорна процедура за нагальною потребою': 'negotiation.quick',
        u'Переговорна процедура (для потреб оборони)': 'aboveThresholdUA.defense'
    }
    type_name = type_dictionary.get(method_name)
    if type_name:
        return type_name
    else:
        return method_name


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


def get_status_type(status_name):
    type_dictionary = {
        u'Період уточнень': 'active.enquiries',
        u'Період уточнень завершено': 'active.enquiries.ended',
        u'Подача пропозицій': 'active.tendering',
        u'Очікування пропозицій': 'active.auction',
        u'Кваліфікація переможця': 'active.qualification',
        u'Пропозиції розглянуто': 'active.awarded',
        u'Закупівля не відбулась': 'unsuccessful',
        u'Pавершена закупівля': 'complete',
        u'Відмінена закупівля': 'cancelled'
    }
    type_name = type_dictionary.get(status_name)
    if type_name:
        return type_name
    else:
        return status_name


def get_lot_num_by_item(tender_data, item_index):
    items = tender_data['items']

    lot_num = 0
    item_num = 1
    lots_count = 0
    related_lot = None
    count_of_items_in_lot_dictionary = {}

    if 'lots' in tender_data:
        lots = tender_data['lots']
        lots_count = len(lots)
        lot_num = 1

        for item in items:
            related_lot = item['relatedLot']
            if related_lot in count_of_items_in_lot_dictionary:
                count_of_items_in_lot_dictionary[related_lot] += 1
            else:
                count_of_items_in_lot_dictionary[related_lot] = 1

            if item_index in item['description']:
                break

        for lot in lots:
            if related_lot in lot['id']:
                break
            lot_num += 1

        item_num = count_of_items_in_lot_dictionary[related_lot]
    else:
        for item in items:
            if item_index in item['description']:
                break
            item_num += 1

    return item_num, lot_num, lots_count


def get_item_num(tender_data, item_id):
    items = tender_data['items']
    item_num = 0

    for i, item in enumerate(items):
        if item_id in item['description']:
            item_num = i
            break

    return item_num + 1


def is_object_present(tender_data, object_id):
    result = False

    if 'i-' in object_id:
        items = tender_data['items']
        for item in items:
            if object_id in item['description']:
                result = True
                break

    if 'l-' in object_id:
        lots = tender_data['lots']
        for lot in lots:
            if object_id in lot['title']:
                result = True
                break

    return result


def get_unit_ru_name(current_name):
    dictionary = {
        u'кілограми': u'килограмм',
        u'пара': u'пара',
        u'літр': u'литр',
        u'набір': u'комплект',
        u'пачок': u'пачка',
        u'метри': u'метр',
        u'лот': u'лот',
        u'послуга': u'услуга',
        u'метри кубічні': u'метр кубический',
        u'ящик': u'ящик',
        u'рейс': u'рейс',
        u'тони': u'тонна',
        u'метри квадратні': u'метр квадратный',
        u'кілометри': u'километр',
        u'штуки': u'штука',
        u'місяць': u'месяц',
        u'пачка': u'пачка',
        u'упаковка': u'упаковка',
        u'гектар': u'гектар',
        u'блок': u'блок'
    }

    expected_name = dictionary.get(current_name)

    if expected_name:
        return expected_name
    else:
        return current_name


def format_amount(amount):
    amount = round(amount/100, 2)
    return format(float(amount), '.2f')
