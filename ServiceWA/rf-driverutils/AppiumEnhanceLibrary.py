# -*- coding: utf-8 -*-
"""AppiumEnhanceLibrary is the enhancement of robotframework-appiumlibrary.

It will bring back these missing keywords from robotframework selenium2library.

Detail imformation could be found on github.com:
    https://github.com/ScenK/robotframework-AppiumEnhanceLibrary
"""
from robot.libraries.BuiltIn import BuiltIn


class AppiumEnhanceLibrary(object):
    """AppiumEnhanceLibrary for supporting actions that not included in RF.

    Support more keywords for AppiumLibrary.

    Detail imformation about AppiumLibrary could be found on github.com:
        https://github.com/jollychang/robotframework-appiumlibrary
    """

    def __init__(self):
        """Init function.

        Load and store configs in to variables.
        """
        super(AppiumEnhanceLibrary, self).__init__()
        self.apu = BuiltIn().get_library_instance('AppiumLibrary')


    def select_frame(self, locator):
        """Sets frame identified by `locator` as current frame.

        Key attributes for frames are `id` and `name.` See `introduction` for
        details about locating elements.
        """
        element = self.apu._element_find(locator, True, True)
        self.apu._current_application().switch_to_frame(element)

    def unselect_frame(self):
        """Sets the top frame as the current frame."""
        self.apu._current_application().switch_to_default_content()

    def scroll_to_given_element(self, locator):
        """Scrolls down to element"""
        locator = locator.split("xpath=")[1]
        locator = locator.replace('"', "'")
        driver = self.apu._current_application()
        driver.execute_script('window.document.evaluate("{}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, '
                              'null).singleNodeValue.scrollIntoView(true)'.format(locator))



    # def get_title(self):
    #     """Sets the top frame as the current frame."""
    #     return  self.apu._current_application().title()

    def scroll_up_screen(self):
        """Scrolls up to element"""
        driver = self.apu._current_application()
        driver.execute_script("mobile: scroll", {"direction": 'up'})

