require 'spec_helper'

describe Backhead do
  it 'cannot be included into a non-railtie' do
    expect {Class.new.send(:include, Backhead)}.to raise_error(TypeError)
  end
  describe 'included into a rails engine and configured' do
    before do
      @engine = Class.new(Rails::Engine)
      @initializers = []
      @engine.stub(:initializer) {|name, options, &body| @initializers << body}
      @engine.class_eval do
        include Backhead
        configuration :foo do
          option :bar
          option :baz_bang
        end
      end
      @app = mock('Rails App', :config => @engine.config)
      @initialize = proc do
        @initializers.each do |i|
          i.call(@app)
        end
      end
    end

    describe "setting a configuration parameter" do
      before do
        @engine.config.foo.bar = 'bif'
      end
      it "actually sets it." do
        @engine.config.foo.bar.should eql 'bif'
      end
    end

    describe "when an environment variable is set" do
      before do
        ENV['FOO_BAZ_BANG'] = 'booyeah'
      end
      after do
        ENV.delete 'FOO_BAZ_BANG'
      end

      describe 'when initialized' do
        before do
          @initialize.call
        end
        it 'sets the configuration parameter from the environment' do
          @engine.config.foo.baz_bang.should eql 'booyeah'
        end
      end

      describe 'but when initialized when option is set explicitly from ruby code' do
        before do
          @engine.config.foo.baz_bang = 'blort'
          @initialize.call
        end
        it 'uses the value set from ruby code' do
          @engine.config.foo.baz_bang.should eql 'blort'
        end
      end
    end

  end
end
