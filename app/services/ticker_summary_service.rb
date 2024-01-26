class TickerSummaryService
  ROUND_DIGITS = 2
  OPEN_PROPERTY = "o"
  CLOSE_PROPERTY = "c"
  HIGH_PROPERTY = "h"
  LOW_PROPERTY = "l"
  VOLUME_PROPERTY = "vw"

  def initialize(results)
    @results = results
  end

  def to_h
    summary_hash = {
      "price" => {
        "average" => average(OPEN_PROPERTY, CLOSE_PROPERTY),
        "high" => average(HIGH_PROPERTY),
        "low" => average(LOW_PROPERTY)
      },
      "volume" => {
        "average" => average(VOLUME_PROPERTY),
        "high" => max(VOLUME_PROPERTY),
        "low" => min(VOLUME_PROPERTY)
      }
    }

    summary_hash
  end

  private

  def average(*properties)
    total = properties.sum { |property| @results.sum { |result| result[property] } }
    total_count = @results.length.to_f
    (total / (total_count * properties.length)).round(ROUND_DIGITS) if total_count.positive?
  end

  def max(property)
    @results.max_by { |result| result[property] }[property]
  end

  def min(property)
    @results.min_by { |result| result[property] }[property]
  end
end
