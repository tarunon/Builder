# Builder

Introduce if/switch/for expression in swift.
`build`, `builder` function provides context that can use if/switch/for expression.


### Example
For example, we can use `Publisher.flatMap` without `eraseToAnyPublisher`. 😄
```swift
import Combine
import CombineBuilder

...

myPublisher.flatMap(builder { arg in
  if let delayInterval = env.delayInterval {
    nextPublisherCreate(arg)
      .delay(for: delayInterval, scheduler: env.delayScheduler)
      .subscribe(on: env.mainScheduler)
  } else {
  nextPublisherCreate(arg)
      .subscribe(on: env.mainScheduler)
  }
})
```

### Require
Swift 5.4 or later.
