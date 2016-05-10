Gem::Specification.new do |s|
  s.name = 'logstash-filter-stanford-nlp'
  s.version         = '0.0.1'
  s.licenses = ['Apache License (2.0)']
  s.summary = "This filter extracts named entities from the message and adds them as attributes to the message."
  s.description     = "This gem is a Logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/logstash-plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["Jonathan Randall"]
  s.email = 'jonathar@users.noreply.github.com'
  s.homepage = "http://www.github.com/rahtanoj/logstash-filter-stanford-nlp"
  s.require_paths = ["lib"]
  s.platform = 'java'

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT', 'lib/*.jar', '*file']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.requirements << "jar 'edu.stanford.nlp:stanford-corenlp', '3.6.0'"
  s.requirements << "jar 'org.slf4j:slf4j-simple', '1.7.21'"
  s.requirements << "jar 'com.google.protobuf:protobuf-java', '2.6.1'"
  s.add_runtime_dependency "jar-dependencies", "~> 0"
  s.add_runtime_dependency "logstash-core", ">= 2.0.0", "< 3.0.0"
  s.add_development_dependency "logstash-devutils", "= 0.0.19" 
end
