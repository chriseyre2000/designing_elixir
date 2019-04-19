defmodule Clock do
  def start(f) do
    run(f, 0)
  end

  def run(your_hearts_desire, count) do
    your_hearts_desire.(count)
    new_counter = Counter.Core.inc(count)
    :timer.sleep 1000
    run(your_hearts_desire, new_counter)
  end
end