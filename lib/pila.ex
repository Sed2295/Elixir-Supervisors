#Calculadora basada en pila
#Nota: Un supervisor evita que si el gen server llega a morir todo no colapse
#Por ejemplo si dividimos 0/0 todo colapsa y se reinicia el iex
#Un supervisor tiene hijos
defmodule Supervisores.Pila do
  use GenServer
  alias Supervisores.Calculadora

  def start_link([]), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  def push(val), do: GenServer.call(__MODULE__, {:push, val})

  def init(:ok) do
    IO.puts "Pila: Iniciando gen server"
    {:ok, []}
  end

  def handle_call({:push, :add}, _from, [a,b | stack]) do
    IO.puts "Pila: Push ADD"
    resul = Calculadora.add(a,b)
    {:reply, resul, [resul | stack]}
  end

  def handle_call({:push, :sub}, _from, [a,b | stack]) do
    IO.puts "Pila: Push SUB"
    resul = Calculadora.sub(a, b)
    {:reply, resul, [resul | stack]}
  end

  def handle_call({:push, :mul}, _from, [a,b | stack]) do
    IO.puts "Pila: Push MUL"
    resul = Calculadora.mul(a, b)
    {:reply, resul, [resul | stack]}
  end

  def handle_call({:push, :div}, _from, [a,b | stack]) do
    IO.puts "Pila: Push DIV"
    resul = Calculadora.div(a, b)
    {:reply, resul, [resul | stack]}
  end

  def handle_call({:push, x}, _from, stack) when is_number(x) do
    IO.puts "Pila: Push #{x}"
    {:reply, x, [x | stack]}
  end
end
#-----------SUPERVISORES PARTE 1 TERMINAL------------#
# childs = [{Supervisores.Calculadora, []}, {Supervisores.Pila, []}]
#con este código creamos nuestro supervisor con nuestros hijos
#  {:ok, pid} = Supervisor.start_link(childs, strategy: :one_for_one)
# Supervisores.Pila.push(5)
#  Supervisores.Pila.push(5)
# Supervisores.Pila.push(:add) // 5 + 5    //10
#Y si ocurre un error en cualquier hijo se vuelve a levantar solo
#----------SUPERVISORES PARTE 2 TERMINAL-------------#
#Otra forma de declarar un hijo de un supervisor

