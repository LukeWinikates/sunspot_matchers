require 'sunspot'
require 'sunspot_matchers'

describe SunspotMatchers::BeASearchFor do
  before do
    Sunspot.session = SunspotMatchers::SunspotSessionSpy.new(Sunspot.session)
  end

  subject do
    described_class.new(Class.new).tap do |matcher|
      matcher.matches? Sunspot.session
    end
  end

  context "when no search has been performed" do
    its(:failure_message_for_should) { should =~ /but no searches were found/}
  end

  context "when a search has been performed for a different class" do
    let(:search_klass) { SearchKlass = Class.new }
    before { Sunspot.search(search_klass) }

    its(:failure_message_for_should) { should =~ /expected search class.*to match expected class/}
  end
end
