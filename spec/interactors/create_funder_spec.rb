require "rails_helper"

RSpec.describe CreateFunder do
  describe ".call" do
    let(:xml_file) { file_fixture("irs-form-990.xml").read }
    let(:parsed_filing) { Ox.load(xml_file) }

    subject { described_class.call(parsed_filing: parsed_filing) }

    it "creates a Funder record" do
      expect { subject }.to change { Funder.count }.by(1)
    end

    it "sets the new Funder record attributes to the expected values" do
      subject

      expect(Funder.last).to have_attributes(
        ein: 200253310,
        name: "Pasadena Community Foundation",
        address: "260 S Los Robles Avenue No 119",
        city: "Pasadena",
        state: "CA",
        zip_code: "91101"
      )
    end

    context "when a Funder with the same EIN already exist" do
      before { Funder.create!(ein: 200253310) }

      it "does not create a new Funder record" do
        expect { subject }.not_to change { Funder.count }
      end
    end

    context "when parsed_filing is missing" do
      subject { described_class.call }

      it "fails" do
        expect(subject).to be_failure
      end
    end
  end
end
