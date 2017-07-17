module RailsApiBenchmark
  class ResultSet
    attr_reader :results

    def initialize
      @results = []
    end

    def add(endpoint, results)
      @results << { endpoint: endpoint, results: results }
    end

    def averages
      rps = @results.map { |v| v[:results][:req_per_sec] }.compact
      rt = @results.map { |v| v[:results][:response_time] }.compact

      avg_rps = rps.inject(0) { |sum, v| sum + v.to_i } / rps.count
      avg_rt = rt.inject(0) { |sum, v| sum + v.to_i } / rt.count

      { req_per_sec: avg_rps, response_time: avg_rt }
    end

    # Returns only the results with the relative speed
    def compute_relative_speed
      @results = @results.map do |r|
        avgs = averages
        res = r[:results]

        avg_rt = avgs[:response_time]
        avg_rps = avgs[:req_per_sec]

        f_rt = ((res[:response_time].to_f - avg_rt) / avg_rt * 100).round(1)
        f_rps = ((res[:req_per_sec].to_f - avg_rps) / avg_rps * 100).round(1)
        r.merge(factors: { response_time: f_rt, req_per_sec: f_rps })
      end
    end

    # Use it like this:
    # resultset.each_result do |endpoint, results|
    #   ...
    # end
    def each_result
      @results.each do |r|
        yield r[:endpoint], r[:results]
      end
    end
  end
end
