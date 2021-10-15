class ParseTaxFilling
  include Interactor

  FILER_PATH = "Return/ReturnHeader/Filer/*"
  AWARDS_PATH = "Return/ReturnData/IRS990ScheduleI/RecipientTable/*"

  def call
    context.filer_nodes = parsed_filling.locate(FILER_PATH)
    context.awards_path = parsed_filling.locate(AWARDS_PATH)
  end

  private

  def parsed_filling
    @parsed_filling ||= Ox.load(context.xml_file)
  end
end
