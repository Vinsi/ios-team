## General rules

1. We make use of `Makefiles` in our projects to performs tasks
2. We make use of [fastlane scan](https://github.com/fastlane/fastlane/tree/master/scan) in our projects to run tests
3. We make use of [Danger](danger.systems) in our projects to lint PR according to the rules
4. We use git submodules, Bundler and CocoaPods for dependencies

## How to set up a project

Let's pick as an example an imaginary project: `iOS-Guest`

### Ruby dependencies

1. Initialize Bundler `bundle init` if there is no `Gemfile` yet
2. Add following gems to your `Gemfile`
```ruby
gem 'cocoapods'
gem 'fastlane'
gem 'danger'
gem 'danger-junit'
gem 'danger-slather'
```

### Fastlane

1. Setup `bundle exec fastlane init` if it's not ready yet
2. Add following `Scanfile` into `fastlane/` directory with the rules to `fastlane scan`
```ruby
clean true # clean the project before each test
code_coverage true # collect code coverage from Xcode
skip_build false # build the project before to have the products to test

workspace "#{Project_Workspace}.xcworkspace"
scheme "#{Project_Workspace}" # make sure to have it shared
device "iPhone 7 (10.3)" # make sure to pick the latest device we support
configuration "Debug" #

output_directory "./fastlane/test_output" # folder for the junit test
output_style "basic" # don't go crazy with output as nobody will see it
output_types "junit" # junit is pretty common standard
```

### Preheat iOS simulator

As we use `fastlane scan` to run tests for all projects there is an [issue](https://github.com/fastlane/fastlane/issues/1943) with starting the simulator, to preheat the simulator, please create `scripts` directory in project root and put there following script with the name `launch-ios-simulator.sh`
```sh
!/bin/bash

if [ "$1" = "" ]; then
    echo "Usage: launch-ios-simulator.sh <device name>"
    exit 1;
fi

device="$1"
ios="$2"
printf "Closing any open instances of the iphone simulator...\n"
killall "Simulator" || true
if [ -z "$ios" ]; then
  printf "Determining latest iOS simulator...\n"
  ios=$(xcodebuild -showsdks | grep -Eo "iphonesimulator(.+)" | tail -1)
  ios=${ios##iphonesimulator}
  printf "Detected latest iOS simulator version: ${ios}\n"
fi
printf "Pre-Launching iphone simulator for ${device} (${ios})\n"
simulator_id=$(xcrun instruments -s | grep -Eo "${device} \(${ios}\) \[.*\]" | grep -Eo "\[.*\]" | sed "s/^\[\(.*\)\]$/\1/")
open -b com.apple.iphonesimulator --args -CurrentDeviceUDID $simulator_id

RETVALUE=$?
if [ "$RETVALUE" != "0" ]; then
   printf "Something went wrong when attempting to launch the simulator for ${device} (${ios})\n"
   exit 1;
fi
printf "Simulator launched for ${device} (${ios})\n"
```

### Setup Makefile

1. Create `Makefile` if there is none in the project root directory
2. Add command to setup dependencies, below is a general example, please edit it if there is a specific dependency needed to be ready for CI before tests
```ruby
dependencies:
	bundle install # install gems
	bundle exec pod repo update # update CocoaPods repo to fetch new podspecs
	bundle exec pod install # install CocoaPods dependencies
	git submodule init # install submodules
	git submodule update # update submodules
```
3. Add command to run on ci, there is a common pattern for all conichi projects, but you can extend it for the project needs
```ruby
ci: dependencies # run dependencies command first
  sh scripts/preheat_ios_simulator.sh 'iPhone 7' '10.3' # pass the device from Scanfile
  bundle exec fastlane scan # run tests with configuration from Scanfile
  bundle exec danger # executes Danger if run agains the PR
```
