class CreateAward
  include Interactor

  ATTRIBUTES_MAPPING = {
    recipient_ein: ["RecipientEIN", "EINOfRecipient"],
    recipient_name: ["RecipientBusinessName/BusinessNameLine1", "RecipientNameBusiness/BusinessNameLine1", "RecipientBusinessName/BusinessNameLine1Txt"],
    recipient_address: ["AddressUS/AddressLine1", "USAddress/AddressLine1", "USAddress/AddressLine1Txt"],
    recipient_city: ["AddressUS/City", "USAddress/City", "USAddress/CityNm"],
    recipient_state: ["AddressUS/State", "USAddress/State", "USAddress/StateAbbreviationCd"],
    recipient_zip_code: ["AddressUS/ZIPCode", "USAddress/ZIPCode", "USAddress/ZIPCd"],
    award_amount: ["AmountOfCashGrant", "CashGrantAmt"],
    award_purpose: ["PurposeOfGrant", "PurposeOfGrantTxt"]
  }.freeze

  before do
    context.fail! unless context.parsed_award
    context.fail! unless context.funder
  end

  def call
    context.recipient = create_recipient
    context.award = create_award
  end

  private

  def create_recipient
    Recipient.create_or_find_by(ein: ein) do |recipient|
      recipient.name = value_for(:recipient_name)
      recipient.address = value_for(:recipient_address)
      recipient.city = value_for(:recipient_city)
      recipient.state = value_for(:recipient_state)
      recipient.zip_code = value_for(:recipient_zip_code)
    end
  end

  def create_award
    Award.create(
      recipient: context.recipient,
      funder: context.funder,
      amount: value_for(:award_amount).to_i,
      purpose: value_for(:award_purpose)
    )
  end

  def ein
    value_for(:recipient_ein).to_i
  end

  def value_for(attribute)
    ATTRIBUTES_MAPPING[attribute].map do |attribute_path|
      context.parsed_award.locate("#{attribute_path}/*").first
    end.compact.first
  end
end
