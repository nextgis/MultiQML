UI_PATH=.
UI_SOURCES=$(wildcard $(UI_PATH)/*.ui)
UI_FILES=$(patsubst $(UI_PATH)/%.ui, $(UI_PATH)/ui_%.py, $(UI_SOURCES))

LANG_PATH=i18n
LANG_SOURCES=$(wildcard $(LANG_PATH)/*.ts)
LANG_FILES=$(patsubst $(LANG_PATH)/%.ts, $(LANG_PATH)/%.qm, $(LANG_SOURCES))

RES_PATH=.
RES_SOURCES=$(wildcard $(RES_PATH)/*.qrc)
RES_FILES=$(patsubst $(RES_PATH)/%.qrc, $(RES_PATH)/%_rc.py, $(RES_SOURCES))

PRO_PATH=.
PRO_FILES=$(wildcard $(PRO_PATH)/*.pro)

ALL_FILES= ${RES_FILES} ${UI_FILES} ${LANG_FILES}

all: $(ALL_FILES)

ui: $(UI_FILES)

ts: $(PRO_FILES)
	pylupdate4 -verbose $<

lang: $(LANG_FILES)

res: $(RES_FILES)

$(UI_FILES): $(UI_PATH)/ui_%.py: $(UI_PATH)/%.ui
	pyuic4 -o $@ $<

$(LANG_FILES): $(LANG_PATH)/%.qm: $(LANG_PATH)/%.ts
	lrelease $<

$(RES_FILES): $(RES_PATH)/%_rc.py: $(RES_PATH)/%.qrc
	pyrcc4 -o $@ $<

clean:
	rm -f $(ALL_FILES)
	rm -f *.pyc
	rm -f *.zip

package:
	cd .. && rm -f *.zip && zip -r multiqml.zip multiqml -x \*.pyc \*.ts \*.ui \*.qrc \*.pro \*~ \*.git\* \*.svn\* \*Makefile*
	mv ../multiqml.zip .

upload:
	plugin_uploader_NG.py multiqml.zip
