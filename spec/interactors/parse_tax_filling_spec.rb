require "rails_helper"

RSpec.describe ParseTaxFilling do
  describe ".call" do
    let(:xml_file) { file_fixture("irs-form-990.xml").read }

    subject { described_class.call(xml_file: xml_file) }

    it "parses the XML file into a Hash" do
      expect(subject.parsed_filling).to be_a Hash
    end

    it "sets parsed_filling to the parsed content of the XML file" do
      expect(subject.parsed_filling[:Return].third[:ReturnData].count).to eq 8
    end
  end
end
