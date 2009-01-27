from PyQt4.QtCore import QTranslator, QLocale
from PyQt4.QtGui import QApplication

import resources

if QLocale.system().name() == "ru_RU":
#	i18n Russian
	translatorDlg = QTranslator()
	translatorDlg.load(":/plugins/multiqml/translations/multiqml_ru")
	QApplication.installTranslator(translatorDlg)
	
mVersion = " 0.2.6"
def name():
	return unicode(QApplication.translate("__init__", "MultiQml"))
def description():
	return unicode(QApplication.translate("__init__", "Apply single qml style to multiple raster or vector layers."))
def qgisMinimumVersion():
	return "1.0"
def version():
	return unicode(QApplication.translate("__init__", "Version")) + mVersion # unicode(" 0.2.5")
def classFactory( iface ):
	from plugin import MultiQmlPlugin
	return MultiQmlPlugin( iface )

