.PHONY: clean refresh build-runner build-adb build-apk clean-ios clean-build-runner refresh-env open-xcode refresh-lang run-dev

refresh:
	@echo "╠ Getting Dependency"
	fvm flutter pub get 

clean-ios:
	@echo "╠ Cleaning ios the code"
	fvm flutter clean
	cd ios && rm -rf Podfile.lock 
	cd ios && rm -rf Pods 
	fvm flutter pub get
	cd ios && pod install

build-adb:
	@echo "╠ Getting Dependency"
	fvm flutter pub get
	fvm flutter build appbundle 

build-apk:refresh
	@echo "╠ Building apk"
	@fvm flutter build apk --split-per-abi	

build-runner:
	@echo "╠ Build Runner Started"
	@fvm flutter pub run build_runner build

clean-build-runner:
	@echo "╠ Cleaning Build Runner"
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

clean:
	@echo "╠ Cleaning Flutter"
	@fvm flutter clean
	@fvm flutter pub get

refresh-env: build-runner	

open-xcode:
	open ios/Runner.xcworkspace

refresh-lang:
	@echo "╠ Rereshing String language"
	fvm flutter gen-l10n

run-dev:
	fvm flutter run --dart-define=env.mode=dev
