require 'rspec/core/formatters/html_formatter'

class CustomFormatter < RSpec::Core::Formatters::HtmlFormatter
  def extra_failure_content(failure)
    @html = '<table border="1">'
    @html << '<th>Command Log</th>'
    $logger.log.each { |x| @html << '<tr><td style="color:' + x.color + '">' + x.text + '</td></tr>'  }
    @html << '</table><table border="1"><th>Test Artifacts</th>'
    @html << '<tr><td><a href="screenshot_' + RSpec.configuration.test_name + '.png">Screenshot Png</a></td></tr>'
    @html << '<tr><td><a href="screenshot_' + RSpec.configuration.test_name + '.html">Source Html</a></td></tr>'
    @html << '<tr><td><a href="output.txt">Documentation</a></td></tr>'
    @html << '</span></table>'
    super + @html

  end

end