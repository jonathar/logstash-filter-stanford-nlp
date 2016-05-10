# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "logstash-filter-stanford-nlp_jars.rb"
require_jar( 'edu.stanford.nlp', 'stanford-corenlp', 'models', '3.6.0' )


class LogStash::Filters::Ner < LogStash::Filters::Base

  config_name "ner"
  config :message, :validate => :string, :default => ""

  module NlpSimple
    include_package "edu.stanford.nlp.simple"
  end

  public
  def register
  end

  public
  def filter(event)
    if @message
      names = []
      locations = []
      organizations = []
      dates = []

      document = NlpSimple::Document.new(event["message"])
      document.sentences().each do |sentence|
        names.concat(sentence.mentions("PERSON"))
        locations.concat(sentence.mentions("LOCATION"))
        organizations.concat(sentence.mentions("ORGANIZATION"))
        dates.concat(sentence.mentions("DATE"))
      end
      event["ner.names"] = names
      event["ner.locations"] = locations
      event["ner.organizations"] = organizations
      event["ner.dates"] = dates
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end
end
