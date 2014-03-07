module CommandLogger



  include Aquarium::Aspects
  Aspect.new :around, :calls_to => :all_methods,:exclude_calls_to => [/^visible/,/^allow_reload/,/^text/],:for_types => [Capybara::Node::Element,Capybara::Node::Actions],:method_options => :exclude_ancestor_methods do |jp, obj, *args|
    begin
      names = "#{jp.method_name}"
      $logger.info "#{names} #{args}"
      jp.proceed
    ensure

    end
  end

  Aspect.new :around, :calls_to => :all_methods,:in_type => Capybara::Node::Finders,:method_options => :exclude_ancestor_methods do |jp, obj, *args|
    begin
      names = "#{jp.method_name}"
      $logger.info "#{names} #{args}"
      jp.proceed
    ensure

    end
  end
    Aspect.new :after_raising, :calls_to => :all_methods,:in_type => Capybara::Node::Finders,:method_options => :exclude_ancestor_methods do |jp, obj, *args|
      begin
        names = "#{jp.method_name}"
        $logger.info "ERRORR : Element Not Found : #{args}"
        jp.proceed
      ensure

      end
  end
end