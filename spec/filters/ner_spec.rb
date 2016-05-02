# encoding: utf-8
require 'spec_helper'
require "logstash/filters/ner"

describe LogStash::Filters::Ner do
  describe "should extract named entities" do
    let(:config) { {} }
    subject { described_class.new(config) }

    describe "from the message attribute and expose" do
      let(:data) { "Jeffrey Alan Mott and Michelle Mott, individuals Dda Integrity Landscape 3756 Independence Avenue Sanger, CA 93637 CSLB#774222 Decision 04/04/2016. Aldan, Inc. P.O. Box 9428, Brea, CA 92822 CSLB #949229 Decision"}
      let(:event) { LogStash::Event.new("message" => data) }

      it "a list of PERSONs" do
        subject.register
        subject.filter(event)
        expect(event['message']).to eq(data)
        expect(event['ner.names']).to include('Jeffrey Alan Mott')
      end

      it "a list of LOCATIONS" do
        subject.register
        subject.filter(event)
        expect(event['message']).to eq(data)
        expect(event['ner.locations']).to include('Brea')
      end

      it "a list of ORGANIZATIONs" do
        subject.register
        subject.filter(event)
        expect(event['message']).to eq(data)
        expect(event['ner.organizations']).to include('Aldan , Inc.')
      end

      it "a list of DATEs" do
        subject.register
        subject.filter(event)
        expect(event['message']).to eq(data)
        expect(event['ner.dates']).to include('04/04/2016')
      end
    end
  end
end
