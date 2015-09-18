# nightfall
Dark mode for individual apps. Not like UIColors, Eclipse, or Nightmode. Specifically crafted dark mode for apps.

### Basic Guidelines

* Don't `%hook -[UIView backgroundColor]` or `-[UILabel textColor]`
* Don't just `%hook` a major superclass like `UIView` because you're lazy
* If you don't know what your doing or what `-release` and `-retain` do then just stick to being a user ;P
* Don't write "hacky" code.
* Use modern objective-c (don't use `#define str @""`, but use `NSString *const str = @"";`
* Write each app extension in a different .xm file so it's organized.
* Any other questions contact me ([@atomikpanda](http://twitter.com/atomikpanda) on twitter).

---
