class ParseTaxFilling
  include Interactor

  before { context.fail! unless context.xml_file }

  def call
    context.parsed_filing = Ox.load(context.xml_file)
  end
end
