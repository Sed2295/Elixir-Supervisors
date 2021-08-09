defmodule Supervisores.MainSup do
  use Supervisor
  def start_link(args) do
    IO.puts "[MAINSUP] Lanzando mainsup"
    IO.inspect args
    Supervisor.start_link([
      {Supervisores, []}
    ], strategy: :one_for_one)
  end
end
