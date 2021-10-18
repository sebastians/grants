require "rails_helper"

RSpec.describe CreateAward do
  describe ".call" do
    let(:xml_file) { file_fixture("irs-form-990.xml").read }
    let(:funder) { Funder.create!(ein: 202153310) }
    let(:parsed_award) { Ox.load(xml_file).locate(CreateAwards::AWARDS_LIST_PATH).first }

    subject { described_class.call(funder: funder, parsed_award: parsed_award) }

    it "creates a Recipient record" do
      expect { subject }.to change { Recipient.count }.by(1)
    end

    it "creates an Award record" do
      expect { subject }.to change { Award.count }.by(1)
    end

    it "sets the new Award record attributes to the expected value" do
      subject

      expect(Award.last).to have_attributes(
        amount: 17000,
        purpose: "General Support and/or Capital & Program"
      )
    end

    context "when a Recipient with the same EIN already exist" do
      before { Recipient.create!(ein: 953825203) }

      it "does not create a new Filer record" do
        expect { subject }.not_to change { Recipient.count }
      end
    end

    context "when parsed_award is missing" do
      subject { described_class.call(funder: funder) }

      it "fails" do
        expect(subject).to be_failure
      end
    end

    context "when funder is missing" do
      subject { described_class.call(parsed_award: parsed_award) }

      it "fails" do
        expect(subject).to be_failure
      end
    end
  end
end
