class CreateFunder
  include Interactor

  FILER_PATH = "Return/ReturnHeader/Filer".freeze
  FILER_ATTRIBUTE_MAPPING = {
    ein: "EIN",
    name: "Name",
    address: "AddressLine1",
    city: "City",
    state: "State",
    zip_code: "ZIPCode"
  }.freeze

  before { context.fail! unless context.parsed_filing }

  def call
    context.funder = create_funder
  end

  private

  def create_funder
    Funder.create_or_find_by!(ein: ein) do |funder|
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
    context.parsed_filing.locate("#{FILER_PATH}/#{FILER_ATTRIBUTE_MAPPING[attribute]}/*").first
  end
end
