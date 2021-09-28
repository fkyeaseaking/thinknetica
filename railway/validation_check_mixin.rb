module ValidationCheckMixin
  def valid?
    validate!
  rescue StandardError
    false
  end
end
