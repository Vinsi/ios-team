Welcome
============

The home of iOS conichi team.

## Fresh Start

If you're a new developer in a team start with the following:

```sh
git clone https://github.com/conichiGMBH/ios-team.git
cd ios-team
scripts/bootstrap_ruby.sh
```

and after ruby is installed correctly execute script to clone and bootstrap all repos

```sh
scripts/bootstrap_projects.sh
```

## Guides

These guides are not to blindly followed but to discuss when in doubt.

* [Things to Remember in First Day](https://github.com/conichiGMBH/ios-team/blob/master/docs/things_to_remember.md)
* [Swift Style Guide](https://github.com/conichiGMBH/ios-team/blob/master/docs/swift_style_guide.md)
* [Objective-C Style Guide](https://github.com/conichiGMBH/ios-team/blob/master/docs/objective_c_style_guide.md)
* [Language Choice Guide](https://github.com/conichiGMBH/ios-team/blob/master/docs/language_choice_guide.md)
* [Code Review Guide](https://github.com/thoughtbot/guides/tree/master/code-review)
* [Git Guide](https://github.com/conichiGMBH/ios-team/blob/master/docs/git_protocol.md)
* [PR Guide](https://github.com/conichiGMBH/ios-team/blob/master/docs/pr_protocol.md)
* [Accesibility Naming Guide](https://github.com/conichiGMBH/ios-team/blob/master/docs/accessibility_naming_guide.md)
* [New Project Guide](https://github.com/conichiGMBH/ios-team/blob/master/docs/new_project_guide.md)
* [CI Guide](https://github.com/conichiGMBH/ios-team/blob/master/docs/ci_guide.md)

## Technology Stack

* Objective-C - most of the codebase is written in Objective-C, but new features are considered to be written in Swift.
* Swift - some apps have been already migrated to support Swift language, but if not ready yet, create a respective task and do so 🚀
* [CocoaPods](https://github.com/CocoaPods/CocoaPods) - as a main dependency manager, we use CocoaPods, but for the OSS project don't forget about [Carthage](https://github.com/Carthage/Carthage) and [Swift Package Manager](https://github.com/apple/swift-package-manager) if available.
* Bundler - we use `Gemfile` to manage our `ruby` dependencies. Recommend to read [Gemfile Guide](https://guides.cocoapods.org/using/a-gemfile.html).

## Testing

We do test all our apps to ensure that our behavior is what we expect. Initially the codebase was written by `XCTest` framework. Recently we migrated to [Quick](https://github.com/Quick/Quick/) and [Specta](https://github.com/specta/specta).

For the UI tests we use extensively [FBSnapshotTests](https://www.objc.io/issues/15-testing/snapshot-testing/). We use iOS 9.3 as a main version for all UITests and all screenshots are captured in iPhone 6, iPhone 6 Plus, iPhone 5s and iPad Air simulators.

## Lokalise

We use [Lokalise](https://lokalise.co) service for managing the strings localizations. To add / update / remove the key and its default English value, please firstly set the needed credentials in `.bash_profile`:
```sh
export LOKALISE_API_TOKEN='Please find it in shared 1Password ios-team vault'
export LOKALISE_GUEST_PROJECT_ID='Please find it in shared 1Password ios-team vault'
export LOKALISE_MERCHANT_PROJECT_ID='Please find it in shared 1Password ios-team vault'
```

and execute the following to type in the needed info prompted:
```sh
scripts/lokalise.sh
```

## Troubleshooting
* When `git ls-remote https://github.com/<your-repo-path>` is executed, it requires username and password. However, If GitHub's [Two-Factor authentication](https://help.github.com/articles/about-two-factor-authentication/) is enabled, the process will fail even though both of the username and password are correct. The solution is generating a Personal Access Token, and once the token is created, use the token as the password. In other words, copy the token from GitHub and paste it into Terminal. [Here](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/#using-a-token-on-the-command-line) is the reference.
