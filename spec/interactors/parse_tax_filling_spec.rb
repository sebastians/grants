require "rails_helper"

RSpec.describe ParseTaxFilling do
  describe ".call" do
    let(:xml_file) { file_fixture("irs-form-990.xml").read }

    subject { described_class.call(xml_file: xml_file) }

    it "sets parsed_filing to an Ox::Document instance" do
      expect(subject.parsed_filing).to be_an Ox::Document
    end

    context "when xml_file is missing" do
      subject { described_class.call }

      it "fails" do
        expect(subject).to be_failure
      end
    end
  end
end
