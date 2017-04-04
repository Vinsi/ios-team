# Accessibility Naming Guide

## What for?
For the sake of efficient UI automated testing (e.g. [Earl Grey](https://github.com/google/EarlGrey) framework) we use [Accessibility Identifiers](https://developer.apple.com/reference/appkit/nsaccessibility/1535023-accessibilityidentifier?language=objc). Conformance of UI classes to [UIAccessibility](https://developer.apple.com/reference/uikit/uiaccessibility) informal protocol is not required. To avoid confusions and speed up process of writing UI tests we have clear naming convention for id's which saves time and makes naming straightforward.

## Where we set `accessibilityIdentifier`?
We take following priorites to set Accessibility Identifier on a UI class that is to be accessed by a proper UI test matcher:

1. Setting accessibility ID in a Storyboard
2. Setting accessibility ID in a relevant xib file containing subject UI class
3. If above are not possible, supplying accessibility id to class' initializer.
4. If initializer does not support 3. - we set accessibility in the code right after the initalization.

## What name should I give to my tested UI class?

We follow [reversed domain name notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation) with following structure:

```
organizationBundle.storyboardName.viewControllerName.testedIBOutletName
```

if there is no IBOutlet set on certain UI class we set it to:

```
organizationBundle.nibName.viewControllerName.viewControllerPropertyName
```

finally, if above is not the case we set it to:

```
organizationBundle.viperModuleName.viewControllerName.variableName
```

Keeping above convention allows to guess accessibility identifier straightforward when writing specific test, because all name components are visible to the user.

So, for sign in button (with outlet `signInBtn`) in `CNISignInVC` view controller in `Login` storyboard it is:
```
com.conichi.Login.CNISignInVC.signInBtn
```

However, we don't write organizationBundle part explicitly, instead we create accessibility identifiers by specific helper method for that from Conichi_Meta utility:
```
NSString *accessibilityID = CNIAccessibility(module, viewController, outlet)
```

The reason why we don't specify product name in the bundle is that it differs for each target and there is no need to add it to the accessibilityID explicitly. In fact, it helps to reuse interface builder generated interfaces.

