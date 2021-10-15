class ParseTaxFilling
  include Interactor

  def call
    context.parsed_filling = Ox.load(context.xml_file).root
  end
end
