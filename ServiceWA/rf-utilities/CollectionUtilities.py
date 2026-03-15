import datetime
def remove_given_Value_from_list(list_Data, valueToRemove):
    list_Data.remove(valueToRemove)
    return list_Data


def remove_given_index_from_list(list_Data, index_num):
    list_Data.pop(int(index_num))
    return list_Data


def Combine_two_dictionary(dict_one, dict_two):
    dict_one.update(dict_two)
    return dict_one


def Create_new_dict_for_given_values(dict_items, list_items):
    new_dict = dict((k, v) for k, v in dict_items.items() if k in list_items)
    return new_dict


def Validate_the_given_Lists_are_in_ascending_order(list_items):
    flag = False
    if list_items == sorted(list_items):
        flag = True

    return flag


def Convert_price_string_to_numbers(price_string):
    import locale
    locale.setlocale(locale.LC_ALL, '')
    money = price_string
    amount_in_numbers = locale.atof(money.strip("$"))
    return amount_in_numbers


def convert_string_to_decimal_number(number_str):
    Float = float(number_str)
    formatted_float = "{:.2f}".format(Float)
    return formatted_float


def generate_random_cart_name(cartname='TestCart'):
    now = datetime.datetime.now()
    newcartname = cartname + '_' + now.strftime("%Y%m%d%H%M%S")
    return newcartname
