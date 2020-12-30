# ParamMap

Use atom keys to access values in string-keyed maps.

Unlike similar packages, `ParamMap`, does not blindly convert strings to atoms.
It converts only the keys you specify.

The API is compatible with a subset of the `Map` module, which we are already
familiar with.

If you use Ecto, maybe you know that as hard as we try, we can't help but
read values from untrusted, string-keyed maps before they get
normalized into an Ecto.Changeset.
Changesets can be too heavy-handed for some situations.

## Usage

```elixir
iex> params = %{"color" => "red", "size" => "large", "age" => 100}

iex> ParamMap.get(params, :color)
"red"

iex> ParamMap.delete(params, :size)
%{"color" => "red", "age" => 100}

iex> ParamMap.take(params, [:color, :size])
%{color: "red", size: "large"}

iex> ParamMap.pop(params, :color)
{"red", %{"size" => "large", "age" => 100}}

## Still works with maps that have atom keys, in case you don't
## know ahead of time whether the keys are strings or atoms.

iex> params = %{:color => "red", "age" => 100}

iex> ParamMap.get(params, :color)
"red"

# The params may have a key both as a string and an atom.
# `get/1`, `pop/1`, and `take/2` prioritize the atom key.
# `delete/2`, `pop/1` remove both the atom and string version of the key.

iex> params = %{:color => "red", "color" => "blue"}

iex> ParamMap.get(params, :color)
"red"

iex> params = %{:color => "red", "color" => "blue", "age" => 100}

iex> ParamMap.delete(params, :color)
%{"age" => 100}

iex> params = %{:color => "red", "color" => "blue", "age" => 100}

iex> ParamMap.pop(params, :color)
{"red", %{"age" => 100}}
```

## Installation

The package can be installed by adding `param_map` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:param_map, "~> 0.1"}
  ]
end
```
