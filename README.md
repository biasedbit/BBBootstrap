BBBootstrap
===========
A comprehensive bundle full of time-savers, for iOS and OSX development.


## How to add BBBootstrap to your project

### As a git submodule

1. Add the submodule:

    ```sh
    $ git submodule add git@github.com:brunodecarvalho/BBBootstrap.git leProject/External/BBBootstrap
    ```

2. Add the files under `Classes` to your Xcode project.
3. Copy and paste the contents of `Sample-Prefix.pch` to your prefix file


### As a CocoaPod

Just add this line on your `Podfile`:

```ruby
pod "BBBootstrap", :git => "https://github.com/brunodecarvalho/BBBootstrap.git"
```


## Contents

This package contains:

- **UIKit extensions:** time-savers that deal with common usage patterns and will save you plenty of lines of code;
- **Foundation extensions:** handy helpers to foundation classes that'll save duplicated code across projects;
- **Utility classes:** built to help you deal with every day concurrency (and other) patterns;
- **Prefix macros:** because `ifdef`'ing on `DEBUG` sometimes just isn't enough.


## License

Apache License, Version 2.0
