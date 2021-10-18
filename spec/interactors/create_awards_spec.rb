require "rails_helper"

RSpec.describe CreateAwards do
  describe ".call" do
    let(:xml_file) { file_fixture("irs-form-990.xml").read }
    let(:funder) { Funder.create!(ein: 200253310) }
    let(:parsed_filing) { Ox.load(xml_file) }

    subject { described_class.call(funder: funder, parsed_filing: parsed_filing) }

    it "creates Recipient records" do
      expect { subject }.to change { Recipient.count }.by(123)
    end

    it "creates Award records" do
      expect { subject }.to change { Award.count }.by(129)
    end

    context "when parsed_filing is missing" do
      subject { described_class.call(funder: funder) }

      it "fails" do
        expect(subject).to be_failure
      end
    end

    context "when funder is missing" do
      subject { described_class.call(parsed_filing: parsed_filing) }

      it "fails" do
        expect(subject).to be_failure
      end
    end
  end
end
