# Git Protocol

A guide for programming within version control. Some rules are checked automatically by [Danger](danger.systems).

## Maintaining the repo

* Keep `.gitignore` file up to date and don't let the developer specific files to be included in source control;
* Delete local and remote branches after merging
* Don't commit directly to `master` branch. Try avoiding commit to `develop` branch.
* Perform work on a feature branch
* Rebase frequently

## New feature flow

Assume the related feature in JIRA has the `CNI-152` name.

* Checkout new branch, named as a related JIRA ticket. Usually root tasks should be started from develop. However in case of subtask the checkout can be done from root feature branch.
```
git checkout develop
git pull origin develop
git checkout -b CNI-152
```
* Commit frequently and start each message with the JIRA ticket number.
```
git commit -am 'CNI-152; Update CocoaPods dependencies;'
```
* Rebase frequently
```
git fetch origin
git rebase origin/develop
```
* After finishing worn on the feature, squash meaningless commits using interactive git rebase
```
git rebase -i origin/develop
```
* Push branch to remote
```
git push origin CNI-152
```
* Ask for review the team members

## Branches management

* If there is a JIRA ticket that is an Epic which has another JIRA sub-tickets then there should be an Epic branch for the Epic JIRA ticket and sub-branches from it for the JIRA sub-tickets.
* If any of the sub-branches is finished, it needs to be instantly rebased into the Epic branch. Developers expect that the Epic branch is always up to date.
