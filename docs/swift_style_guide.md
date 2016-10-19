conichi Swift Style Guide
============

Below are documents that have been used as a base for the conichi style guide.
* [GitHub Swift Style Guide](https://github.com/github/swift-style-guide)
* [Apple Swift API design guide](https://swift.org/documentation/api-design-guidelines)

## SwiftLint

To enforce format swift code according to our rules we use [SwiftLint](https://github.com/realm/SwiftLint) in each iOS projects. To setup it locally please run `make bootstrap` in the project's directory. Any warnings produce by `SwiftLint` config must be fixed and then if any doubts can be discussed inside the team.

## Correctness

Consider warnings to be errors. This rule informs many stylistic decisions such as not to use the `++` or `--` operators, C-style for loops, or strings as selectors.

## Whitespace

* Tabs, not spaces.
* End files with a newline.
* Use one vertical whitespace to divide code into logical chunks.
* Don’t leave trailing whitespace.
* Don’t leave trailing whitespace. on blank lines.

## Variable bindings

Constants are defined using the `let` keyword, and variables with the `var` keyword. Always use `let` instead of `var` if the value of the variable will not change.

**Tip:** A good technique is to define everything using `let` and only change it to `var` if the compiler complains!

## Conditions

When you have to meet certain criteria to continue execution, try to exit early. So, instead of this:

```swift
if n.isNumber {
    // Use n here
}
else {
    return
}
```

use this:
```swift
guard n.isNumber else {
    return
}
// Use n here
```

You can also do it with `if` statement, but using `guard` is preferred, because `guard` statement without `return`, `break` or `continue` produces a compile-time error, so the exit is guaranteed.

## Throws functions

Any function that can meet unpredictable conditions lead to a crash should be marked as throws. So instead of:

```swift
func objectAt(index: Int, in array: [Foo]) -> Foo {
  return array[index]
}
```

use this:
```swift
func objectAt(index: Int, in array: [Foo]) throws -> Foo {
  guard index < array.count && index >= 0 else {
    throw MyError.indexOutOfBounds(description: "Index \(index) is out of bounds of the given array \(array)")
  }
  return array[index]
}
```

## Do not Force Unwrap Optionals

Force Unwrapping optionals can lead to a runtime crash. So, instead of this:

```swift
let foo = bar! * baz!
// Use foo here
```

use this:
```swift
if let bar = bar, let baz = baz {
  let foo = bar * baz
  // Use foo here
}
```

or even if they are required:
```swift
guard let bar = bar, let baz = baz else {
  fatalAssert("bar and baz are required")
}
let foo = bar * baz
// Use foo here
```

## Avoid using Implicitly Unwrapped Optionals

Implicitly Unwrapped optionals can lead to a runtime crash. So, instead of this:

```swift
let foo: FooType!
```

use this:
```swift
let foo: FooType?
```

## Prefer implicit getters on read-only properties and subscripts

When possible, omit the `get` keyword on read-only computed properties and
read-only subscripts. So, instead of this:

```swift
var myGreatProperty: Int {
    get {
        return 4
    }
}

subscript(index: Int) -> T {
    get {
        return objects[index]
    }
}
```

use this:
```swift
var myGreatProperty: Int {
    return 4
}

subscript(index: Int) -> T {
    return objects[index]
}
```

## When specifying a type, always associate the colon with the identifier

When specifying the type of an identifier, always put the colon immediately
after the identifier, followed by a space and then the type name. So, instead of this:

```swift
class SmallBatchSustainableFairtrade : Coffee { ... }

let timeToCoffee :NSTimeInterval = 2

func makeCoffee(type : CoffeeType) -> Coffee { ... }

let capitals : [Mountain : Height] = [ Everest :8.848 ]
```

use this:
```swift
class SmallBatchSustainableFairtrade: Coffee { ... }

let timeToCoffee: NSTimeInterval = 2

func makeCoffee(type: CoffeeType) -> Coffee { ... }

let capitals: [Mountain: Height] = [ Everest: 8.848 ]
```

#### Only explicitly refer to `self` when required

When accessing properties or methods on `self`, leave the reference to `self` implicit by default. So, instead of this:

```swift
private class History {
    var events: [Event]

    func rewrite() {
        self.events = []
    }
}
```

use this:
```swift
private class History {
    var events: [Event]

    func rewrite() {
        events = []
    }
}
```

Only include the explicit keyword when required by the language—for example, in a closure, or when parameter names conflict:

```swift
extension History {
    init(events: [Event]) {
        self.events = events
    }

    var whenVictorious: {
        return {
            self.rewrite()
        }
    }
}
```

## Prefer structs over classes

Unless you require functionality that can only be provided by a class (like identity or deinitializers), implement a struct instead.

Note that inheritance is (by itself) usually _not_ a good reason to use classes, because polymorphism can be provided by protocols, and implementation reuse can be provided through composition.

For example, this class hierarchy:

```swift
class Vehicle {
    let numberOfWheels: Int

    init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
    }

    func maximumTotalTirePressure(pressurePerWheel: Float) -> Float {
        return pressurePerWheel * Float(numberOfWheels)
    }
}

class Bicycle: Vehicle {
    init() {
        super.init(numberOfWheels: 2)
    }
}

class Car: Vehicle {
    init() {
        super.init(numberOfWheels: 4)
    }
}
```

could be refactored into these definitions:

```swift
protocol Vehicle {
    var numberOfWheels: Int { get }
}

func maximumTotalTirePressure(vehicle: Vehicle, pressurePerWheel: Float) -> Float {
    return pressurePerWheel * Float(vehicle.numberOfWheels)
}

struct Bicycle: Vehicle {
    let numberOfWheels = 2
}

struct Car: Vehicle {
    let numberOfWheels = 4
}
```

## Make classes `final` by default

Classes should start as `final`, and only be changed to allow subclassing if a valid need for inheritance has been identified. Even in that case, as many definitions as possible _within_ the class should be `final` as well, following the same rules.

## Omit type parameters where possible

Methods of parameterized types can omit type parameters on the receiving type when they’re identical to the receivers. For example:

```swift
struct Composite<T> {
    …
    func compose(other: Composite<T>) -> Composite<T> {
        return Composite<T>(self, other)
    }
}
```

could be rendered as:

```swift
struct Composite<T> {
    …
    func compose(other: Composite) -> Composite {
        return Composite(self, other)
    }
}
```

## Protocols

Following Apple's API Design Guidelines, protocols names that describe what something is should be a noun. Examples: `Collection`, `WidgetFactory`. Protocols names that describe an ability should end in -ing, -able, or -ible. Examples: `Equatable`, `Resizing`.

## Enumerations

Following Apple's API Design Guidelines for Swift 3, use lowerCamelCase for enumeration values.

```swift
enum Shape {
  case rectangle
  case square
  case rightTriangle
  case equilateralTriangle
}
```

## Documentation

Write a documentation for the class of method if clarification is required. Use combination of (⌥ Option + ⌘ Command + /). However, the method name should be self-descriptive as much as possible.

## Class Prefixes

The class prefix is redundant in Swift in favor of module's namespace. But in conichi projects with objective-c codebase, we require `CNI` prefix to be consistent.

## Selectors

Selectors are Obj-C methods that act as handlers for many Cocoa and Cocoa Touch APIs. Prior to Swift 2.2, they were specified using type unsafe strings. This now causes a compiler warning. The "Fix it" button replaces these strings with the **fully qualified** type safe selector. Often, however, you can use context to shorten the expression. This is the preferred style. So instead of:

```swift
let sel = #selector(ViewController.viewDidLoad)
```

use this:
```swift
let sel = #selector(viewDidLoad)
```

### Generics

Generic type parameters should be descriptive, upper camel case names. When a type name doesn't have a meaningful relationship or role, use a traditional single uppercase letter such as `T`, `U`, or `V`. So instead of:

```swift
struct Stack<T> { ... }
func writeTo<target: OutputStream>(inout t: target)
func max<Thing: Comparable>(x: Thing, _ y: Thing) -> Thing
```

use this:
```swift
struct Stack<Element> { ... }
func writeTo<Target: OutputStream>(inout target: Target)
func max<T: Comparable>(x: T, _ y: T) -> T
```

## Code Organization

Use `// MARK: - ` for code organization

* `// MARK: - Interface` for public methods
* `// MARK: - Actions` for actions
* `// MARK: - UICollectionViewDelegate` for delegate and data sources
* `// MARK: - Helpers` for private helper methods
* `// MARK: - UI` for private UI methods

However, it's better to organize code using extensions. So instead of this:

```swift
// MARK - Actions

@IBAction func buttonClicked(sender: UIButton) {

}
```

use this:
```swift
extension ViewController {
// MARK - Actions

@IBAction func buttonClicked(sender: UIButton) {

}

}
```

## Unused Code

The unused or dead code is supposed to be removed. For example, don't leave the autogenerated template code if not used:

```swift
override func didReceiveMemoryWarning() {
   super.didReceiveMemoryWarning()
  // Dispose of any resources that can be recreated.
}
```

## Minimal Imports

Keep imports minimal. For example, don't import `UIKit` when importing `Foundation` will suffice.

## Closure Expressions

Use trailing closure syntax only if there's a single closure expression parameter at the end of the argument list. Give the closure parameters descriptive names. So instead of:

```swift
UIView.animateWithDuration(1.0, animations: {
  self.myView.alpha = 0
})

UIView.animateWithDuration(1.0,
  animations: {
    self.myView.alpha = 0
  }) { f in
    self.myView.removeFromSuperview()
}
```

use this:
```swift
UIView.animateWithDuration(1.0) {
  self.myView.alpha = 0
}

UIView.animateWithDuration(1.0,
  animations: {
    self.myView.alpha = 0
  },
  completion: { finished in
    self.myView.removeFromSuperview()
  }
)
```

For single-expression closures where the context is clear, use implicit returns:

```swift
attendeeList.sort { a, b in
  a > b
}
```

## Struct Initializers

Use the native Swift struct initializers rather than the legacy CGGeometry constructors. So instead of:

```swift
let bounds = CGRectMake(40, 20, 120, 80)
let centerPoint = CGPointMake(96, 42)
```

use this:
```swift
let bounds = CGRect(x: 40, y: 20, width: 120, height: 80)
let centerPoint = CGPoint(x: 96, y: 42)
```

Prefer the struct-scope constants `CGRect.infinite`, `CGRect.null`, etc. over global constants `CGRectInfinite`, `CGRectNull`, etc. For existing variables, you can use the shorter `.zero`.

## Lazy Initialization

Consider using lazy initialization for finer grain control over object lifetime. This is especially true for `UIViewController` that loads views lazily. You can either use a closure that is immediately called `{ }()` or call a private factory method. Example:

```swift
lazy var locationManager: CLLocationManager = self.makeLocationManager()

private func makeLocationManager() -> CLLocationManager {
  let manager = CLLocationManager()
  manager.desiredAccuracy = kCLLocationAccuracyBest
  manager.delegate = self
  manager.requestAlwaysAuthorization()
  return manager
}
```

## Syntactic Sugar

Prefer the shortcut versions of type declarations over the full generics syntax. So instead of:

```swift
var deviceModels: Array<String>
var employees: Dictionary<Int, String>
var faxNumber: Optional<Int>
```

use this:
```swift
var deviceModels: [String]
var employees: [Int: String]
var faxNumber: Int?
```

## Extending object lifetime

Extend object lifetime using the `[weak self]` and `guard let strongSelf = self else { return }` idiom. `[weak self]` is preferred to `[unowned self]` where it is not immediately obvious that `self` outlives the closure. Explicitly extending lifetime is preferred to optional unwrapping. So instead of:

```swift
// might crash if self is released before response returns
resource.request().onComplete { [unowned self] response in
  let model = self.updateModel(response)
  self.updateUI(model)
}
```

```swift
// deallocate could happen between updating the model and updating UI
resource.request().onComplete { [weak self] response in
  let model = self?.updateModel(response)
  self?.updateUI(model)
}
```

use this:
```swift
resource.request().onComplete { [weak self] response in
  guard let strongSelf = self else { return }
  let model = strongSelf.updateModel(response)
  strongSelf.updateUI(model)
}
```

## Parentheses

Parentheses around conditionals are not required and should be omitted. So instead of:

```swift
if (name == "Hello") {
  print("World")
}
```

use this:
```swift
if name == "Hello" {
  print("World")
}
```

## Avoid NSObject and @objc to Improve Performance

Swift allows us to extend classes from `NSObject` to get Objective-C runtime features for an object. It also allows us to annotate Swift methods with `@objc` to allow the methods to be used by the Objective-C runtime.

Supporting the Objective-C runtime means that method calls are going to be using dynamic dispatch instead of static or vtable dispatch. This end result is that methods that support the Objective-C runtime have a four times performance penalty when called. In practical usage, the performance hit may be negligible but the cool thing is that armed with this knowledge, we now know that method execution in Swift is four times faster than Objective-C.
