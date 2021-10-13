require "rails_helper"

RSpec.describe ParseFileService do
  describe ".call" do
    let(:xml_file) { file_fixture("irs-form-990.xml").read }

    subject { described_class.call(xml_file) }

    it "parses the XML file into a Hash" do
      expect(subject).to be_a Hash
    end
  end
end
