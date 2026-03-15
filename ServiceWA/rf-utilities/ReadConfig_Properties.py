import os

from jproperties import Properties


def read_properties(filePath):
    ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    CONFIG_PATH = os.path.join(ROOT_DIR,  filePath)
    configs = Properties()
    data_dict = dict()
    with open(CONFIG_PATH, 'rb') as read_prop:
        configs.load(read_prop)
    prop_view = configs.items()
    for item in prop_view:
        data_dict[item[0]] = item[1].data
    print(data_dict)
    return data_dict


# read_properties("rf-config/Config.properties")
