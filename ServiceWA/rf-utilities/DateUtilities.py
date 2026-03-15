import calendar
from datetime import datetime
from datetime import timedelta, date


def add_given_no_of_days_and_return_new_date(no_of_days):
    EndDate = date.today() + timedelta(days=int(no_of_days))
    month = EndDate.strftime("%B")
    day = EndDate.day
    year = EndDate.year
    return day, month, year


def add_given_no_of_business_days_and_return_new_date(no_of_days):
    EndDate = date.today()
    business_days_to_add = int(no_of_days)
    while business_days_to_add > 0:
        EndDate += timedelta(days=1)
        weekday = EndDate.weekday()
        if weekday >= 5:  # sunday = 6
            continue
        business_days_to_add -= 1
    month = EndDate.strftime("%B")
    day = EndDate.day
    year = EndDate.year
    return day, month, year


def get_month_name(number):
    datetime_object = datetime.strptime(number, "%m")
    full_month_name = datetime_object.strftime("%B")
    return full_month_name


def get_months_of_the_year():
    month_list = []
    for i in range(1, 12):
        month_list.append(calendar.month_name[i])
    return month_list


def validate_the_given_date_format(date_string, date_format="%B %d, %Y"):
    print("The original string is : " + str(date_string))
    try:
        res = bool(datetime.strptime(date_string, date_format))
        print("The given date format matches with expected format: " + str(res))
    except ValueError:
        raise


def get_current_year():
    today_date = date.today()
    year = today_date.year
    return year


def get_current_month():
    today_date = date.today()
    month = today_date.strftime("%B")
    # month = today_date.month
    return month
