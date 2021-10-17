class CreateFunder
  include Interactor

  FILER_PATH = "Return/ReturnHeader/Filer".freeze
  FILER_ATTRIBUTE_MAPPING = {
    ein: ["EIN"],
    name: ["BusinessName/BusinessNameLine1Txt", "Name/BusinessNameLine1", "BusinessName/BusinessNameLine1"],
    address: ["USAddress/AddressLine1Txt", "USAddress/AddressLine1", "USAddress/AddressLine1"],
    city: ["USAddress/CityNm", "USAddress/City"],
    state: ["USAddress/StateAbbreviationCd", "USAddress/State"],
    zip_code: ["USAddress/ZIPCd", "USAddress/ZIPCode"]
  }.freeze

  before { context.fail! unless context.parsed_filing }

  def call
    context.funder = create_funder
  end

  private

  def create_funder
    Funder.create_or_find_by(ein: ein) do |funder|
      funder.name = value_for(:name)
      funder.address = value_for(:address)
      funder.city = value_for(:city)
      funder.state = value_for(:state)
      funder.zip_code = value_for(:zip_code)
    end
  end

  def ein
    value_for(:ein).to_i
  end

  def value_for(attribute)
    FILER_ATTRIBUTE_MAPPING[attribute].map do |attribute_path|
      context.parsed_filing.locate("#{FILER_PATH}/#{attribute_path}/*").first
    end.compact.first
  end
end
