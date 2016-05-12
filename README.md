# Logstash Plugin

This is a plugin for [Logstash](https://github.com/elastic/logstash). It integrates
the Logstash with the [Stanford NLP library](http://nlp.stanford.edu/software)

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

```sh
▶ bin/logstash -p lib -e '
input { stdin { } }
filter { ner {}}
output {
  stdout { codec => rubydebug }
}
'

Settings: Default pipeline workers: 8
Pipeline main started
Jeffrey Alan Mott and Michelle Mott, individuals Dda Integrity Landscape 3756 Independence Avenue Sanger, CA 93637 CSLB#774222 Decision 04/04/2016. Aldan, Inc. P.O. Box 9428, Brea, CA 92822 CSLB #949229 Decision
Reading POS tagger model from edu/stanford/nlp/models/pos-tagger/english-left3words/english-left3words-distsim.tagger ... done [0.8 sec].
Loading classifier from edu/stanford/nlp/models/ner/english.all.3class.distsim.crf.ser.gz ... done [1.4 sec].
Loading classifier from edu/stanford/nlp/models/ner/english.muc.7class.distsim.crf.ser.gz ... done [0.8 sec].
Loading classifier from edu/stanford/nlp/models/ner/english.conll.4class.distsim.crf.ser.gz ... done [0.9 sec].
[[main]>worker1] INFO edu.stanford.nlp.time.JollyDayHolidays - Initializing JollyDayHoliday for SUTime from classpath edu/stanford/nlp/models/sutime/jollyday/Holidays_sutime.xml as sutime.binder.1.
Reading TokensRegex rules from edu/stanford/nlp/models/sutime/defs.sutime.txt
May 10, 2016 9:45:39 AM edu.stanford.nlp.ling.tokensregex.CoreMapExpressionExtractor appendRules
INFO: Read 83 rules
Reading TokensRegex rules from edu/stanford/nlp/models/sutime/english.sutime.txt
May 10, 2016 9:45:39 AM edu.stanford.nlp.ling.tokensregex.CoreMapExpressionExtractor appendRules
INFO: Read 267 rules
Reading TokensRegex rules from edu/stanford/nlp/models/sutime/english.holidays.sutime.txt
May 10, 2016 9:45:39 AM edu.stanford.nlp.ling.tokensregex.CoreMapExpressionExtractor appendRules
INFO: Read 25 rules
{
            "ner.dates" => [
        [0] "04/04/2016",
        [1] "9428"
    ],
           "@timestamp" => 2016-05-10T15:45:33.852Z,
             "@version" => "1",
            "ner.names" => [
        [0] "Jeffrey Alan Mott",
        [1] "Michelle Mott",
        [2] "Sanger"
    ],
        "ner.locations" => [
        [0] "Brea"
    ],
              "message" => "Jeffrey Alan Mott and Michelle Mott, individuals Dda Integrity Landscape 3756 Independence Avenue Sanger, CA 93637 CSLB#774222 Decision 04/04/2016. Aldan, Inc. P.O. Box 9428, Brea, CA 92822 CSLB #949229 Decision",
    "ner.organizations" => [
        [0] "Aldan , Inc."
    ]
}
```
## Developing

### 1. Plugin Developement and Testing

#### Code
- To get started, you'll need JRuby with the Bundler gem installed.

- Create a new plugin or clone and existing from the GitHub [logstash-plugins](https://github.com/logstash-plugins) organization. We also provide [example plugins](https://github.com/logstash-plugins?query=example).

- Install dependencies
```sh
bundle install

curl http://nlp.stanford.edu/software/stanford-english-corenlp-2016-01-10-models.jar -o lib/edu/stanford/nlp/stanford-corenlp/3.6.0/stanford-corenlp-3.6.0-models.jar
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
