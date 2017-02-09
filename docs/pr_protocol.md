# Pull Request Protocol

A guide to help us be our best selves when we collaborate on pull requests.

## Creating the PR

* Include the associated JIRA issue to the PR in the beginning. For example: `CNI-123; Title`;
* Include the purpose of this PR in the title. For example `JIRA_ISSUE; This fixes missed check-out button title`;
* Consider providing an overview of why the work is taking place (with any relevant links); don’t assume familiarity with the history;
* Be explicit, if the Pull Request is work in progress, say so. A prefix of `[WIP]` 
  in the title is a simple, common pattern to indicate that state. And [Danger](danger.systems) will notify people about it;
* @mention individuals that you specifically want to involve in the discussion, 
  and mention why. (`@antondomashnev maybe we should consider only iOS9+ support`);
* @mention teams that you want to involve in the discussion, and mention why. (`@conichi/backend, any concerns with this approach?`)
* If the PR contains any UI changes, consider adding the screenshot or gif (if flow) to provide inline context about the changes
  and it brings also some fun ✨ and action ✨;
* Mark the PR as #trivial if it's something that is too small to be in the changelog, or if it is something resembling one-line code typo fix etc. There is no clear border for that, but intuition should tell you when it's the case;

## Reviewing the PR

* If you disagree strongly, consider giving it a few minutes before responding; think before you react;
* Ask, don’t tell. (`What do you think about trying...?` rather than `Don’t do...`);
* Explain your reasons when you do a change request (to avoid long PRs): refer to [Swift](https://github.com/conichiGMBH/ios-team/blob/master/docs/swift_style_guide.md)/[Objective-C](https://github.com/conichiGMBH/ios-team/blob/master/docs/objective_c_style_guide.md) style guide, attach relevant links or maybe it's personal preference;
* Avoid hyperbole. (“NEVER do…”);
* Ask for clarification. (`I don't understand why do we need it. Can you clarify?`);
* Don't use sarcasm;
* Talk synchronously (e.g. chat, screen sharing, in person) if there are too many `I don't understand` or similar comments. Post a follow-up comment summarizing the discussion;
* Use new GitHub review feature. Finish reviewing with `request changes` if needed, to block the merge;
* It’s better not to say same comment more than once. You can just write the comment and then write ‘apply to all’;
* It’s mandatory to give full feedback in your first review so that your first `change request` will contain everything regarding the first PR submission. If you are continuosly submitting `change request` for changes that can be caught from the first PR submission, then this will slow down the reviewing process;
* If PR is marked as #trivial require only review from one reviewer, not more. This is for the sake of limiting interruptions (hey? could you review how I changed this "a" to capital "A" letter in my PR?) and saving precious time;
* Submit questions as comments, not a change request;

## Having your PR reviewed

* Consider leading with an expression of appreciation, especially when feedback has been mixed;
* Be grateful for the reviewer's suggestions. (`Sounds good. I'll update.`);
* If make changes, follow-up with the commit. (`Fixed in fa2s41`);
* Offer clarification, explain the decisions you made to reach a solution in question;
* Offer the in person (real/virtual) communication if the discussion is growing. Post a follow-up comment summarizing the discussion;

## General

We're all working hard to do our best, let's appreciate what people do and the time they spent;
Don't forget to also have fun during the PR, use `gif` if it doesn't spread the focus or emoji to clarify tone   ✨

These guidelines were inspired by Thoughtbot's code review [guide](https://github.com/thoughtbot/guides/tree/master/code-review) 
and GitHub's PR [guide](https://github.com/blog/1943-how-to-write-the-perfect-pull-request) and one [PR](https://github.com/conichiGMBH/ios-guest/pull/761) 

<img src="http://i.giphy.com/3o6Zt8qDiPE2d3kayI.gif" width="320" />
