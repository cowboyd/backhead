# Backhead

The "backhead" was where the the gauges and controls sat on the old steam engines. This
gem removes the tedium of defining rails engine configuration options

## Usage

Include backhead into class. You can now define configuration options
for your engine.

    class MyEngine < Rails::Engine
      include Backhead

      configuration :my_engine do
        option :fast
        option :efficient
      end

      # standard engine stuff
      initializer 'my_engine.setup' do |app|
        MyEngine.enable_nitrus_mode() if app.config.my_engine.fast
        MyEngine.decrease_fuel_consumption() if app.config.my_engine.efficient
      end
    end

This will create two new configuration options that users can set in their environment files:
`config.my_engine.fast` and `config.my_engine.efficient`.

As a bonus, it will also allow users to set these configuration parameters via the environment
variables `MY_ENGINE_FAST` and `MY_ENGINE_EFFICIENT` if they so choose. This gives more baked in
flexibility to control the app and runtime rather than via source control.

Configuration options that are explicitly set during initialization will take precedence over
those specified by environment variables