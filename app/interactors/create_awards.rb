class CreateAwards
  include Interactor

  AWARDS_LIST_PATH = "Return/ReturnData/IRS990ScheduleI/RecipientTable".freeze

  before do
    context.fail! unless context.parsed_filing
    context.fail! unless context.funder
  end

  def call
    awards_document_section.map do |award_element|
      CreateAward.call(funder: context.funder, parsed_award: award_element)
    end
  end

  private

  def awards_document_section
    context.parsed_filing.locate(AWARDS_LIST_PATH)
  end
end
