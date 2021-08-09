defmodule Supervisores do
  use Supervisor
  def start_link(args) do
    IO.puts "Iniciando Supervisores principal ..."
    IO.inspect args
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
    #Supervisor.start_link([
      #{Supervisores.Calculadora, []},
      #{Supervisores.Pila, []}
    #], strategy: :one_for_one)
  end
  def init(args) do
    IO.puts "[Supervisame] llamo a init"
    IO.inspect args
    children = [
      {Supervisores.Calculadora, []},
      {Supervisores.Pila, []}
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
