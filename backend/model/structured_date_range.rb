class StructuredDateRange < Sequel::Model(:structured_date_range)
  def before_save
    if !self.begin_date_standardized && self.begin_date_expression
      # parse date
      parsed_date = Timetwister.parse(self.begin_date_expression)
      # store the parsed values if we were able to parse
      self.begin_date_standardized = parsed_date[0][:date_start] if parsed_date[0][:date_start]
    end

    if !self.end_date_standardized && self.end_date_expression
      # parse date
      parsed_date = Timetwister.parse(self.end_date_expression)
      # store the parsed values if we were able to parse
      self.end_date_standardized = parsed_date[0][:date_start] if parsed_date[0][:date_start]
    end

    super
  end
end
