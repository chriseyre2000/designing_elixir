defmodule Mastery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    IO.puts "starting Mastery"
    # List all child processes to be supervised
    children = [
      { 
        Mastery.Boundary.QuizManager, 
        [name: Mastery.Boundary.QuizManager]
      },
      { 
        Registry,
        [name: Mastery.Registry.QuizSession, keys: :unique]
      },
      {
        DynamicSupervisor,
        [name: Mastery.Supervisor.QuizSession, strategy: :one_for_one]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mastery.Supervisor]
    Supervisor.start_link(children, opts)
  end
end