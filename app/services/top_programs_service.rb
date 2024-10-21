class TopProgramsService
  def self.call
    Bank.includes(:programs).limit(5).map do |bank|
      bank.programs.order(interest_rate: :asc).limit(3)
    end.flatten
  end
end

