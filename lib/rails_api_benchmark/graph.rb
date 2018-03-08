module RailsApiBenchmark
  class Graph
    def initialize(target, output_dir)
      @output_dir = output_dir
      @target = target
    end

    def generate
      run
      copy_file
    end

    def run
      gnuplotscript = File.expand_path('../../gnuplotscript', __dir__)
      `gnuplot -e "plot_title='Benchmark #{@target.title}'; plot_file='#{@target.name}_plot.jpg'" #{gnuplotscript}`
    end

    def copy_file
      dest = File.join(@output_dir)
      FileUtils.mv("#{@target.name}_plot.jpg", dest)
    end
  end
end
