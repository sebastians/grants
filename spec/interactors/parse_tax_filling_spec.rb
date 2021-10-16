require "rails_helper"

RSpec.describe ParseTaxFilling do
  describe ".call" do
    let(:xml_file) { file_fixture("irs-form-990.xml").read }

    subject { described_class.call(xml_file: xml_file) }

    it "sets filer_nodes to an Array with Filer nodes" do
      expect(subject.filer_nodes).to be_an Array
      expect(subject.filer_nodes.first.value).to eq "EIN"
    end

    it "sets awards_path to an Array with Awards nodes" do
      expect(subject.awards_path).to be_an Array
      expect(subject.awards_path.size).to eq 771
      expect(subject.awards_path.first.value).to eq "RecipientNameBusiness"
    end

    context "when xml_file is missing" do
      subject { described_class.call }

      it "fails" do
        expect(subject).to be_failure
      end
    end
  end
end
