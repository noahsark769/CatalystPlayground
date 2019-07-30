# Catalyst Playground
An example project demonstrating Mac Catalyst features

<img width="1051" alt="Screen Shot 2019-07-24 at 3 08 22 PM" src="https://user-images.githubusercontent.com/1168853/61821470-4f5c9000-ae25-11e9-8d17-65435c31543f.png">

## Running
To run the project, clone and cd into the repo, then:

```
bundle install --path vendor/bundle
bundle exec pod install
xed .
```

Then click the run button!

(Note that the project compiles on Mac and on iPad, but some features like the toolbar and appkit bundle bridging are not available on iPad)
