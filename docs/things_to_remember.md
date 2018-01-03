# Things to remember...
Make sure you have already had access to all required accounts.

#### For Communication
We use [Slack](https://slack.com/) for internal communication.

#### For Issue Tracking & Documentation
We use [JIRA](https://www.atlassian.com/software/jira) for scrum/kanban management.
We use [Confluence](https://www.atlassian.com/software/confluence) for documentation.

#### For Start!
- We have multiple repos which we work on, if you haven't already been asked for your [GitHub](http://github.com) account, feel free to share your [GitHub](http://github.com) username and let us add you to your team/repos. in the case that you don't have your private GitHub account, you can create a new one.

- Get an invitation to access our [admin portals](https://dev.conichi.com/admin) for various of environments (the link is for dev environment) which we use to work on and it's really important part for testing our apps.

- Clone This repository ([ios-team](https://github.com/conichiGMBH/ios-team)) which include all guidelines of our team and installation scripts for Homebrew, openssl, Xcode command line tools, gnupg, rvm, ruby, bundler etc. Scripts also clone all necessary repos and bootstrap them.

- Don't hesitate and feel free to ask any question!

#### Development Flow Example

- Confluence reference for business logic and user story for the given feature:    
  - [Main UI reference][1]
  - [QA processes](https://conichi.atlassian.net/wiki/spaces/CON/pages/62881793/QA+processes)

[1]: https://conichi.atlassian.net/wiki/spaces/CON/pages/52765598/Documentation+Core+Resources#Documentation(CoreResources)

- Jira ticket for task and schedule management:
    - For features → PM will assign to you or you could assign yourself to `in progress`
    - For issues → assigned by QA or PM
    - There’s a type field for indicating `Story` and `Sub-Task`. You could also change a `Bug` to `Story` for including different needed `Sub-Task`


- [Git protocol](https://github.com/conichiGMBH/ios-team/blob/master/docs/git_protocol.md) management:
    - For features → You can create `Sub-Task` from the `Story`, and if the sub-task PR is approved, rebase it back in the story and then push to Github
    - On Github press delete the branch after PR approved and rebase is done


- Pay attention to repo `README.md` and `RELEASING.md`
- Use `VIPER` architecture to code
- You could also ask for Sketch file for UI elements
- [Lokalise](https://lokalise.co/) for localized strings
- [API reference](https://github.com/conichiGMBH/api-documentation) (this could be changed in the future)
- Write test:
    - Quick / Nimble testing framework
    - Nimble Snapshot for Swift
    - OCMock / FBSnapshotTests for Objective-C
- Update `CHANGELOG.yml` / other needed config file like `Podfile` if update needed / `bundle update`
- Send out PR request on Github and discuss with team members on Slack
- Update for Git / Jira
    - For feature → Set status from `In progress` → `In Review` / PR, and after review / PR approval, if needing QA test, change the status to be `In Testing`, otherwise `Done`
    - For issue → Fastlane send pre-release to Beta, assign iOS testers, in Jira status set `In Testing`, add description, and assign QA, and commit / push to Github

- You could ask the backend engineer for creating some testing data.
