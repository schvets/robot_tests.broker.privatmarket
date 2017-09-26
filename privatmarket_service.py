# coding=utf-8

from munch import munchify as privatmarket_munchify
from selenium.common.exceptions import StaleElementReferenceException
from datetime import datetime, timedelta
from pytz import timezone


def modify_test_data(initial_data):
    #set user name
    # initial_data['procuringEntity']['name'] = u'Товариство З Обмеженою Відповідальністю \'Мак Медіа Прінт\''
    initial_data['procuringEntity']['name'] = u'ТОВАРИСТВО З ОБМЕЖЕНОЮ ВІДПОВІДАЛЬНІСТЮ \'СІЛЬСЬКОГОСПОДАРСЬКА ФІРМА \'РУБІЖНЕ\''
    initial_data['procuringEntity']['contactPoint']['telephone'] = u'+380670444580'
    initial_data['procuringEntity']['contactPoint']['url'] = u'https://dadadad.com'
    initial_data['procuringEntity']['identifier']['legalName'] = u'ТОВАРИСТВО З ОБМЕЖЕНОЮ ВІДПОВІДАЛЬНІСТЮ \'СІЛЬСЬКОГОСПОДАРСЬКА ФІРМА \'РУБІЖНЕ\''
    initial_data['procuringEntity']['identifier']['id'] = u'38580144'
    # initial_data['procuringEntity']['name'] = u'Макстрой Діск, Товариство З Обмеженою Відповідальністю'
    # initial_data['procuringEntity']['name'] = u'ФОП ОГАНІН ОЛЕКСАНДР ПЕТРОВИЧ'
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
    monthes = [u"января", u"февраля", u"марта", u"апреля", u"мая", u"июня",
               u"июля", u"августа", u"сентября", u"октября", u"ноября", u"декабря",
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


def get_current_date():
    now = datetime.now()
    return now.strftime('%d-%m-%Y')


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
        u'упаковка': {u'упаковка', u'упаковок', u'упаковки'},
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


def get_unit_name_ru(current_name):
    if isinstance(current_name, str):
        current_name = current_name.decode("utf-8")
    dictionary = {
        u'килограмм': {u'килограмм', u'килограмма', u'килограммов', u'кілограми'},
        u'пара': {u'пара', u'пары', u'пар'},
        u'литр': {u'литр', u'литра', u'литров'},
        u'набор': {u'набір', u'набора', u'наборов'},
        u'пачек': {u'пачка', u'пачек', u'пачки'},
        u'метр': {u'метр', u'метра', u'метров'},
        u'лот': {u'лот', u'лоты', u'лотов'},
        u'услуга': {u'услуга', u'услуг', u'услуги'},
        u'метр .куб.': {u'метр кубический', u'метра кубического', u'метров кубических'},
        u'ящик': {u'ящик', u'ящика', u'ящиков'},
        u'рейс': {u'рейс', u'рейса', u'рейсов'},
        u'тонны': {u'тонна', u'тонны', u'тонн'},
        u'метр квадратный': {u'метр квадратный', u'метра квадратного', u'метров квадратных'},
        u'километры': {u'километр', u'километров', u'километра'},
        u'штука': {u'штука', u'штуки', u'штук'},
        u'месяц': {u'месяц', u'месяца', u'месяцев'},
        u'пачка': {u'пачка', u'пачек', u'пачкики'},
        u'упаковка': {u'упаковка', u'упаковок', u'упаковки'},
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
        u'ДК 18-2000': u'ДК018',
        u'ДК003: 2010': u'ДК003',
        u'ДК003:2010': u'ДК003',
        u'ДК021': u'CPV'

    }
    classifications_type = classifications_dictionary.get(classifications)
    if classifications_type:
        return classifications_type
    else:
        return classifications


def get_status_type(status_name):
    status_name = status_name.strip()
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
        u'Відмінено': 'cancelled',
        u'Розглядається': 'pending',
        u'Кваліфікація учасника': 'active.pre-qualification',
        u'Пауза перед аукціоном': 'active.pre-qualification.stand-still',
        u'Прекваліфікація': 'active.pre-qualification',
        u'Преквалификация': 'active.pre-qualification'
    }
    type_name = type_dictionary.get(status_name)
    return type_name


def convert_float_to_string(number):
    return format(number, '.2f')


def get_claim_status (status):
    type_dictionary = {
        u'Вiдправлено': 'claim',
        u'Отримано вiдповiдь': 'answered',
        u'Вирiшена': 'resolved',
        u'Скасована': 'cancelled',
        u'Не вирiшена, обробляється': 'pending',
        u'Залишена без відповіді': 'ignored',
        u'Вiдхилена': 'declined',
        u'Недiйсна': 'invalid'
    }
    type_name = type_dictionary.get(status)
    return type_name


def sum_of_numbers(number, value):
    number = int(number) + int(value)
    return number


def get_abs_item_index(lot_index, item_index, items_count):
    abs_index = ((int(lot_index)-1) * int(items_count)) + item_index
    return abs_index


def get_percent(value):
    value = value * 100
    return format(value, '.0f')


def get_cause(cause_text):
    cause_dictionary = {
        u'Закупівля творів мистецтва або закупівля, пов’язана із захистом прав інтелектуальної власності, або укладення договору про закупівлю з переможцем архітектурного чи мистецького конкурсу': u'artContestIP',
        u'Відсутність конкуренції (у тому числі з технічних причин) на відповідному ринку, внаслідок чого договір про закупівлю може бути укладено лише з одним постачальником, завідсутності при цьому альтернативи': u'noCompetition',
        u'Нагальна потреба у здійсненні закупівлі у зв’язку з виникненням особливих економічних чи соціальних обставин, яка унеможливлює дотримання замовниками строків для проведення тендеру, а саме пов’язаних з негайною ліквідацією наслідків надзвичайних ситуацій, а також наданням у встановленому порядку Україною гуманітарної допомоги іншим державам. Застосування переговорної процедури закупівлі в таких випадках здійснюється за рішенням замовника щодо кожної процедури': u'quick',
        u'Якщо замовником було двічі відмінено тендер через відсутність достатньої кількостіучасників,прицьому предмет закупівлі, його технічні та якісніхарактеристики, атакож вимогидо учасника не повинні відрізнятисявід вимог, що були визначені замовникому тедерній документації': u'twiceUnsuccessful',
        u'Потреба здійснити додаткову закупівлю в того самого постачальника з метою уніфікації, стандартизації або забезпечення сумісності з наявними товарами, технологіями, роботами чи послугами, якщо заміна попереднього постачальника (виконавця робіт, надавача послуг) може призвести до несумісності або виникнення проблем технічного характеру,пов’язаних з експлуатацією та обслуговуванням': u'additionalPurchase',
        u'Необхідність проведення додаткових будівельних робіт, не зазначених у початковому проекті, але які стали через непередбачувані обставини необхідними для виконання проекту за сукупності таких умов: договір буде укладено з попереднім виконавцем цих робіт, такі роботи технічно чи економічно пов’язані з головним (первинним) договором; загальна вартість додаткових робіт не перевищує 50 відсотків вартості головного (первинного) договору': u'additionalConstruction',
        u'Закупівля юридичних послуг, пов’язаних із захистом прав та інтересів України, у тому числі з метою захисту національної безпеки і оборони, під час врегулювання спорів, розгляду в закордонних юрисдикційних органах справ за участю іноземного суб’єкта та України, на підставі рішення Кабінету Міністрів України або введених в дію відповідно до закону рішень Ради національної безпеки і оборони України': u'stateLegalServices'
    }
    cause_type = cause_dictionary.get(cause_text)
    if cause_type:
        return cause_type
    else:
        return cause_text


def get_items_from_lot(items, lot_id):
    lot_items = []
    for item in items:
        if item['relatedLot'] == lot_id:
            lot_items.append(item)
    return lot_items
