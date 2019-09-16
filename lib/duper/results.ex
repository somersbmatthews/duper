defmodule Duper.Results do
   use GenServer

   @me __MODULE__


   # API

   def start_link(_) do
      Genserver.start_link(__MODULE__), :no_args, name: @me)
   end
end