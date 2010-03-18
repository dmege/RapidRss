#
# This makefile performs the steps necessary to download and extract
# the RWPluginUtilities.framework folder from the RapidWeaver SDK
# located on the Realmac Software website and place the framework
# into this project.
#

URL = http://www.realmacsoftware.com/downloads
ZIPFILE = rapidweaver_plugin_sdk.zip
FRAMEWORK = RWPluginUtilities.framework
TEMP = temp_sdk_folder
TEMPFRAMEWORK = $(TEMP)/RapidWeaver Plugin SDK/HelloWorld/$(FRAMEWORK)

install: $(FRAMEWORK)
	make -f GetRWPluginSDK.makefile cleanup

update:
	make -f GetRWPluginSDK.makefile cleanup
	rm -rf $(FRAMEWORK)
	make -f GetRWPluginSDK.makefile install

cleanup:
	rm -rf $(TEMP) $(ZIPFILE) 


$(FRAMEWORK): $(TEMPFRAMEWORK)
	rm -rf $(FRAMEWORK)
	mv "$(TEMPFRAMEWORK)" .
	
$(TEMPFRAMEWORK): $(ZIPFILE)
	unzip -o $(ZIPFILE) -d $(TEMP)

$(ZIPFILE):
	curl "$(URL)/$(ZIPFILE)" > $(ZIPFILE)
