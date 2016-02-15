# coding=utf-8
import re

from iso8601 import parse_date
from munch import fromYAML, Munch, munchify


def get_pb_time(time):
    iso_dt = parse_date(time)
    if(iso_dt.minute <= 15):
        iso_dt = iso_dt.replace(minute=30)
    else:
        iso_dt = iso_dt.replace(hour=iso_dt.hour + 1, minute=00)
    return iso_dt.strftime("%H:%M")

def get_reg_exp_matches(reg_exp, string, group_num = 1):
    result = "none"
    # m = re.search(reg_exp.decode("utf-8"), string.decode("utf-8"), re.U)
    m = re.search(reg_exp, string)
    if m:
        result = m.group(int(group_num))
    return result

def convert_date_to_etender_format(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%d-%m-%Y")
    return date_string

def strip_string(string):
    return string.strip()

def strip_string(string):
    return string.strip()

def get_month_number(month_name):
    monthes=[u"янв.", u"февр.", u"марта", u"апр.", u"мая", u"июня", u"июля", u"авг.", u"сент.", u"окт.", u"нояб.", u"дек."]
    return monthes.index(month_name) + 1

def is_element_stale(webelement):
    """
    Checks if a webelement is stale.
    @param webelement: A selenium webdriver webelement
    """
    try:
        webelement.tag_name
    except StaleElementReferenceException:
        return True
    except:
        pass
    return False

def readFileContent(filePath):
    with open(filePath, 'r') as content_file:
        content = content_file.read()
    return content

def fill_file_data(url, title, dateModified, datePublished):
    return munchify({
        "data": {
            "url": url,
            "title": title,
            "id": "",
            "dateModified": dateModified,
            "datePublished": datePublished,
        }
    })

def fill_bid_data(amount):
    return munchify({
        "data": {
            "value": {
                "amount": amount,
                "currency": "UAH"
            }
        }
    })