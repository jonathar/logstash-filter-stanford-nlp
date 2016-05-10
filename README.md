# Logstash Plugin

This is a plugin for [Logstash](https://github.com/elastic/logstash). It integrates
the Logstash with the [Stanford NLP library](http://nlp.stanford.edu/software)

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

## Developing

### 1. Plugin Developement and Testing

#### Code
- To get started, you'll need JRuby with the Bundler gem installed.

- Create a new plugin or clone and existing from the GitHub [logstash-plugins](https://github.com/logstash-plugins) organization. We also provide [example plugins](https://github.com/logstash-plugins?query=example).

- Install dependencies
```sh
bundle install
```

#### Test

The Stanford NLP library relies on ***large*** (~400mb) model files stored in
JAR files. You will need to increase the size of your Java heap to run the tests
without crashing.

```sh
export JRUBY_OPTS="-J-Xmx2048m"
```
- Update your dependencies

```sh
bundle install
```

- Run tests

```sh
bundle exec rspec
```

### 2. Running your unpublished Plugin in Logstash

#### 2.1 Run in a local Logstash clone

- Edit Logstash `Gemfile` and add the local plugin path, for example:
```ruby
gem "logstash-filter-stanford-nlp", :path => "/your/local/logstash-filter-nlp"
```
- Install plugin
```sh
# Logstash 2.3 and higher
bin/logstash-plugin install --no-verify

# need to install a dependency
 mkdir -p lib/edu/stanford/nlp/stanford-corenlp/3.6.0/ && curl http://nlp.stanford.edu/software/stanford-english-corenlp-2016-01-10-models.jar -o lib/edu/stanford/nlp/stanford-corenlp/3.6.0/stanford-corenlp-3.6.0-models.jar

# Prior to Logstash 2.3 - not supported
```
- Run Logstash with your plugin

You may need to increase the heap size of logstash, just prepend LS_HEAP_SIZE=2048m
to the logstash invocation.

```sh
bin/logstash -p lib -e 'input { stdin {} } filter { ner {} } output { stdout { codec => rubydebug } }'
```
At this point any modifications to the plugin code will be applied to this local Logstash setup. After modifying the plugin, simply rerun Logstash.

#### 2.2 Run in an installed Logstash

You can use the same **2.1** method to run your plugin in an installed Logstash by editing its `Gemfile` and pointing the `:path` to your local plugin development directory or you can build the gem and install it using:

- Build your plugin gem
```sh
gem build logstash-filter-awesome.gemspec
```
- Install the plugin from the Logstash home
```sh
# Logstash 2.3 and higher
bin/logstash-plugin install --no-verify

# need to install a dependency
mkdir -p lib/edu/stanford/nlp/stanford-corenlp/3.6.0/ && curl http://nlp.stanford.edu/software/stanford-english-corenlp-2016-01-10-models.jar -o lib/edu/stanford/nlp/stanford-corenlp/3.6.0/stanford-corenlp-3.6.0-models.jar

# Prior to Logstash 2.3 - not supported
```
- Start Logstash and proceed to test the plugin

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, complaints, and even something you drew up on a napkin.

Programming is not a required skill. Whatever you've seen about open source and maintainers or community members  saying "send patches or die" - you will not see that here.

It is more important to the community that you are able to contribute.

For more information about contributing, see the [CONTRIBUTING](https://github.com/elastic/logstash/blob/master/CONTRIBUTING.md) file.
