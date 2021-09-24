module ValidationCheckMixin
  def valid?
    validate!
  rescue
    false
  end
end
