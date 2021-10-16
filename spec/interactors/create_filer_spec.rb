require "rails_helper"

RSpec.describe CreateFiler do
  describe ".call" do
    context "when filer_nodes is missing" do
      subject { described_class.call }

      it "fails" do
        expect(subject).to be_failure
      end
    end
  end
end
