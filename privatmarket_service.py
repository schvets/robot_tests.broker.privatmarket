# coding=utf-8
import re

from munch import munchify
from selenium.common.exceptions import StaleElementReferenceException


def get_reg_exp_matches(reg_exp, string, group_num = 1):
    result = "none"
    # m = re.search(reg_exp.decode("utf-8"), string.decode("utf-8"), re.U)
    m = re.search(reg_exp, string)
    if m:
        result = m.group(int(group_num))
    return result

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

def read_file_content(filePath):
    with open(filePath, 'r') as content_file:
	return content_file.read()

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