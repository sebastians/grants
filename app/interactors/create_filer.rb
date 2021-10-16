class CreateFiler
  include Interactor

  before { context.fail! unless context.filer_nodes }
end
