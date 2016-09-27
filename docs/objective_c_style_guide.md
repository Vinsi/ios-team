conichi Objective-C Style Guide
============

Below are documents that have been used as a base for the conichi style guide.
* [Wikimedia_Apps Objective-C Style Guide](https://www.mediawiki.org/wiki/Wikimedia_Apps/Team/iOS/ObjectiveCStyleGuide)
* [New York Times Objective-C Style Guide](https://github.com/NYTimes/objective-c-style-guide)

## spacecommander

To enforce and automatically format objective-c code according our rules we use [spacecommander](https://github.com/square/spacecommander) in each iOS projects as a submodule. To setup it locally please run `make bootstrap` in the project's directory.

## Dot Notation Syntax

Every property must be get or set using dot notation

```objc
view.backgroundColor = [UIColor redColor];
NSLog(@"Label text is %@", label.text);
```

Not
```objc
[view setBackgroundColor: [UIColor redColor]];
NSLog(@"Label text is %@", [label text]);
```

## Conditions

Conditions must always use braces and can not be written in a one line

```objc
if (view.isHidden) {
    NSLog(@"View is hidden");
}
```

Not
```objc
if (view.isHidden) { NSLog(@"View is hidden"); }

or

if (view.isHidden) NSLog(@"View is hidden");

or

if (view.isHidden)
    NSLog(@"View is hidden");
```

## Golden path

When coding with conditionals, the left hand margin of the code should be the "golden" path. That is, don't nest `if` statements. Multiple return statements are ok.

```objc
- (void)doSomethingWithHiddenView {
    if (!view.isHidden){
         return;
    }
    //Do something important
}
```

Not
```objc
- (void)doSomethingWithHiddenView {
    if (view.isHidden){
         //Do something important
    }
}
```

## Ternary Operator

Ternary Operator simply should be understandable for developer.

## Methods

In method signatures, there SHOULD be a space after the scope (`-` or `+` symbol).

```objc
- (void)dynamicMethod;
+ (NSMutableString *)statisMethod;
```

The opening curly brace should be on the last line of the method signature not following by the empty string
```objc
- (void)dynamicMethod {
    //Do something
}
```

Not
```objc
- (void)dynamicMethod
{
    //Do something
}

or

- (void)dynamicMethod {

    //Do something
}
```

## Variables

Except custom setters and getters instance variables should be avoid.  

## Properties

Properties should be named as clear as possible, following by a type name if can be not clear in context.

```objc
@property (nonatomic, copy) NSString *photoURLString;
```

Not
```objc
@property (nonatomic, strong) NSString *photoURL;

or

@property (nonatomic, strong) NSString *photo;
```

Do not use `atomic` attribute if not necessary. Even if `strong` attribute is a default one, in property declaration it should be specified.  
`NSString` properties usually suppose to have `copy` attribute not `strong`.

## Categories

Do not create "umbrella" categories. Each category for not conichi's class should have prefix. Methods and properties added in categories MUST be named with an app- or organization-specific (`CNI`) prefix.

```objc
@interface UIView (CNIGeometry)

- (CGFloat)cni_width;

@end
```

Not
```objc
@interface UIView (Geometry)

- (CGFloat)width;

@end
```

## Comments

To create interface comments we enforce using the Xcode plugin [VVDocumenter-Xcode](https://github.com/onevcat/VVDocumenter-Xcode). Usually methods should be self documented however sometimes it's useful to describe logic or to generate documentation.

## Literals

`NSString`, `NSDictionary`, `NSArray`, and `NSNumber` literals SHOULD be used whenever creating immutable instances of those objects. Pay special care that `nil` values not be passed into `NSArray` and `NSDictionary` literals, as this will cause a crash.

```objc
NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"};
NSNumber *shouldUseLiterals = @YES;
NSNumber *buildingZIPCode = @10018;
```

Not
```objc
NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill", @"Mobile Web", nil];
NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];
NSNumber *buildingZIPCode = [NSNumber numberWithInteger:10018];
```

## `CGRect` Functions

When accessing the `x`, `y`, `width`, or `height` of a `CGRect`, code MUST use the [`CGGeometry` functions](http://developer.apple.com/library/ios/#documentation/graphicsimaging/reference/CGGeometry/Reference/reference.html) instead of direct struct member access. From Apple's `CGGeometry` reference:

```objc
CGRect frame = self.view.frame;
CGFloat x = CGRectGetMinX(frame);
CGFloat y = CGRectGetMinY(frame);
CGFloat width = CGRectGetWidth(frame);
CGFloat height = CGRectGetHeight(frame);
```

Not
```objc
CGRect frame = self.view.frame;
CGFloat x = frame.origin.x;
CGFloat y = frame.origin.y;
CGFloat width = frame.size.width;
CGFloat height = frame.size.height;
```

However usually every geometry calculation made by autolayout and if you need to change geometry of the `UIView` subclass you do it with `NSLayoutConstraint`

## Constants

Constants are preferred over in-line string literals or numbers, as they allow for easy reproduction of commonly used variables and can be quickly changed without the need for find and replace. Constants should not be declared using `#define`. Instead, use the `static` qualifier within your implementation file, or `extern` for public constants in the header. Also constant should be prefixed with `k`

```objc
// Class.h
extern NSString* const kCompanyName;

// Class.m
NSString* const kCompanyName = @"conichi";

or for private

static NSString* const kCompanyName = @"PrivateFoo";
```

or for only private constants

```objc
static NSString* const kCompanyName = @"PrivateFoo";
```

Not
```objc
#define CompanyName @"conichi"
```

## Booleans

If boolean property intends to be an adjective it should have the specified getter with "is" prefix

```objc
@property (nonatomic, assign, getter=isHidden) BOOL hidden;
```

Not
```objc
@property (nonatomic, assign) BOOL isHidden;

or

@property (nonatomic, assign) BOOL hidden;
```

## Image Naming and Asset Catalogs

Each image should be placed under related module in assets catalog. The name of the image should be start with module name and use underscore naming notation.

```objc
pre_checkin_hotels_list_search_icon
```

Not
```objc
search_icon

or

preCheckinHotelsListSearchIcon
```

## Code Organization

Use `#pragma mark -` for code organization

* `#pragma mark - Interface` for public methods
* `#pragma mark - Actions` for actions
* `#pragma mark - Properties` for custom getters and setters
* `#pragma mark - UICollectionViewDelegate` for delegate and data sources
* `#pragma mark - Helpers` for private helper methods
* `#pragma mark - UI` for private UI methods

For import use following structure

```objc
/*-------View Controllers-------*/

/*-------Frameworks-------*/

/*-------Views-------*/

/*-------Helpers & Managers-------*/

/*-------Models-------*/
```

Use folders to group related files in Xcode project. Each module should have it's own folder in the project.  
For `.h` whenever possible use `@class` directive instead of `#import "Foo.h"`

```objc
@class MyCustomClass;

@interface Foo: NSObject

@property (nonatomic, strong) MyCustomClass *bar

@end
```

Not
```objc
#import "MyCustomClass"

@interface Foo: NSObject

@property (nonatomic, strong) MyCustomClass *bar

@end
```

## Class Constructor Methods

For class constructor methods use `instancetype`.

```objc
@interface CNIBeacon
+ (instancetype)beaconWithMajor:(NSNumber *)major;
@end
```

Not
```objc
@interface CNIBeacon
+ (CNIBeacon *)beaconWithMajor:(NSNumber *)major;
@end
```

## Generics

Always use `generics` for collection types such as `NSDictionary`, `NSArray`, `NSSet` and their mutable subclasses

```objc
NSSet<Foo *> *setOfFoo = [NSSet set];
NSArray<Foo *> *arrayOfFoo = [NSArray array];
NSDictionary<NSString *, Foo *> dictionaryKeyFoo = [NSDictionary dictionary];
```

Not
```objc
NSSet *setOfFoo = [NSSet set];
NSArray *arrayOfFoo = [NSArray array];
NSDictionary dictionaryKeyFoo = [NSDictionary dictionary];
```

## Nullability annotation

Always place `NS_ASSUME_NONNULL_BEGIN` in the beginning and `NS_ASSUME_NONNULL_END` in the end of file. And set nullability attribute for every interface method or property.

```objc
NS_ASSUME_NONNULL_BEGIN

@interface CNISDKVenue: NSObject

@property (nonatomic, copy, readonly, nullable) NSString *phone;

- (void)setPhone:(nullable NSString *)phone;

@end

NS_ASSUME_NONNULL_END
```

## Tests

Each test should be named using following pattern unless the BDD framework is used which is preferrable:  

```objc
- (void)testThat"Method name"Should"Expected Action"If"Condition"
```

## Modules

Always use `dynamic import` if possible instead of old-fashioned `#import`

```objc
@improt CNISDKCoreKit;
```

Not
```objc
#import <CNISDKCoreKit/CNISDKCoreKit.h>
```
