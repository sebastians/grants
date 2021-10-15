require "rails_helper"

RSpec.describe ParseTaxFilling do
  describe ".call" do
    let(:xml_file) { file_fixture("irs-form-990.xml").read }

    subject { described_class.call(xml_file: xml_file) }

    it "parses the XML file into an Ox::Element" do
      expect(subject.parsed_filling).to be_an Ox::Element
    end

    it "sets parsed_filling to the parsed content of the XML file" do
      expect(subject.parsed_filling.nodes.first.value).to eq "ReturnHeader"
      expect(subject.parsed_filling.nodes.second.value).to eq "ReturnData"
      expect(subject.parsed_filling.nodes.second.attributes).to eq({ documentCount: "7" })
    end
  end
end
