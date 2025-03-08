class ApplicationService
  class << self
    def call(*args, **kwargs, &block)
      new(*args, **kwargs, &block).call
    end
  end
end
