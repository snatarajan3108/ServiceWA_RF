import os

import pytesseract as tess

tess.pytesseract.tesseract_cmd = os.path.expanduser('~') + r'\AppData\Local\Programs\Tesseract-OCR\tesseract.exe'
from PIL import Image


def image_text_extract():
    img = Image.open(r'product-img.jfif')
    text = tess.image_to_string(img, lang='eng')
    print(text)
    return text