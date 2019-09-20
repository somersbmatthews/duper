defmodule Duper.WorkerSupervisor do
   use DynamicSupervisor

   @me WorkerSupervisor

   def start(_type, _args) do
      children = [
         Duper.Results,
         {Duper.PathFinder, "."},
         Duper.WorkerSupervisor,
      ]
      opts = [strategy: :one_for_one, name: Duper.Supervisor]
      Supervisor.start_link(children, opts)
   end

   def start_link(_) do
      DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
   end

   def init(:no_args) do
      DynamicSupervisor.init(strategy: :one_for_one)
   end

   def add_worker() do
      {:ok, _pid} = DynamicSupervisor.start_child(@me, Duper.Worker)
   end
end