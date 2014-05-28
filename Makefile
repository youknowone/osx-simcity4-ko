STEAMDIR=~/Library/Application\ Support/Steam/
SIMCITY4=/steamapps/common/SimCity 4 Deluxe/Sim City 4 Deluxe Edition.app/Contents/GameData

all: ko
	
clean: revert
	

test:
	@if [ ! -e "$(STEAMDIR)$(SIMCITY4)" ]; then echo "ERROR: directory not found at '$(STEAMDIR)$(SIMCITY4)'.\nERROR: Please set STEAMDIR env"; exit 2; fi

backup: test
	cd "$(STEAMDIR)$(SIMCITY4)" && if [ ! -e Fonts.orig ]; then cp -r Fonts Fonts.orig; fi
	cd "$(STEAMDIR)$(SIMCITY4)" && if [ ! -e English.orig ]; then cp -r English English.orig; fi

ko: test backup
	-rm "$(STEAMDIR)$(SIMCITY4)/English/"*
	cp SimCityLocale.dat "$(STEAMDIR)$(SIMCITY4)/English/"
	-rm "$(STEAMDIR)$(SIMCITY4)/Fonts/"*
	cp /System/Library/Fonts/AppleSDGothicNeo-*.otf "$(STEAMDIR)$(SIMCITY4)/Fonts/"
	@echo "DONE! Run Simcity4 in 'English'"

revert: test
	-cd "$(STEAMDIR)$(SIMCITY4)" && rm -rf English
	cd "$(STEAMDIR)$(SIMCITY4)" && cp -r English.orig English
	-cd "$(STEAMDIR)$(SIMCITY4)" && rm -rf Fonts
	cd "$(STEAMDIR)$(SIMCITY4)" && cp -r Fonts.orig Fonts
	@echo "REVERTED"