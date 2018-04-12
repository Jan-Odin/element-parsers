defmodule Parser do
  use Platform.Parsing.Behaviour

  #ELEMENT IoT Parser for TrackNet Tabs object locator
  # According to documentation provided by TrackNet

  def parse(<<status, battery, temp, time::little-16, count::little-24>>, _meta) do
  <<rfu::6, state_1::1, state_0::1>> = <<status>>
  <<rem_cap::4, voltage::4>> = <<battery>>
  <<rfu::1, temperature::7>> = <<temp>>

  button_1 = case state_1 do
    0 -> "not pushed"
    1 -> "pushed"
  end

  button_0 = case state_0 do
    0 -> "not pushed"
    1 -> "pushed"
  end


    %{
      button_1_state: button_1,
      button_0_state: button_0,
      battery_state: rem_cap,
      battery_voltage: voltage,
      temperature: temperature-32,
      time_elapsed_since_trigger: time,
      total_count: count
    }
  end

end
