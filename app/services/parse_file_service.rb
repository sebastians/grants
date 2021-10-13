class ParseFileService < ApplicationService
  def initialize(content)
    @content = content
  end

  def call
    Ox.load(content, mode: :hash)
  end

  private

  attr_reader :content
end
