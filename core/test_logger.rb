class TestLogger
attr_accessor :results_directory,:test_directory,:current_date_string,:test_filename

  RSpec.configure do |config|
    config.before :all do |x|
      current_date_string = DateTime.now.strftime("%H%M%S")
      results_directory = "TestResults"
      test_directory = results_directory + "\\Test_" + current_date_string
      test_filename = test_directory + "\\testlog.html"

      Dir.mkdir(results_directory) unless Dir.exist?(results_directory)
      Dir.mkdir(test_directory) unless Dir.exist?(test_directory)

      File.delete(test_filename) if File.exist?(test_filename)
      $logger = Logger.new(test_filename)
      $logger.level=Logger::INFO
      $logger.formatter=Logger::Formatter.new
      $logger.info('<html><body><table border="1">')
      $logger.formatter = proc do |severity, datetime, progname, msg|
        time = datetime.strftime("%H:%M:%S")
        "<tr><td>#{time}</td><td>#{msg}</td></tr>\n"
      end

    end
    config.before :each do |x|
      $logger.info "Starting Test : #{x.class.description} : #{x.example.description}"
    end

    config.after :each do |x|
      if example.exception != nil
        $logger.info "TEST FAILED : #{x.class.description} : #{x.example.description}"
      end
      if example.exception == nil
        $logger.info "TEST PASSED : #{x.class.description} : #{x.example.description}"
      end
    end
    config.after :all do |x|
      $logger.formatter = ''
      $logger.info "</table></body></html>"
    end

    def Log message,color
      $logger.info message
    end

  end

end