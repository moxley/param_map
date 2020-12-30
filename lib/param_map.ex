defmodule ParamMap do
  @moduledoc """
  A subset of the `Map` module that operates on string-keyed maps using
  atom key arguments.

  ## Examples

      iex> params = %{"color" => "red", "size" => "large", "age" => 100}
      iex> ParamMap.get(params, :color)
      "red"
      iex> ParamMap.delete(params, :size)
      %{"color" => "red", "age" => 100}
      iex> ParamMap.take(params, [:color, :size])
      %{color: "red", size: "large"}
      iex> ParamMap.pop(params, :color)
      {"red", %{"size" => "large", "age" => 100}}

  Still works with maps that have atom keys, in case you don't
  know ahead of time whether the keys are strings or atoms.

      iex> params = %{:color => "red", "age" => 100}
      iex> ParamMap.get(params, :color)
      "red"

  The params may have a key both as a string and an atom.
  `get/1`, `pop/1`, and `take/2` prioritize the atom key.
  `delete/2`, `pop/1` remove both the atom and string version of the key.

      iex> params = %{:color => "red", "color" => "blue"}
      iex> ParamMap.get(params, :color)
      "red"
      iex> params = %{:color => "red", "color" => "blue", "age" => 100}
      iex> ParamMap.delete(params, :color)
      %{"age" => 100}
      iex> params = %{:color => "red", "color" => "blue", "age" => 100}
      iex> ParamMap.pop(params, :color)
      {"red", %{"age" => 100}}
  """

  def get(params, atom_key, default \\ nil) do
    case fetch(params, atom_key) do
      {:ok, value} -> value
      :error -> default
    end
  end

  def delete(params, atom_key) do
    string_key = to_string(atom_key)

    params
    |> Map.delete(atom_key)
    |> Map.delete(string_key)
  end

  def fetch(params, atom_key) do
    string_key = to_string(atom_key)

    case params do
      %{^atom_key => value} -> {:ok, value}
      %{^string_key => value} -> {:ok, value}
      _ -> :error
    end
  end

  def pop(params, atom_key, default \\ nil) do
    value = get(params, atom_key, default)
    params = delete(params, atom_key)
    {value, params}
  end

  def take(params, keys), do: take(params, keys, %{})

  def take(_params, [], map), do: map

  def take(params, [key | keys], map) do
    with {:ok, value} = fetch(params, key) do
      Map.put(take(params, keys, map), key, value)
    end
  end
end
