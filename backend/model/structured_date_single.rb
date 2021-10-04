class StructuredDateSingle < Sequel::Model(:structured_date_single)
  def before_save
    if !self.date_standardized && self.date_expression
      # parse date
      parsed_date = Timetwister.parse(self.date_expression)
      # store the parsed values if we were able to parse
      self.date_standardized = parsed_date[0][:date_start] if parsed_date[0][:date_start]
    end
    super
  end
end
