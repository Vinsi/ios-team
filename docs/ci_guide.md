# CI for iOS projects

For all iOS projects at conichi, we decided to use Jenkins solution as an in-house continuous integration tool.
There are some benefits for our choice:
* Broad range of plugins for the CI
* Full control of the build process and CI machine status
* Fewer dependencies on external partners

### Prepare a project for Jenkins CI

See the [guide](new_project_guide.md)

### Setup GitHub hooks

To let Jenkins listen the GitHub's events the hooks need to be configured in the repo. Please be sure your account has rights to create a webhook, if no ping [@antondomashnev](https://github.com/Antondomashnev) or [@dimango](https://github.com/adimango)
1. Go to the https://github.com/conichiGMBH/#{you_repo_name}/settings/hooks
2. Add PUSH web hook
```
Payload URL: http://jenkins-conichi.eu.ngrok.io/github-webhook/
Content type: application/json
Which events would you like to trigger this webhook?: Just the push event.
Active: true
```
3. Add PRs web hook
```
Payload URL: http://jenkins-conichi.eu.ngrok.io/ghprbhook/
Content type:application/x-www-form-urlencoded
Which events would you like to trigger this webhook?: Let me select individual events. -> Issue comment
& Pull request
Active: true
```

In the end you will see exactly the following:
<img src="../assets/webhooks_setup.png" width="640" />

### Create a Jenkins job

Please find the `Jenkins Web Interface` item in conichi 1password and login into our Jenkins web interface with it's credentials

*Start creating a new item in Jenkins dashboard*
<img src="../assets/jenkins_dashboard.png" width="640" />

#### Default branch watcher

First create a default branch watcher (usually master or develop).
For that type of jobs please follow the naming convention: `iOS-#{Project_Short_Name}-#{Branch_Name}-Branch`.

*Start creating a new item in Jenkins dashboard. Inherit from already existed set up to simplify the life*
<img src="../assets/new_branch_job.png" width="640" />

*Set correct job name, add proper description, type valid url to the project*
<img src="../assets/branch_job_configuration_1.png" width="640" />  

*Set ssh format of the URL so Jenkins will be able to clone the project and specify branch to watch*
<img src="../assets/branch_job_configuration_2.png" width="640" />  

*Let Jenkins to listen for PUSH hook from GitHub*
<img src="../assets/branch_job_configuration_3.png" width="640" />

*To manage ruby version and bundle we use RVM and the related plugin for Jenkins*
*Also to not annoy anyone with a stale build, we use timeout for 120 seconds when there is no activity in logs*
<img src="../assets/branch_job_configuration_4.png" width="640" />

*Please type the scripts to run, if you follow the general approach it's just a make ci*
<img src="../assets/branch_job_configuration_5.png" width="640" />

*Save the job and test it*  
<img src="../assets/branch_job_configuration_6.png" width="640" />

If the build succeeded, you're set, congratulations!

#### PR's watcher

Another important job for each project is a one to run on each Pull Request
For that type of jobs please follow the naming convention: `iOS-#{Project_Short_Name}-PRs`
Start creating a new item in Jenkins dashboard  

*Create a new job following the naming convention. Inherit from already existed set up to simplify the life*
<img src="../assets/pr_job_configuration_1.png" width="640" />  

*Set proper job name, description and the project URL*
<img src="../assets/pr_job_configuration_2.png" width="640" />  

*Let Jenkins to listen for Pull Request hooks from GitHub. ${sha1} - is a parameter to listen the PRs*
*Set ssh format of the URL so Jenkins will be able to clone the project and specify branch to watch*
<img src="../assets/pr_job_configuration_3.png" width="640" />

*As an admin please be sure to add yourself, so you will be able to trigger the build from GitHub's comment in PR*
<img src="../assets/pr_job_configuration_4.png" width="640" />

*To manage ruby version and bundle we use RVM and the related plugin for Jenkins*
*Also to not annoy anyone with a stale build, we use timeout for 120 seconds when there is no activity in logs*
<img src="../assets/pr_job_configuration_5.png" width="640" />

*Please type the scripts to run, if you follow the general approach it's just a make ci*
<img src="../assets/pr_job_configuration_6.png" width="640" />

## Test your setup

To test the `Branch Watcher` you can always click `Build Now` in the web interface of the Jenkins's job.
To test the `PRs Watcher` you have to be an admin in the job's setup and you can trigger the test using `retest` comment.

If all is green, you're set, congratulations!
