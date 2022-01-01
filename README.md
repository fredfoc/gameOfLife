# gameOfLife

## Introduction 
A Swift package to implement a simple Game Of Life in any of your projects.

# Getting Started
1.    Installation process
To install this package you use Swift Package Manager
2.    Software dependencies
This software has a dependency on Swinject

# Build and Test

To build this package you can use:

```
swift build
```

To test this package you can use:

```
swift test
```

To generate a Xcode proj:

```
swift package generate-xcodeproj
```

# Let's play
## display a Game Of Life
Add GameOfLife package to your project
```swift
import GameOfLife
import SwiftUI

struct ContentView: View {
    var body: some View {
        Game.create(rows: 30, columns: 20)
    }
}
```
If you remove the created view, memory will be cleaned by itself.

See Example for a concrete project.
